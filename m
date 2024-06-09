Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9D1BF40
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918757; cv=none; b=pFLw8TJ6eb2iAm+fdMsGESS7pvVCJfpKgOcrRhEcz348WtPrqXbESrKwl0A7vhLkSPTzLNCHT7m28HxergSy9IF1MUzJuyfadp97p9ocsNsFkgmbknulNlngdlvYNHWMCdRTYU+If7+DH3IdQDwJsWMoAzESvtCF8oyCKfT2UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918757; c=relaxed/simple;
	bh=Ff4SKO1h8WU9QiV/k7A7pSBYC3F5y78Rm1F+KokwtOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IZEvP5M5J5+F3h39v4VGP4tcO2VHLcuKHpJDUtfuBsx/Yhe/qvTgZ1o9+0gVYb20PwQ4LnHppa09cvxx44oMcJzNDqxMygMW7MXfo4NxbsdiHBJN7FGN5vk9QUb0cNeHczDtGfxkm2ZmO6L+Ww/294AWQIEiiAlY9am2djlwXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ho1Zm7kH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ho1Zm7kH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717918748; x=1718523548; i=l.s.r@web.de;
	bh=oCLkyEMNqoqKFAfp5x4mE0m6AwFFc2iCve8pW9tfhOI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ho1Zm7kH/bbWX7zjyln4CYxMTR8F1179Qtu898SJduEe15v16GOiovkcO+W7zNoM
	 a+4tDATyTDjanCpQt8NGJmwXF/I5AZVwwRZ/jQET8xS2UdOM9402Uk1RABaZb3eFP
	 6wvCvzMZE0gDDG/sCwVTf6UbXhQC9R6RcbVMp/o9c/tlzeQk9jYh6mdqelT2SKBXJ
	 noNWluOQdisLrjw8CJTZ7wtZM+I85CQ7oLjLPGoiolisZBD6gps0OAXH4If6HGAo2
	 PWDtbo8Ar0ZPCPAMFBsy46XkoM4RTujxDRNslzmC4naABqiaai0e6C9ozrcGhKAte
	 zKrAcytCxdiH3sTtgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1s0BOM2USU-00RnBv; Sun, 09
 Jun 2024 09:39:08 +0200
Message-ID: <0dd72a49-1c6d-4cd9-9257-d942443e1bc3@web.de>
Date: Sun, 9 Jun 2024 09:39:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/3] userdiff: add and use struct external_diff
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Language: en-US
In-Reply-To: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jjqr12oY32eEBXrB5GfjYghKMaAUcKK2f0zce7J0XZCHtq9YUzY
 JVUO+tLcHd1K8QUWYU9OvjyAfksDTN5fWIKfxY3483wQbwYmWX+dj7rENNMQX8HZupiSTO6
 AVnNPLZlQYbWwQv4VsBmmI8PCRDfKPWgZxU0Cq8FCgeDdFNAG+n8SZ9JZwiomCjjQCl5YW5
 csH+xzEznzvzl2v3m6PAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uqhf/LgFh6o=;VCMhs2U//7kgEH+PknBQL9yqj/O
 UnNyr6QVOmDYEwX8mga0FJlAubfE6Yd5pGXO/10fWdnlisypbWMfUN8TSt+BQQyVmUIG8m5G6
 sGnhhrcW8IEA8jOAdi6X/7QUe1qQ7B6YXS4xbO8WrcD3LKWrRm1l3UZRHaHHo/IaRS/o7V4EH
 LyvVN2va1YK5z8WFiu0+uhsisdf2MrNJ+PtyvGwqpsZrzxFFzZicz/qUyDfDNV3T42jnDusKB
 jRzi+WG1NB5WP6wZLXATrLhbc0T4Q7gVmwtT3/V9JPkWbnvBfs7gEjv4Ub0m5ofwuyG4+JCA0
 30sjcmiqN6hkPg/4FZGrNGyMJqWJZYgt1UqsgAnRQupcoyxlCNrFoXTvxEOvY/ySh8W/KfKwq
 sz1Efp5stvTsgyir4EZKtrPuh21iupffHWZF4cPW6ysqJdl++LbdSIfBsogyWB3hmkuWqmbDX
 Uwhew4ZX/tiqfqGvRgQLEAT2Joi8x9IADISBPHDIVQfGkh0YAq0Msxhl1HIM8w7zIc+2qFWVa
 wCUlww9cpEntWaimwMWEi7Y7f1TZK+ivICm/jvgflGSFMfeEg0FTz4WpYNtAhqJbGDstgq3Wk
 C2p5DBxzYgGHoPmDkV2p1qX+T9VAb4uXBmvi8VU5KKgviP187BC1AmP2I9kk2Gf/1e5jvxN80
 skZ+NOR3a+Th8k0ESJ7cbkMSm0PtAfAGLWIdz44paeLH6jNbM3VISkPtWZSurCFk7zAK3Fp4j
 A5eYBQ6LzfDpuqkc2Qft9Va/0XIuCC+gB4ybpcRZ1A9U7fTElhCHUSQHA9Imt5GjBCedfWyA4
 +B3HPMFU0JQDQyxjovApYDEvLpQ0fOSE1tsIKZReyakms=

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
index e70301df76..4b86c61631 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -57,7 +57,7 @@ static int diff_color_moved_ws_default;
 static int diff_context_default =3D 3;
 static int diff_interhunk_context_default;
 static char *diff_word_regex_cfg;
-static char *external_diff_cmd_cfg;
+static struct external_diff external_diff_cfg;
 static char *diff_order_file_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
@@ -431,7 +431,7 @@ int git_diff_ui_config(const char *var, const char *va=
lue,
 		return 0;
 	}
 	if (!strcmp(var, "diff.external"))
-		return git_config_string(&external_diff_cmd_cfg, var, value);
+		return git_config_string(&external_diff_cfg.cmd, var, value);
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
 	if (!strcmp(var, "diff.orderfile"))
@@ -548,18 +548,20 @@ static char *quote_two(const char *one, const char *=
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
@@ -4375,7 +4377,7 @@ static void add_external_diff_name(struct repository=
 *r,
  *               infile2 infile2-sha1 infile2-mode [ rename-to ]
  *
  */
-static void run_external_diff(const char *pgm,
+static void run_external_diff(const struct external_diff *pgm,
 			      const char *name,
 			      const char *other,
 			      struct diff_filespec *one,
@@ -4386,7 +4388,7 @@ static void run_external_diff(const char *pgm,
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q =3D &diff_queued_diff;

-	strvec_push(&cmd.args, pgm);
+	strvec_push(&cmd.args, pgm->cmd);
 	strvec_push(&cmd.args, name);

 	if (one && two) {
@@ -4512,7 +4514,7 @@ static void fill_metainfo(struct strbuf *msg,
 	}
 }

-static void run_diff_cmd(const char *pgm,
+static void run_diff_cmd(const struct external_diff *pgm,
 			 const char *name,
 			 const char *other,
 			 const char *attr_path,
@@ -4530,8 +4532,8 @@ static void run_diff_cmd(const char *pgm,
 	if (o->flags.allow_external || !o->ignore_driver_algorithm)
 		drv =3D userdiff_find_by_path(o->repo->index, attr_path);

-	if (o->flags.allow_external && drv && drv->external)
-		pgm =3D drv->external;
+	if (o->flags.allow_external && drv && drv->external.cmd)
+		pgm =3D &drv->external;

 	if (msg) {
 		/*
@@ -4597,7 +4599,7 @@ static void strip_prefix(int prefix_length, const ch=
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
index cc8e5abfef..2d59a8fc56 100644
=2D-- a/userdiff.h
+++ b/userdiff.h
@@ -11,9 +11,13 @@ struct userdiff_funcname {
 	int cflags;
 };

+struct external_diff {
+	char *cmd;
+};
+
 struct userdiff_driver {
 	const char *name;
-	char *external;
+	struct external_diff external;
 	char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
=2D-
2.45.2
