From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] parse-options: do not infer PARSE_OPT_NOARG from option
 type
Date: Mon, 29 Nov 2010 21:04:41 -0600
Message-ID: <20101130030441.GC5326@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101130025223.GA5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 04:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNGWv-0002FG-Ub
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 04:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab0K3DEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 22:04:52 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:48640 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab0K3DEv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 22:04:51 -0500
Received: by vws15 with SMTP id 15so466683vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 19:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C+dwK2l5RUVoZX0+7emWFv4brXLxezs63Dt5HzxITys=;
        b=K2P/2MXBLHhiJqOIDqKul0+a06C096jNBLG3GeZA1Fy3qv6Sg3APZ4h/ECaKepM7lt
         Yx559DDv0KZ8hzoESLCjVwR+Y0lFWyVSd6OY7xMicyqLC13ltwAEBYFYg/hKkUiFVp0r
         KFMgvqm9n2XwbXw3bcW9KT71xe8sQVlJ6NIDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kUodt3sr/VCpvGnoLVU12X7LYR1Ls68z//AXkJrJp3VJRmpD8JkaFgLzCLDlGe+R5j
         poYN7AmVMqMVN2bzt7QA9AQacRHUzDWIT5yoDwPn04GH/UIByIoqKGSnfVp/tjmOZc1c
         2m5yrV7DnSSz58u0MRvfmHeITDqzUTo+Zfqjc=
Received: by 10.220.178.65 with SMTP id bl1mr1295451vcb.45.1291086290691;
        Mon, 29 Nov 2010 19:04:50 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id i2sm902065vcs.33.2010.11.29.19.04.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 19:04:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130025223.GA5326@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162464>

From: Stephen Boyd <bebarino@gmail.com>

Simplify the "takes no value" error path by relying on PARSE_OPT_NOARG
being set correctly.  That is:

 - if the PARSE_OPT_NOARG flag is set, reject --opt=value
   regardless of the option type;
 - if the PARSE_OPT_NOARG flag is unset, accept --opt=value
   regardless of the option type.

This way, the accepted usage more closely matches the usage advertised
with --help-all.

No functional change intended, since the NOARG flag is only used
with "boolean-only" option types in existing parse_options callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 1806bb3..bc92d69 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -77,23 +77,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
 		return opterror(opt, "isn't available", flags);
-
-	if (!(flags & OPT_SHORT) && p->opt) {
-		switch (opt->type) {
-		case OPTION_CALLBACK:
-			if (!(opt->flags & PARSE_OPT_NOARG))
-				break;
-			/* FALLTHROUGH */
-		case OPTION_BOOLEAN:
-		case OPTION_BIT:
-		case OPTION_NEGBIT:
-		case OPTION_SET_INT:
-		case OPTION_SET_PTR:
-			return opterror(opt, "takes no value", flags);
-		default:
-			break;
-		}
-	}
+	if (!(flags & OPT_SHORT) && p->opt && (opt->flags & PARSE_OPT_NOARG))
+		return opterror(opt, "takes no value", flags);
 
 	switch (opt->type) {
 	case OPTION_BIT:
-- 
1.7.2.3
