From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 06/14] read-cache: get modified file list from file watcher
Date: Fri, 17 Jan 2014 16:47:32 +0700
Message-ID: <1389952060-12297-7-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4630-0002uW-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbaAQJsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:54 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62742 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbaAQJsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:45 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so3355914pbc.14
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IHpQ4507hieETflbWFhq0WD2cHjiai/Ey8fFusGOO5A=;
        b=AfrofsRT0Ddw/2lnkPR+dfCYg2xIPj841pPIARlACzJ1bPjhgEdROGoApTxWXEHbub
         meoeoCvuccEyeV6ayCHSClmt5qKMesDgxtDHBuzM+pe9Xo026dpDA7XNU4Ix2hsVnDAb
         ktlE3r1PilcQrp+0xqViYHDw7U7JvDBB9LYPhx96wWD86F8ME3mIW5Bp3R6EHAQPIHP9
         pnADx3ENDrtXvIK4sxjmnyHnavBue+gLPkkO4aWPRce0+N06f3F39iCM8G/4uRIt9917
         JblvE98S2PebywZfS1Mg7urFNPUgwE/91Hi8ABXqVlDJ2fzbjxVDnc+kB1leKrJzM/oz
         iC9A==
X-Received: by 10.66.248.130 with SMTP id ym2mr1047327pac.9.1389952121336;
        Fri, 17 Jan 2014 01:48:41 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id pq1sm21359042pbc.8.2014.01.17.01.48.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:35 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240589>

A new command is added to file watcher to send back the list of
updated files to git. These entries will have CE_WATCHED removed. The
remaining CE_WATCHED entries will have CE_VALID set (i.e. no changes
and no lstat either).

The file watcher does not cache stat info and send back to git. Its
main purpose is to reduce lstat on most untouched files, not to
completely eliminate lstat.

The file watcher keeps reporting the same "updated" list until it
receives "forget" commands, which should only be issued after the
updated index is written down. This ensures that if git crashes half
way before it could update the index (or multiple processes is reading
the same index), "updated" info is not lost.

After the index is updated (e.g. in this case because of toggling
CE_WATCHED bits), git sends the new index signature to the file
watcher.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |   1 +
 file-watcher.c |  63 +++++++++++++++++++++++++++++++++---
 read-cache.c   | 100 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 3 files changed, 157 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index bcec29b..8f065ed 100644
--- a/cache.h
+++ b/cache.h
@@ -284,6 +284,7 @@ struct index_state {
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	int watcher;
+	struct string_list *updated_entries;
 };
=20
 extern struct index_state the_index;
diff --git a/file-watcher.c b/file-watcher.c
index 3a54168..369af37 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 #include "file-watcher-lib.h"
+#include "string-list.h"
 #include "pkt-line.h"
=20
 static const char *const file_watcher_usage[] =3D {
@@ -11,6 +12,8 @@ static const char *const file_watcher_usage[] =3D {
 };
=20
 static char index_signature[41];
+static struct string_list updated =3D STRING_LIST_INIT_DUP;
+static int updated_sorted;
=20
 static int watch_path(char *path)
 {
@@ -23,6 +26,37 @@ static int watch_path(char *path)
 	return -1;
 }
=20
+static void reset(void)
+{
+	string_list_clear(&updated, 0);
+	index_signature[0] =3D '\0';
+}
+
+static void send_status(int fd, struct sockaddr_un *sun)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, size;
+	socklen_t vallen =3D sizeof(size);
+	if (getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &size, &vallen))
+		die_errno("could not get SO_SNDBUF from socket %d", fd);
+
+	strbuf_grow(&sb, size);
+	strbuf_addstr(&sb, "new ");
+
+	for (i =3D 0; i < updated.nr; i++) {
+		int len =3D strlen(updated.items[i].string) + 4;
+		if (sb.len + len >=3D size) {
+			send_watcher(fd, sun, "%s", sb.buf);
+			strbuf_reset(&sb);
+			strbuf_addstr(&sb, "new ");
+		}
+		packet_buf_write(&sb, "%s", updated.items[i].string);
+	}
+	strbuf_addstr(&sb, "0000");
+	send_watcher(fd, sun, "%s", sb.buf);
+	strbuf_release(&sb);
+}
+
 static void watch_paths(char *buf, int maxlen,
 			int fd, struct sockaddr_un *sock)
 {
@@ -40,6 +74,19 @@ static void watch_paths(char *buf, int maxlen,
 	send_watcher(fd, sock, "fine %d", n);
 }
=20
+static void remove_updated(const char *path)
+{
+	struct string_list_item *item;
+	if (!updated_sorted) {
+		sort_string_list(&updated);
+		updated_sorted =3D 1;
+	}
+	item =3D string_list_lookup(&updated, path);
+	if (!item)
+		return;
+	unsorted_string_list_delete_item(&updated, item - updated.items, 0);
+}
+
 static int handle_command(int fd)
 {
 	struct sockaddr_un sun;
@@ -53,11 +100,17 @@ static int handle_command(int fd)
 	if ((arg =3D skip_prefix(msg, "hello "))) {
 		send_watcher(fd, &sun, "hello %s", index_signature);
 		if (strcmp(arg, index_signature))
-			/*
-			 * Index SHA-1 mismatch, something has gone
-			 * wrong. Clean up and start over.
-			 */
-			index_signature[0] =3D '\0';
+			reset();
+	} else if ((arg =3D skip_prefix(msg, "clear"))) {
+		reset();
+	} else if (!strcmp(msg, "status")) {
+		send_status(fd, &sun);
+	} else if ((arg =3D skip_prefix(msg, "bye "))) {
+		strlcpy(index_signature, arg, sizeof(index_signature));
+	} else if ((arg =3D skip_prefix(msg, "forget "))) {
+		int len =3D strlen(index_signature);
+		if (!strncmp(arg, index_signature, len) && arg[len] =3D=3D ' ')
+			remove_updated(arg + len + 1);
 	} else if (starts_with(msg, "watch ")) {
 		watch_paths(msg + 6, len - 6, fd, &sun);
 	} else if (!strcmp(msg, "die")) {
diff --git a/read-cache.c b/read-cache.c
index 406834a..3aa541d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1453,6 +1453,69 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void update_watched_files(struct index_state *istate)
+{
+	int i;
+	if (istate->watcher <=3D 0)
+		return;
+	if (send_watcher(istate->watcher, NULL, "status") < 0)
+		goto failed;
+	for (;;) {
+		char *line, *end;
+		ssize_t len;
+		int ch;
+		line =3D read_watcher(istate->watcher, &len, NULL);
+		if (!line || !starts_with(line, "new ")) {
+			if (!len) {
+				close(istate->watcher);
+				istate->watcher =3D -1;
+			}
+			goto failed;
+		}
+		end =3D line + len;
+		line +=3D 4;
+		for (; line < end; line[len] =3D ch, line +=3D len) {
+			len =3D packet_length(line);
+			if (!len)
+				break;
+			ch =3D line[len];
+			line[len] =3D '\0';
+			i =3D index_name_pos(istate, line + 4, len - 4);
+			if (i < 0)
+				continue;
+			if (istate->cache[i]->ce_flags & CE_WATCHED) {
+				istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
+				istate->cache_changed =3D 1;
+			}
+			if (!istate->updated_entries) {
+				struct string_list *sl;
+				sl =3D xmalloc(sizeof(*sl));
+				memset(sl, 0, sizeof(*sl));
+				sl->strdup_strings =3D 1;
+				istate->updated_entries =3D sl;
+			}
+			string_list_append(istate->updated_entries, line + 4);
+		}
+		if (!len)
+			break;
+	}
+
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHED)
+			istate->cache[i]->ce_flags |=3D CE_VALID;
+	return;
+failed:
+	if (istate->updated_entries) {
+		string_list_clear(istate->updated_entries, 0);
+		free(istate->updated_entries);
+		istate->updated_entries =3D NULL;
+	}
+	send_watcher(istate->watcher, NULL, "clear");
+	for (i =3D 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
+	istate->cache_changed =3D 1;
+}
+
 static int watcher_config(const char *var, const char *value, void *da=
ta)
 {
 	if (!strcmp(var, "filewatcher.minfiles")) {
@@ -1484,6 +1547,7 @@ static void validate_watcher(struct index_state *=
istate, const char *path)
 		if (send_watcher(istate->watcher, NULL, "%s", sb.buf) > 0 &&
 		    (msg =3D read_watcher(istate->watcher, NULL, NULL)) !=3D NULL &&
 		    !strcmp(msg, sb.buf)) { /* good */
+			update_watched_files(istate);
 			strbuf_release(&sb);
 			return;
 		}
@@ -1597,6 +1661,21 @@ static void watch_entries(struct index_state *is=
tate)
 	free(sorted);
 }
=20
+static void farewell_watcher(struct index_state *istate,
+			     const unsigned char *sha1)
+{
+	int i;
+	if (istate->watcher <=3D 0)
+		return;
+	send_watcher(istate->watcher, NULL, "bye %s", sha1_to_hex(sha1));
+	if (!istate->updated_entries)
+		return;
+	for (i =3D 0; i < istate->updated_entries->nr; i++)
+		send_watcher(istate->watcher, NULL, "forget %s %s",
+			     sha1_to_hex(sha1),
+			     istate->updated_entries->items[i].string);
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1718,6 +1797,11 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	if (istate->updated_entries) {
+		string_list_clear(istate->updated_entries, 0);
+		free(istate->updated_entries);
+		istate->updated_entries =3D NULL;
+	}
 	return 0;
 }
=20
@@ -1778,7 +1862,7 @@ static int write_index_ext_header(git_SHA_CTX *co=
ntext, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
=20
-static int ce_flush(git_SHA_CTX *context, int fd)
+static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 {
 	unsigned int left =3D write_buffer_len;
=20
@@ -1796,6 +1880,8 @@ static int ce_flush(git_SHA_CTX *context, int fd)
=20
 	/* Append the SHA1 signature at the end */
 	git_SHA1_Final(write_buffer + left, context);
+	if (sha1)
+		hashcpy(sha1, write_buffer + left);
 	left +=3D 20;
 	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
 }
@@ -1960,12 +2046,21 @@ int write_index(struct index_state *istate, int=
 newfd)
 	int entries =3D istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	unsigned char sha1[20];
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
 		else if (cache[i]->ce_flags & CE_WATCHED) {
 			/*
+			 * CE_VALID when used with CE_WATCHED is not
+			 * supposed to be persistent. Next time git
+			 * runs, if this entry is still watched and
+			 * nothing has changed, CE_VALID will be
+			 * reinstated.
+			 */
+			cache[i]->ce_flags &=3D ~CE_VALID;
+			/*
 			 * We may set CE_WATCHED (but not CE_VALID)
 			 * early when refresh has not been done
 			 * yet. At that time we had no idea if the
@@ -2073,8 +2168,9 @@ int write_index(struct index_state *istate, int n=
ewfd)
 			return -1;
 	}
=20
-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+	if (ce_flush(&c, newfd, sha1) || fstat(newfd, &st))
 		return -1;
+	farewell_watcher(istate, sha1);
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
 	return 0;
--=20
1.8.5.1.208.g05b12ea
