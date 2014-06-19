From: Jeff King <peff@peff.net>
Subject: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of xmalloc +
 sprintf
Date: Thu, 19 Jun 2014 17:28:00 -0400
Message-ID: <20140619212800.GF28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:28:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxjsO-0001Mr-54
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319AbaFSV2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:28:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:47793 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964845AbaFSV2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:28:02 -0400
Received: (qmail 17159 invoked by uid 102); 19 Jun 2014 21:28:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:28:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:28:00 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252189>

This is shorter, harder to get wrong, and more clearly
captures the intent.

Signed-off-by: Jeff King <peff@peff.net>
---
I wondered if there was a reason to avoid this (because we are in
setup_git_env, which can potentially be called by git_pathdup). But the
git_graft_file initialization below already uses it, and I
double-checked that it is safe once git_dir is set.

 environment.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/environment.c b/environment.c
index 4dac5e9..4de7b81 100644
--- a/environment.c
+++ b/environment.c
@@ -135,15 +135,11 @@ static void setup_git_env(void)
 	gitfile = read_gitfile(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
 	git_object_dir = getenv(DB_ENVIRONMENT);
-	if (!git_object_dir) {
-		git_object_dir = xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
-	}
+	if (!git_object_dir)
+		git_object_dir = git_pathdup("objects");
 	git_index_file = getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file) {
-		git_index_file = xmalloc(strlen(git_dir) + 7);
-		sprintf(git_index_file, "%s/index", git_dir);
-	}
+	if (!git_index_file)
+		git_index_file = git_pathdup("index");
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = git_pathdup("info/grafts");
-- 
2.0.0.566.gfe3e6b2
