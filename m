Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B61C6B8
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422177; cv=none; b=oQmMq2+aItnN3cVbjEsHoO3AE+oDkyJtPTS2q176p408H72/qTcaiNe+gi8nHyzZp/rWQOnaJYAvcvCpRNirS77TjPDyXa/LAhVmChi8aex4K+aHz+O9Cvd6or84qVg2JHSnn6g9y1FjBf/xRaaYTXTAQLwl6fAGQPMB84f3BrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422177; c=relaxed/simple;
	bh=EWpc1vAGPEWJp21aRjuvuFinFPqtWZIf1h3aCVYl9hY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EKRhjGQYiCvFOBEXA7AaJCW5s/Suiy4dphnLTyq2TBI2xWGer/Mr0/sVx6k504XnBsEGr/7rUXGIQ2iDSEjwdoyWphQcp0Nroriru3TNSg7JkL39L1ltwadGjTA5QuU0VWpIMKZQJdChCMsgmFFyutBQB6iakoeEWf4LCTefxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=k1q6PEkb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="k1q6PEkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729422153; x=1730026953; i=l.s.r@web.de;
	bh=3ADYBJAOCC95/BUWLQDt82qqN1q7zf2XDz0OnoUJzTQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k1q6PEkblV3Kfh99lTcnkjaBlUn0NNtfERVscLD/VeZ9g8bcxfJJ1VC5TrHAFOn2
	 6bGAi+fp/cvef1O9k1q5QDd7FoZGIsNZjLb8VdAyCx0K+FhDtJwvjDri0TqghARu1
	 lqhlHJgfdWy+EUaoKQ4MwDmYKOmCQ6hcz+ONECjyA0mFT+wjCAZfPWi1/0YoEk8pX
	 GQdoetmXB6ZgRnO3DrEs/yN+sMB3SvsFrC8QdtKTTiGSgP2h1sjDDu8ZEGTbmGOMW
	 /h3aihtcwoYKh5n4xXJTk6zloeEHpaMpjpjE0qEONWLtx0i9/UIM+T/RKvYmDuQPr
	 JNX9V2sGeqQ6yeNodQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.30.137]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8Wg-1tFcqH0rEO-00M66r; Sun, 20
 Oct 2024 13:02:33 +0200
Message-ID: <7a51a68e-5f9d-4444-a568-9ca180bc4c6b@web.de>
Date: Sun, 20 Oct 2024 13:02:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] grep: disable lookahead on error
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Taylor Blau <me@ttaylorr.com>, David Gstir <david@sigma-star.at>
Cc: git@vger.kernel.org, Richard Weinberger <richard@sigma-star.at>,
 Jeff King <peff@peff.net>
References: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>
 <Zw22sTxyWCbczZy8@nand.local> <0eaf6c1c-7205-4897-ba19-e5ba03194012@web.de>
Content-Language: en-US
In-Reply-To: <0eaf6c1c-7205-4897-ba19-e5ba03194012@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:30IVTP0Xg3l0JiqIOdd5pku4zVXwJLG2WpR2vAfJnoO3wgYRLwA
 W/ZkZ1eKOUne/bm0OX6krcVtbOEMZoMk/toXBtzdlaSm3tIsArk4h2xJVJeT2E+CkYSpzxf
 y62r4vtIWFSbcBB7wWe6TtU5avwP4UA/8vAo1Hc/gxTh127nEc8ltbHjYUHsAHnwiJub4C2
 TmTWFfdKojFF8apogiBOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u8gP66PXCFA=;6ZGA5iFCMlxEPSz9FRsrrCCR7nD
 YDqrsupqosThqYxESBp+vYLJq4V5nV4QwoljmarqbczfthgYBHdtG6BXJ0EtC4RXOQBNgprV2
 22QsEM0ICuUYbZu3/C9++8nuZInuKNITlO5wf7kyJkmLKlCJQk2HoYVh3VVu1vEyWJ8yJ4rvv
 Q6FNPjW/lA+rXF+VvmWmnJpXsk1xShWZFol5YnWMOhYFD5n47i29bGlqedMmoDQQxYwBgEvMP
 y+aXzys8TfSfINIhU7cn3+MFKPlj2do5EL1aqicX2TCE0vwsOXN+wlKEYVkpa42ZteP/UvJVN
 fnOLspqTvXejJm8L8dlZfgX7imimDsSIlNTDu8HVUhbh2RkCN3Ei/5AW7k+cfSQ4BtQ5NOh89
 K+2q2Tu/j9kszOaj+Vyt++LFqkGKjCIBz8U/HEFaBLk7IhE//h9umWvOv4VE0qS3+PlwnZxmu
 DpbVJAQq9yCxf+3iuCmUC/moKUvY0Mb0J69eDdHPFQTjmpUNRDS9721gyL4LRzJ+N0/FgeM5u
 7SqK44n5sWbcoF47O2lnke1myh4Aizxlo1awOtKAaIBUlva9i6WKJkpn0ShlkZDSQqAxrgv9T
 c6hm1lSKBpVKpFT8p00Iotue2kX4Zva4RvsFfDwo30a5xOsN3lhlifvUe6Oh7q0cNwwXQlwWw
 SXr4glPffGlqd95TAUo81rFvQk9dE/bhSgd8IMAwzR7DpqX0oTBqWu0H6oEGLutEoxz4VEQf4
 gZnXdzz4tosmXNCd4heStakppGVMNB3C+ydfC70C2zIjR5AP9dOEZMloDwB/JkphC/GUfc4nP
 nyQ+8pIb0J3YxXaqKwremnJg==

regexec(3) can fail.  E.g. on macOS it fails if it is used with an UTF-8
locale to match a valid regex against a buffer containing invalid UTF-8
characters.

git grep has two ways to search for matches in a file: Either it splits
its contents into lines and matches them separately, or it matches the
whole content and figures out line boundaries later.  The latter is done
by look_ahead() and it's quicker in the common case where most files
don't contain a match.

Fall back to line-by-line matching if look_ahead() encounters an
regexec(3) error by propagating errors out of patmatch() and bailing out
of look_ahead() if there is one.  This way we at least can find matches
in lines that contain only valid characters.  That matches the behavior
of grep(1) on macOS.

pcre2match() dies if pcre2_jit_match() or pcre2_match() fail, but since
we use the flag PCRE2_MATCH_INVALID_UTF it handles invalid UTF-8
characters gracefully.  So implement the fall-back only for regexec(3)
and leave the PCRE2 matching unchanged.

Reported-by: David Gstir <david@sigma-star.at>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c          | 30 ++++++++++++++++++++----------
 t/t7810-grep.sh |  9 +++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/grep.c b/grep.c
index 701e58de04..506f0423c8 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -906,15 +906,17 @@ static int patmatch(struct grep_pat *p,
 		    const char *line, const char *eol,
 		    regmatch_t *match, int eflags)
 {
-	int hit;
-
 	if (p->pcre2_pattern)
-		hit =3D !pcre2match(p, line, eol, match, eflags);
-	else
-		hit =3D !regexec_buf(&p->regexp, line, eol - line, 1, match,
-				   eflags);
+		return !pcre2match(p, line, eol, match, eflags);

-	return hit;
+	switch (regexec_buf(&p->regexp, line, eol - line, 1, match, eflags)) {
+	case 0:
+		return 1;
+	case REG_NOMATCH:
+		return 0;
+	default:
+		return -1;
+	}
 }

 static void strip_timestamp(const char *bol, const char **eol_p)
@@ -952,6 +954,8 @@ static int headerless_match_one_pattern(struct grep_pa=
t *p,

  again:
 	hit =3D patmatch(p, bol, eol, pmatch, eflags);
+	if (hit < 0)
+		hit =3D 0;

 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -1461,6 +1465,8 @@ static int look_ahead(struct grep_opt *opt,
 		regmatch_t m;

 		hit =3D patmatch(p, bol, bol + *left_p, &m, 0);
+		if (hit < 0)
+			return -1;
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
@@ -1655,9 +1661,13 @@ static int grep_source_1(struct grep_opt *opt, stru=
ct grep_source *gs, int colle
 		if (try_lookahead
 		    && !(last_hit
 			 && (show_function ||
-			     lno <=3D last_hit + opt->post_context))
-		    && look_ahead(opt, &left, &lno, &bol))
-			break;
+			     lno <=3D last_hit + opt->post_context))) {
+			hit =3D look_ahead(opt, &left, &lno, &bol);
+			if (hit < 0)
+				try_lookahead =3D 0;
+			else if (hit)
+				break;
+		}
 		eol =3D end_of_line(bol, &left);

 		if ((ctx =3D=3D GREP_CONTEXT_HEAD) && (eol =3D=3D bol))
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index af2cf2f78a..64ac4f04ee 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -87,6 +87,7 @@ test_expect_success setup '
 	# Still a no-op.
 	function dummy() {}
 	EOF
+	printf "\200\nASCII\n" >invalid-utf8 &&
 	if test_have_prereq FUNNYNAMES
 	then
 		echo unusual >"\"unusual\" pathname" &&
@@ -534,6 +535,14 @@ do
 		test_cmp expected actual
 	'

+	test_expect_success "grep $L searches past invalid lines on UTF-8 locale=
" '
+		LC_ALL=3Den_US.UTF-8 git grep A. invalid-utf8 >actual &&
+		cat >expected <<-EOF &&
+		invalid-utf8:ASCII
+		EOF
+		test_cmp expected actual
+	'
+
 	test_expect_success FUNNYNAMES "grep $L should quote unusual pathnames" =
'
 		cat >expected <<-EOF &&
 		${HC}"\"unusual\" pathname":unusual
=2D-
2.47.0
