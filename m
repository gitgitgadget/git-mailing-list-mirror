From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/7] Use a function to determine whether a remote is valid
Date: Wed, 27 May 2009 14:15:35 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905271406590.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 20:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Nfj-0001Hm-Vi
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 20:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764213AbZE0SPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 14:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbZE0SPi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 14:15:38 -0400
Received: from iabervon.org ([66.92.72.58]:46851 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933105AbZE0SPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 14:15:34 -0400
Received: (qmail 18396 invoked by uid 1000); 27 May 2009 18:15:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2009 18:15:35 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120088>

Currently, it only checks url, but it will allow other things in the future.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 2c3e905..5552ce7 100644
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
@@ -653,14 +658,14 @@ struct remote *remote_get(const char *name)
 
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
1.6.0.6
