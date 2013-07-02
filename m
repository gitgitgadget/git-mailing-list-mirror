From: Jeff King <peff@peff.net>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 2 Jul 2013 00:07:58 -0400
Message-ID: <20130702040758.GA7068@sigill.intra.peff.net>
References: <201307012102.31384.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Jul 02 06:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utrsh-0005Ak-G1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 06:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab3GBEHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 00:07:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:53658 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3GBEHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 00:07:51 -0400
Received: (qmail 14165 invoked by uid 102); 2 Jul 2013 04:09:00 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Jul 2013 23:09:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 00:07:58 -0400
Content-Disposition: inline
In-Reply-To: <201307012102.31384.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229356>

On Mon, Jul 01, 2013 at 09:02:31PM -0600, Martin Fick wrote:

> A simple synthetic test case with 1M refs all pointing to the same
> sha1 seems to be easily handled by git these days.  However, in our
> experience with our internal git repo, we still have performance
> issues related to having too many refs, in our kernel/msm instance we
> have around 400K.

I'm not too surprised. There's O(n^2) behavior in fetch-pack's
mark_complete function, as it adds each of the N ref tips to a
commit_list, sorting by date (so each insertion is O(n)).

I posted two alternative patches in May of 2011.  The first simply
avoids adding duplicate objects, which is simple and covers many
real-world cases (e.g., an "alternates" repository which has a bunch of
copies of the same tags, one per fork). The second one switches the
commit_list out for a heap-based priority queue.

We ended up taking the first (as ea5f220), since it was trivial and
obviously correct, but didn't bother with the second since:

  1. There had been no real-world reports of it.

  2. While in theory a priority queue implementation would be used in
     other spots, too, it ended up being a pain to use it, as most of
     the callers wanted list-like splicing.

You can see the original here:

  http://thread.gmane.org/gmane.comp.version-control.git/174003/focus=3D=
174005

Though it probably doesn't apply cleanly anymore.  However, I've kept i=
t
rebased over the years at:

  git://github.com/peff/git.git jk/fast-commit-list

Junio recently added a priority queue implementation in b4b594a
(prio-queue: priority queue of pointers to structs, 2013-06-06), which
is currently in next. So a modern version of that series would build on
top of that, rather than my priority queue.

And yet another alternative would be to keep the list unsorted during
the mark_complete calls, and then sort it at the end. Like this:

diff --git a/fetch-pack.c b/fetch-pack.c
index abe5ffb..4df8abd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -505,7 +505,7 @@ static int mark_complete(const char *refname, const=
 unsigned char *sha1, int fla
 		struct commit *commit =3D (struct commit *)o;
 		if (!(commit->object.flags & COMPLETE)) {
 			commit->object.flags |=3D COMPLETE;
-			commit_list_insert_by_date(commit, &complete);
+			commit_list_insert(commit, &complete);
 		}
 	}
 	return 0;
@@ -622,6 +622,7 @@ static int everything_local(struct fetch_pack_args =
*args,
 	if (!args->depth) {
 		for_each_ref(mark_complete, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
+		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}

(If you're wondering why we didn't do this trivial bit at the time, it
was because back then we did not yet have the Ren=C3=A9's nice linked-l=
ist
mergesort that backs commit_list_sort_by_date).

> The result, a copy of linus' repo with a million unique=20
> valid refs and a git fetch of a single updated ref taking a=20
> very long time (55mins and it did not complete yet).  Note,=20
> with 100K refs it completes in about 2m40s.  It is likely=20
> not linear since 2m40s * 10 would be ~26m (but the=20
> difference could also just be how the data in the sha1s are=20
> ordered).

That sounds like the O(n^2) problem. My timings back then with 100K ref=
s
were 1-2 minutes. Does the patch above fix it for you?

-Peff
