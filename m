From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] filter_ref: make a copy of extra "sought" entries
Date: Thu, 19 Mar 2015 16:37:09 -0400
Message-ID: <20150319203708.GB7666@peff.net>
References: <20150319203126.GA31663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:37:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhBs-0006Ml-MU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbbCSUhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:37:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:35422 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbbCSUhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:37:11 -0400
Received: (qmail 3595 invoked by uid 102); 19 Mar 2015 20:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 15:37:11 -0500
Received: (qmail 17268 invoked by uid 107); 19 Mar 2015 20:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:37:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 16:37:09 -0400
Content-Disposition: inline
In-Reply-To: <20150319203126.GA31663@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265827>

If the server supports allow_tip_sha1_in_want, we add any
unmatched raw-sha1 entries in our "sought" list of refs to
the list of refs we will ask the other side for. We do so by
inserting the original "struct ref" directly into our list,
rather than making a copy. This has several problems.

The most minor problem is that one cannot ever free the
resulting list; it contains structs that are copies of the
remote refs (made earlier by fetch_pack) along with sought
refs that are referenced elsewhere.

But more importantly that we set the ref->next pointer to
NULL, chopping off the remainder of any existing list that
the ref was a part of. We get the set of "sought" refs in
an array rather than a linked list, but that array is often
in turn generated from a list.  The test modification in
t5516 demonstrates this. Rather than fetching just an exact
sha1, we fetch that sha1 plus another ref:

  - we build a linked list of refs to fetch when do_fetch
    calls get_ref_map; the exact sha1 is first, followed by
    the named ref ("refs/heads/extra" in this case).

  - we pass that linked list to transport_fetch_ref, which
    squashes it into an array of pointers

  - that array goes to fetch_pack, which calls filter_ref.
    There we generate the want list from a mix of what the
    remote side has advertised, and the "sought" entry for
    the exact sha1. We set the sought entry's "next" pointer
    to NULL.

  - after we return from transport_fetch_refs, we then try
    to update the refs by following the linked list. But our
    list is now truncated, and we do not update
    refs/heads/extra at all.

We can fix this by making a copy of the ref. There's nothing
that fetch_pack does to it that must be reflected in the
original "sought" list (and indeed, if that were the case we
would have a serious bug, because it is only exact-sha1
entries which are treated this way).

Signed-off-by: Jeff King <peff@peff.net>
---
I always feel a little dirty modifying an existing test rather than
writing a new one that more clearly demonstrates what we are testing.
But the setup involved in the exact-sha1 fetch is a little complicated,
so this seemed easiest (and anybody blaming the change can hopefully
rely on the explanation above to understand what is going on).

 fetch-pack.c          |  5 ++---
 t/t5516-fetch-push.sh | 13 ++++++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 058c258..84d5a66 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -555,9 +555,8 @@ static void filter_refs(struct fetch_pack_args *args,
 				continue;
 
 			ref->matched = 1;
-			*newtail = ref;
-			ref->next = NULL;
-			newtail = &ref->next;
+			*newtail = copy_ref(ref);
+			newtail = &(*newtail)->next;
 		}
 	}
 	*refs = newlist;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 630885d..5e04d64 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1107,9 +1107,16 @@ test_expect_success 'fetch exact SHA1' '
 			git config uploadpack.allowtipsha1inwant true
 		) &&
 
-		git fetch -v ../testrepo $the_commit:refs/heads/copy &&
-		result=$(git rev-parse --verify refs/heads/copy) &&
-		test "$the_commit" = "$result"
+		git fetch -v ../testrepo $the_commit:refs/heads/copy master:refs/heads/extra &&
+		cat >expect <<-EOF &&
+		$the_commit
+		$the_first_commit
+		EOF
+		{
+			git rev-parse --verify refs/heads/copy &&
+			git rev-parse --verify refs/heads/extra
+		} >actual &&
+		test_cmp expect actual
 	)
 '
 
-- 
2.3.3.520.g3cfbb5d
