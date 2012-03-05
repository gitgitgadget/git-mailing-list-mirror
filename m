From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/11] Add more large blob test cases
Date: Mon,  5 Mar 2012 10:43:38 +0700
Message-ID: <1330919028-6611-2-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:44:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Oqa-0003U1-Hj
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab2CEDoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:44:24 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41418 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2CEDoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:44:23 -0500
Received: by pbcun15 with SMTP id un15so2292252pbc.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:44:23 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.238.227 as permitted sender) client-ip=10.68.238.227;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.238.227 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.238.227])
        by 10.68.238.227 with SMTP id vn3mr23834912pbc.123.1330919063029 (num_hops = 1);
        Sun, 04 Mar 2012 19:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0q398h7B6z/H6OmlCnDV47WzzIhl6j/taADhpbquE/c=;
        b=WxGqe2XJ6o61wbODdy0MAI+h5ZRB5/I+OAv66jikdE1Eu6SqRgBKNgXoXDeK4g5xTa
         17/M/5C9xFnRRweNga7AEQQYJBApjXJ/uEfRd2+aRa4PeAzqrOE0uK837MUPASdlQOaQ
         R/3Z48W9vynhz0+lnG/l1CA6LSaYNkPx9M2lvggVizLfiQ1AfTwVFADdPG/WGXXF24l5
         ixSx4QruIoyhJIzWZPLjjTK5Az+hAffrBBlXIIVdnzuUFVAqwpetXfw6uPdtenNZcCp9
         MqXgseSL1YY2ihYYrc/Sq1yyCauDpwiZP69TIZ1KW81shUfRwCfRlAQPkPq3bMmmdofE
         TT3Q==
Received: by 10.68.238.227 with SMTP id vn3mr20807705pbc.123.1330919062958;
        Sun, 04 Mar 2012 19:44:22 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id m7sm12111866pba.30.2012.03.04.19.44.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:44:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:43:57 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192194>

New test cases list commands that should work when memory is
limited. All memory allocation functions (*) learn to reject any
allocation larger than $GIT_ALLOC_LIMIT if set.

(*) Not exactly all. Some places do not use x* functions, but
malloc/calloc directly, notably diff-delta. These code path should
never be run on large blobs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1050-large.sh |   63 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
 wrapper.c        |   27 ++++++++++++++++++++--
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 29d6024..80f157a 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -6,11 +6,15 @@ test_description=3D'adding and checking out large blo=
bs'
 . ./test-lib.sh
=20
 test_expect_success setup '
-	git config core.bigfilethreshold 200k &&
+	# clone does not allow us to pass core.bigfilethreshold to
+	# new repos, so set core.bigfilethreshold globally
+	git config --global core.bigfilethreshold 200k &&
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
@@ -100,4 +104,59 @@ test_expect_success 'packsize limit' '
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
+test_expect_failure 'cat-file a large file from a tag' '
+	git tag -m largefile largefiletag :large1 &&
+	git cat-file blob largefiletag >/dev/null
+'
+
+test_expect_failure 'git-show a large file' '
+	git show :large1 >/dev/null
+
+'
+
+test_expect_failure 'clone' '
+	git clone file://"$PWD"/.git new
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
+test_expect_failure 'repack' '
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
