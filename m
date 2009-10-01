From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] do not mangle short options which take arguments
Date: Thu, 1 Oct 2009 22:16:48 +0200
Message-ID: <20091001201648.GA12175@localhost>
References: <20090925233226.GC14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 22:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtS5C-0006al-B7
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 22:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbZJAUQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbZJAUQs
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 16:16:48 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:34377 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbZJAUQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 16:16:47 -0400
Received: by bwz6 with SMTP id 6so452882bwz.37
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=l9d1JwJx2C2yXFdI1m0wmF3zmpToMQGtwMP1AlUyS3I=;
        b=ggdJbKKgpJITcMpf+TWnZcKX/e9aK65UaPPn5ahlMarlp4L8iqC8wtB94TrFw488HF
         2e2pRlE+XVcEdayI1qN/S4FI7rkLRzwjvKe57bvyltiYkIeyuzTWRJBRTf7JTSogPLNN
         wqPnpqTENu9bP38paIEdD60ucvLzbDocqzTjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=WG4rJsCb1FXE3WAZ46vxC8mhk2ZpESAo3EK4R2Xr+jMgowIRigyhiJ6LjiqKhSSHu/
         rmnaayI2ekLEa9e6xgiPspfU23cubZeRipZx4v6NkN8NnAsRcKZ4iLwNSnccYZ1moeZ2
         uJ2nrpNzRAJA3suTGRTfLJmFNfs8fkuKUg7bQ=
Received: by 10.204.16.88 with SMTP id n24mr371286bka.52.1254428210043;
        Thu, 01 Oct 2009 13:16:50 -0700 (PDT)
Received: from darc.lan (p549A5338.dip.t-dialin.net [84.154.83.56])
        by mx.google.com with ESMTPS id 17sm621310bwz.81.2009.10.01.13.16.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 13:16:48 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MtS52-0003go-Vg; Thu, 01 Oct 2009 22:16:48 +0200
Content-Disposition: inline
In-Reply-To: <20090925233226.GC14660@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129408>

Instead of

  $ git commit -a -ammend
  [work ce38944] mend
   1 files changed, 2 insertions(+), 0 deletions(-)

we now get

  $ git commit -a -ammend
  error: switch `m' must not be mangled with other options
  usage: git commit [options] [--] <filepattern>...
  [...]

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Fri, Sep 25, 2009 at 04:32:26PM -0700, Shawn O. Pearce wrote:
> I wonder, should the -m flag on commit not allow cuddling its
> value against the switch when its combined in short form with
> other switches?

Here we go.

Clemens

 parse-options.c            |   16 ++++++++++++----
 t/t0040-parse-options.sh   |   12 ++++++++++++
 t/t3701-add-interactive.sh |    2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a64a4d6..4f16f37 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -5,6 +5,7 @@
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
+#define OPT_MANY 4
 
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
@@ -43,9 +44,12 @@ static int get_value(struct parse_opt_ctx_t *p,
 		     const struct option *opt, int flags)
 {
 	const char *s, *arg;
+	const int many = flags & OPT_MANY;
 	const int unset = flags & OPT_UNSET;
 	int err;
 
+	if (many && !(opt->flags & PARSE_OPT_NOARG))
+		return opterror(opt, "must not be mangled with other options", flags);
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
@@ -149,14 +153,18 @@ static int get_value(struct parse_opt_ctx_t *p,
 	}
 }
 
-static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
+static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option
+		*options, int many)
 {
 	const struct option *numopt = NULL;
+	int flags = OPT_SHORT;
+	if (many)
+		flags |= OPT_MANY;
 
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
-			return get_value(p, options, OPT_SHORT);
+			return get_value(p, options, flags);
 		}
 
 		/*
@@ -374,7 +382,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			ctx->opt = arg + 1;
 			if (internal_help && *ctx->opt == 'h')
 				return parse_options_usage(usagestr, options);
-			switch (parse_short_opt(ctx, options)) {
+			switch (parse_short_opt(ctx, options, 0)) {
 			case -1:
 				return parse_options_usage(usagestr, options);
 			case -2:
@@ -385,7 +393,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			while (ctx->opt) {
 				if (internal_help && *ctx->opt == 'h')
 					return parse_options_usage(usagestr, options);
-				switch (parse_short_opt(ctx, options)) {
+				switch (parse_short_opt(ctx, options, 1)) {
 				case -1:
 					return parse_options_usage(usagestr, options);
 				case -2:
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index bbc821e..86eb350 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -315,4 +315,16 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 	test_cmp expect output
 '
 
+cat > mangle.err << EOF
+error: switch \`s' must not be mangled with other options
+EOF
+
+cat mangle.err expect.err > expect-mangle.err
+
+test_expect_success 'do not mangle options which require arguments' '
+	test_must_fail test-parse-options -bs123 > output 2> output.err &&
+	! test -s output &&
+	test_cmp expect-mangle.err output.err
+'
+
 test_done
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 62fd65e..208a134 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -207,7 +207,7 @@ index b6f2c08..61b9053 100755
 EOF
 # Test splitting the first patch, then adding both
 test_expect_success 'add first line works' '
-	git commit -am "clear local changes" &&
+	git commit -a -m "clear local changes" &&
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
 	git diff --cached > diff &&
-- 
1.6.5.rc1.214.g13c5a
