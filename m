From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/6] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Mon, 29 Nov 2010 20:55:51 -0600
Message-ID: <20101130025551.GB5326@burratino>
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
X-From: git-owner@vger.kernel.org Tue Nov 30 04:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNGXT-0002Mk-3V
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 04:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0K3DFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 22:05:49 -0500
Received: from mail-qw0-f66.google.com ([209.85.216.66]:57859 "EHLO
	mail-qw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab0K3DFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 22:05:49 -0500
Received: by qwd6 with SMTP id 6so1746882qwd.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 19:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8eFyZenqmc1TMEqLiW8sYQ3ELLgob3vTt7sYlezjPSE=;
        b=EsV8MoL24LSKIUdm+kji2w81tIGCcSrpZYWMKnV2ignLmQvDGSimPegviqQ2KUSkI9
         mBN4yg7Lh3OqeQEjowjy86CSrYTqCCM6HDvrkF71VnnHPtc1Cp+S/Y1BY0uPBeJeWDh6
         393D3LKE7eDJ5DU7BmHwwCwC02Gzg7s/zTMjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FIJEGXazp+jrIbOT6uvkWmsR4vPYM02Imf+95nk+f4HS0LMfse6D8x3CsBc/Smi8y0
         JpvEPuzYEzCXUvB+jCq7imgT1JsGtVUKHaHO6TrA/z5oDdVoPEnZoZZ64CjDj7li8fiA
         CHYFqM2aljKS5GTbMsLWsrETRbU1GuuivE9M8=
Received: by 10.229.190.204 with SMTP id dj12mr5578174qcb.66.1291085760321;
        Mon, 29 Nov 2010 18:56:00 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id s34sm3689870qcp.8.2010.11.29.18.55.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 18:55:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130025223.GA5326@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162465>

Some option types cannot use an argument --- boolean options that
would set a bit or flag or increment a counter, for example.  If
configured in the flag word to accept an argument anyway, the result
is an argument that is advertised in "program -h" output only to be
rejected by parse-options::get_value.

Luckily all current users of these option types use PARSE_OPT_NOARG
and do not use PARSE_OPT_OPTARG.  Add a check to ensure that that
remains true.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New patch, preparing for patch 2.  Maybe the check should be
implemented elsewhere (ideally compile time) so all flags can be
checked rather than just the flags that happen to be used in a given
test run.

 parse-options.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..1806bb3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -44,6 +44,26 @@ static void fix_filename(const char *prefix, const char **file)
 	*file = xstrdup(prefix_filename(prefix, strlen(prefix), *file));
 }
 
+static void check_flags(const struct option *opt)
+{
+	switch (opt->type) {
+	case OPTION_BOOLEAN:
+	case OPTION_BIT:
+	case OPTION_NEGBIT:
+	case OPTION_SET_INT:
+	case OPTION_SET_PTR:
+	case OPTION_NUMBER:
+		break;
+	default:	/* (usually accepts an argument) */
+		return;
+	}
+	if ((opt->flags & (PARSE_OPT_OPTARG | PARSE_OPT_NOARG)) == PARSE_OPT_NOARG)
+		return;
+	die("BUG: option '-%c%s' should not accept an argument",
+				!opt->short_name ? '-' : opt->short_name,
+				!opt->short_name ? opt->long_name : "");
+}
+
 static int get_value(struct parse_opt_ctx_t *p,
 		     const struct option *opt, int flags)
 {
@@ -51,6 +71,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 	const int unset = flags & OPT_UNSET;
 	int err;
 
+	check_flags(opt);
+
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
 	if (unset && (opt->flags & PARSE_OPT_NONEG))
-- 
1.7.2.3
