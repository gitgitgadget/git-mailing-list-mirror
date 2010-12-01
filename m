From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/10] parse-options: move NODASH sanity checks to
 parse_options_check
Date: Wed, 1 Dec 2010 17:29:51 -0600
Message-ID: <20101201232950.GD31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:30:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw7i-0001Ig-Tl
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab0LAXaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:30:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34169 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0LAX37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:29:59 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so759557vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yGFM6D49pozyOA/P1mbpUp1KZ/Ad4xL/WFIFpezYXBg=;
        b=DWtYvgIxsizkcNfiSlqcLNbrXac+/Ax+AZpsA/jHa8/UyJI8VfISE67SMSAmGAC6mB
         kheLYL6N1/PSmHC37CGbASn9PEY7XRdpwGrwqjgOg1IYH8MylhBzPi2xJiGFcjH0HGVk
         N/tyo9CmjqY6E5Z/YMSaYchGXfIOJ2ULdrPww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iARbdjM1N72u236gz2vjA6EeMZX+4eNwsCv1pLfmjTys73hPlFnP0DexK9EGk1ea0Q
         hygWn8wXfgJzQGb24DkEHILoyypTqSXcv24W3tTrShDz7FlN1MAmN8Rubq8tJOuYbFcx
         Xkmn0BgyiVoUjZrV0q4fmtxK+FpPTUO19lNnI=
Received: by 10.220.198.137 with SMTP id eo9mr2495431vcb.2.1291246198982;
        Wed, 01 Dec 2010 15:29:58 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id e18sm242048vbm.5.2010.12.01.15.29.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:29:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162641>

A dashless switch (like '(' passed to 'git grep') cannot be negated,
cannot be attached to an argument, and cannot have a long form.
Currently parse-options runs the related sanity checks when the
dashless option is used; better to always check them at the start of
option parsing, so mistakes can be caught more quickly.

The error message at the new call site is less specific about the
nature of the error, for simplicity.  On the other hand, it is more
specific in that it prints which switch was problematic.  Before:

	fatal: BUG: dashless options can't be long

After:

	fatal: BUG: switch '(' uses feature not supported for dashless options

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 12f100b..c825620 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -288,13 +288,6 @@ static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 	for (; options->type != OPTION_END; options++) {
 		if (!(options->flags & PARSE_OPT_NODASH))
 			continue;
-		if ((options->flags & PARSE_OPT_OPTARG) ||
-		    !(options->flags & PARSE_OPT_NOARG))
-			die("BUG: dashless options don't support arguments");
-		if (!(options->flags & PARSE_OPT_NONEG))
-			die("BUG: dashless options don't support negation");
-		if (options->long_name)
-			die("BUG: dashless options can't be long");
 		if (options->short_name == arg[0] && arg[1] == '\0')
 			return get_value(p, options, OPT_SHORT);
 	}
@@ -328,6 +321,13 @@ static void parse_options_check(const struct option *opts)
 		    (opts->flags & PARSE_OPT_OPTARG))
 			optbug(opts, "uses incompatible flags "
 				"LASTARG_DEFAULT and OPTARG");
+		if (opts->flags & PARSE_OPT_NODASH &&
+		    ((opts->flags & PARSE_OPT_OPTARG) ||
+		     !(opts->flags & PARSE_OPT_NOARG) ||
+		     !(opts->flags & PARSE_OPT_NONEG) ||
+		     opts->long_name))
+			optbug(opts, "uses feature "
+				"not supported for dashless options");
 	}
 }
 
-- 
1.7.2.3
