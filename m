From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/10] parse-options: Don't call parse_options_check() so much
Date: Wed, 1 Dec 2010 17:28:52 -0600
Message-ID: <20101201232852.GB31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw6n-0000sv-FT
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab0LAX3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:29:03 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34169 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab0LAX3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:29:01 -0500
Received: by vws16 with SMTP id 16so759557vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tK98kzqddjBmqLooKAgfmuKSKCRuwwkEo5EnstoOQYQ=;
        b=nm99lwo3G24A85RHOSi+hPG3a7ClqMBqbz75I0fknH6qzL6psTZDJp/DSPuB7bc7Z7
         18aw3IMo7xYFxlj5Ri7ri97LeezArX8Sb1Kt+QxpsP7v4iE37Dwinx0Iruvil1BtmxuI
         7mdTijEpTZ7cjaXNMH3O9whaivEqxcf84fkKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LDQWO+OtZS4kzyeOL7y/fwnYSZiWQ4iU1XvnmXo3sCJ30kgSFvwkUGo5ywL772vnEq
         Ut1RUqpjh8k/44g4zk/B/aq5SplsvDmOtnElAL54VrIQE8sxwHZ1IZFRtbcnENLI2VDk
         f6Fu8Ka2psXckygNbcYqBPUn3uNvwn3u4Pr4Q=
Received: by 10.220.181.65 with SMTP id bx1mr2713004vcb.19.1291246140632;
        Wed, 01 Dec 2010 15:29:00 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id p22sm154007vcf.44.2010.12.01.15.28.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:29:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162639>

From: Stephen Boyd <bebarino@gmail.com>

parse_options_check() is being called for each invocation of
parse_options_step() which can be quite a bit for some commands. The
commit introducing this function cb9d398 (parse-options: add
parse_options_check to validate option specs., 2009-06-09) had the
correct motivation and explicitly states that parse_options_check()
should be called from parse_options_start(). However, the implementation
differs from the motivation. Fix it.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I would prefer to put "options" before flags, but seemed better to
just get this out there.  Unchanged.

 builtin/blame.c    |    2 +-
 builtin/shortlog.c |    2 +-
 parse-options.c    |    7 +++----
 parse-options.h    |    2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1015354..adf344c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2299,7 +2299,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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
@@ -269,7 +269,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
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
@@ -338,7 +338,7 @@ static void parse_options_check(const struct option *opts)
 
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
 
@@ -452,7 +451,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 {
 	struct parse_opt_ctx_t ctx;
 
-	parse_options_start(&ctx, argc, argv, prefix, flags);
+	parse_options_start(&ctx, argc, argv, prefix, flags, options);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
diff --git a/parse-options.h b/parse-options.h
index d982f0f..cfa03d5 100644
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
1.7.2.3
