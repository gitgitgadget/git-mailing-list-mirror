From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/11] Add more large blob test cases
Date: Mon, 27 Feb 2012 14:55:05 +0700
Message-ID: <1330329315-11407-2-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:56:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vR9-0006sO-KO
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab2B0Hzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:55:52 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33496 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2B0Hzv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:55:51 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so1787730pbc.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:55:51 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.213.234 as permitted sender) client-ip=10.68.213.234;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.213.234 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.213.234])
        by 10.68.213.234 with SMTP id nv10mr37197987pbc.71.1330329351726 (num_hops = 1);
        Sun, 26 Feb 2012 23:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L3OG8oOB5WbRw444RS8RYm5XN599XSrqwlYhJZYjZis=;
        b=O3ZuLIWlI9/bCvi55Dnk4fbY04toEDOXdiYJABfmQzHMzH1SrIWJdjwDU+YvXeriEo
         /sUTQKLg5Rq46L9IpQRute033vd2w1rMb1j24/y8oqdIOlrbPWBBhO3uumIwtevpUkXP
         /1JOyKI+0P2O+32LaDiJKO49QW/hM1Qew6bcI=
Received: by 10.68.213.234 with SMTP id nv10mr31666993pbc.71.1330329351563;
        Sun, 26 Feb 2012 23:55:51 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id u9sm12038228pbj.39.2012.02.26.23.55.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:55:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:55:27 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191606>

New test cases list commands that should work when memory is
limited. All memory allocation functions (*) learn to reject any
allocation larger than $GIT_ALLOC_LIMIT if set.

(*) Not exactly all. Some places do not use x* functions, but
malloc/calloc directly, notably diff-delta. These could path should
never be run on large blobs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1050-large.sh |   59 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 wrapper.c        |   27 ++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 29d6024..f245e59 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -10,7 +10,9 @@ test_expect_success setup '
 	echo X | dd of=3Dlarge1 bs=3D1k seek=3D2000 &&
 	echo X | dd of=3Dlarge2 bs=3D1k seek=3D2000 &&
 	echo X | dd of=3Dlarge3 bs=3D1k seek=3D2000 &&
-	echo Y | dd of=3Dhuge bs=3D1k seek=3D2500
+	echo Y | dd of=3Dhuge bs=3D1k seek=3D2500 &&
+	GIT_ALLOC_LIMIT=3D1500 &&
+	export GIT_ALLOC_LIMIT
 '
=20
 test_expect_success 'add a large file or two' '
@@ -100,4 +102,59 @@ test_expect_success 'packsize limit' '
 	)
 '
=20
+test_expect_success 'diff --raw' '
+	git commit -q -m initial &&
+	echo modified >>large1 &&
+	git add large1 &&
+	git commit -q -m modified &&
+	git diff --raw HEAD^
+'
+
+test_expect_success 'hash-object' '
+	git hash-object large1
+'
+
+test_expect_failure 'cat-file a large file' '
+	git cat-file blob :large1 >/dev/null
+'
+
+test_expect_failure 'git-show a large file' '
+	git show :large1 >/dev/null
+
+'
+
+test_expect_failure 'clone' '
+	git clone -n file://"$PWD"/.git new &&
+	(
+	cd new &&
+	git config core.bigfilethreshold 200k &&
+	git checkout master
+	)
+'
+
+test_expect_failure 'fetch updates' '
+	echo modified >> large1 &&
+	git commit -q -a -m updated &&
+	(
+	cd new &&
+	git fetch --keep # FIXME should not need --keep
+	)
+'
+
+test_expect_failure 'fsck' '
+	git fsck --full
+'
+
+test_expect_success 'repack' '
+	git repack -ad
+'
+
+test_expect_failure 'tar achiving' '
+	git archive --format=3Dtar HEAD >/dev/null
+'
+
+test_expect_failure 'zip achiving' '
+	git archive --format=3Dzip HEAD >/dev/null
+'
+
 test_done
diff --git a/wrapper.c b/wrapper.c
index 85f09df..d4c0972 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -9,6 +9,18 @@ static void do_nothing(size_t size)
=20
 static void (*try_to_free_routine)(size_t size) =3D do_nothing;
=20
+static void memory_limit_check(size_t size)
+{
+	static int limit =3D -1;
+	if (limit =3D=3D -1) {
+		const char *env =3D getenv("GIT_ALLOC_LIMIT");
+		limit =3D env ? atoi(env) * 1024 : 0;
+	}
+	if (limit && size > limit)
+		die("attempting to allocate %d over limit %d",
+		    size, limit);
+}
+
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 {
 	try_to_free_t old =3D try_to_free_routine;
@@ -32,7 +44,10 @@ char *xstrdup(const char *str)
=20
 void *xmalloc(size_t size)
 {
-	void *ret =3D malloc(size);
+	void *ret;
+
+	memory_limit_check(size);
+	ret =3D malloc(size);
 	if (!ret && !size)
 		ret =3D malloc(1);
 	if (!ret) {
@@ -79,7 +94,10 @@ char *xstrndup(const char *str, size_t len)
=20
 void *xrealloc(void *ptr, size_t size)
 {
-	void *ret =3D realloc(ptr, size);
+	void *ret;
+
+	memory_limit_check(size);
+	ret =3D realloc(ptr, size);
 	if (!ret && !size)
 		ret =3D realloc(ptr, 1);
 	if (!ret) {
@@ -95,7 +113,10 @@ void *xrealloc(void *ptr, size_t size)
=20
 void *xcalloc(size_t nmemb, size_t size)
 {
-	void *ret =3D calloc(nmemb, size);
+	void *ret;
+
+	memory_limit_check(size * nmemb);
+	ret =3D calloc(nmemb, size);
 	if (!ret && (!nmemb || !size))
 		ret =3D calloc(1, 1);
 	if (!ret) {
--=20
1.7.3.1.256.g2539c.dirty
