From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] remote: don't resolve HEAD in non-repository
Date: Sat, 5 Mar 2016 17:11:57 -0500
Message-ID: <20160305221157.GC31508@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:12:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKQe-0008Cc-Rt
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbcCEWMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:12:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:55321 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbcCEWMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:12:00 -0500
Received: (qmail 13089 invoked by uid 102); 5 Mar 2016 22:11:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:11:59 -0500
Received: (qmail 12122 invoked by uid 107); 5 Mar 2016 22:12:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:12:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:11:57 -0500
Content-Disposition: inline
In-Reply-To: <20160305220829.GA31316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288331>

The remote-config code wants to look at HEAD to mark the
current branch specially. But if we are not in a repository
(e.g., running "git archive --remote"), this makes no sense;
there is no HEAD to look at, and we have no current branch.

This doesn't really cause any bugs in practice (if you are
not in a repo, you probably don't have a .git/HEAD file),
but we should be more careful about triggering the refs code
at all in a non-repo. As we grow new ref backends, we would
not even know which backend to use.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index fc02698..28fd676 100644
--- a/remote.c
+++ b/remote.c
@@ -455,7 +455,6 @@ static void read_config(void)
 {
 	static int loaded;
 	struct object_id oid;
-	const char *head_ref;
 	int flag;
 
 	if (loaded)
@@ -463,10 +462,12 @@ static void read_config(void)
 	loaded = 1;
 
 	current_branch = NULL;
-	head_ref = resolve_ref_unsafe("HEAD", 0, oid.hash, &flag);
-	if (head_ref && (flag & REF_ISSYMREF) &&
-	    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-		current_branch = make_branch(head_ref, 0);
+	if (startup_info->have_repository) {
+		const char *head_ref = resolve_ref_unsafe("HEAD", 0, oid.hash, &flag);
+		if (head_ref && (flag & REF_ISSYMREF) &&
+		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
+			current_branch = make_branch(head_ref, 0);
+		}
 	}
 	git_config(handle_config, NULL);
 	alias_all_urls();
-- 
2.8.0.rc1.318.g2193183
