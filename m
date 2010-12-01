From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/10] parse-options: clearer reporting of API misuse
Date: Wed, 1 Dec 2010 17:29:23 -0600
Message-ID: <20101201232923.GC31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw7F-00016t-GA
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab0LAX3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:29:32 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34169 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab0LAX3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:29:31 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so759557vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Cav8XigFM64objqRk/SvjXuqJhTydE6Nfj7bf9xZO9o=;
        b=KYX942KvWqIwkPlFHgbhhArwDB31JsaYKPS6Jh1R3NC2Fklhafet4Va4kJfTiKHNX9
         TaRND/Z6Ct0upDTwykqAFEW7ZvCaPtRt1WW/34K9hHJ29NCGQ303qAZc3KHN1U9SOV2P
         UHk5yCSU863BVuswc1we8ztPXvrn9yn8pIIrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nGnREtlznz2zx4rwzbK+ShcEmuRANCYwCw5CoEYWDkcQwQMJjh6pFQmlfPtu/+Dx3t
         xtnfTOzEIWHOaaTJd/HwsjpZ1yZjPZefSAa7wUkjifL20/3hfww88SwcOzRzjqhB/5kR
         O5PMPVukhjMOF1+5uOWN1IKyCCAmoasiRmw9s=
Received: by 10.220.182.203 with SMTP id cd11mr2631432vcb.36.1291246171326;
        Wed, 01 Dec 2010 15:29:31 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id e16sm156142vcm.8.2010.12.01.15.29.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:29:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162640>

The PARSE_OPT_LASTARG_DEFAULT flag is meant for options like
--contains that (1) traditionally had a mandatory argument and
(2) have some better behavior to use when appearing in the final
position.  It makes no sense to combine this with OPTARG, so ever
since v1.6.4-rc0~71 (parse-options: add parse_options_check to
validate option specs, 2009-07-09) this mistake is flagged with

	error: `--option` uses incompatible flags LASTARG_DEFAULT and OPTARG

and an exit status representing an error in commandline usage.

Unfortunately that which might confuse scripters calling such an
erroneous program into thinking the _script_ contains an error.
Clarify that it is an internal error by dying with a message beginning
"fatal: BUG: ..." and status 128.

While at it, clean up parse_options_check to prepare for more checks.

Long term, it would be nicer to make such checks happen at compile
time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 196ba71..12f100b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,6 +11,13 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
+static NORETURN void optbug(const struct option *opt, const char *reason)
+{
+	if (opt->long_name)
+		die("BUG: option '%s' %s", opt->long_name, reason);
+	die("BUG: switch '%c' %s", opt->short_name, reason);
+}
+
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
@@ -316,24 +323,12 @@ static void check_typos(const char *arg, const struct option *options)
 
 static void parse_options_check(const struct option *opts)
 {
-	int err = 0;
-
 	for (; opts->type != OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
-		    (opts->flags & PARSE_OPT_OPTARG)) {
-			if (opts->long_name) {
-				error("`--%s` uses incompatible flags "
-				      "LASTARG_DEFAULT and OPTARG", opts->long_name);
-			} else {
-				error("`-%c` uses incompatible flags "
-				      "LASTARG_DEFAULT and OPTARG", opts->short_name);
-			}
-			err |= 1;
-		}
+		    (opts->flags & PARSE_OPT_OPTARG))
+			optbug(opts, "uses incompatible flags "
+				"LASTARG_DEFAULT and OPTARG");
 	}
-
-	if (err)
-		exit(129);
 }
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
-- 
1.7.2.3
