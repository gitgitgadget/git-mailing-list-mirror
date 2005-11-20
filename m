From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-config-set: add more options
Date: Sun, 20 Nov 2005 06:52:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511200650130.12832@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Nov 20 06:53:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edi8S-0001cY-2q
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 06:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVKTFwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 00:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKTFwY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 00:52:24 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13474 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750884AbVKTFwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 00:52:24 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9292F1401CE; Sun, 20 Nov 2005 06:52:22 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 741699F381; Sun, 20 Nov 2005 06:52:22 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 42D349D8EA; Sun, 20 Nov 2005 06:52:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 147501401CE; Sun, 20 Nov 2005 06:52:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12371>

... namely

--replace-all, to replace any amount of matching lines, not just 0 or 1,
--get, to get the value of one key,
--get-all, the multivar version of --get, and
--unset-all, which deletes all matching lines from .git/config

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This patch is on top of my previous patches, because it is not
	a bug fix, but provides new features.

	Also, it extends t1300-config-set.sh to test these, and moves it 
	into t/...

	The only thing I am concerned about now is how to deal with
	anti value_regex's, i.e.

		[proxy]
			command=ssh for kernel.org
			command=rsh

	I cannot think of a POSIX regex which matches all values *not*
	containing " for " (like the second command), short of matching
	the exact value.

	Note: we could adjust the pattern syntax so that a prefix "!"
	means "no match", and "\!" means "match literal !", but this
	is ugly.

 Documentation/git-config-set.txt |   62 ++++++++++++++++++--
 cache.h                          |    3 -
 config-set.c                     |   92 +++++++++++++++++++++++++++++-
 config.c                         |  116 +++++++++++++++++++++++---------------
 t/t1300-config-set.sh            |   46 +++++++++++++++
 5 files changed, 258 insertions(+), 61 deletions(-)
diff --git a/Documentation/git-config-set.txt b/Documentation/git-config-set.txt
index 8e897be..c707fbc 100644
--- a/Documentation/git-config-set.txt
+++ b/Documentation/git-config-set.txt
@@ -8,12 +8,18 @@ git-config-set - Set options in .git/con
 
 SYNOPSIS
 --------
-'git-config-set' ( name [value [value_regex]] | --unset name [value_regex] )
+'git-config-set' name [value [value_regex]]
+'git-config-set' --replace-all name [value [value_regex]]
+'git-config-set' --get name [value_regex]
+'git-config-set' --get-all name [value_regex]
+'git-config-set' --unset name [value_regex]
+'git-config-set' --unset-all name [value_regex]
 
 DESCRIPTION
 -----------
-You can set/replace/unset options with this command. The name is actually
-the section and the key separated by a dot, and the value will be escaped.
+You can query/set/replace/unset options with this command. The name is
+actually the section and the key separated by a dot, and the value will be
+escaped.
 
 If you want to set/unset an option which can occor on multiple lines, you
 should provide a POSIX regex for the value.
@@ -31,8 +37,23 @@ This command will fail if
 OPTIONS
 -------
 
+--replace-all::
+	Default behaviour is to replace at most one line. This replaces
+	all lines matching the key (and optionally the value_regex)
+
+--get::
+	Get the value for a given key (optionally filtered by a regex
+	matching the value).
+
+--get-all::
+	Like get, but does not fail if the number of values for the key
+	is not exactly one.
+
 --unset::
-	Remove the given option from .git/config
+	Remove the line matching the key from .git/config.
+
+--unset-all::
+	Remove all matching lines from .git/config.
 
 
 EXAMPLE
@@ -84,14 +105,39 @@ To delete the entry for renames, do
 % git config-set --unset diff.renames
 ------------
 
-or just
+If you want to delete an entry for a multivar (like proxy.command above),
+you have to provide a regex matching the value of exactly one line.
+
+To query the value for a given key, do
 
 ------------
-% git config-set diff.renames
+% git config-set --get core.filemode
 ------------
 
-If you want to delete an entry for a multivar (like proxy.command above),
-you have to provide a regex matching the value of exactly one line.
+or
+
+------------
+% git config-set core.filemode
+------------
+
+or, to query a multivar:
+
+------------
+% git config-set --get proxy.command "for kernel.org$"
+------------
+
+If you want to know all the values for a multivar, do:
+
+------------
+% git config-set --get-all proxy.command
+------------
+
+If you like to live dangerous, you can replace *all* proxy.commands by a
+new one with
+
+------------
+% git config-set --replace-all proxy.command ssh
+------------
 
 
 Author
diff --git a/cache.h b/cache.h
index e2be3e7..a7c1bbd 100644
--- a/cache.h
+++ b/cache.h
@@ -192,7 +192,6 @@ extern int diff_rename_limit_default;
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern char *enter_repo(char *path, int strict);
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
@@ -388,7 +387,7 @@ extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
-extern int git_config_set_multivar(const char *, const char *, const char *);
+extern int git_config_set_multivar(const char *, const char *, const char *, int);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config-set.c b/config-set.c
index 1b1547b..90a28b3 100644
--- a/config-set.c
+++ b/config-set.c
@@ -1,24 +1,106 @@
 #include "cache.h"
+#include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-config-set name [value [value_regex]] | --unset name [value_regex]";
+"git-config-set [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
+
+static char* key = NULL;
+static char* value = NULL;
+static regex_t* regex = NULL;
+static int do_all = 0;
+static int seen = 0;
+
+static int show_config(const char* key_, const char* value_)
+{
+	if (!strcmp(key_, key) &&
+			(regex == NULL ||
+			 !regexec(regex, value_, 0, NULL, 0))) {
+		if (do_all) {
+			printf("%s\n", value_);
+			return 0;
+		}
+		if (seen > 0) {
+			fprintf(stderr, "More than one value: %s\n", value);
+			free(value);
+		}
+		value = strdup(value_);
+		seen++;
+	}
+	return 0;
+}
+
+static int get_value(const char* key_, const char* regex_)
+{
+	int i;
+
+	key = malloc(strlen(key_)+1);
+	for (i = 0; key_[i]; i++)
+		key[i] = tolower(key_[i]);
+
+	if (regex_) {
+		regex = (regex_t*)malloc(sizeof(regex_t));
+		if (regcomp(regex, regex_, REG_EXTENDED)) {
+			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+			return -1;
+		}
+	}
+
+	i = git_config(show_config);
+	if (value) {
+		printf("%s\n", value);
+		free(value);
+	}
+	free(key);
+	if (regex) {
+		regfree(regex);
+		free(regex);
+	}
+
+	if (do_all)
+		return 0;
+
+	return seen == 1 ? 0 : 1;
+}
 
 int main(int argc, const char **argv)
 {
 	setup_git_directory();
 	switch (argc) {
 	case 2:
-		return git_config_set(argv[1], NULL);
+		return get_value(argv[1], NULL);
 	case 3:
 		if (!strcmp(argv[1], "--unset"))
 			return git_config_set(argv[2], NULL);
-		else
+		else if (!strcmp(argv[1], "--unset-all"))
+			return git_config_set_multivar(argv[2], NULL, NULL, 1);
+		else if (!strcmp(argv[1], "--get"))
+			return get_value(argv[2], NULL);
+		else if (!strcmp(argv[1], "--get-all")) {
+			do_all = 1;
+			return get_value(argv[2], NULL);
+		} else
+
 			return git_config_set(argv[1], argv[2]);
 	case 4:
 		if (!strcmp(argv[1], "--unset"))
-			return git_config_set_multivar(argv[2], NULL, argv[3]);
+			return git_config_set_multivar(argv[2], NULL, argv[3], 0);
+		else if (!strcmp(argv[1], "--unset-all"))
+			return git_config_set_multivar(argv[2], NULL, argv[3], 1);
+		else if (!strcmp(argv[1], "--get"))
+			return get_value(argv[2], argv[3]);
+		else if (!strcmp(argv[1], "--get-all")) {
+			do_all = 1;
+			return get_value(argv[2], argv[3]);
+		} else if (!strcmp(argv[1], "--replace-all"))
+
+			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
 		else
-			return git_config_set_multivar(argv[1], argv[2], argv[3]);
+
+			return git_config_set_multivar(argv[1], argv[2], argv[3], 0);
+	case 5:
+		if (!strcmp(argv[1], "--replace-all"))
+			return git_config_set_multivar(argv[2], argv[3], argv[4], 1);
+	case 1:
 	default:
 		usage(git_config_set_usage);
 	}
diff --git a/config.c b/config.c
index bbcafff..697d79f 100644
--- a/config.c
+++ b/config.c
@@ -263,11 +263,15 @@ int git_config(config_fn_t fn)
 /*
  * Find all the stuff for git_config_set() below.
  */
+
+#define MAX_MATCHES 512
+
 static struct {
 	int baselen;
 	char* key;
 	regex_t* value_regex;
-	off_t offset;
+	int multi_replace;
+	off_t offset[MAX_MATCHES];
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 	int seen;
 } store;
@@ -279,12 +283,16 @@ static int store_aux(const char* key, co
 		if (!strcmp(key, store.key) &&
 				(store.value_regex == NULL ||
 				!regexec(store.value_regex, value, 0, NULL, 0))) {
-			if (store.seen == 1) {
+			if (store.seen == 1 && store.multi_replace == 0) {
 				fprintf(stderr,
 					"Warning: %s has multiple values\n",
 					key);
+			} else if (store.seen >= MAX_MATCHES) {
+				fprintf(stderr, "Too many matches\n");
+				return 1;
 			}
-			store.offset = ftell(config_file);
+
+			store.offset[store.seen] = ftell(config_file);
 			store.seen++;
 		}
 		break;
@@ -293,14 +301,15 @@ static int store_aux(const char* key, co
 			store.state = SECTION_END_SEEN;
 			break;
 		} else
-			store.offset = ftell(config_file);
+			/* do not increment matches: this is no match */
+			store.offset[store.seen] = ftell(config_file);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (!strcmp(key, store.key) &&
 				(store.value_regex == NULL ||
 				!regexec(store.value_regex, value, 0, NULL, 0))) {
-			store.offset = ftell(config_file);
+			store.offset[store.seen] = ftell(config_file);
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else if(!strncmp(key, store.key, store.baselen))
@@ -334,14 +343,38 @@ static void store_write_pair(int fd, con
 	write(fd, "\n", 1);
 }
 
+static int find_beginning_of_line(const char* contents, int size,
+	int offset_, int* found_bracket)
+{
+	int equal_offset = size, bracket_offset = size;
+	int offset;
+
+	for (offset = offset_-2; offset > 0 
+			&& contents[offset] != '\n'; offset--)
+		switch (contents[offset]) {
+			case '=': equal_offset = offset; break;
+			case ']': bracket_offset = offset; break;
+		}
+	if (bracket_offset < equal_offset) {
+		*found_bracket = 1;
+		offset = bracket_offset+1;
+	} else
+		offset++;
+
+	return offset;
+}
+
 int git_config_set(const char* key, const char* value)
 {
-	return git_config_set_multivar(key, value, NULL);
+	return git_config_set_multivar(key, value, NULL, 0);
 }
 
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
+ * if multi_replace==0, nothing, or only one matching key/value is replaced,
+ *     else all matching key/values (regardless how many) are removed,
+ *     before the new pair is written.
  *
  * Returns 0 on success.
  *
@@ -360,7 +393,7 @@ int git_config_set(const char* key, cons
  *
  */
 int git_config_set_multivar(const char* key, const char* value,
-	const char* value_regex)
+	const char* value_regex, int multi_replace)
 {
 	int i;
 	struct stat st;
@@ -368,6 +401,8 @@ int git_config_set_multivar(const char* 
 	char* config_file = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
 
+	store.multi_replace = multi_replace;
+
 	/*
 	 * Since "key" actually contains the section name and the real
 	 * key name separated by a dot, we have to know where the dot is.
@@ -431,7 +466,7 @@ int git_config_set_multivar(const char* 
 	} else{
 		int in_fd;
 		char* contents;
-		int offset, new_line = 0;
+		int i, copy_begin, copy_end, new_line = 0;
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
@@ -446,7 +481,7 @@ int git_config_set_multivar(const char* 
 			}
 		}
 
-		store.offset = 0;
+		store.offset[0] = 0;
 		store.state = START;
 		store.seen = 0;
 
@@ -472,52 +507,42 @@ int git_config_set_multivar(const char* 
 			free(store.value_regex);
 		}
 
-		/* if nothing to unset, error out */
-		if (store.seen == 0 && value == NULL) {
+		/* if nothing to unset, or too many matches, error out */
+		if ((store.seen == 0 && value == NULL) ||
+				(store.seen > 1 && multi_replace == 0)) {
 			close(fd);
 			unlink(lock_file);
 			return 5;
 		}
 
-		store.key = (char*)key;
-
 		in_fd = open(config_file, O_RDONLY, 0666);
 		contents = mmap(NULL, st.st_size, PROT_READ,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
-		if (store.offset == 0) {
-			store.offset = offset = st.st_size;
-		} else if (store.state != KEY_SEEN) {
-			offset = store.offset;
-		} else {
-			int equal_offset = st.st_size,
-				bracket_offset = st.st_size;
-
-			if (value == NULL && store.seen > 1) {
-				fprintf(stderr, "Cannot remove multivar (%s has %d values\n", key, store.seen);
-				close(fd);
-				unlink(lock_file);
-				return 7;
-			}
-			for (offset = store.offset-2; offset > 0 
-					&& contents[offset] != '\n'; offset--)
-				switch (contents[offset]) {
-				case '=': equal_offset = offset; break;
-				case ']': bracket_offset = offset; break;
-				}
-			if (bracket_offset < equal_offset) {
-				new_line = 1;
-				offset = bracket_offset+1;
+		if (store.seen == 0)
+			store.seen = 1;
+
+		for (i = 0, copy_begin = 0; i < store.seen; i++) {
+			if (store.offset[i] == 0) {
+				store.offset[i] = copy_end = st.st_size;
+			} else if (store.state != KEY_SEEN) {
+				copy_end = store.offset[i];
 			} else
-				offset++;
+				copy_end = find_beginning_of_line(
+					contents, st.st_size,
+					store.offset[i]-2, &new_line);
+
+			/* write the first part of the config */
+			if (copy_end > copy_begin) {
+				write(fd, contents + copy_begin,
+				copy_end - copy_begin);
+				if (new_line)
+					write(fd, "\n", 1);
+			}
+			copy_begin = store.offset[i];
 		}
 
-		/* write the first part of the config */
-		write(fd, contents, offset);
-		if (new_line)
-			write(fd, "\n", 1);
-
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
 			if (store.state == START)
@@ -526,9 +551,9 @@ int git_config_set_multivar(const char* 
 		}
 
 		/* write the rest of the config */
-		if (store.offset < st.st_size)
-			write(fd, contents + store.offset,
-				st.st_size - store.offset);
+		if (copy_begin < st.st_size)
+			write(fd, contents + copy_begin,
+				st.st_size - copy_begin);
 
 		munmap(contents, st.st_size);
 		unlink(config_file);
@@ -544,3 +569,4 @@ int git_config_set_multivar(const char* 
 	return 0;
 }
 
+
diff --git a/t1300-config-set.sh b/t/t1300-config-set.sh
similarity index 100%
rename from t1300-config-set.sh
rename to t/t1300-config-set.sh
index df89216..717bf4d 100644
--- a/t1300-config-set.sh
+++ b/t/t1300-config-set.sh
@@ -76,9 +76,44 @@ noIndent= sillyValue ; 'nother silly com
 # empty line
 		; comment
 		haha   ="beta" # last silly comment
+haha = hello
+	haha = bello
 [nextSection] noNewline = ouch
 EOF
 
+cp .git/config .git/config2
+
+test_expect_success 'multiple unset' \
+	'git-config-set --unset-all beta.haha'
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+[nextSection] noNewline = ouch
+EOF
+
+test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
+
+mv .git/config2 .git/config
+
+test_expect_success '--replace-all' \
+	'git-config-set --replace-all beta.haha gamma'
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+	haha = gamma
+[nextSection] noNewline = ouch
+EOF
+
+test_expect_success 'all replaced' 'cmp .git/config expect'
+
 git-config-set beta.haha alpha
 
 cat > expect << EOF
@@ -108,7 +143,8 @@ EOF
 
 test_expect_success 'really really mean test' 'cmp .git/config expect'
 
-git-config-set beta.haha
+test_expect_success 'get value' 'test alpha = $(git-config-set beta.haha)'
+git-config-set --unset beta.haha
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -137,6 +173,12 @@ EOF
 
 test_expect_success 'multivar' 'cmp .git/config expect'
 
+test_expect_failure 'ambiguous get' \
+	'git-config-set --get nextsection.nonewline'
+
+test_expect_success 'get multivar' \
+	'git-config-set --get-all nextsection.nonewline'
+
 git-config-set nextsection.nonewline "wow3" "wow$"
 
 cat > expect << EOF
@@ -152,6 +194,8 @@ EOF
 
 test_expect_success 'multivar replace' 'cmp .git/config expect'
 
+test_expect_failure 'ambiguous value' 'git-config-set nextsection.nonewline'
+
 test_expect_failure 'ambiguous unset' \
 	'git-config-set --unset nextsection.nonewline'
 
