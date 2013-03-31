From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] fetch-pack: save shallow file before fetching the pack
Date: Sun, 31 Mar 2013 18:09:05 +0700
Message-ID: <1364728148-7537-2-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 13:09:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMG8s-0007G9-5z
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab3CaLJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:09:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53897 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3CaLJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:09:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so8279pde.23
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=URH4L/LXzcxb4FMS7H/fIcOczrPV1JiVhOKaaQjdycw=;
        b=EamVQ0FDhUc445/sDFfOkdo5XmqYeayQskx3QVghBbw0ncgSjNCIFFkaqrpZ5OEFN+
         l7IunoW1pXp8cfAvKzfHj7QBxcZ1BrTfinquV8phddMlFXajDjudQJEylsQ0tSo65F3x
         KZGeCTT6wwD5HaWQdF+cMOX4YFkWeo+SKJmJHU5pAHWcVQz5oxKo1uccFXCzk4Bq+T6a
         sfHPJ2Bhw8wPt3LDTRJXg6TxR/D0prFv37FAMjSd60fpkzBfugnoggGULtmdR9V7mrKs
         Bcmq/8sn7gjYgjgBlxoB4HeJ7qwzrEluNVB8TrnGsWxBDuByuG5LtWYRsVbTptmt+NWV
         t0ZQ==
X-Received: by 10.68.31.130 with SMTP id a2mr12628939pbi.213.1364728150725;
        Sun, 31 Mar 2013 04:09:10 -0700 (PDT)
Received: from lanh ([115.74.58.181])
        by mx.google.com with ESMTPS id gj2sm9296985pbc.25.2013.03.31.04.09.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 04:09:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Mar 2013 18:09:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219612>

index-pack --strict looks up and follows parent commits. If shallow
information is not ready by the time index-pack is run, index-pack may
be lead to non-existent objects. Make fetch-pack save shallow file to
disk before invoking index-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c          | 70 ++++++++++++++++++++++++++++---------------=
--------
 t/t5500-fetch-pack.sh |  7 ++++++
 2 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cef8fde..1f9c5ba 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -779,11 +779,44 @@ static int cmp_ref_by_name(const void *a_, const =
void *b_)
 	return strcmp(a->name, b->name);
 }
=20
+static void flush_shallow_to_disk(struct stat *st)
+{
+	static struct lock_file lock;
+	struct cache_time mtime;
+	struct strbuf sb =3D STRBUF_INIT;
+	char *shallow =3D git_path("shallow");
+	int fd;
+
+	mtime.sec =3D st->st_mtime;
+	mtime.nsec =3D ST_MTIME_NSEC(*st);
+	if (stat(shallow, st)) {
+		if (mtime.sec)
+			die("shallow file was removed during fetch");
+	} else if (st->st_mtime !=3D mtime.sec
+#ifdef USE_NSEC
+		   || ST_MTIME_NSEC(*st) !=3D mtime.nsec
+#endif
+		   )
+		die("shallow file was changed during fetch");
+
+	fd =3D hold_lock_file_for_update(&lock, shallow,
+				       LOCK_DIE_ON_ERROR);
+	if (!write_shallow_commits(&sb, 0)
+	    || write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
+		unlink_or_warn(shallow);
+		rollback_lock_file(&lock);
+	} else {
+		commit_lock_file(&lock);
+	}
+	strbuf_release(&sb);
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
 				 struct ref **sought, int nr_sought,
-				 char **pack_lockfile)
+				 char **pack_lockfile,
+				 struct stat *shallow_st)
 {
 	struct ref *ref =3D copy_ref_list(orig_ref);
 	unsigned char sha1[20];
@@ -858,6 +891,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
+	if (args->depth > 0)
+		flush_shallow_to_disk(shallow_st);
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
@@ -952,38 +987,9 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
s,
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
=20
-	if (args->depth > 0) {
-		static struct lock_file lock;
-		struct cache_time mtime;
-		struct strbuf sb =3D STRBUF_INIT;
-		char *shallow =3D git_path("shallow");
-		int fd;
-
-		mtime.sec =3D st.st_mtime;
-		mtime.nsec =3D ST_MTIME_NSEC(st);
-		if (stat(shallow, &st)) {
-			if (mtime.sec)
-				die("shallow file was removed during fetch");
-		} else if (st.st_mtime !=3D mtime.sec
-#ifdef USE_NSEC
-				|| ST_MTIME_NSEC(st) !=3D mtime.nsec
-#endif
-			  )
-			die("shallow file was changed during fetch");
-
-		fd =3D hold_lock_file_for_update(&lock, shallow,
-					       LOCK_DIE_ON_ERROR);
-		if (!write_shallow_commits(&sb, 0)
-		 || write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
-			unlink_or_warn(shallow);
-			rollback_lock_file(&lock);
-		} else {
-			commit_lock_file(&lock);
-		}
-		strbuf_release(&sb);
-	}
+	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
+				pack_lockfile, &st);
=20
 	reprepare_packed_git();
 	return ref_cpy;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d574085..557b073 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -135,6 +135,13 @@ test_expect_success 'clone shallow depth 1' '
 	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
 '
=20
+test_expect_success 'clone shallow depth 1 with fsck' '
+	git config --global fetch.fsckobjects true &&
+	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0fsck=
 &&
+	test "`git --git-dir=3Dshallow0fsck/.git rev-list --count HEAD`" =3D =
1 &&
+	git config --global --unset fetch.fsckobjects
+'
+
 test_expect_success 'clone shallow' '
 	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
--=20
1.8.2.83.gc99314b
