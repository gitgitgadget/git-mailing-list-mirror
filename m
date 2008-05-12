From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Improve reporting of errors in config file routines
Date: Mon, 12 May 2008 23:41:04 +0200
Message-ID: <20080512214104.GA12294@steel.home>
References: <20080512141636.GA29590@elte.hu>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon May 12 23:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvfmQ-00051J-Pb
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYELVlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYELVlI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:41:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:29839 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbYELVlG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 17:41:06 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (fruni mo24) (RZmta 16.34)
	with ESMTP id v06d7ek4CJKGvx ; Mon, 12 May 2008 23:41:04 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DE784277BD;
	Mon, 12 May 2008 23:41:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9A8E356D28; Mon, 12 May 2008 23:41:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080512141636.GA29590@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81955>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Ingo Molnar, Mon, May 12, 2008 16:16:37 +0200:
>  #
>  # Ah, stupid me! I forgot to cd into the Git repository and it tries to 
>  # access .git. And i wanted the --global option anyway. So the Git 
>  # error messages led me on the completely wrong path.
>  #

I hope this can improve situation a little. I have this patch in my
tree for quite a while, but never came around to send it.
Ingo's report reminded me about it.

 config.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/config.c b/config.c
index 4d00ebc..0e22c7a 100644
--- a/config.c
+++ b/config.c
@@ -627,11 +627,9 @@ static int store_aux(const char* key, const char* value)
 	case KEY_SEEN:
 		if (matches(key, value)) {
 			if (store.seen == 1 && store.multi_replace == 0) {
-				fprintf(stderr,
-					"Warning: %s has multiple values\n",
-					key);
+				warning("%s has multiple values", key);
 			} else if (store.seen >= MAX_MATCHES) {
-				fprintf(stderr, "Too many matches\n");
+				error("too many matches for %s", key);
 				return 1;
 			}
 
@@ -681,9 +679,9 @@ static int store_aux(const char* key, const char* value)
 	return 0;
 }
 
-static int write_error(void)
+static int write_error(const char *filename)
 {
-	fprintf(stderr, "Failed to write new configuration file\n");
+	error("failed to write new configuration file %s", filename);
 
 	/* Same error code as "failed to rename". */
 	return 4;
@@ -842,7 +840,7 @@ int git_config_set_multivar(const char* key, const char* value,
 	 */
 
 	if (last_dot == NULL) {
-		fprintf(stderr, "key does not contain a section: %s\n", key);
+		error("key does not contain a section: %s", key);
 		ret = 2;
 		goto out_free;
 	}
@@ -862,14 +860,14 @@ int git_config_set_multivar(const char* key, const char* value,
 		/* Leave the extended basename untouched.. */
 		if (!dot || i > store.baselen) {
 			if (!iskeychar(c) || (i == store.baselen+1 && !isalpha(c))) {
-				fprintf(stderr, "invalid key: %s\n", key);
+				error("invalid key: %s", key);
 				free(store.key);
 				ret = 1;
 				goto out_free;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			fprintf(stderr, "invalid key (newline): %s\n", key);
+			error("invalid key (newline): %s", key);
 			free(store.key);
 			ret = 1;
 			goto out_free;
@@ -885,7 +883,7 @@ int git_config_set_multivar(const char* key, const char* value,
 	lock = xcalloc(sizeof(struct lock_file), 1);
 	fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (fd < 0) {
-		fprintf(stderr, "could not lock config file\n");
+		error("could not lock config file %s", config_filename);
 		free(store.key);
 		ret = -1;
 		goto out_free;
@@ -932,8 +930,7 @@ int git_config_set_multivar(const char* key, const char* value,
 			store.value_regex = (regex_t*)xmalloc(sizeof(regex_t));
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
-				fprintf(stderr, "Invalid pattern: %s\n",
-					value_regex);
+				error("invalid pattern: %s", value_regex);
 				free(store.value_regex);
 				ret = 6;
 				goto out_free;
@@ -951,7 +948,7 @@ int git_config_set_multivar(const char* key, const char* value,
 		 * existing config file.
 		 */
 		if (git_config_from_file(store_aux, config_filename)) {
-			fprintf(stderr, "invalid config file\n");
+			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL) {
 				regfree(store.value_regex);
@@ -1030,7 +1027,7 @@ int git_config_set_multivar(const char* key, const char* value,
 	}
 
 	if (commit_lock_file(lock) < 0) {
-		fprintf(stderr, "Cannot commit config file!\n");
+		error("could not commit config file %s", config_filename);
 		ret = 4;
 		goto out_free;
 	}
@@ -1051,7 +1048,7 @@ out_free:
 	return ret;
 
 write_err_out:
-	ret = write_error();
+	ret = write_error(lock->filename);
 	goto out_free;
 
 }
@@ -1101,7 +1098,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	config_filename = xstrdup(config_filename);
 	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (out_fd < 0) {
-		ret = error("Could not lock config file!");
+		ret = error("could not lock config file %s", config_filename);
 		goto out;
 	}
 
@@ -1125,7 +1122,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 				}
 				store.baselen = strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error();
+					ret = write_error(lock->filename);
 					goto out;
 				}
 				continue;
@@ -1136,14 +1133,14 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 			continue;
 		length = strlen(buf);
 		if (write_in_full(out_fd, buf, length) != length) {
-			ret = write_error();
+			ret = write_error(lock->filename);
 			goto out;
 		}
 	}
 	fclose(config_file);
  unlock_and_out:
 	if (commit_lock_file(lock) < 0)
-			ret = error("Cannot commit config file!");
+		ret = error("could not commit config file %s", config_filename);
  out:
 	free(config_filename);
 	return ret;
-- 
1.5.5.1.242.gf371f
