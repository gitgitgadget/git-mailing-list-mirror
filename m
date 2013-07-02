From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] commit.c: make compare_commits_by_commit_date global
Date: Tue, 2 Jul 2013 02:21:48 -0400
Message-ID: <20130702062148.GB27856@sigill.intra.peff.net>
References: <20130702061149.GB1206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 08:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UttyD-0007rx-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 08:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260Ab3GBGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 02:21:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:54541 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213Ab3GBGVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 02:21:41 -0400
Received: (qmail 20864 invoked by uid 102); 2 Jul 2013 06:22:50 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Jul 2013 01:22:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 02:21:48 -0400
Content-Disposition: inline
In-Reply-To: <20130702061149.GB1206@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229366>

This helper function was introduced as a prio_queue
comparator to help topological sorting. However, other users
of prio_queue who want to replace commit_list_insert_by_date
will want to use it, too. So let's make it public.

Signed-off-by: Jeff King <peff@peff.net>
---
There is also compare_commits_by_author_date, but I expect it to be less
generally useful (especially because it relies on a slab), so I didn't
bother publicizing it.  I think this is sufficient for now, and any
later users can make the author version public if they need to.

Note also that we have a similar comparison function,
commit_list_compare_by_date, which gets fed to the linked-list mergesort
for commit_list_sort_by_date. I was tempted to unify them, but we can't,
because it takes an actual "struct commit_list *", not a "struct commit
*" (and the logic is not so complex that it is worth factoring out to a
shared helper).

 commit.c | 2 +-
 commit.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 521e49c..ebc0eea 100644
--- a/commit.c
+++ b/commit.c
@@ -581,7 +581,7 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
 	return 0;
 }
 
-static int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
+int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
 	/* newer commits with larger date first */
diff --git a/commit.h b/commit.h
index 4d452dc..18a5234 100644
--- a/commit.h
+++ b/commit.h
@@ -254,4 +254,6 @@ extern void check_commit_signature(const struct commit* commit, struct signature
  */
 extern void check_commit_signature(const struct commit* commit, struct signature_check *sigc);
 
+int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
+
 #endif /* COMMIT_H */
-- 
1.8.3.rc2.14.g7eee6b3
