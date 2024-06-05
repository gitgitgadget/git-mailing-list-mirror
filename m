Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D91946AA
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576602; cv=none; b=iKUr6brT4mkJGWd1RVHyEM/E8HzFlSCXvpsNDRPKHDLq4rIKMhd/wLBDmCqBA9cneLpeFJxkRzy3ITfuMdpEsG6K6GF6p14G3OTDE7nnxM1Z7FxhiSdmPWA2IO41bnD7BTVksa756X5Bss82WBQeLD6yuUNhHqvMHORxs5+wllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576602; c=relaxed/simple;
	bh=PxsekTgPu0VhFwaMlhO4prAv1QDs6stHZoA6CZS2YsQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BjmX4H03LEHE1bnIJ3HH02NXA7csfKtXN1fqgr0jDwU5KkTgZJqQFOEfMHxDsUAN3YJKVr3fUwHdOFjjx25wlr/3ltec5/5QeXasFWG4C2XoHhs+Ay7aKplHbesxicOuhBjK/MURpYxejztvWOxIFg/TaCN19R9xgFyiou6SxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fdr0Sgvm; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fdr0Sgvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717576592; x=1718181392; i=l.s.r@web.de;
	bh=2UK/cxdgbVhhp2nxaXhMjdkBam2K0w/l4wNqlAi6JU4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fdr0SgvmwSoD5KghL5T6C47l46+g5N4SfaUCAjvjbtjg2xJRpUdbK3V4kqSGTWyA
	 qwx8ixeH8c5KS3HXORlHCz0rEUaJGs7LWTiiANl0KYcoUSF6owQgAhJuH+tfo7RNj
	 u2njzGjKN7MNOwDLrH1LZsiHrh8HMi4Jd4Jxy8oqIhkV+BY9Coy2z2mx9N5G6EXUy
	 ygk8qpQu+ISOX1PE4oIRQtKQJWp2s2nAwfTvwtF+cM+S+EHrqSQsG5/bhTWCJytFo
	 4vOthpYbcNgEIaX79sE8ji0Mkj35l+yUhu9n7h9n0yzYILWBpppVNH80X6+SPKSdp
	 +oqwVH/3avac8Mmlfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lnF-1sVC3v1WAN-00vBcB; Wed, 05
 Jun 2024 10:36:32 +0200
Message-ID: <87251602-1dc8-4115-ad4a-b9160ec082a9@web.de>
Date: Wed, 5 Jun 2024 10:36:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] userdiff: add and use struct external_diff
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Content-Language: en-US
In-Reply-To: <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUBjgJlls5lJ8BhhN23+rVvDDRd7Qy/e62N1epUbOKuu9UJpNDS
 phJMzL25a+h3FBWNCFBjHc1/zQrqtlCi9ful67hO9XKDVRee7poFoCSGHzGh22fNyQ+fyLC
 UF4GQjuZS+9Bgg2oKgCBB51zqyP8LvzlEmjzm7ajKmKkkJrK55MzuKWyuYhAM7HoBEpDTnd
 TPsIieWSK/7QVLl6aGTfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jK6WZ3WwJNQ=;fTwo58LezK+6Y54wsSzJEMUS0FJ
 xo5oWyVq9iuW0KUe6rEw9JWo6wdo2l91vmilNrvsynqUrCk9Nk1+65tHVj6JyNSFlO/uS+Z1a
 4vhcfVC1wuKkkLBgyY6CR49MWSB7mk/XLfwkGnIwUyPeiaiTMOZFXirsyVf5TWRjyk6bGXo5G
 PuCQeE7wCKptcuCRWVSFTOdW4QHIx9g0n7eIW0c/Jt7yAxj7oCcAR4aCpdQNHf9GjxocQzSBv
 Unyg4MfxZrzeCkOW7Wr8Vhxu6v1AWKjjtpy+rytAs7I4lTVP7kzlNCcy+GSkorXySNzhyx/Vc
 oaouN+3MiSvpzMqJwkQoHqs8jfKFNIFGc6SEkAsIKgBkuD0X3zfwDyGIr2J8IpBDtMunrmfSJ
 YXvAmDpHb3JuTyR5PH/53TJow15NnSBbdhIYohf84d+tf/Sle0wdXZEJeE+glQCN5M6nawy0u
 QsXSdPGJDS5HA4N07dIl3eHHsDbhXMEGTbt3muRnrUMHPthcvDpvWupk6/1PKv+XlVOl/IOj7
 1uGvxDshtFbyXdCyY8wyQO0lm1SaHTU/llU1WAIf05zXCQP53OscJ2IM8924Lrr31IDhOytuf
 RN3p7GQeOgsN7AK7J607xafGrnj22fJU/wBvoDT+uv3lAvNygdhL1RESw0Zrn+2//YUC0Ge4d
 LcDz9mvRF8+tApxzubzc1OPtR3P2cpA4PSS3IjFwWMY/ETsBsapCi5U7CtkDc5P3HGJ60Dsj+
 VcdXutTgNL+0PbbMdOW0CU36PoeXCzyp5Ty1HXGYZeKQ1RfKqktUfoTmsCu+43QdMU6P2+4/7
 FfofzMkE/4+3Yy762rPDAvprzCNSW0mmyoPQTqsKh7ask=

Wrap the string specifying the external diff command in a new struct to
simplify adding attributes, which the next patch will do.

Make sure external_diff() still returns NULL if neither the environment
variable GIT_EXTERNAL_DIFF nor the configuration option diff.external is
set, to continue allowing its use in a boolean context.

Use a designated initializer for the default builtin userdiff driver to
adjust to the type change of the second struct member.  Spelling out
only the non-zero members improves readability as a nice side-effect.

No functional change intended.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c     | 32 +++++++++++++++++---------------
 userdiff.c |  4 ++--
 userdiff.h |  6 +++++-
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index ded9ac70df..286d093bfa 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -57,7 +57,7 @@ static int diff_color_moved_ws_default;
 static int diff_context_default =3D 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
-static const char *external_diff_cmd_cfg;
+static struct external_diff external_diff_cfg;
 static const char *diff_order_file_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
@@ -429,7 +429,7 @@ int git_diff_ui_config(const char *var, const char *va=
lue,
 		return 0;
 	}
 	if (!strcmp(var, "diff.external"))
-		return git_config_string(&external_diff_cmd_cfg, var, value);
+		return git_config_string(&external_diff_cfg.cmd, var, value);
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
 	if (!strcmp(var, "diff.orderfile"))
@@ -546,18 +546,20 @@ static char *quote_two(const char *one, const char *=
two)
 	return strbuf_detach(&res, NULL);
 }

-static const char *external_diff(void)
+static const struct external_diff *external_diff(void)
 {
-	static const char *external_diff_cmd =3D NULL;
+	static struct external_diff external_diff_env, *external_diff_ptr;
 	static int done_preparing =3D 0;

 	if (done_preparing)
-		return external_diff_cmd;
-	external_diff_cmd =3D xstrdup_or_null(getenv("GIT_EXTERNAL_DIFF"));
-	if (!external_diff_cmd)
-		external_diff_cmd =3D external_diff_cmd_cfg;
+		return external_diff_ptr;
+	external_diff_env.cmd =3D xstrdup_or_null(getenv("GIT_EXTERNAL_DIFF"));
+	if (external_diff_env.cmd)
+		external_diff_ptr =3D &external_diff_env;
+	else if (external_diff_cfg.cmd)
+		external_diff_ptr =3D &external_diff_cfg;
 	done_preparing =3D 1;
-	return external_diff_cmd;
+	return external_diff_ptr;
 }

 /*
@@ -4373,7 +4375,7 @@ static void add_external_diff_name(struct repository=
 *r,
  *               infile2 infile2-sha1 infile2-mode [ rename-to ]
  *
  */
-static void run_external_diff(const char *pgm,
+static void run_external_diff(const struct external_diff *pgm,
 			      const char *name,
 			      const char *other,
 			      struct diff_filespec *one,
@@ -4384,7 +4386,7 @@ static void run_external_diff(const char *pgm,
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q =3D &diff_queued_diff;

-	strvec_push(&cmd.args, pgm);
+	strvec_push(&cmd.args, pgm->cmd);
 	strvec_push(&cmd.args, name);

 	if (one && two) {
@@ -4510,7 +4512,7 @@ static void fill_metainfo(struct strbuf *msg,
 	}
 }

-static void run_diff_cmd(const char *pgm,
+static void run_diff_cmd(const struct external_diff *pgm,
 			 const char *name,
 			 const char *other,
 			 const char *attr_path,
@@ -4528,8 +4530,8 @@ static void run_diff_cmd(const char *pgm,
 	if (o->flags.allow_external || !o->ignore_driver_algorithm)
 		drv =3D userdiff_find_by_path(o->repo->index, attr_path);

-	if (o->flags.allow_external && drv && drv->external)
-		pgm =3D drv->external;
+	if (o->flags.allow_external && drv && drv->external.cmd)
+		pgm =3D &drv->external;

 	if (msg) {
 		/*
@@ -4595,7 +4597,7 @@ static void strip_prefix(int prefix_length, const ch=
ar **namep, const char **oth

 static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
-	const char *pgm =3D external_diff();
+	const struct external_diff *pgm =3D external_diff();
 	struct strbuf msg;
 	struct diff_filespec *one =3D p->one;
 	struct diff_filespec *two =3D p->two;
diff --git a/userdiff.c b/userdiff.c
index 82bc76b910..f47e2d9f36 100644
=2D-- a/userdiff.c
+++ b/userdiff.c
@@ -333,7 +333,7 @@ PATTERNS("scheme",
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
-{ "default", NULL, NULL, -1, { NULL, 0 } },
+{ .name =3D "default", .binary =3D -1 },
 };
 #undef PATTERNS
 #undef IPATTERN
@@ -445,7 +445,7 @@ int userdiff_config(const char *k, const char *v)
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-		return git_config_string(&drv->external, k, v);
+		return git_config_string(&drv->external.cmd, k, v);
 	if (!strcmp(type, "textconv"))
 		return git_config_string(&drv->textconv, k, v);
 	if (!strcmp(type, "cachetextconv"))
diff --git a/userdiff.h b/userdiff.h
index d726804c3e..7e2b28e88d 100644
=2D-- a/userdiff.h
+++ b/userdiff.h
@@ -11,9 +11,13 @@ struct userdiff_funcname {
 	int cflags;
 };

+struct external_diff {
+	const char *cmd;
+};
+
 struct userdiff_driver {
 	const char *name;
-	const char *external;
+	struct external_diff external;
 	const char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
=2D-
2.45.2
