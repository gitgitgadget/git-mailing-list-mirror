From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] config.c: Expand $HOME and tilde character in core.excludesfile
Date: Mon, 28 Jan 2008 23:49:05 +0200
Organization: Private
Message-ID: <y7a9aaem.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 22:51:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJbsZ-0000gO-TD
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 22:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762275AbYA1Vts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbYA1Vts
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 16:49:48 -0500
Received: from main.gmane.org ([80.91.229.2]:33986 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745AbYA1Vtq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 16:49:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JJbrH-0003UE-JJ
	for git@vger.kernel.org; Mon, 28 Jan 2008 21:49:39 +0000
Received: from a91-155-188-244.elisa-laajakaista.fi ([91.155.188.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 21:49:39 +0000
Received: from jari.aalto by a91-155-188-244.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 21:49:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-188-244.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:Lk8rdEKBwNSsqVwNteNZO11ewSg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71902>

c* str_replace(): New function. Generic replace command.
* str_replace_home(): New funtion. Substitute $HOME and tilde(~) in string.
* git_default_config(): Pass core.excludesfile to str_replace_home().

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---

 From ac6941f5055b2acdded59627d228bbf03ba0d9fc

 config.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 526a3f4..7c91689 100644
--- a/config.c
+++ b/config.c
@@ -309,6 +309,46 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }
 
+char *str_replace(const char *str, const char *find, const char *replace)
+{
+        int maxlen   = strlen(str) + strlen(replace) + 1;
+        char *start  = strstr(str, find);
+        char *ptr    = (char *)malloc(maxlen);
+        int len      = strlen(find);
+        int llen, rlen;         /* left, right portion length */
+
+        if (start == (char *)NULL) {
+                strcpy( ptr, str);
+        }
+        else{
+                rlen = strlen(start) - strlen(find);
+                llen = strlen(str) - strlen(start);
+                strncpy( ptr, str, llen);
+                strcat( ptr, replace);
+                strncat( ptr, start + len, rlen); /* Does not add  '\0' */
+                strcat( ptr, "");   /* Terminate with null string */
+        }
+
+        return ptr;
+}
+
+char *str_replace_home(const char *str)
+{
+        char *ret  = xstrdup(str);
+        char *home = getenv("HOME");
+
+        if (home != (char *)NULL ) {
+                if (strstr(str, "~") != NULL) {
+                        ret = str_replace(str, "~", home);
+                }
+                else if (strstr(str, "$HOME") != NULL) {
+                        ret = str_replace(str, "$HOME", home);
+                }
+        }
+
+        return ret;
+}
+
 int git_default_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -447,7 +487,9 @@ int git_default_config(const char *var, const char *value)
 		if (!value)
 			die("core.excludesfile without value");
 		excludes_file = xstrdup(value);
-		return 0;
+                /* expand $HOME and tilde(~) */
+                excludes_file = str_replace_home(excludes_file);
+                return 0;
 	}
 
 	if (!strcmp(var, "core.whitespace")) {
-- 
1.5.4-rc3.GIT
