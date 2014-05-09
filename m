From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/17] contrib: remove 'convert-objects'
Date: Fri,  9 May 2014 14:11:34 -0500
Message-ID: <1399662703-355-9-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDg-0001Rg-Vg
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbaEITMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:25 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:49223 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165AbaEITMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:20 -0400
Received: by mail-yh0-f44.google.com with SMTP id b6so4141570yha.17
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/KSeScZzbhv3744tlD6208u8GfhuXRG3Fgm8pCBgzhE=;
        b=A4RWBpxZf4gW0xnBKXAEudRTbiJAvHfqyuE0sGtZIWxLL7WiogOJCHM8Bc0vESHmmw
         7zO2/y2JlamSEHirwomSx+59gIlB9er4RrgerUGqvCCE6hly2EkNBkqzs+8Tua2tb7fz
         mcMWrsyO0OK8QS5KVVv5Ts/CPERzlsCDH8ambdf84DCXxS25SHSo86s7tK5cq2scYW9m
         Q9iIETbBOl7A3CP6t6CRO/rG9A+++Ze06zbixz0sJD2m4p32S4CHsv+UHAdWS4NzWNP9
         fMGfJvGNon7VeHHY596JzkgbP0VQiXHCGj0p1Fhw0+QLDaGkt1I6mXY9w8xNI1lCLjLD
         D0ZQ==
X-Received: by 10.236.141.113 with SMTP id f77mr17996583yhj.128.1399662740289;
        Fri, 09 May 2014 12:12:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r46sm7411558yhd.29.2014.05.09.12.12.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248619>

No activity since 2010, no tests, no documentation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/convert-objects/convert-objects.c       | 329 ------------------------
 contrib/convert-objects/git-convert-objects.txt |  29 ---
 2 files changed, 358 deletions(-)
 delete mode 100644 contrib/convert-objects/convert-objects.c
 delete mode 100644 contrib/convert-objects/git-convert-objects.txt

diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
deleted file mode 100644
index f3b57bf..0000000
--- a/contrib/convert-objects/convert-objects.c
+++ /dev/null
@@ -1,329 +0,0 @@
-#include "cache.h"
-#include "blob.h"
-#include "commit.h"
-#include "tree.h"
-
-struct entry {
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
-	int converted;
-};
-
-#define MAXOBJECTS (1000000)
-
-static struct entry *convert[MAXOBJECTS];
-static int nr_convert;
-
-static struct entry * convert_entry(unsigned char *sha1);
-
-static struct entry *insert_new(unsigned char *sha1, int pos)
-{
-	struct entry *new = xcalloc(1, sizeof(struct entry));
-	hashcpy(new->old_sha1, sha1);
-	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
-	convert[pos] = new;
-	nr_convert++;
-	if (nr_convert == MAXOBJECTS)
-		die("you're kidding me - hit maximum object limit");
-	return new;
-}
-
-static struct entry *lookup_entry(unsigned char *sha1)
-{
-	int low = 0, high = nr_convert;
-
-	while (low < high) {
-		int next = (low + high) / 2;
-		struct entry *n = convert[next];
-		int cmp = hashcmp(sha1, n->old_sha1);
-		if (!cmp)
-			return n;
-		if (cmp < 0) {
-			high = next;
-			continue;
-		}
-		low = next+1;
-	}
-	return insert_new(sha1, low);
-}
-
-static void convert_binary_sha1(void *buffer)
-{
-	struct entry *entry = convert_entry(buffer);
-	hashcpy(buffer, entry->new_sha1);
-}
-
-static void convert_ascii_sha1(void *buffer)
-{
-	unsigned char sha1[20];
-	struct entry *entry;
-
-	if (get_sha1_hex(buffer, sha1))
-		die("expected sha1, got '%s'", (char *) buffer);
-	entry = convert_entry(sha1);
-	memcpy(buffer, sha1_to_hex(entry->new_sha1), 40);
-}
-
-static unsigned int convert_mode(unsigned int mode)
-{
-	unsigned int newmode;
-
-	newmode = mode & S_IFMT;
-	if (S_ISREG(mode))
-		newmode |= (mode & 0100) ? 0755 : 0644;
-	return newmode;
-}
-
-static int write_subdirectory(void *buffer, unsigned long size, const char *base, int baselen, unsigned char *result_sha1)
-{
-	char *new = xmalloc(size);
-	unsigned long newlen = 0;
-	unsigned long used;
-
-	used = 0;
-	while (size) {
-		int len = 21 + strlen(buffer);
-		char *path = strchr(buffer, ' ');
-		unsigned char *sha1;
-		unsigned int mode;
-		char *slash, *origpath;
-
-		if (!path || strtoul_ui(buffer, 8, &mode))
-			die("bad tree conversion");
-		mode = convert_mode(mode);
-		path++;
-		if (memcmp(path, base, baselen))
-			break;
-		origpath = path;
-		path += baselen;
-		slash = strchr(path, '/');
-		if (!slash) {
-			newlen += sprintf(new + newlen, "%o %s", mode, path);
-			new[newlen++] = '\0';
-			hashcpy((unsigned char *)new + newlen, (unsigned char *) buffer + len - 20);
-			newlen += 20;
-
-			used += len;
-			size -= len;
-			buffer = (char *) buffer + len;
-			continue;
-		}
-
-		newlen += sprintf(new + newlen, "%o %.*s", S_IFDIR, (int)(slash - path), path);
-		new[newlen++] = 0;
-		sha1 = (unsigned char *)(new + newlen);
-		newlen += 20;
-
-		len = write_subdirectory(buffer, size, origpath, slash-origpath+1, sha1);
-
-		used += len;
-		size -= len;
-		buffer = (char *) buffer + len;
-	}
-
-	write_sha1_file(new, newlen, tree_type, result_sha1);
-	free(new);
-	return used;
-}
-
-static void convert_tree(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	void *orig_buffer = buffer;
-	unsigned long orig_size = size;
-
-	while (size) {
-		size_t len = 1+strlen(buffer);
-
-		convert_binary_sha1((char *) buffer + len);
-
-		len += 20;
-		if (len > size)
-			die("corrupt tree object");
-		size -= len;
-		buffer = (char *) buffer + len;
-	}
-
-	write_subdirectory(orig_buffer, orig_size, "", 0, result_sha1);
-}
-
-static unsigned long parse_oldstyle_date(const char *buf)
-{
-	char c, *p;
-	char buffer[100];
-	struct tm tm;
-	const char *formats[] = {
-		"%c",
-		"%a %b %d %T",
-		"%Z",
-		"%Y",
-		" %Y",
-		NULL
-	};
-	/* We only ever did two timezones in the bad old format .. */
-	const char *timezones[] = {
-		"PDT", "PST", "CEST", NULL
-	};
-	const char **fmt = formats;
-
-	p = buffer;
-	while (isspace(c = *buf))
-		buf++;
-	while ((c = *buf++) != '\n')
-		*p++ = c;
-	*p++ = 0;
-	buf = buffer;
-	memset(&tm, 0, sizeof(tm));
-	do {
-		const char *next = strptime(buf, *fmt, &tm);
-		if (next) {
-			if (!*next)
-				return mktime(&tm);
-			buf = next;
-		} else {
-			const char **p = timezones;
-			while (isspace(*buf))
-				buf++;
-			while (*p) {
-				if (!memcmp(buf, *p, strlen(*p))) {
-					buf += strlen(*p);
-					break;
-				}
-				p++;
-			}
-		}
-		fmt++;
-	} while (*buf && *fmt);
-	printf("left: %s\n", buf);
-	return mktime(&tm);
-}
-
-static int convert_date_line(char *dst, void **buf, unsigned long *sp)
-{
-	unsigned long size = *sp;
-	char *line = *buf;
-	char *next = strchr(line, '\n');
-	char *date = strchr(line, '>');
-	int len;
-
-	if (!next || !date)
-		die("missing or bad author/committer line %s", line);
-	next++; date += 2;
-
-	*buf = next;
-	*sp = size - (next - line);
-
-	len = date - line;
-	memcpy(dst, line, len);
-	dst += len;
-
-	/* Is it already in new format? */
-	if (isdigit(*date)) {
-		int datelen = next - date;
-		memcpy(dst, date, datelen);
-		return len + datelen;
-	}
-
-	/*
-	 * Hacky hacky: one of the sparse old-style commits does not have
-	 * any date at all, but we can fake it by using the committer date.
-	 */
-	if (*date == '\n' && strchr(next, '>'))
-		date = strchr(next, '>')+2;
-
-	return len + sprintf(dst, "%lu -0700\n", parse_oldstyle_date(date));
-}
-
-static void convert_date(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	char *new = xmalloc(size + 100);
-	unsigned long newlen = 0;
-
-	/* "tree <sha1>\n" */
-	memcpy(new + newlen, buffer, 46);
-	newlen += 46;
-	buffer = (char *) buffer + 46;
-	size -= 46;
-
-	/* "parent <sha1>\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
-		memcpy(new + newlen, buffer, 48);
-		newlen += 48;
-		buffer = (char *) buffer + 48;
-		size -= 48;
-	}
-
-	/* "author xyz <xyz> date" */
-	newlen += convert_date_line(new + newlen, &buffer, &size);
-	/* "committer xyz <xyz> date" */
-	newlen += convert_date_line(new + newlen, &buffer, &size);
-
-	/* Rest */
-	memcpy(new + newlen, buffer, size);
-	newlen += size;
-
-	write_sha1_file(new, newlen, commit_type, result_sha1);
-	free(new);
-}
-
-static void convert_commit(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	void *orig_buffer = buffer;
-	unsigned long orig_size = size;
-
-	if (memcmp(buffer, "tree ", 5))
-		die("Bad commit '%s'", (char *) buffer);
-	convert_ascii_sha1((char *) buffer + 5);
-	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
-		convert_ascii_sha1((char *) buffer + 7);
-		buffer = (char *) buffer + 48;
-	}
-	convert_date(orig_buffer, orig_size, result_sha1);
-}
-
-static struct entry * convert_entry(unsigned char *sha1)
-{
-	struct entry *entry = lookup_entry(sha1);
-	enum object_type type;
-	void *buffer, *data;
-	unsigned long size;
-
-	if (entry->converted)
-		return entry;
-	data = read_sha1_file(sha1, &type, &size);
-	if (!data)
-		die("unable to read object %s", sha1_to_hex(sha1));
-
-	buffer = xmalloc(size);
-	memcpy(buffer, data, size);
-
-	if (type == OBJ_BLOB) {
-		write_sha1_file(buffer, size, blob_type, entry->new_sha1);
-	} else if (type == OBJ_TREE)
-		convert_tree(buffer, size, entry->new_sha1);
-	else if (type == OBJ_COMMIT)
-		convert_commit(buffer, size, entry->new_sha1);
-	else
-		die("unknown object type %d in %s", type, sha1_to_hex(sha1));
-	entry->converted = 1;
-	free(buffer);
-	free(data);
-	return entry;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned char sha1[20];
-	struct entry *entry;
-
-	setup_git_directory();
-
-	if (argc != 2)
-		usage("git-convert-objects <sha1>");
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	entry = convert_entry(sha1);
-	printf("new sha1: %s\n", sha1_to_hex(entry->new_sha1));
-	return 0;
-}
diff --git a/contrib/convert-objects/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
deleted file mode 100644
index 0565d83..0000000
--- a/contrib/convert-objects/git-convert-objects.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-git-convert-objects(1)
-======================
-
-NAME
-----
-git-convert-objects - Converts old-style git repository
-
-
-SYNOPSIS
---------
-[verse]
-'git-convert-objects'
-
-DESCRIPTION
------------
-Converts old-style git repository to the latest format
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-- 
1.9.2+fc1.28.g12374c0
