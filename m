From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/6] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Tue, 30 Nov 2010 00:13:15 -0800
Message-ID: <4CF4B21B.5030401@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com> <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino> <20101130025223.GA5326@burratino> <20101130025551.GB5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:13:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLLG-0006IB-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab0K3INd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 03:13:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46696 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0K3INc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 03:13:32 -0500
Received: by gyb11 with SMTP id 11so2552184gyb.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 00:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=AqVPUyDTHNZFKTIDEva7j2JvcmKFQw3Kzm+rDdLC62Q=;
        b=boFtqV8UX7EBtBDnNDi23pS8+zz0gY4VIz0NdYhGBvbAVkE4iQ0NCYBVsGYJ0uk7Wl
         8QCeclUDSM1K8YwNTwNwlVXvW2bCONv7C6ggv91uxkzha3qTdA3mx9PWZVc0GiQU99YN
         lEiKEHO/yexvfNrA1/6mIe/Q24tKvfZ49Sr6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=S0/gUBbrOpWRtPS7XN/h4xxcPbM+8bQeXkojIPRQ/IX4wVqRSnRhNVrvPLMu1bdakP
         E+ZvJwyRB8IMDrMng7V1XRZwoF1P3qeoABW0K3dUReWQ++ETnpZjrxWBt5x4xpXwIjHJ
         lJXSVpf15p1OubBxVY/qG78+vbrEQkeuYXuRI=
Received: by 10.150.182.12 with SMTP id e12mr12085085ybf.298.1291104810999;
        Tue, 30 Nov 2010 00:13:30 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id y21sm3821545yhc.14.2010.11.30.00.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 00:13:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101130025551.GB5326@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162476>

On 11/29/10 18:55, Jonathan Nieder wrote:
> +static void check_flags(const struct option *opt)
> +{
> +	switch (opt->type) {
> +	case OPTION_BOOLEAN:
> +	case OPTION_BIT:
> +	case OPTION_NEGBIT:
> +	case OPTION_SET_INT:
> +	case OPTION_SET_PTR:
> +	case OPTION_NUMBER:
> +		break;
> +	default:	/* (usually accepts an argument) */
> +		return;
> +	}
> +	if ((opt->flags & (PARSE_OPT_OPTARG | PARSE_OPT_NOARG)) == PARSE_OPT_NOARG)
> +		return;
> +	die("BUG: option '-%c%s' should not accept an argument",
> +				!opt->short_name ? '-' : opt->short_name,
> +				!opt->short_name ? opt->long_name : "");
> +}
> +

This check should probably go into parse_options_check() and be run once
for each invocation of parse_options_start()... Oh that isn't good.

Looks like parse_options_check() is being called for each
parse_options_step(). Here's a patch to fix that. Junio, this can
probably be applied to maint.

---8<------>8-----
Subject: [PATCH] parse-options: Don't call parse_options_check() so much

parse_options_check() is being called for each invocation of
parse_options_step() which can be quite a bit for some commands. The
commit introducing this function cb9d398 (parse-options: add
parse_options_check to validate option specs., 2009-06-09) had the
correct motivation and explicitly states that parse_options_check()
should be called from parse_options_start(). However, the implementation
differs from the motivation. Fix it.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/blame.c    |    2 +-
 builtin/shortlog.c |    2 +-
 parse-options.c    |    7 +++----
 parse-options.h    |    2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f5fccc1..19a2ebf 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2310,7 +2310,7 @@ int cmd_blame(int argc, const char **argv, const
char *prefix)
 	dashdash_pos = 0;

 	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
-			    PARSE_OPT_KEEP_ARGV0);
+			    PARSE_OPT_KEEP_ARGV0, options);
 	for (;;) {
 		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
 		case PARSE_OPT_HELP:
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 2135b0d..8473391 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -269,7 +269,7 @@ int cmd_shortlog(int argc, const char **argv, const
char *prefix)
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
-			    PARSE_OPT_KEEP_ARGV0);
+			    PARSE_OPT_KEEP_ARGV0, options);

 	for (;;) {
 		switch (parse_options_step(&ctx, options, shortlog_usage)) {
diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..196ba71 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -338,7 +338,7 @@ static void parse_options_check(const struct option
*opts)

 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
-			 int flags)
+			 int flags, const struct option *options)
 {
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->argc = argc - 1;
@@ -350,6 +350,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
 		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+	parse_options_check(options);
 }

 static int usage_with_options_internal(struct parse_opt_ctx_t *,
@@ -362,8 +363,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);

-	parse_options_check(options);
-
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;

@@ -452,7 +451,7 @@ int parse_options(int argc, const char **argv, const
char *prefix,
 {
 	struct parse_opt_ctx_t ctx;

-	parse_options_start(&ctx, argc, argv, prefix, flags);
+	parse_options_start(&ctx, argc, argv, prefix, flags, options);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
diff --git a/parse-options.h b/parse-options.h
index ae8647d..828c056 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -180,7 +180,7 @@ struct parse_opt_ctx_t {

 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
 				int argc, const char **argv, const char *prefix,
-				int flags);
+				int flags, const struct option *options);

 extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
-- 
1.7.3.2.614.g03864
