From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Alternative approach to the git config NULL value checking
 patches..
Date: Sun, 10 Feb 2008 12:32:39 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIsS-0002Aw-RH
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbYBJUdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbYBJUdP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:33:15 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49307 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753812AbYBJUdO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 15:33:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AKWeBE008914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 12:32:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1AKWdcH013062;
	Sun, 10 Feb 2008 12:32:40 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.084 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_75,J_CHICKENPOX_93,PATCH_UNIFIED_DIFF_OSDL,TW_VP
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73402>


So I realize that people have worked on checking for NULL, but I'm kind of 
of the opinion that we could just decide to say that "value" just should 
never be NULL at all, and marking the special case "true" value 
differently.

Namely by just using a _special_ empty string that can be distinguished 
from any regular user-generated empty strings.

This fairly simple patch just uses a special static "config_true" array 
variable to specify that special case that we used to use NULL for, and 
then replaces the few explicit places where we knew that NULL was special 
in the config handling with testing whether the value is that special 
array.

It may be a bit odd, but it automatically means that codepaths that simply 
don't want to care about the subtle difference between "true" and "empty" 
will just automatically work, because to them the two cases will look 
identical, because the strings will compare the same - they have the same 
data, just different addresses.

This also means that code (notably the value regexp parsing) that does 
something like

	value ? value : ""

just automatically can go away, and just use 'value' directly.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Hmm?

 builtin-config.c |   10 +++++-----
 cache.h          |    1 +
 config.c         |    7 ++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index e4a12e3..a58f2a1 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -20,7 +20,7 @@ static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
 static int show_all_config(const char *key_, const char *value_)
 {
-	if (value_)
+	if (value_ != config_true)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
 		printf("%s%c", key_, term);
@@ -38,11 +38,11 @@ static int show_config(const char* key_, const char* value_)
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
 	if (regexp != NULL &&
-	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+	    (do_not_match ^ !!regexec(regexp, value_, 0, NULL, 0)))
 		return 0;
 
 	if (show_keys) {
-		if (value_)
+		if (value_ != config_true)
 			printf("%s%c", key_, key_delim);
 		else
 			printf("%s", key_);
@@ -50,11 +50,11 @@ static int show_config(const char* key_, const char* value_)
 	if (seen && !do_all)
 		dup_error = 1;
 	if (type == T_INT)
-		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
+		sprintf(value, "%d", git_config_int(key_, value_));
 	else if (type == T_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
 	else
-		vptr = value_?value_:"";
+		vptr = value_;
 	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
diff --git a/cache.h b/cache.h
index 549f4bb..ffe99fc 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value);
+extern const char config_true[];
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 498259e..ba381d3 100644
--- a/config.c
+++ b/config.c
@@ -10,6 +10,7 @@
 
 #define MAXNAME (256)
 
+const char config_true[1] = "";
 static FILE *config_file;
 static const char *config_file_name;
 static int config_linenr;
@@ -114,7 +115,7 @@ static inline int iskeychar(int c)
 static int get_value(config_fn_t fn, char *name, unsigned int len)
 {
 	int c;
-	char *value;
+	const char *value;
 
 	/* Get the full name */
 	for (;;) {
@@ -131,7 +132,7 @@ static int get_value(config_fn_t fn, char *name, unsigned int len)
 	while (c == ' ' || c == '\t')
 		c = get_next_char();
 
-	value = NULL;
+	value = config_true;
 	if (c != '\n') {
 		if (c != '=')
 			return -1;
@@ -298,7 +299,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 
 int git_config_bool(const char *name, const char *value)
 {
-	if (!value)
+	if (value == config_true)
 		return 1;
 	if (!*value)
 		return 0;
