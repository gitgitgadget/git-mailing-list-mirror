Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD012F581
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722953; cv=none; b=Z2atPC91H68ZajxUve4jkHw1ZWn3JR8a+F6lesz4YjZHuGQSPe0zSNdPxPN9u1m+YL7M3WgkyubpiJxCXLR2z/dsV+/p8Q1d64Y1Z5uidnjA877a8iHol8hO29iVcyshI90ZLre66pGnYeI2Bm0DkiaH2rgVYZ8aGzW4Xk7ITDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722953; c=relaxed/simple;
	bh=7Y3kRPV2ETJslGdeofc5krO8YqcJTGx905OFi8A0Lvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCej11yHcs+xlBNv2ijfkXN4e9h5vG3HfqkxZex/WdJyR7mxK8+6FytjidpfVZK64GxMahA08GSgg2mAWHqzV8zvMKuV4cWC4J+mWmWadIy6G3bI2+RuMwvqlKbhFYbLKVjalY4UiIQOGsBQUMCWNwxa/ehv1//myw616bv4kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ebct8lS2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebct8lS2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C6EB1D6FAD;
	Wed, 31 Jan 2024 12:42:24 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=7Y3kRPV2ETJslGdeofc5krO8Y
	qcJTGx905OFi8A0Lvo=; b=ebct8lS21SHeJudJYg3eHG3ZR55uGakpYNIJm/v0i
	eA9s0rD8r1+lNusdwZnmm59JfCSlyWymUPrztIWnb/u0UNYWrctQ5Gy10OKiKgGs
	6/+HRidGI/aqkX1+eSU51w7fh5VjIu73xSzmxQt3RWVMje3XhbPh8orwKrNiNVuc
	80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 249731D6FAB;
	Wed, 31 Jan 2024 12:42:24 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 874801D6FAA;
	Wed, 31 Jan 2024 12:42:23 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] Makefile: reduce repetitive library paths
Date: Wed, 31 Jan 2024 09:42:19 -0800
Message-ID: <20240131174220.4160560-2-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-493-gbc7ee2e5e1
In-Reply-To: <20240131174220.4160560-1-gitster@pobox.com>
References: <20240131174220.4160560-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 17525620-C060-11EE-9167-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

When we take a library package we depend on (e.g., LIBPCRE) from a
directory other than the default location of the system, we add the
same directory twice on the linker command like, like so:

  EXTLIBS +=3D -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib=
)

Introduce a template "libpath_template" that takes the path to the
directory, which can be used like so:

  EXTLIBS +=3D $(call libpath_template,$(LIBPCREDIR)/$(lib))

and expand it into the "-L$(DIR) $(CC_LD_DYNPATH)$(DIR)" form.
Hopefully we can reduce the chance of typoes this way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile   | 12 ++++++------
 shared.mak |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 03adcb5a48..13f256ca13 100644
--- a/Makefile
+++ b/Makefile
@@ -1575,7 +1575,7 @@ endif
=20
 ifdef LIBPCREDIR
 	BASIC_CFLAGS +=3D -I$(LIBPCREDIR)/include
-	EXTLIBS +=3D -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib=
)
+	EXTLIBS +=3D $(call libpath_template,$(LIBPCREDIR)/$(lib))
 endif
=20
 ifdef HAVE_ALLOCA_H
@@ -1595,7 +1595,7 @@ else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=3D$(CURLDIR)/$(lib)" in such a case.
 		CURL_CFLAGS =3D -I$(CURLDIR)/include
-		CURL_LIBCURL =3D -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
+		CURL_LIBCURL =3D $(call libpath_template,$(CURLDIR)/$(lib))
 	else
 		CURL_CFLAGS =3D
 		CURL_LIBCURL =3D
@@ -1631,7 +1631,7 @@ else
 	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS +=3D -I$(EXPATDIR)/include
-			EXPAT_LIBEXPAT =3D -L$(EXPATDIR)/$(lib) $(CC_LD_DYNPATH)$(EXPATDIR)/$=
(lib) -lexpat
+			EXPAT_LIBEXPAT =3D $(call libpath_template,$(EXPATDIR)/$(lib)) -lexpa=
t
 		else
 			EXPAT_LIBEXPAT =3D -lexpat
 		endif
@@ -1644,7 +1644,7 @@ IMAP_SEND_LDFLAGS +=3D $(OPENSSL_LINK) $(OPENSSL_LI=
BSSL) $(LIB_4_CRYPTO)
=20
 ifdef ZLIB_PATH
 	BASIC_CFLAGS +=3D -I$(ZLIB_PATH)/include
-	EXTLIBS +=3D -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
+	EXTLIBS +=3D $(call libpath_template,$(ZLIB_PATH)/$(lib))
 endif
 EXTLIBS +=3D -lz
=20
@@ -1652,7 +1652,7 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS +=3D -I$(OPENSSLDIR)/include
-		OPENSSL_LINK =3D -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/=
$(lib)
+		OPENSSL_LINK =3D $(call libpath_template,$(OPENSSLDIR)/$(lib))
 	else
 		OPENSSL_LINK =3D
 	endif
@@ -1679,7 +1679,7 @@ ifndef NO_ICONV
 	ifdef NEEDS_LIBICONV
 		ifdef ICONVDIR
 			BASIC_CFLAGS +=3D -I$(ICONVDIR)/include
-			ICONV_LINK =3D -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib=
)
+			ICONV_LINK =3D $(call libpath_template,$(ICONVDIR)/$(lib))
 		else
 			ICONV_LINK =3D
 		endif
diff --git a/shared.mak b/shared.mak
index aeb80fc4d5..f33cab8a4e 100644
--- a/shared.mak
+++ b/shared.mak
@@ -108,3 +108,9 @@ endif
 define mkdir_p_parent_template
 $(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
 endef
+
+## Getting sick of writing -L$(SOMELIBDIR) $(CC_LD_DYNPATH)$(SOMELIBDIR)=
?
+## Write $(call libpath_template,$(SOMELIBDIR)) instead, perhaps?
+define libpath_template
+-L$(1) $(CC_LD_DYNPATH)$(1)
+endef
--=20
2.43.0-493-gbc7ee2e5e1

