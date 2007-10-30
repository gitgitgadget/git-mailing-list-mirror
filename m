From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Correct handling of upload-pack in builtin-fetch-pack
Date: Mon, 29 Oct 2007 22:35:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292232330.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 03:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imgx4-00030b-9G
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 03:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbXJ3CfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 22:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbXJ3CfT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 22:35:19 -0400
Received: from iabervon.org ([66.92.72.58]:58417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbXJ3CfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 22:35:18 -0400
Received: (qmail 2422 invoked by uid 1000); 30 Oct 2007 02:35:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 02:35:08 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62649>

The field in the args was being ignored in favor of a static constant

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Found this while trying to figure out how builtin-fetch-pack was 
initializing the string in the args struct, and why it generally worked 
even though it wasn't.

 builtin-fetch-pack.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 8f25d50..8753840 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -11,11 +11,12 @@
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
-static struct fetch_pack_args args;
+static struct fetch_pack_args args = {
+	/* .uploadpack = */ "git-upload-pack",
+};
 
 static const char fetch_pack_usage[] =
 "git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
-static const char *uploadpack = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -773,7 +774,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	pid = git_connect(fd, (char *)dest, uploadpack,
+	pid = git_connect(fd, (char *)dest, args.uploadpack,
                           args.verbose ? CONNECT_VERBOSE : 0);
 	if (pid < 0)
 		return NULL;
-- 
1.5.3.4.1206.g5f96
