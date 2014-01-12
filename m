From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] read-cache: get "updated" path list from file watcher
Date: Sun, 12 Jan 2014 18:03:40 +0700
Message-ID: <1389524622-6702-5-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 11:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Ikq-0006n6-F9
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbaALK6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 05:58:53 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54642 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaALK6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:58:50 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so6305618pdj.23
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=j0gQ9Bkpzr+uvusXXGkql7ZvUWlXjBChv5J7BRUU+VM=;
        b=xdse6Nm+jPdrh6KGZ0HPBTYDkK7qbjiXngODmfLZqeJyxPsJ2DLnJXZxruPJPlMf3A
         xfZvGicDuTCBKVbY6nXk3LgopZ6YCdSsMRu7IoeO1vhAOZzx8vdKIiYm2yVR3GRI/0Pj
         CaxYyXgXJPhCu1g1vwOiWt0pg30hvuGrcifaCEe58C9BAVWOqFMVL0o42avAsCMNTYTV
         pQa6jfEusRhLksGUL1048sjcVE7BcSMObq1GYUpHyuhDzKTxxWYdeizsLtTK/eo+QSyl
         eB0XA4STeZeXKv9RxgDbyViO7732t+SfEphlGqvR2Gk9y5ZwfRLtIHztYP26rDPcUtsc
         x6cQ==
X-Received: by 10.68.218.65 with SMTP id pe1mr14832453pbc.1.1389524330165;
        Sun, 12 Jan 2014 02:58:50 -0800 (PST)
Received: from lanh ([115.73.194.184])
        by mx.google.com with ESMTPSA id pa1sm38636922pac.17.2014.01.12.02.58.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 02:58:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 12 Jan 2014 18:04:07 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240343>

A new command is added to file watcher to send back the list of
updated files to git. These entries will have CE_WATCHED removed. The
remaining CE_WATCHED entries will have CE_VALID set (i.e. no changes
and no lstat either).

The file watcher keeps reporting the same "updated" list until it
receives "forget" commands, which should only be issued after the
updated index is written down. This ensures that if git crashes half
way before it could update the index (or multiple processes is reading
the same index), "updated" info is not lost. After the index is
updated (e.g. in this case because of toggling CE_WATCHED bits), git
sends the new index signature to the file watcher.

The file watcher does not cache stat info and send back to git. Its
main purpose is to reduce lstat on most untouched files, not to
completely eliminate lstat.

One can see that, assuming CE_WATCHED is magically set in some
entries, they will be all cleared over the time and we need to do
lstat on all entries. We haven't talked about how CE_WATCHED is set
yet. More to come later.

TODO: get as many paths as possible in one packet to reduce round
trips

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        |  1 +
 file-watcher.c | 35 +++++++++++++++++++---
 read-cache.c   | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 6a182b5..2eddc1e 100644
--- a/cache.h
+++ b/cache.h
@@ -282,6 +282,7 @@ struct index_state {
 	struct hash_table dir_hash;
 	unsigned char sha1[20];
 	int watcher;
+	struct string_list *updated_entries;
 };
=20
 extern struct index_state the_index;
diff --git a/file-watcher.c b/file-watcher.c
index 66b44e5..6aeed4d 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -1,7 +1,16 @@
 #include "cache.h"
 #include "sigchain.h"
+#include "string-list.h"
=20
 static char index_signature[41];
+static struct string_list updated =3D STRING_LIST_INIT_DUP;
+static int updated_sorted;
+
+static void reset(const char *sig)
+{
+	string_list_clear(&updated, 0);
+	strlcpy(index_signature, sig, sizeof(index_signature));
+}
=20
 static int handle_command(int fd, char *msg, int msgsize)
 {
@@ -22,10 +31,28 @@ static int handle_command(int fd, char *msg, int ms=
gsize)
 		sendtof(fd, 0, &sun, socklen, "hello %s", index_signature);
 		if (!strcmp(index_signature, arg))
 			return 0;
-		/*
-		 * Index SHA-1 mismatch, something has gone
-		 * wrong. Clean up and start over.
-		 */
+		reset(arg);
+	} else if ((arg =3D skip_prefix(msg, "reset "))) {
+		reset(arg);
+	} else if (!strcmp(msg, "status")) {
+		int i;
+		for (i =3D 0; i < updated.nr; i++)
+			sendto(fd, updated.items[i].string,
+			       strlen(updated.items[i].string),
+			       0, &sun, socklen);
+		sendtof(fd, 0, &sun, socklen, "%c", 0);
+	} else if ((arg =3D skip_prefix(msg, "forget "))) {
+		struct string_list_item *item;
+		if (!updated_sorted) {
+			sort_string_list(&updated);
+			updated_sorted =3D 1;
+		}
+		item =3D string_list_lookup(&updated, arg);
+		if (item)
+			unsorted_string_list_delete_item(&updated,
+							 item - updated.items,
+							 0);
+	} else if ((arg =3D skip_prefix(msg, "bye "))) {
 		strlcpy(index_signature, arg, sizeof(index_signature));
 	} else {
 		die("unrecognized command %s", msg);
diff --git a/read-cache.c b/read-cache.c
index 506d488..caa2298 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1443,6 +1443,55 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void update_watched_files(struct index_state *istate)
+{
+	int i;
+	if (istate->watcher =3D=3D -1)
+		return;
+	if (writef(istate->watcher, "status") < 0)
+		goto failed;
+	for (;;) {
+		char line[1024];
+		int len;
+		len =3D read(istate->watcher, line, sizeof(line) - 1);
+		if (len <=3D 0)
+			goto failed;
+		line[len] =3D '\0';
+		if (len =3D=3D 1 && line[0] =3D=3D '\0')
+			break;
+		i =3D index_name_pos(istate, line, len);
+		if (i < 0)
+			continue;
+		if (istate->cache[i]->ce_flags & CE_WATCHED) {
+			istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
+			istate->cache_changed =3D 1;
+		}
+		if (!istate->updated_entries) {
+			struct string_list *sl;
+			sl =3D xmalloc(sizeof(*sl));
+			memset(sl, 0, sizeof(*sl));
+			sl->strdup_strings =3D 1;
+			istate->updated_entries =3D sl;
+		}
+		string_list_append(istate->updated_entries, line);
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
+	writef(istate->watcher, "reset %s", sha1_to_hex(istate->sha1));
+	for (i =3D 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
+	istate->cache_changed =3D 1;
+}
+
 static void connect_watcher(struct index_state *istate, const char *pa=
th)
 {
 	struct stat st;
@@ -1473,8 +1522,10 @@ static void connect_watcher(struct index_state *=
istate, const char *path)
 		len =3D read(istate->watcher, line, sizeof(line) - 1);
 		if (len > 0) {
 			line[len] =3D '\0';
-			if (!strcmp(sb.buf, line))
+			if (!strcmp(sb.buf, line)) {
+				update_watched_files(istate);
 				return; /* good */
+			}
 		}
 	}
=20
@@ -1486,6 +1537,20 @@ static void connect_watcher(struct index_state *=
istate, const char *path)
 		}
 }
=20
+static void farewell_watcher(struct index_state *istate,
+			     const unsigned char *sha1)
+{
+	if (istate->watcher =3D=3D -1)
+		return;
+	if (istate->updated_entries) {
+		int i;
+		for (i =3D 0; i < istate->updated_entries->nr; i++)
+			writef(istate->watcher, "forget %s",
+			       istate->updated_entries->items[i].string);
+	}
+	writef(istate->watcher, "bye %s", sha1_to_hex(sha1));
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1605,6 +1670,11 @@ int discard_index(struct index_state *istate)
 		close(istate->watcher);
 		istate->watcher =3D -1;
 	}
+	if (istate->updated_entries) {
+		string_list_clear(istate->updated_entries, 0);
+		free(istate->updated_entries);
+		istate->updated_entries =3D NULL;
+	}
 	return 0;
 }
=20
@@ -1665,7 +1735,7 @@ static int write_index_ext_header(git_SHA_CTX *co=
ntext, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
=20
-static int ce_flush(git_SHA_CTX *context, int fd)
+static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 {
 	unsigned int left =3D write_buffer_len;
=20
@@ -1683,6 +1753,8 @@ static int ce_flush(git_SHA_CTX *context, int fd)
=20
 	/* Append the SHA1 signature at the end */
 	git_SHA1_Final(write_buffer + left, context);
+	if (sha1)
+		hashcpy(sha1, write_buffer + left);
 	left +=3D 20;
 	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
 }
@@ -1847,12 +1919,22 @@ int write_index(struct index_state *istate, int=
 newfd)
 	int entries =3D istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	unsigned char sha1[20];
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
-		else if (cache[i]->ce_flags & CE_WATCHED)
+		else if (cache[i]->ce_flags & CE_WATCHED) {
+			/*
+			 * CE_VALID when used with CE_WATCHED is not
+			 * supposed to be persistent. Next time git
+			 * runs, if this entry is still watched and
+			 * nothing has changed, CE_VALID will be
+			 * reinstated.
+			 */
+			cache[i]->ce_flags &=3D ~CE_VALID;
 			has_watches++;
+		}
=20
 		/* reduce extended entries if possible */
 		cache[i]->ce_flags &=3D ~CE_EXTENDED;
@@ -1945,8 +2027,9 @@ int write_index(struct index_state *istate, int n=
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
1.8.5.2.240.g8478abd
