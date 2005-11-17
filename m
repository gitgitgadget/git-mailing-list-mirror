From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add functions git_config_set() and git_config_set_multivar()
Date: Thu, 17 Nov 2005 22:32:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172230460.18177@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Nov 17 22:34:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrN5-0003yd-MG
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVKQVci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKQVci
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:32:38 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26551 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751347AbVKQVci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:32:38 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D7C9A13FCAE; Thu, 17 Nov 2005 22:32:36 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BA6799F342; Thu, 17 Nov 2005 22:32:36 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97C9E837F7; Thu, 17 Nov 2005 22:32:36 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7526413FCAE; Thu, 17 Nov 2005 22:32:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12154>

    
The function git_config_set() does exactly what you think it does.
Given a key (in the form "core.filemode") and a value, it sets the
key to the value. Example:

	git_config_set("core.filemode", "true");

The function git_config_set_multivar() is meant for setting variables which
can have several values for the same key. Example:

	[diff]
		twohead = resolve
		twohead = recarsive

the typo in the second line can be replaced by

	git_config_set_multivar("diff.twohead", "recursive", "^recar");

The third argument of the function is a POSIX extended regex which has to
match the value. If there is no key/value pair with a matching value, a new
key/value pair is added.

These commands are also capable of unsetting (deleting) entries:

	git_config_set_multivar("diff.twohead", NULL, "sol");

will delete the entry

		twohead = resolve

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 cache.h  |    2 
 config.c |  294 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+), 1 deletions(-)
diff --git a/cache.h b/cache.h
index 99afa2c..f93f516 100644
--- a/cache.h
+++ b/cache.h
@@ -386,6 +386,8 @@ extern int git_default_config(const char
 extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
+extern int git_config_set(const char *, const char *);
+extern int git_config_set_multivar(const char *, const char *, const char *);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 915bb97..bbcafff 100644
--- a/config.c
+++ b/config.c
@@ -1,5 +1,12 @@
-
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ * Copyright (C) Johannes Schindelin, 2005
+ *
+ */
 #include "cache.h"
+#include <regex.h>
 
 #define MAXNAME (256)
 
@@ -252,3 +259,288 @@ int git_config(config_fn_t fn)
 	}
 	return ret;
 }
+
+/*
+ * Find all the stuff for git_config_set() below.
+ */
+static struct {
+	int baselen;
+	char* key;
+	regex_t* value_regex;
+	off_t offset;
+	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
+	int seen;
+} store;
+
+static int store_aux(const char* key, const char* value)
+{
+	switch (store.state) {
+	case KEY_SEEN:
+		if (!strcmp(key, store.key) &&
+				(store.value_regex == NULL ||
+				!regexec(store.value_regex, value, 0, NULL, 0))) {
+			if (store.seen == 1) {
+				fprintf(stderr,
+					"Warning: %s has multiple values\n",
+					key);
+			}
+			store.offset = ftell(config_file);
+			store.seen++;
+		}
+		break;
+	case SECTION_SEEN:
+		if (strncmp(key, store.key, store.baselen+1)) {
+			store.state = SECTION_END_SEEN;
+			break;
+		} else
+			store.offset = ftell(config_file);
+		/* fallthru */
+	case SECTION_END_SEEN:
+	case START:
+		if (!strcmp(key, store.key) &&
+				(store.value_regex == NULL ||
+				!regexec(store.value_regex, value, 0, NULL, 0))) {
+			store.offset = ftell(config_file);
+			store.state = KEY_SEEN;
+			store.seen++;
+		} else if(!strncmp(key, store.key, store.baselen))
+			store.state = SECTION_SEEN;
+	}
+	return 0;
+}
+
+static void store_write_section(int fd, const char* key)
+{
+	write(fd, "[", 1);
+	write(fd, key, store.baselen);
+	write(fd, "]\n", 2);
+}
+
+static void store_write_pair(int fd, const char* key, const char* value)
+{
+	int i;
+
+	write(fd, "\t", 1);
+	write(fd, key+store.baselen+1,
+		strlen(key+store.baselen+1));
+	write(fd, " = ", 3);
+	for (i = 0; value[i]; i++)
+		switch (value[i]) {
+		case '\n': write(fd, "\\n", 2); break;
+		case '\t': write(fd, "\\t", 2); break;
+		case '"': case '\\': write(fd, "\\", 1);
+		default: write(fd, value+i, 1);
+	}
+	write(fd, "\n", 1);
+}
+
+int git_config_set(const char* key, const char* value)
+{
+	return git_config_set_multivar(key, value, NULL);
+}
+
+/*
+ * If value==NULL, unset in (remove from) config,
+ * if value_regex!=NULL, disregard key/value pairs where value does not match.
+ *
+ * Returns 0 on success.
+ *
+ * This function does this:
+ *
+ * - it locks the config file by creating ".git/config.lock"
+ *
+ * - it then parses the config using store_aux() as validator to find
+ *   the position on the key/value pair to replace. If it is to be unset,
+ *   it must be found exactly once.
+ *
+ * - the config file is mmap()ed and the part before the match (if any) is
+ *   written to the lock file, then the changed part and the rest.
+ *
+ * - the config file is removed and the lock file rename()d to it.
+ *
+ */
+int git_config_set_multivar(const char* key, const char* value,
+	const char* value_regex)
+{
+	int i;
+	struct stat st;
+	int fd;
+	char* config_file = strdup(git_path("config"));
+	char* lock_file = strdup(git_path("config.lock"));
+
+	/*
+	 * Since "key" actually contains the section name and the real
+	 * key name separated by a dot, we have to know where the dot is.
+	 */
+	for (store.baselen = 0;
+			key[store.baselen] != '.' && key[store.baselen];
+			store.baselen++);
+	if (!key[store.baselen] || !key[store.baselen+1]) {
+		fprintf(stderr, "key does not contain a section: %s\n", key);
+		return 2;
+	}
+
+	/*
+	 * Validate the key and while at it, lower case it for matching.
+	 */
+	store.key = (char*)malloc(strlen(key)+1);
+	for (i = 0; key[i]; i++)
+		if (i != store.baselen && (!isalnum(key[i]) ||
+				(i == store.baselen+1 && !isalpha(key[i])))) {
+			fprintf(stderr, "invalid key: %s\n", key);
+			free(store.key);
+			return 1;
+		} else
+			store.key[i] = tolower(key[i]);
+
+	/*
+	 * The lock_file serves a purpose in addition to locking: the new
+	 * contents of .git/config will be written into it.
+	 */
+	fd = open(lock_file, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		fprintf(stderr, "could not lock config file\n");
+		free(store.key);
+		return -1;
+	}
+
+	/*
+	 * If .git/config does not exist yet, write a minimal version.
+	 */
+	if (stat(config_file, &st)) {
+		static const char contents[] =
+			"#\n"
+			"# This is the config file\n"
+			"#\n"
+			"\n";
+
+		free(store.key);
+
+		/* if nothing to unset, error out */
+		if (value == NULL) {
+			close(fd);
+			unlink(lock_file);
+			return 5;
+		}
+
+		store.key = (char*)key;
+
+		write(fd, contents, sizeof(contents)-1);
+		store_write_section(fd, key);
+		store_write_pair(fd, key, value);
+	} else{
+		int in_fd;
+		char* contents;
+		int offset, new_line = 0;
+
+		if (value_regex == NULL)
+			store.value_regex = NULL;
+		else {
+			store.value_regex = (regex_t*)malloc(sizeof(regex_t));
+			if (regcomp(store.value_regex, value_regex,
+					REG_EXTENDED)) {
+				fprintf(stderr, "Invalid pattern: %s",
+					value_regex);
+				free(store.value_regex);
+				return 6;
+			}
+		}
+
+		store.offset = 0;
+		store.state = START;
+		store.seen = 0;
+
+		/*
+		 * After this, store.offset will contain the *end* offset
+		 * of the last match, or remain at 0 if no match was found.
+		 * As a side effect, we make sure to transform only a valid
+		 * existing config file.
+		 */
+		if (git_config(store_aux)) {
+			fprintf(stderr, "invalid config file\n");
+			free(store.key);
+			if (store.value_regex != NULL) {
+				regfree(store.value_regex);
+				free(store.value_regex);
+			}
+			return 3;
+		}
+
+		free(store.key);
+		if (store.value_regex != NULL) {
+			regfree(store.value_regex);
+			free(store.value_regex);
+		}
+
+		/* if nothing to unset, error out */
+		if (store.seen == 0 && value == NULL) {
+			close(fd);
+			unlink(lock_file);
+			return 5;
+		}
+
+		store.key = (char*)key;
+
+		in_fd = open(config_file, O_RDONLY, 0666);
+		contents = mmap(NULL, st.st_size, PROT_READ,
+			MAP_PRIVATE, in_fd, 0);
+		close(in_fd);
+
+		if (store.offset == 0) {
+			store.offset = offset = st.st_size;
+		} else if (store.state != KEY_SEEN) {
+			offset = store.offset;
+		} else {
+			int equal_offset = st.st_size,
+				bracket_offset = st.st_size;
+
+			if (value == NULL && store.seen > 1) {
+				fprintf(stderr, "Cannot remove multivar (%s has %d values\n", key, store.seen);
+				close(fd);
+				unlink(lock_file);
+				return 7;
+			}
+			for (offset = store.offset-2; offset > 0 
+					&& contents[offset] != '\n'; offset--)
+				switch (contents[offset]) {
+				case '=': equal_offset = offset; break;
+				case ']': bracket_offset = offset; break;
+				}
+			if (bracket_offset < equal_offset) {
+				new_line = 1;
+				offset = bracket_offset+1;
+			} else
+				offset++;
+		}
+
+		/* write the first part of the config */
+		write(fd, contents, offset);
+		if (new_line)
+			write(fd, "\n", 1);
+
+		/* write the pair (value == NULL means unset) */
+		if (value != NULL) {
+			if (store.state == START)
+				store_write_section(fd, key);
+			store_write_pair(fd, key, value);
+		}
+
+		/* write the rest of the config */
+		if (store.offset < st.st_size)
+			write(fd, contents + store.offset,
+				st.st_size - store.offset);
+
+		munmap(contents, st.st_size);
+		unlink(config_file);
+	}
+
+	close(fd);
+
+	if (rename(lock_file, config_file) < 0) {
+		fprintf(stderr, "Could not rename the lock file?\n");
+		return 4;
+	}
+
+	return 0;
+}
+
