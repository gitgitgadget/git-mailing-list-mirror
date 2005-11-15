From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Add function git_config_set()
Date: Tue, 15 Nov 2005 22:36:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511152233030.2152@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 15 22:37:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8TR-0005uz-8k
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVKOVgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVKOVgN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:36:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6348 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750984AbVKOVgM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:36:12 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A57CA13F704; Tue, 15 Nov 2005 22:36:11 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 88D639F2FC; Tue, 15 Nov 2005 22:36:11 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6A95F9F2F9; Tue, 15 Nov 2005 22:36:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C4CC13F704; Tue, 15 Nov 2005 22:36:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11943>


This function does exactly what you think it does. Given a key and a value,
it sets the key (in the form "core.filemode") to the value.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 cache.h  |    1 
 config.c |  145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 0 deletions(-)

applies-to: a54ecd1a81180a8d860a6554e6fc71dcab3327ef
c38f654a4387ed503a8ea445824e49b44a796c61
diff --git a/cache.h b/cache.h
index 9a6bfb9..91070ae 100644
--- a/cache.h
+++ b/cache.h
@@ -384,6 +384,7 @@ extern int git_default_config(const char
 extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
+extern int git_config_set(const char *, const char *);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index bd35138..1b39290 100644
--- a/config.c
+++ b/config.c
@@ -247,3 +247,148 @@ int git_config(config_fn_t fn)
 	}
 	return ret;
 }
+
+static struct {
+	int baselen;
+	const char* key;
+	const char* value;
+	off_t offset;
+	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
+} store;
+
+static int store_aux(const char* key, const char* value)
+{
+	switch (store.state) {
+		case KEY_SEEN:
+			if (!strcmp(key, store.key))
+				store.offset = ftell(config_file);
+			break;
+		case SECTION_SEEN:
+			if (strncmp(key, store.key, store.baselen+1)) {
+				store.offset = ftell(config_file);
+				store.state = SECTION_END_SEEN;
+				break;
+			}
+		case SECTION_END_SEEN:
+		case START:
+			if (!strcmp(key, store.key)) {
+				store.offset = ftell(config_file);
+				store.state = KEY_SEEN;
+			} else if(!strncmp(key, store.key, store.baselen))
+				store.state = SECTION_SEEN;
+	}
+	return 0;
+}
+
+static void store_write_section(int fd)
+{
+	write(fd, "[", 1);
+	write(fd, store.key, store.baselen);
+	write(fd, "]\n", 2);
+}
+
+static void store_write_pair(int fd)
+{
+	int i;
+
+	write(fd, "\t", 1);
+	write(fd, store.key+store.baselen+1,
+		strlen(store.key+store.baselen+1));
+	write(fd, " = ", 3);
+	for (i = 0; store.value[i]; i++)
+		switch (store.value[i]) {
+		case '\n': write(fd, "\\n", 2); break;
+		case '\t': write(fd, "\\t", 2); break;
+		case '"': case '\\': write(fd, "\\", 1);
+		default: write(fd, store.value+i, 1);
+	}
+	write(fd, "\n", 1);
+}
+
+int git_config_set(const char* key, const char* value)
+{
+	int i;
+	struct stat st;
+	int fd;
+	char* config_file = strdup(git_path("config"));
+	char* lock_file = strdup(git_path("config.lock"));
+
+	for (store.baselen = 0;
+			key[store.baselen] != '.' && key[store.baselen];
+			store.baselen++);
+	if (!key[store.baselen]) {
+		fprintf(stderr, "key does not contain a section: %s\n", key);
+		return 2;
+	}
+
+	for (i = 0; key[i]; i++)
+		if (i != store.baselen && !isalpha(key[i])) {
+			fprintf(stderr, "invalid key: %s\n", key);
+			return 1;
+		}
+
+	store.key = key;
+	store.value = value;
+
+	fd = open(lock_file, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0) {
+		fprintf(stderr, "could not lock config file\n");
+		return -1;
+	}
+
+	if (stat(config_file, &st)) {
+		/* write new file */
+		static const char contents[] =
+			"#\n"
+			"# This is the config file\n"
+			"#\n"
+			"\n";
+
+		write(fd, contents, sizeof(contents)-1);
+		store_write_section(fd);
+		store_write_pair(fd);
+	} else{
+		int in_fd;
+		char* contents;
+		int offset;
+
+		store.offset = 0;
+		store.state = START;
+
+		if (git_config(store_aux)) {
+			fprintf(stderr, "invalid config file\n");
+			return 3;
+		}
+
+		in_fd = open(config_file, O_RDONLY, 0666);
+		contents = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, in_fd, 0);
+		close(in_fd);
+
+		if (store.offset == 0)
+			offset = st.st_size;
+		else {
+			for (offset = store.offset-2; offset > 0 
+					&& contents[offset] != '\n'; offset--);
+			offset++;
+		}
+		write(fd, contents, offset);
+		if (store.state == START)
+			store_write_section(fd);
+		store_write_pair(fd);
+		if (store.offset > offset)
+			write(fd, contents + store.offset,
+				st.st_size - store.offset);
+		
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
---
0.99.9.GIT
