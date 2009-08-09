From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/8] Use a function to determine whether a remote is valid
Date: Sun, 9 Aug 2009 15:28:13 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908091526440.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 21:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaE4f-0005Sd-42
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 21:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbZHIT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZHIT2P
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 15:28:15 -0400
Received: from iabervon.org ([66.92.72.58]:33228 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbZHIT2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 15:28:12 -0400
Received: (qmail 12191 invoked by uid 1000); 9 Aug 2009 19:28:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2009 19:28:13 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125370>

Currently, it only checks url, but it will allow other things in the future.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index c3ada2d..e6f5cd2 100644
--- a/remote.c
+++ b/remote.c
@@ -48,6 +48,11 @@ static int rewrite_nr;
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
+static int valid_remote(const struct remote *remote)
+{
+	return !!remote->url;
+}
+
 static const char *alias_url(const char *url)
 {
 	int i, j;
@@ -667,14 +672,14 @@ struct remote *remote_get(const char *name)
 
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
-		if (!ret->url)
+		if (!valid_remote(ret))
 			read_remotes_file(ret);
-		if (!ret->url)
+		if (!valid_remote(ret))
 			read_branches_file(ret);
 	}
-	if (name_given && !ret->url)
+	if (name_given && !valid_remote(ret))
 		add_url_alias(ret, name);
-	if (!ret->url)
+	if (!valid_remote(ret))
 		return NULL;
 	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
-- 
1.6.4.183.g77eb9.dirty
