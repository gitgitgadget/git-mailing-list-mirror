Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AD1CD21C
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989653; cv=none; b=ugbZTFty2nbbZrnqfPjfg6YMGrwfphpVmQN3sobCusIM2P0X22dZlsByJqJ5NycqqOHHpyNY6BsXJsX5LEqvdOL/odKQEFTYqBq4NAHN9fxs13Y54l8xnEP3sUWnlPaUCX/ic2THJOsJNMhliAe15u4BzBaoOr3vu6vX3HW7WXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989653; c=relaxed/simple;
	bh=f6Tjgqyw+uISSvRqOeZKO6UAkEajJYS5467KrVpn34U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CI24g34Fw6SpMz3QxSdO0AJyUZmlvZsba6NhielCsyT+xKXEzZIA2M/kTBUh11Tx1doEezGrCZfsPLsygQF47aNo/fzW+2c+Il3xVWgyjMbPrt1sKSu97eJr/KFJ+RDJ7vtztfCVlvNywLM8ja6GXGEDi3DBScxgApEQ4SPKpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZZ3bAXb5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZZ3bAXb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741989643; x=1742594443; i=l.s.r@web.de;
	bh=0bo/9LoUfBzjNYYgA6QhzsNj5tZvWJj/qtxgKUW+r4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZZ3bAXb5gWUbAmt1Cp340g9uriraaSAemdnrX1TMEn+poERAs+UEJZLKYU4rGUjq
	 bnxCThbkGfuDG/4Oy41sve2z1AvMZQ3PnQJ3tD+QwKhsp6WJhm/etN9vcPsIdDiEB
	 1k9MXlXcIBiUU6bmigPtPfHxtEFzJSjb1ValLyk1MKjLaUgWv60hDpVo2dushbjjm
	 0uyyN2U18C6FxM3zq0iiU+S0gmxSFRILgTUuQSkTbb/0o5YyAMMZ2bTWMMjoeB+sl
	 CFJXQn7O6Mh4RkGr++FqOIP5TjQs50rlBoX8UtZfmTts3zPDR5lnvG5ZfMl0mRN7P
	 F0z+On6+Z8umOjurmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.218]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoNZM-1tQSyx1036-00nCIL; Fri, 14
 Mar 2025 23:00:43 +0100
Message-ID: <4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de>
Date: Fri, 14 Mar 2025 23:00:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] xdiff: avoid arithmetic overflow in xdl_get_hunk()
To: Jason Cho <jason11choca@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
 <NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rVkfZxSGcbyb3KK9ncjCO1Z60ZbKn26ixEAVynAHFEFntYZAj/Q
 oAgCnSFLVOvUPBbvFHq9TkaxP++S9zUIHuddCONOyZEuApioBNskFCES8c3DXIBbI9kG8n5
 f6SnlploE4XxRE334sLDm8TDP4I2pm0DltHjzaMb7mGyWJ9LDfWmjiqOrsxnxjimj5YnCTR
 gdzKUk7nKtSLUmQqdhvaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WxMNOqGPuRM=;yvQAOYLCMYFLD5FNeyNMb82mgvu
 cbRtVeCukNnjnGJMiBTZMzpRGXd6gElSNQCK9pFZxe8oE46EXDpqwgUwGnM2GQclXAOAVZrzg
 C3Ht/qnrJekzGQoJY+107VMtgRO05Myv6wJ28sfxCngoro3g+m2syccVREkArpuxcBErkl7KR
 rMqbNJTT+IQBkSrmRoOmrkKhjFAAo5uXPTHOyE0rxIUJOLzBtkC5IVq3WS6Rpq8hW8uWzNbnD
 WuprmBR1pw1CiG0fkQG+4vIiI4EYd76pKvCyqewJodCdI8tlZ7Ez6diNNPVWS19VkYuPAskKN
 Y1eoWWeT7QMOR3C1LtZo6ZXrNTxlEPIwAO1/3whi3ns7zAS8NHqSnG+9gFdnBAJdqmpCSvSfK
 l2+p6PAo5E8bPuAMj7tXApuNeOkbS2yuz/4ERBglc5kTCCIVM4eDv8BoeKt1pRgMOjQoo2HdI
 lDRsWfVREHj8hVD/bohLg+C6yarRo3W2xnT5Hvh8p0Kie/SKZiWCjth51Gc5DtP0VR7qxVP9I
 mgC7LylMoY4mI8FqbeADfHx4luMbo+V4Rxpa6F6Y2+vXsr3Hp7qMEMxvqlc4rbixyxMkO98Eo
 JRACi4m2NV/DEdITuKa+qPP/R7wQiSp8LWoIpX2RRDExrdsPVlci3PzacmleB9FneChyMWTtR
 6O4F68wSFbZ+fbWE004+6NuAZzJeockaIncv76bcMP5YLmIMH0VwOaeNxaZchN+CKTwEWlrpL
 BM+/fwvaIEOUVxJZGUhVFDnefVNheMKkeV01FDbRgfY7yMolY7N3ChA1gUr3z8XdPlPcVFmKu
 8ceaX8CRMRnso51oZZ9O7yt56tn5T2nyEfVSZuAO00Wrm8NDQsjNJ53XExRzTswwPn2ujdycZ
 LA1e23Z6fLnLNVLA/uCN/32mmwIaGjLe5HVwrcB96ZYaJ2HmUIcunZNlsEFwKAbt9Znd6HAam
 FM61rE7N8ZcdZP3cv8kBk+sKPJ9TrvlbxyhXB1RDJUskamdeBy9s+nCLd3Uw6XXWz7ebxz+jx
 O/PV7W8XOwBjBdFVaGB/N/LUXg1/i9KJYZea3WhfJj/+WT0z7SSX19utOiA5kAmhrj/j+IPOi
 4aPs6n791AY1MU4Dr0MpGVC1/RZPiGhqlVcTSZgIhnlckm8BuHft2RXkiv9kHbcNj3QNcmZFC
 7YrizpadBo+V7Hb98bqGat9vHwQbYXraTsuWlepiQq5zB8JJz0gzgqyVEb0yS9Ph2OzvnYa1w
 hrFfg82/IzPO9JaPdJWwcUgziZrgT4FoVHQpI8vaUF5v8e3MQ+MhmhgPQIOtua1HggGO+ljKJ
 HK9x/+aYvq3gLAlXeK3LhkQzl7J1JaifphTfxquwBXjCSiyIkoicG3ctywmpvEwnJN1ExPdvC
 /huN62tvCiu45LU4Xdyt42PMck/4Zxzm+4irFSmPWThwiWey2vvflsOB8RS6xaDxfnwSHRwxj
 H9SwWQA==

xdl_get_hunk() calculates the maximum number of common lines between two
changes that would fit into the same hunk for the given context options.
It involves doubling and addition and thus can overflow if the terms are
huge.

The type of ctxlen and interhunkctxlen in xdemitconf_t is long, while
the type of the corresponding context and interhunkcontext in struct
diff_options is int.  On many platforms longs are bigger that ints,
which prevents the overflow.  On Windows they have the same range and
the overflow manifests as hunks that are split erroneously and lines
being repeated between them.

Fix the overflow by checking and not going beyond LONG_MAX.  This allows
specifying a huge context line count and getting all lines of a changed
files in a single hunk, as expected.

Reported-by: Jason Cho <jason11choca@proton.me>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4055-diff-context.sh | 10 ++++++++++
 xdiff/xemit.c           |  8 +++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index f7ff234cf9..ec2804eea6 100755
=2D-- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -89,4 +89,14 @@ test_expect_success '-U0 is valid, so is diff.context=
=3D0' '
 	grep "^+MODIFIED" output
 '

+test_expect_success '-U2147483647 works' '
+	echo APPENDED >>x &&
+	test_line_count =3D 16 x &&
+	git diff -U2147483647 >output &&
+	test_line_count =3D 22 output &&
+	grep "^-ADDED" output &&
+	grep "^+MODIFIED" output &&
+	grep "^+APPENDED" output
+'
+
 test_done
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index f8e3f25b03..1d40c9cb40 100644
=2D-- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -43,6 +43,10 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char=
 const *pre, xdemitcb_t *
 	return 0;
 }

+static long saturating_add(long a, long b)
+{
+	return signed_add_overflows(a, b) ? LONG_MAX : a + b;
+}

 /*
  * Starting at the passed change atom, find the latest change atom to be =
included
@@ -52,7 +56,9 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char =
const *pre, xdemitcb_t *
 xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
 {
 	xdchange_t *xch, *xchp, *lxch;
-	long max_common =3D 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
+	long max_common =3D saturating_add(saturating_add(xecfg->ctxlen,
+							xecfg->ctxlen),
+					 xecfg->interhunkctxlen);
 	long max_ignorable =3D xecfg->ctxlen;
 	long ignored =3D 0; /* number of ignored blank lines */

=2D-
2.48.1
