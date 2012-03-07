From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] Add more large blob test cases
Date: Wed,  7 Mar 2012 17:54:16 +0700
Message-ID: <1331117661-19378-3-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:53:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EUe-0002vb-4w
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab2CGKxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:53:09 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64743 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab2CGKxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:53:07 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so7761663dad.11
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qgZtVS2n5ABwU6WiWentVcz5vGUuS0I18GTNnQqA0bA=;
        b=rvTM+DT3OqejdaGwhjbgtA1H9tmskvrItZpzzvyuvnZAXUibDOh/vQ5bQiSEvr7H3y
         Sx/vKNo5XJgvwsJlvWsnk47GWRUNX+TnlmTqSxI/dl148hEJvf99PLoV/W0p8BpXWuOp
         sGzd9nikQii2Kcgd1NBnwW4PNv/zRTFHtB5DjseAN9sRXlelwHLcIo3LX65eRoB76prC
         HWQwjIRWcx7NAhJl6+3NSll2rkVB2VnSyiPfrpx9sZ9ejF+7zLgIkXh6gTfL0knG8tge
         FXun27funB8Cf/UnXHQcOYiaYFSWBCcZLSVCYEVb59BIXPDOysuXAp4Ox7VYqEqasbk7
         3gUA==
Received: by 10.68.242.201 with SMTP id ws9mr2769917pbc.67.1331117587575;
        Wed, 07 Mar 2012 02:53:07 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id o7sm591896pbq.8.2012.03.07.02.53.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:53:06 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:54:37 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192438>

New test cases list commands that should work when memory is
limited. All memory allocation functions (*) learn to reject any
allocation larger than $GIT_ALLOC_LIMIT if set.

(*) Not exactly all. Some places do not use x* functions, but
malloc/calloc directly, notably diff-delta. These code path should
never be run on large blobs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1050-large.sh |   38 ++++++++++++++++++++++++++++++++++++--
 wrapper.c        |   27 ++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 29d6024..ded66b3 100755
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
@@ -100,4 +104,34 @@ test_expect_success 'packsize limit' '
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
+test_expect_failure 'repack' '
+	git repack -ad
+'
+
 test_done
diff --git a/wrapper.c b/wrapper.c
index 85f09df..6ccd059 100644
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
+		die("attempting to allocate %"PRIuMAX" over limit %d",
+		    (intmax_t)size, limit);
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
1.7.8.36.g69ee2
