From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] parse-options: Add support for dumping out long options
Date: Wed, 11 Apr 2012 03:29:24 -0700
Message-ID: <1334140165-24958-2-git-send-email-bebarino@gmail.com>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
Cc: spearce@spearce.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 12:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHuo0-0003xq-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 12:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab2DKK3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 06:29:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39952 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab2DKK3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 06:29:30 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so1037432obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LuQhTBfykoN48bAemgvpeMBghJuML2a8MMdr10e+mlw=;
        b=GOeqIO7P8c4YQYXc8G2rofng6c7ihWL6ViwfrEXPzTyEwsQImAKPVH5yidLCQXzryF
         xPUnhq/f4ArnURBdXk28YxiLmi9SuGuFEpLHW3cn0r8lx7UvqU0in/zCbKrNaSE1b//8
         y9BVtwWtYZHLsg4EV6c+XzrcKaozTs0R6+WLncExfrX12FTqOfGTpIgWB+WChTQEmuwo
         znYgudNrn7m/LKsLvn1qn3Dy9DjxTTIbgqdaPzbY0B+OckYOKn4q6Kn6lYHL95qSGBc9
         DqxJLMPmURpQJhdq7gutQN+VRGJHlFwm9yJKeIBkAHTL49/oDOMpI7kzqO61/8G/BbFj
         nv2w==
Received: by 10.60.170.172 with SMTP id an12mr20579110oec.44.1334140170094;
        Wed, 11 Apr 2012 03:29:30 -0700 (PDT)
Received: from earth (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id b2sm2404649obo.22.2012.04.11.03.29.27
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 03:29:29 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 11 Apr 2012 03:29:29 -0700
X-Mailer: git-send-email 1.7.10.128.g7945c.dirty
In-Reply-To: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195160>

The bash completion script wants to know what the long options are for a
certain command at runtime. Add a magical long option that nobody could
possibly ever use (--dump-raw-long-options) to get this information.

Some example output:

 $ git clone --dump-raw-long-options
 --no-verbose --no-quiet --progress --no-progress --no-checkout
 --checkout --bare --no-bare --mirror --no-mirror --local --no-local
 --no-hardlinks --hardlinks --shared --no-shared --recursive
 --no-recursive --recurse-submodules --no-recurse-submodules --template=
 --no-template --reference= --no-reference --origin= --no-origin
 --branch= --no-branch --upload-pack= --no-upload-pack --depth=
 --no-depth --single-branch --no-single-branch --separate-git-dir=
 --no-separate-git-dir --config= --no-config

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

The name can be anything. This seemed sufficiently obscure.

 parse-options.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 850cfa7..6c37497 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -364,6 +364,45 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
 
+static int parse_options_raw(const struct option *opts)
+{
+	for (; opts->type != OPTION_END; opts++) {
+		if (opts->flags & PARSE_OPT_HIDDEN)
+			continue;
+		if (!opts->long_name)
+			continue;
+		switch (opts->type) {
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_COUNTUP:
+		case OPTION_SET_INT:
+		case OPTION_SET_PTR:
+			fprintf(stdout, "--%s ", opts->long_name);
+			break;
+		case OPTION_LOWLEVEL_CALLBACK:
+		case OPTION_STRING:
+		case OPTION_FILENAME:
+		case OPTION_INTEGER:
+		case OPTION_CALLBACK:
+			if (opts->flags & PARSE_OPT_OPTARG)
+				fprintf(stdout, "--%s ", opts->long_name);
+			else if (!(opts->flags & PARSE_OPT_NOARG))
+				fprintf(stdout, "--%s= ", opts->long_name);
+			break;
+		default:
+			continue;
+		}
+		if (!(opts->flags & PARSE_OPT_NONEG)) {
+			if (!prefixcmp(opts->long_name, "no-"))
+				fprintf(stdout, "--%s ", opts->long_name + 3);
+			else
+				fprintf(stdout, "--no-%s ", opts->long_name);
+		}
+	}
+
+	return PARSE_OPT_HELP;
+}
+
 int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const struct option *options,
 		       const char * const usagestr[])
@@ -431,6 +470,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
 		if (internal_help && !strcmp(arg + 2, "help"))
 			return parse_options_usage(ctx, usagestr, options, 0);
+		if (!strcmp(arg + 2, "dump-raw-long-options"))
+			return parse_options_raw(options);
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
 			return parse_options_usage(ctx, usagestr, options, 1);
-- 
1.7.10.128.g7945c.dirty
