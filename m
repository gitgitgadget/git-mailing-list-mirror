From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] Add memory pool library
Date: Thu, 15 Jul 2010 13:57:06 -0500
Message-ID: <20100715185706.GA2774@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 20:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTdK-0004e6-Pi
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 20:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934318Ab0GOS6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 14:58:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63374 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934137Ab0GOS6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 14:58:03 -0400
Received: by ewy23 with SMTP id 23so355794ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/ugI7dcy/eBiYblYFibfQ2vYs7M6JU8SwGkcekkWkw8=;
        b=VhVqyVKaZPCLw9QzKSLtvUdrw9INYAmZ2m4HYgc7XrbZOTx7kRtxE1kmYWSpXdHUDo
         +O3hW+ckxusf8d+8hDSc9ZmnbonswopfR1vtH9d5bJJz5dYi+0RCxbHG/xk/WbxHyAaL
         msk21psqEhEEzKbWhLmmiTWz2vxcEJBZ87Xzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JCxHvoraohBtaEKGIM5PUaGI/PkZAaA7PYnkS/kJTvjhdbjibhiRafBa1UNltr1ypU
         9F/DEgct/v8zTjVvDRiDKMm0G2XgAoPPzj5MDyQrn2g4cENt0+qt0sAsScVkRBq0lb4Q
         u5sqwJfP1UdsyPk5JU3Ikpzt6Xw9SE9BSdTTQ=
Received: by 10.213.10.8 with SMTP id n8mr3194907ebn.46.1279220280375;
        Thu, 15 Jul 2010 11:58:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id z55sm10488573eeh.9.2010.07.15.11.57.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 11:57:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151107>

Ramkumar Ramachandra wrote:

> void pre_commit(void);
>=20
> 	Write the pool to file.

Except as a proof of concept, this is the wrong API to have.  The probl=
em
is that the caller cannot choose the filename, so it ends up being a .b=
in
file in the current directory, wherever that is.

The log message leaves out a subtlety: this also increases the
=E2=80=98committed=E2=80=99 value, and bookkeeping for that might be us=
eful to some
callers.

In other words:

> +static MAYBE_UNUSED void pre##_init(void) \
> +{ \
> +	struct stat st; \
> +	pre##_pool.file =3D fopen(#pre ".bin", "a+"); \
> +	rewind(pre##_pool.file); \
> +	fstat(fileno(pre##_pool.file), &st); \
> +	pre##_pool.size =3D st.st_size / sizeof(obj_t); \
> +	pre##_pool.committed =3D pre##_pool.size; \
> +	pre##_pool.capacity =3D pre##_pool.size * 2; \
> +	if (pre##_pool.capacity < initial_capacity) \
> +		pre##_pool.capacity =3D initial_capacity; \
> +	pre##_pool.base =3D malloc(pre##_pool.capacity * sizeof(obj_t)); \
> +	fread(pre##_pool.base, sizeof(obj_t), pre##_pool.size, pre##_pool.f=
ile); \
> +} \

If you just want something working, I=E2=80=99d suggest stubbing this o=
ut:

 static MAYBE_UNUSED void pre##_init(void) \
 { \
 } \

It even almost makes sense as API: the _init function does all
initialization tasks required, which is to say, none.  (The {0, ...}
initializer already has taken care of setting all fields to 0).

> +static MAYBE_UNUSED void pre##_commit(void) \
> +{ \
> +	pre##_pool.committed +=3D fwrite(pre##_pool.base + pre##_pool.commi=
tted, \
> +		sizeof(obj_t), pre##_pool.size - pre##_pool.committed, \
> +		pre##_pool.file); \
> +} \

This can be simplified

 static MAYBE_UNUSED void pre##_commit(void) \
 { \
	pre##_pool.committed =3D pre##_pool.size; \
 } \

In other words, maybe something like this on top?  This includes the
vestigal _init() function which really should not be there (it is
confusing that some callers use it and others don=E2=80=99t).  I did no=
t
spend much time on it because in the end I suspect we might throw
obj_pool away anyway.

---
diff --git a/Makefile b/Makefile
index fc31ee0..386a586 100644
--- a/Makefile
+++ b/Makefile
@@ -409,6 +409,7 @@ TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-match-trees
+TEST_PROGRAMS_NEED_X +=3D test-obj-pool
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
 TEST_PROGRAMS_NEED_X +=3D test-run-command
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 680d7d6..262f304 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -12,4 +12,10 @@ test_expect_success 'character classes (isspace, isa=
lpha etc.)' '
 	test-ctype
 '
=20
+test_expect_success 'allocator for svn importer' '
+	printf "%s\n" 0 0 0 0 0 2 2 2 2 2 -1 >expected &&
+	test-obj-pool >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/test-obj-pool.c b/test-obj-pool.c
new file mode 100644
index 0000000..1300049
--- /dev/null
+++ b/test-obj-pool.c
@@ -0,0 +1,55 @@
+/*
+ * test-obj-pool.c: code to exercise the svn importer's object pool
+ */
+
+#include "vcs-svn/obj_pool.h"
+
+static const char usage_str[] =3D
+	"test-obj-pool";
+
+obj_pool_gen(int, int, 2)
+obj_pool_gen(other, int, 4096)
+
+int main(int argc, char *argv[])
+{
+	int *p;
+	int i;
+
+	if (argc !=3D 1) {
+		fprintf(stderr, "Usage: %s\n", usage_str);
+		return 1;
+	}
+
+	int_init();
+
+	p =3D int_pointer(int_alloc(10));
+	for (i =3D 0; i < 10; i++)
+		p[i] =3D 0;
+
+	*other_pointer(other_alloc(1)) =3D -1;
+	other_commit();
+
+	p =3D other_pointer(other_alloc(10));
+	for (i =3D 0; i < 10; i++)
+		p[i] =3D 1;
+
+	int_free(5);
+
+	p =3D int_pointer(int_alloc(10));
+	for (i =3D 0; i < 10; i++)
+		p[i] =3D 2;
+
+	int_free(5);
+	int_commit();
+
+	for (i =3D 0; i < int_pool.committed; i++)
+		printf("%d\n", *int_pointer(i));
+
+	for (i =3D 0; i < other_pool.committed; i++)
+		printf("%d\n", *other_pointer(i));
+
+	int_reset();
+	int_reset();
+	other_reset();
+	return 0;
+}
diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
index f60c872..90eda15 100644
--- a/vcs-svn/obj_pool.h
+++ b/vcs-svn/obj_pool.h
@@ -16,21 +16,9 @@ static struct { \
 	uint32_t size; \
 	uint32_t capacity; \
 	obj_t *base; \
-	FILE *file; \
-} pre##_pool =3D { 0, 0, 0, NULL, NULL}; \
+} pre##_pool =3D {0, 0, 0, NULL}; \
 static MAYBE_UNUSED void pre##_init(void) \
 { \
-	struct stat st; \
-	pre##_pool.file =3D fopen(#pre ".bin", "a+"); \
-	rewind(pre##_pool.file); \
-	fstat(fileno(pre##_pool.file), &st); \
-	pre##_pool.size =3D st.st_size / sizeof(obj_t); \
-	pre##_pool.committed =3D pre##_pool.size; \
-	pre##_pool.capacity =3D pre##_pool.size * 2; \
-	if (pre##_pool.capacity < initial_capacity) \
-		pre##_pool.capacity =3D initial_capacity; \
-	pre##_pool.base =3D malloc(pre##_pool.capacity * sizeof(obj_t)); \
-	fread(pre##_pool.base, sizeof(obj_t), pre##_pool.size, pre##_pool.fil=
e); \
 } \
 static MAYBE_UNUSED uint32_t pre##_alloc(uint32_t count) \
 { \
@@ -62,19 +50,15 @@ static MAYBE_UNUSED obj_t *pre##_pointer(uint32_t o=
ffset) \
 } \
 static MAYBE_UNUSED void pre##_commit(void) \
 { \
-	pre##_pool.committed +=3D fwrite(pre##_pool.base + pre##_pool.committ=
ed, \
-		sizeof(obj_t), pre##_pool.size - pre##_pool.committed, \
-		pre##_pool.file); \
+	pre##_pool.committed =3D pre##_pool.size; \
 } \
 static MAYBE_UNUSED void pre##_reset(void) \
 { \
 	free(pre##_pool.base); \
-	if (pre##_pool.file) \
-		fclose(pre##_pool.file); \
 	pre##_pool.base =3D NULL; \
 	pre##_pool.size =3D 0; \
 	pre##_pool.capacity =3D 0; \
-	pre##_pool.file =3D NULL; \
+	pre##_pool.committed =3D 0; \
 }
=20
 #endif
--=20
