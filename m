From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in
 prepare_revision_walk()
Date: Mon, 2 Apr 2012 16:14:33 -0400
Message-ID: <20120402201432.GA26503@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780F5.3060306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEnel-00011e-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab2DBUOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 16:14:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43499
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab2DBUOf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:14:35 -0400
Received: (qmail 20673 invoked by uid 107); 2 Apr 2012 20:14:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 16:14:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 16:14:33 -0400
Content-Disposition: inline
In-Reply-To: <4F7780F5.3060306@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194554>

On Sun, Apr 01, 2012 at 12:11:01AM +0200, Ren=C3=A9 Scharfe wrote:

> Speed up prepare_revision_walk() by adding commits without sorting
> to the commit_list and at the end sort the list in one go.  Thanks
> to mergesort() working behind the scenes, this is a lot faster for
> large numbers of commits than the current insert sort.

I think this is probably a sane thing to do, but I have two slight
misgivings:

  1. Is it worth the complexity of the linked-list mergesort? I was
     planning to just build an array, qsort it, and then put the result=
s
     into a linked list. The patch for that is below for reference.

     It's a lot less code and complexity for the same performance
     (actually, I measured it at 1% faster, but that is probably
     negligible). The downside is that it is not nicely encapsulated in
     commit_list_sort_by_date(). We call the latter from two other
     places; I don't know if they can be fed with enough commits to
     actually benefit from the performance gain or not.

  2. I'm not super happy about fixing this one spot. This quadratic
     behavior comes up in a lot of places, and we're slowly hacking the=
m
     one by one. E.g., this does nothing to help the same case in
     fetch-pack.c:mark_complete[1]. Nor does it help the fact that
     when we follow parents, we will do an O(n) insert_by_date for each
     commit we insert. The latter is largely saved by the locality of
     timestamps (i.e., timestamps of the parents of recently popped
     commits tend to be near the front of the list), as well as the hac=
k
     in fce87ae (Fix quadratic performance in rewrite_one., 2008-07-12)=
=2E

     So I wonder if in the long term we would benefit from a better dat=
a
     structure, which would make these problems just go away. That bein=
g
     said, there is a lot of code to be updated with such a change, so
     even if we do want to do that eventually, a quick fix like this is
     probably still a good thing.

-Peff

[1] I fixed the mark_complete thing in ea5f220 (fetch: avoid repeated
    commits in mark_complete, 2011-05-19), but only for exact-duplicate
    commits. The real-world case where it came up was an "alternates"
    repository that held refs for many clones (so we had hundreds or
    thousands of copies of each tag). But on a repository like the one
    we are testing on, I think it would be similarly slow.

---
Here's the qsort-in-array patch, for reference.

diff --git a/revision.c b/revision.c
index b3554ed..22c26d0 100644
--- a/revision.c
+++ b/revision.c
@@ -2062,10 +2062,24 @@ static void set_children(struct rev_info *revs)
 	}
 }
=20
+static int commit_compare_by_date(const void *va, const void *vb)
+{
+	const struct commit *a =3D va;
+	const struct commit *b =3D vb;
+	if (a->date < b->date)
+		return -1;
+	if (b->date < a->date)
+		return 1;
+	return 0;
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr =3D revs->pending.nr;
 	struct object_array_entry *e, *list;
+	struct commit **commits =3D NULL;
+	int commits_nr =3D 0, commits_alloc =3D 0;
+	int i;
=20
 	e =3D list =3D revs->pending.objects;
 	revs->pending.nr =3D 0;
@@ -2076,11 +2090,17 @@ int prepare_revision_walk(struct rev_info *revs=
)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |=3D SEEN;
-				commit_list_insert_by_date(commit, &revs->commits);
+				ALLOC_GROW(commits, commits_nr + 1, commits_alloc);
+				commits[commits_nr++] =3D commit;
 			}
 		}
 		e++;
 	}
+	qsort(commits, commits_nr, sizeof(*commits), commit_compare_by_date);
+	for (i =3D commits_nr - 1; i >=3D 0; i--)
+		commit_list_insert(commits[i], &revs->commits);
+	free(commits);
+
 	if (!revs->leak_pending)
 		free(list);
=20
