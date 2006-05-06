From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] config: mmap() the contents of the config file
Date: Sun, 7 May 2006 01:04:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605070103270.26358@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 01:04:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcVpI-0005n4-FQ
	for gcvg-git@gmane.org; Sun, 07 May 2006 01:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWEFXEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 19:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWEFXEi
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 19:04:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23967 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750940AbWEFXEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 19:04:37 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1F54D15E4;
	Sun,  7 May 2006 01:04:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 105321A7E;
	Sun,  7 May 2006 01:04:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E638F15E4;
	Sun,  7 May 2006 01:04:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19681>


This makes it possible to rewrite the config without accessing the config
file twice.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Linus said he'd prefer this.

	One thing I am not quite sure about: should we remember the file's 
	mtime and check it to see if the config file has changed since we 
	mmap()ed it?

	BTW this patch is on top of next, and does not yet contain Sean's
	bug fix.

 config.c |  102 ++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/config.c b/config.c
index 87fb220..05d4d8c 100644
--- a/config.c
+++ b/config.c
@@ -10,31 +10,27 @@ #include <regex.h>
 
 #define MAXNAME (256)
 
-static FILE *config_file;
+static const char *contents = NULL;
+static int config_length = 0, config_offset = 0;
 static const char *config_file_name;
 static int config_linenr;
 static int get_next_char(void)
 {
 	int c;
-	FILE *f;
 
 	c = '\n';
-	if ((f = config_file) != NULL) {
-		c = fgetc(f);
-		if (c == '\r') {
+	if (config_offset < config_length) {
+		c = contents[config_offset++];
+		if (c == '\r' && config_offset < config_length) {
 			/* DOS like systems */
-			c = fgetc(f);
+			c = contents[config_offset++];
 			if (c != '\n') {
-				ungetc(c, f);
+				config_offset--;
 				c = '\r';
 			}
 		}
 		if (c == '\n')
 			config_linenr++;
-		if (c == EOF) {
-			config_file = NULL;
-			c = '\n';
-		}
 	}
 	return c;
 }
@@ -162,7 +158,7 @@ static int git_parse_file(config_fn_t fn
 		int c = get_next_char();
 		if (c == '\n') {
 			/* EOF? */
-			if (!config_file)
+			if (config_offset >= config_length)
 				return 0;
 			comment = 0;
 			continue;
@@ -258,18 +254,41 @@ int git_default_config(const char *var, 
 
 int git_config_from_file(config_fn_t fn, const char *filename)
 {
-	int ret;
-	FILE *f = fopen(filename, "r");
+	int ret, in_fd;
+
+	config_offset = 0;
+
+	if (contents) {
+		if (!strcmp(config_file_name, filename))
+			return git_parse_file(fn);
+		munmap((char*)contents, config_length);
+		free((char*)config_file_name);
+	}
+
+	in_fd = open(filename, O_RDONLY);
 
 	ret = -1;
-	if (f) {
-		config_file = f;
-		config_file_name = filename;
+	if (in_fd > 0) {
+		struct stat st;
+
+		fstat(in_fd, &st);
+		config_length = st.st_size;
+		contents = mmap(NULL, config_length, PROT_READ, MAP_PRIVATE,
+				in_fd, 0);
+		close(in_fd);
+
+		config_file_name = strdup(filename);
 		config_linenr = 1;
+		config_offset = 0;
 		ret = git_parse_file(fn);
-		fclose(f);
-		config_file_name = NULL;
+	} else {
+		contents = NULL;
+		config_length = 0;
+		if (in_fd < 0 && ENOENT != errno )
+			die("opening %s: %s", config_file_name,
+					strerror(errno));
 	}
+
 	return ret;
 }
 
@@ -317,7 +336,7 @@ static int store_aux(const char* key, co
 				return 1;
 			}
 
-			store.offset[store.seen] = ftell(config_file);
+			store.offset[store.seen] = config_offset;
 			store.seen++;
 		}
 		break;
@@ -327,12 +346,12 @@ static int store_aux(const char* key, co
 			break;
 		} else
 			/* do not increment matches: this is no match */
-			store.offset[store.seen] = ftell(config_file);
+			store.offset[store.seen] = config_offset;
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			store.offset[store.seen] = ftell(config_file);
+			store.offset[store.seen] = config_offset;
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else if (strrchr(key, '.') - key == store.baselen &&
@@ -367,10 +386,9 @@ static void store_write_pair(int fd, con
 	write(fd, "\n", 1);
 }
 
-static int find_beginning_of_line(const char* contents, int size,
-	int offset_, int* found_bracket)
+static int find_beginning_of_line(int offset_, int* found_bracket)
 {
-	int equal_offset = size, bracket_offset = size;
+	int equal_offset = config_length, bracket_offset = config_length;
 	int offset;
 
 	for (offset = offset_-2; offset > 0 
@@ -420,7 +438,7 @@ int git_config_set_multivar(const char* 
 	const char* value_regex, int multi_replace)
 {
 	int i;
-	int fd, in_fd;
+	int fd;
 	int ret;
 	char* config_filename = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
@@ -471,18 +489,9 @@ int git_config_set_multivar(const char* 
 	/*
 	 * If .git/config does not exist yet, write a minimal version.
 	 */
-	in_fd = open(config_filename, O_RDONLY);
-	if ( in_fd < 0 ) {
+	if (!contents) {
 		free(store.key);
 
-		if ( ENOENT != errno ) {
-			error("opening %s: %s", config_filename,
-			      strerror(errno));
-			close(fd);
-			unlink(lock_file);
-			ret = 3; /* same as "invalid config file" */
-			goto out_free;
-		}
 		/* if nothing to unset, error out */
 		if (value == NULL) {
 			close(fd);
@@ -494,9 +503,7 @@ int git_config_set_multivar(const char* 
 		store.key = (char*)key;
 		store_write_section(fd, key);
 		store_write_pair(fd, key, value);
-	} else{
-		struct stat st;
-		char* contents;
+	} else {
 		int i, copy_begin, copy_end, new_line = 0;
 
 		if (value_regex == NULL)
@@ -555,23 +562,17 @@ int git_config_set_multivar(const char* 
 			goto out_free;
 		}
 
-		fstat(in_fd, &st);
-		contents = mmap(NULL, st.st_size, PROT_READ,
-			MAP_PRIVATE, in_fd, 0);
-		close(in_fd);
-
 		if (store.seen == 0)
 			store.seen = 1;
 
 		for (i = 0, copy_begin = 0; i < store.seen; i++) {
 			if (store.offset[i] == 0) {
-				store.offset[i] = copy_end = st.st_size;
+				store.offset[i] = copy_end = config_length;
 			} else if (store.state != KEY_SEEN) {
 				copy_end = store.offset[i];
 			} else
 				copy_end = find_beginning_of_line(
-					contents, st.st_size,
-					store.offset[i]-2, &new_line);
+					store.offset[i] - 2, &new_line);
 
 			/* write the first part of the config */
 			if (copy_end > copy_begin) {
@@ -591,11 +592,12 @@ int git_config_set_multivar(const char* 
 		}
 
 		/* write the rest of the config */
-		if (copy_begin < st.st_size)
+		if (copy_begin < config_length)
 			write(fd, contents + copy_begin,
-				st.st_size - copy_begin);
+				config_length - copy_begin);
 
-		munmap(contents, st.st_size);
+		munmap((char*)contents, config_length);
+		contents = NULL;
 		unlink(config_filename);
 	}
 
-- 
1.3.1.g5545a
