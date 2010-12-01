From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/10] parse-options: do not infer PARSE_OPT_NOARG from
 option type
Date: Wed, 1 Dec 2010 17:30:40 -0600
Message-ID: <20101201233040.GF31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw8W-0001cH-1L
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab0LAXav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:30:51 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54966 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0LAXav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:30:51 -0500
Received: by vws16 with SMTP id 16so760158vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VdgV++vuGv3KPsDjMWywrCCdbYsixvnuHd0rxdSY+rk=;
        b=lkDqWzW7MSkUqZbRdHtMbAv1PdH+/PRCOAMx//OXOLev6AGI7SSrXjZQwlF2e5BF+Q
         bLPKWwD+SZjD6qGF2R45YmXElDebhOI5Z8TXLFbXbfdvyti8UJWYXGCxTMHwuNR7Coeq
         bYAkIaUKUM8HmPvYSe+IsGX7+az6vG4MXL/Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qi31+h3yy8cT0wAxCD9Vh103N2RHZHozAk85oIOYsXp4oVSWyE8ldF5dabameUWuyr
         YYsxSEyZJ6pOyxAFlc3PrVD1DJ3PtPBt76J6izLlft4VT2IRl3dCeGmfvFtKQlm9e/KM
         eFzc300wtO5eWqqbZUBIxLF3YERHN0u5i2h58=
Received: by 10.220.180.205 with SMTP id bv13mr2527235vcb.154.1291246250388;
        Wed, 01 Dec 2010 15:30:50 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id j22sm156362vcr.7.2010.12.01.15.30.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:30:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162643>

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

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e4d0b82..684d330 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -62,23 +62,8 @@ static int get_value(struct parse_opt_ctx_t *p,
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
