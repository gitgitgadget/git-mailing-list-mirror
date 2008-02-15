From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Validate nicknames of remote branches to prohibit confusing
 ones
Date: Fri, 15 Feb 2008 14:14:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802151412390.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 20:15:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ61S-0006jj-TH
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 20:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761339AbYBOTOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761042AbYBOTOV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 14:14:21 -0500
Received: from iabervon.org ([66.92.72.58]:39946 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760808AbYBOTOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 14:14:20 -0500
Received: (qmail 2573 invoked by uid 1000); 15 Feb 2008 19:14:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Feb 2008 19:14:18 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73976>

The original problem was that the parsers for configuration files were
getting confused by seeing as nicknames remotes that involved
directory-changing characters. In particular, the branches config file
for ".." was particularly mystifying on platforms that can open
directories and read odd data from them.

The validation function was written by Junio Hamano (with a typo
corrected).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I was sort of expecting you to just put this in yourself, but since you 
haven't, I wrote it up as an actual patch and fixed the polarity of the 
test for slashes.

 remote.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 20abbc0..6b56473 100644
--- a/remote.c
+++ b/remote.c
@@ -343,6 +343,16 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 	return rs;
 }
 
+static int valid_remote_nick(const char *name)
+{
+	if (!name[0] || /* not empty */
+	    (name[0] == '.' && /* not "." */
+	     (!name[1] || /* not ".." */
+	      (name[1] == '.' && !name[2]))))
+		return 0;
+	return !strchr(name, '/'); /* no slash */
+}
+
 struct remote *remote_get(const char *name)
 {
 	struct remote *ret;
@@ -351,7 +361,7 @@ struct remote *remote_get(const char *name)
 	if (!name)
 		name = default_remote_name;
 	ret = make_remote(name, 0);
-	if (name[0] != '/') {
+	if (valid_remote_nick(name)) {
 		if (!ret->url)
 			read_remotes_file(ret);
 		if (!ret->url)
-- 
1.5.4
