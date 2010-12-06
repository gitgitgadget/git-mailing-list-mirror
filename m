From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 01/10] parse-options: Don't call parse_options_check()
 so much
Date: Sun, 05 Dec 2010 23:57:42 -0800
Message-ID: <4CFC9776.7040000@gmail.com>
References: <20101201232728.GA31815@burratino> <20101201232852.GB31815@burratino> <4CFBD693.20305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Pierre Habouzit <madcoder@debian.org>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 06 08:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPVxQ-0005QT-BY
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 08:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab0LFH5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 02:57:55 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45038 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab0LFH5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 02:57:54 -0500
Received: by pzk6 with SMTP id 6so1786951pzk.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 23:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GQ0vkUWK3fWHndSSgW3oVHAylv/k9gLp+VFwuDFQOkU=;
        b=xJyun9rN0OnGdw118G9KhEOLTMX0ju13BAMfX9hd7bus5DC3Nxq/fZ0xa6Q0bhIbn8
         2TO6FOFwrF3xZzkPyVq1vsUp5oALVfcZzx/WB7srBA7hiHgc11+lT/qknK4HIDUUiqNs
         gA4JtOGk/dk848CB4ymIkqoaWQL8QrEF8mle8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rWoaShpFvCVf8KjylqXTnw8mky3r/0WWzR8n6k7ak1N9XFxVNyzf5Cpt0fJMM+FBMU
         qLEoY+K1W9PJ3E+vrh7Rj8slObAbI/ngjV6RWpq7REHjDj7T+/cZKt4RnbzxrO2kxktZ
         tvLj8Qr9CId291eIfkrolUpxQ57/tN+BANYkc=
Received: by 10.142.223.2 with SMTP id v2mr4696088wfg.240.1291622274112;
        Sun, 05 Dec 2010 23:57:54 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id x35sm6946505wfd.13.2010.12.05.23.57.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 23:57:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <4CFBD693.20305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162981>

On 12/05/10 10:14, Ren=C3=A9 Scharfe wrote:
> Am 02.12.2010 00:28, schrieb Jonathan Nieder:
>> From: Stephen Boyd <bebarino@gmail.com>
>>  void parse_options_start(struct parse_opt_ctx_t *ctx,
>>  			 int argc, const char **argv, const char *prefix,
>> -			 int flags)
>> +			 int flags, const struct option *options)
>=20
> It might be better to put options before flags, i.e. to use the same
> order as in parse_options().
>=20

Jonathan mentioned that too. Sounds good to me. Here's an updated patch=
=2E

--->8----8<----
Subject: [PATCH] parse-options: Don't call parse_options_check() so muc=
h

parse_options_check() is being called for each invocation of
parse_options_step which can be quite a bit for some commands. The
commit introducing this function cb9d398 (parse-options: add
parse_options_check to validate option specs., 2009-06-09) had the
correct motivation and explicitly states that parse_options_check()
should be called from parse_options_start(). However, the implementatio=
n
differs from the motivation. Fix it.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/blame.c    |    4 ++--
 builtin/shortlog.c |    4 ++--
 parse-options.c    |    7 +++----
 parse-options.h    |    2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cb25ec9..aa30ec5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2325,8 +2325,8 @@ int cmd_blame(int argc, const char **argv, const
char *prefix)
 	save_commit_buffer =3D 0;
 	dashdash_pos =3D 0;

-	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH=
 |
-			    PARSE_OPT_KEEP_ARGV0);
+	parse_options_start(&ctx, argc, argv, prefix, options,
+			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
 		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
 		case PARSE_OPT_HELP:
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 2135b0d..1a21e4b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -268,8 +268,8 @@ int cmd_shortlog(int argc, const char **argv, const
char *prefix)
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
-	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH=
 |
-			    PARSE_OPT_KEEP_ARGV0);
+	parse_options_start(&ctx, argc, argv, prefix, options,
+			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);

 	for (;;) {
 		switch (parse_options_step(&ctx, options, shortlog_usage)) {
diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..9bbbc6a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -338,7 +338,7 @@ static void parse_options_check(const struct option
*opts)

 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
-			 int flags)
+			 const struct option *options, int flags)
 {
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->argc =3D argc - 1;
@@ -350,6 +350,7 @@ void parse_options_start(struct parse_opt_ctx_t *ct=
x,
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
 		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+	parse_options_check(options);
 }

 static int usage_with_options_internal(struct parse_opt_ctx_t *,
@@ -362,8 +363,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 {
 	int internal_help =3D !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);

-	parse_options_check(options);
-
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt =3D NULL;

@@ -452,7 +451,7 @@ int parse_options(int argc, const char **argv, cons=
t
char *prefix,
 {
 	struct parse_opt_ctx_t ctx;

-	parse_options_start(&ctx, argc, argv, prefix, flags);
+	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
diff --git a/parse-options.h b/parse-options.h
index ae8647d..7b53414 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -180,7 +180,7 @@ struct parse_opt_ctx_t {

 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
 				int argc, const char **argv, const char *prefix,
-				int flags);
+				const struct option *options, int flags);

 extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
--=20
