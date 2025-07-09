Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E602441B4
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054338; cv=none; b=ecQBWz3hufIv7VZtIGC7+L8ny3VTKv0mNA3EWN/ecOwID3tkEXcrCGVWLVcG7u2np+1yt2xJAomM5tkVqK1B3852PWx+uyGKI3tm2wC6hMYRew1QbI5S+/3amsxyTTC/p11WOwCl3xIjVAo2dynOlgJqVMO0zyAXFmYI7hj8FTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054338; c=relaxed/simple;
	bh=tFTlHVws58AeDIOf5O25VhvXhFXqtdFkt+MFCEz9hJs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CMZWL5BBuHF16Ao5z3YwNn2pqP8E+CFijEVyw/0Ja3FWzdgZkhknQ7/p95lsj/fYdpkrx4mO8JH6MeIdxsJi/xXvnKZHYSGonQMWeJU+yvSvp6rz+dpAzkIadm8Ffw65QPSyvKQ9BTTN/c6d5opXB3ujns4ID5epR7PiiO3xHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mOlVPJtj; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mOlVPJtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054334; x=1752659134; i=l.s.r@web.de;
	bh=8TNgEvf6hMg+xKn+4Wc3bBFqXc4FBOVGL6y9QteHa5c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mOlVPJtj8WJ0C5gMfaI6VjYUERe1U0xZuJEtINzL5i7jIEdiQzesCfemSh9gxqvI
	 bCOR9uFcrciMFXYxXAAQYwlQh31LuX3wxomKjOfszg/hBgU5pC1KMH9GuxhB67Dn3
	 28CXWp7A+DJvTmX6iW9APFAeY1K72u6nOhsxJk8JAmCmFwPWygrLDtlm1w/9zUz2n
	 Ud1R+7P4SYENKpJwiARWA0Oe0TYsHUWyQbUZAfXUzgWWMqIZTHOH0V0hcVlcy5aSJ
	 ROoqagg1O5Cvph7CgAs4Rrqj2hRIGyGbqPuhYRHXU/N5v/QYuYL1DeYspZrJbn/4U
	 r6iEyyAehyoeecAShQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1v93Il1OXh-00jyeq; Wed, 09
 Jul 2025 11:45:34 +0200
Message-ID: <b0e933c7-1b95-4bfa-b056-1bf00ad2583c@web.de>
Date: Wed, 9 Jul 2025 11:45:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/7] parse-options: add precision handling for OPTION_BIT
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8C+zjK6vFKnYrV7uSsH0ktN/o+CWgmD7xDdjFCm+F11J4V8hKwh
 GJVzwiaCzZLJ5WWPLwyVZv267O+vUI6Wg28NS3UJew0QWzpvuN9g1lUI3+0zJ8H8LnzqsgL
 nWEFFexRxmJ5640YHQbDLXlhg7XF+NEabJKRLNzzuOW5PjxClLNDA/1Qp4kHArfB3AfFGcr
 +0TZEsKze4JstBPf8jezw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HGf1HCJfjbc=;ULFlQTCxt1RwnWypVyCa6c1rujE
 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

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_BIT.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/write-tree.c |  1 +
 parse-options.c      | 19 +++++++++++++++----
 parse-options.h      |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 5a8dc377ec..cfec044710 100644
=2D-- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -35,6 +35,7 @@ int cmd_write_tree(int argc,
 			.type =3D OPTION_BIT,
 			.long_name =3D "ignore-cache-tree",
 			.value =3D &flags,
+			.precision =3D sizeof(flags),
 			.help =3D N_("only useful for debugging"),
 			.flags =3D PARSE_OPT_HIDDEN | PARSE_OPT_NOARG,
 			.defval =3D WRITE_TREE_IGNORE_CACHE_TREE,
diff --git a/parse-options.c b/parse-options.c
index 639f41b83b..b5c877d5e1 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -88,6 +88,14 @@ static int do_get_int_value(const void *value, size_t p=
recision, intmax_t *ret)
 	}
 }
=20
+static intmax_t get_int_value(const struct option *opt, enum opt_parsed f=
lags)
+{
+	intmax_t ret;
+	if (do_get_int_value(opt->value, opt->precision, &ret))
+		BUG("invalid precision for option %s", optname(opt, flags));
+	return ret;
+}
+
 static enum parse_opt_result set_int_value(const struct option *opt,
 					   enum opt_parsed flags,
 					   intmax_t value)
@@ -139,11 +147,14 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 		return opt->ll_callback(p, opt, NULL, unset);
=20
 	case OPTION_BIT:
+	{
+		intmax_t value =3D get_int_value(opt, flags);
 		if (unset)
-			*(int *)opt->value &=3D ~opt->defval;
+			value &=3D ~opt->defval;
 		else
-			*(int *)opt->value |=3D opt->defval;
-		return 0;
+			value |=3D opt->defval;
+		return set_int_value(opt, flags, value);
+	}
=20
 	case OPTION_NEGBIT:
 		if (unset)
@@ -631,11 +642,11 @@ static void parse_options_check(const struct option =
*opts)
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
 		switch (opts->type) {
 		case OPTION_SET_INT:
+		case OPTION_BIT:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
 		case OPTION_COUNTUP:
-		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_NUMBER:
 		case OPTION_BITOP:
diff --git a/parse-options.h b/parse-options.h
index 71516e4b5b..6501ca3c27 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -172,6 +172,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG|(f), \
 	.callback =3D NULL, \
=2D-=20
2.50.0
