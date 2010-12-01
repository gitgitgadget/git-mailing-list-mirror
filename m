From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/10] parse-options: never suppress arghelp if
 LITERAL_ARGHELP is set
Date: Wed, 1 Dec 2010 17:31:36 -0600
Message-ID: <20101201233136.GG31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:31:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw9P-0001uV-9D
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab0LAXbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:31:46 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33863 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487Ab0LAXbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:31:45 -0500
Received: by vws16 with SMTP id 16so760471vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rFglfP/QMwbfXXD6s445TOZOzoFfDJNhr2uYC0hlrwE=;
        b=E6anQQ+SsY3SHoiHb+kAsVApebkv/2acVYcZ+7A40lTVJWeJbV+sOIKNHA7XnbsIuI
         nc0p7ta9xT4uGUYdVz0X7Eqzis45Xh5lHtaTUENnIdzg+ysZi3rdoLQGe3hhQSdMstOG
         Pei2o/K0uIN4tKyU3vmHoOlffq5OyaDukA2O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ja2zw1QrFiYYp+keqA7m7DUxPFlRwj1O8SC1vYhKEIcrHoMw8fsUWmPmU1lth/Iw/5
         2aS+rQv+//OG0mQJneJk2Ej5EYiao6q9WPHhzrAjfKuHvz2/B//oWsM7+D5jpq3yZZUO
         9w+mpRuUqmCJpjPj+d03X/M6dBxeoiqHzBvTo=
Received: by 10.220.192.132 with SMTP id dq4mr540530vcb.77.1291246305251;
        Wed, 01 Dec 2010 15:31:45 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id b28sm156864vcm.6.2010.12.01.15.31.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:31:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162644>

The PARSE_OPT_LITERAL_ARGHELP flag allows a program to override the
standard "<argument> for mandatory, [argument] for optional" markup in
its help message.  Extend it to override the usual "no text for
disallowed", too (for the PARSE_OPT_NOARG | PARSE_OPT_LITERAL_ARGHELP
case, which was previously meaningless), to be more intuitive.

The motivation is to allow update-index to correctly advertise

	--cacheinfo <mode> <object> <path>
	                      add the specified entry to the index

while abusing PARSE_OPT_NOARG to disallow the "sticked form"

	--cacheinfo=<mode> <object> <path>

Noticed-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This seems like the intuitive thing to do, but the motivating use case
is iffy.  Might be better to introduce a PARSE_OPT_NOSTICKED flag.

 parse-options.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 684d330..b640ac5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -533,7 +533,8 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (opts->type == OPTION_NUMBER)
 			pos += fprintf(outfile, "-NUM");
 
-		if (!(opts->flags & PARSE_OPT_NOARG))
+		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+		    !(opts->flags & PARSE_OPT_NOARG))
 			pos += usage_argh(opts, outfile);
 
 		if (pos <= USAGE_OPTS_WIDTH)
-- 
1.7.2.3
