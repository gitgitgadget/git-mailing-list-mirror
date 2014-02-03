From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 25/26] file-watcher: tests for the client side
Date: Mon,  3 Feb 2014 11:29:13 +0700
Message-ID: <1391401754-15347-26-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABCG-0001g9-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbaBCEbo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:44 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38788 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbaBCEbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:43 -0500
Received: by mail-pd0-f179.google.com with SMTP id q10so6439025pdj.38
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bqFpC+vO/UYXgasM+8zlSLblKqCTBXbjMO2A8G4leJk=;
        b=DaoQGE4BLlkb5WPH0iO3frk+6NJ8DpmG6DvZ8Nk0j/bDlGm4Uf/9Sbmpd69lkm0hch
         sNhpsH+uJQiTNLLQmwZzbs/RK92fTOUbMs8d8LZDzoaDQraYBG+VIXR63BYi3lUtM0e3
         Fr2tkva9KIOT5v7wdBpB6z+vI0EY/dzNkluRuXq6RRo4Z91OFQs66Pog9ijFuqndyQfI
         qAD9hvkQa8814QtjWECnKh/ojI+vEtXn0G4iF+/xbvxLyQh0+0v7gGTDBLlXMvM4i6bz
         lKh7BNXhKvwYZmKQ6xemXLKdAqeZZAJg6nX8GW5uPsSZslf4gMziFDqtCvsiXvidvXq2
         Rgag==
X-Received: by 10.68.143.100 with SMTP id sd4mr35267865pbb.0.1391401903343;
        Sun, 02 Feb 2014 20:31:43 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id ja8sm10871333pbd.3.2014.02.02.20.31.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:40 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241420>

Similar to t7513, system inotify is taken out to give us better
controlled environment.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher-lib.c                   |  21 ++--
 t/t7514-file-watcher-lib.sh (new +x) | 190 +++++++++++++++++++++++++++=
++++++++
 test-file-watcher.c                  |  15 +++
 3 files changed, 219 insertions(+), 7 deletions(-)
 create mode 100755 t/t7514-file-watcher-lib.sh

diff --git a/file-watcher-lib.c b/file-watcher-lib.c
index 93afb52..8cc3b73 100644
--- a/file-watcher-lib.c
+++ b/file-watcher-lib.c
@@ -23,7 +23,8 @@ static int connect_watcher(const char *path)
 	return fd;
 }
=20
-static void reset_watches(struct index_state *istate, int disconnect)
+static void reset_watches(struct index_state *istate, int disconnect,
+			  const char *reason)
 {
 	int i, changed =3D 0;
 	if (istate->updated_entries) {
@@ -45,6 +46,8 @@ static void reset_watches(struct index_state *istate,=
 int disconnect)
 		close(istate->watcher);
 		istate->watcher =3D -1;
 	}
+	trace_printf_key("GIT_TRACE_WATCHER", "reset%s: %s\n",
+			 disconnect ? "/disconnect" : "", reason);
 }
=20
 static void mark_ce_valid(struct index_state *istate)
@@ -53,15 +56,16 @@ static void mark_ce_valid(struct index_state *istat=
e)
 	char *line, *end;
 	int i, len;
 	unsigned long n;
+	trace_printf_key("GIT_TRACE_WATCHER", "mark_ce_valid\n");
 	if (packet_write_timeout(istate->watcher, WAIT_TIME, "get-changed") <=
=3D 0 ||
 	    !(line =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, &=
len)) ||
 	    !starts_with(line, "changed ")) {
-		reset_watches(istate, 1);
+		reset_watches(istate, 1, "invalid get-changed response");
 		return;
 	}
 	n =3D strtoul(line + 8, &end, 10);
 	if (end !=3D line + len) {
-		reset_watches(istate, 1);
+		reset_watches(istate, 1, "invalid get-changed response");
 		return;
 	}
 	if (!n)
@@ -69,7 +73,7 @@ static void mark_ce_valid(struct index_state *istate)
 	strbuf_grow(&sb, n);
 	if (read_in_full_timeout(istate->watcher, sb.buf, n, WAIT_TIME) !=3D =
n) {
 		strbuf_release(&sb);
-		reset_watches(istate, 1);
+		reset_watches(istate, 1, "invalid get-changed payload");
 		return;
 	}
 	line =3D sb.buf;
@@ -131,7 +135,7 @@ void open_watcher(struct index_state *istate)
 	char *msg;
=20
 	if (!get_git_work_tree()) {
-		reset_watches(istate, 1);
+		reset_watches(istate, 1, "no worktree");
 		return;
 	}
=20
@@ -165,10 +169,11 @@ void open_watcher(struct index_state *istate)
 	}
=20
 	istate->watcher =3D connect_watcher(watcher_path);
+	trace_printf_key("GIT_TRACE_WATCHER", "open watcher %d\n", istate->wa=
tcher);
 	if (packet_write_timeout(istate->watcher, WAIT_TIME, "hello") <=3D 0 =
||
 	    (msg =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, NUL=
L)) =3D=3D NULL ||
 	    strcmp(msg, "hello")) {
-		reset_watches(istate, 1);
+		reset_watches(istate, 1, "invalid hello response");
 		return;
 	}
=20
@@ -177,7 +182,7 @@ void open_watcher(struct index_state *istate)
 				 get_git_work_tree()) <=3D 0 ||
 	    (msg =3D packet_read_line_timeout(istate->watcher, WAIT_TIME, NUL=
L)) =3D=3D NULL ||
 	    strcmp(msg, "ok")) {
-		reset_watches(istate, 0);
+		reset_watches(istate, 0, "inconsistent");
 		istate->update_watches =3D 1;
 		return;
 	}
@@ -265,6 +270,7 @@ void watch_entries(struct index_state *istate)
 			nr++;
 	if (nr < watch_lowerlimit)
 		return;
+	trace_printf_key("GIT_TRACE_WATCHER", "watch %d\n", nr);
 	sorted =3D xmalloc(sizeof(*sorted) * nr);
 	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
 		if (ce_watchable(istate->cache[i], now))
@@ -280,6 +286,7 @@ void close_watcher(struct index_state *istate, cons=
t unsigned char *sha1)
 	int len, i, nr;
 	if (istate->watcher <=3D 0)
 		return;
+	trace_printf_key("GIT_TRACE_WATCHER", "close watcher\n");
 	if (packet_write_timeout(istate->watcher, WAIT_TIME,
 				 "new-index %s", sha1_to_hex(sha1)) <=3D 0)
 		goto done;
diff --git a/t/t7514-file-watcher-lib.sh b/t/t7514-file-watcher-lib.sh
new file mode 100755
index 0000000..8dabb13
--- /dev/null
+++ b/t/t7514-file-watcher-lib.sh
@@ -0,0 +1,190 @@
+#!/bin/sh
+
+test_description=3D'File watcher daemon and client tests'
+
+. ./test-lib.sh
+
+if git file-watcher --check-support && test_have_prereq POSIXPERM; the=
n
+	: # good
+else
+	skip_all=3D"file-watcher not supported on this system"
+	test_done
+fi
+
+kill_it() {
+	test-file-watcher "$1" <<EOF >/dev/null
+<die
+>see you
+EOF
+}
+
+GIT_TEST_WATCHER=3D2
+GIT_TEST_WATCHER_PATH=3D"$TRASH_DIRECTORY"
+export GIT_TEST_WATCHER GIT_TEST_WATCHER_PATH
+
+test_expect_success 'setup' '
+	chmod 700 . &&
+	mkdir foo bar &&
+	touch abc foo/def bar/ghi &&
+	git add . &&
+	git file-watcher --detach . &&
+	cat <<EOF >expect &&
+<test-mode
+>test mode on
+EOF
+	test-file-watcher . <expect >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'initial opening sequence' '
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	rm actual &&
+	GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual" git ls-files >/dev/null =
&&
+	cat <<EOF >expect &&
+packet:          git> hello
+packet:          git< hello
+packet:          git> index $SIG $TRASH_DIRECTORY
+packet:          git< inconsistent
+packet:          git> watch 20
+packet:          git< watched 3
+EOF
+	test_cmp expect actual &&
+
+	# second time gives the same result because file-watch has not
+	# received new-index
+	GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual2" git ls-files >/dev/null=
 &&
+	test_cmp expect actual2
+'
+
+test_expect_success 'full sequence' '
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	rm actual &&
+	GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual" git status >/dev/null &&
+	SIG2=3D`test-file-watcher --index-signature .git/index` &&
+	cat <<EOF >expect &&
+packet:          git> hello
+packet:          git< hello
+packet:          git> index $SIG $TRASH_DIRECTORY
+packet:          git< inconsistent
+packet:          git> watch 20
+packet:          git< watched 3
+packet:          git> new-index $SIG2
+packet:          git> unchange 0
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'full sequence after file-watcher is active' '
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	rm actual &&
+	GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual" git ls-files -v >paths.a=
ctual &&
+	cat <<EOF >expect &&
+packet:          git> hello
+packet:          git< hello
+packet:          git> index $SIG $TRASH_DIRECTORY
+packet:          git< ok
+packet:          git> get-changed
+packet:          git< changed 0
+EOF
+	test_cmp expect actual &&
+	cat <<EOF >paths.expect &&
+w abc
+w bar/ghi
+w foo/def
+EOF
+	test_cmp paths.expect paths.actual
+'
+
+test_expect_success 'inject a file change' '
+	echo modified >bar/ghi &&
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>ok
+<inotify 2 IN_MODIFY ghi
+<dump changes
+>>changed
+>>bar/ghi
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git obtains the changes' '
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	rm actual &&
+	GIT_TEST_WATCHER=3D1 GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual" git=
 ls-files -v >paths.actual &&
+	cat <<EOF >expect &&
+packet:          git> hello
+packet:          git< hello
+packet:          git> index $SIG $TRASH_DIRECTORY
+packet:          git< ok
+packet:          git> get-changed
+packet:          git< changed 8
+EOF
+	test_cmp expect actual &&
+	cat <<EOF >paths.expect &&
+w abc
+H bar/ghi
+w foo/def
+EOF
+	test_cmp paths.expect paths.actual
+'
+
+test_expect_success 'sync file-watcher after index update' '
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	rm actual &&
+	GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual" git status --porcelain |=
 grep -vF "??" >paths.actual &&
+	SIG2=3D`test-file-watcher --index-signature .git/index` &&
+	cat <<EOF >expect &&
+packet:          git> hello
+packet:          git< hello
+packet:          git> index $SIG $TRASH_DIRECTORY
+packet:          git< ok
+packet:          git> get-changed
+packet:          git< changed 8
+packet:          git> watch 8
+packet:          git< watched 1
+packet:          git> new-index $SIG2
+packet:          git> unchange 8
+EOF
+	test_cmp expect actual &&
+	cat <<EOF >paths.expect &&
+A  abc
+AM bar/ghi
+A  foo/def
+EOF
+	test_cmp paths.expect paths.actual
+'
+
+test_expect_success 'make sure file-watcher cleans its changed list' '
+	SIG=3D`test-file-watcher --index-signature .git/index` &&
+	rm actual &&
+	GIT_TEST_WATCHER=3D1 GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/actual" git=
 ls-files -v >paths.actual &&
+	cat <<EOF >expect &&
+packet:          git> hello
+packet:          git< hello
+packet:          git> index $SIG $TRASH_DIRECTORY
+packet:          git< ok
+packet:          git> get-changed
+packet:          git< changed 0
+EOF
+	test_cmp expect actual &&
+	cat <<EOF >paths.expect &&
+w abc
+H bar/ghi
+w foo/def
+EOF
+	test_cmp paths.expect paths.actual
+'
+
+test_expect_success 'closing the daemon' '
+	test-file-watcher . <<EOF >/dev/null
+<die
+>see you
+EOF
+'
+
+test_done
diff --git a/test-file-watcher.c b/test-file-watcher.c
index ffff198..77037e1 100644
--- a/test-file-watcher.c
+++ b/test-file-watcher.c
@@ -11,6 +11,21 @@ int main(int ac, char **av)
 	int last_command_is_reply =3D 0;
 	int fd;
=20
+	if (!strcmp(av[1], "--index-signature")) {
+		struct stat st;
+		void *mmap;
+		if (lstat(av[2], &st))
+			die_errno("lstat");
+		fd =3D open(av[2], O_RDONLY);
+		if (fd < 0)
+			die_errno("open");
+		mmap =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (mmap =3D=3D MAP_FAILED)
+			die_errno("mmap");
+		printf("%s\n", sha1_to_hex((unsigned char*)mmap + st.st_size - 20));
+		return 0;
+	}
+
 	strbuf_addf(&sb, "%s/socket", av[1]);
 	fd =3D unix_stream_connect(sb.buf);
 	if (fd < 0)
--=20
1.8.5.2.240.g8478abd
