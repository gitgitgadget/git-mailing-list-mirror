From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10 v2] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Thu, 2 Dec 2010 00:08:57 -0600
Message-ID: <20101202060857.GD32125@burratino>
References: <20101201232728.GA31815@burratino>
 <20101201233020.GE31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 07:09:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO2Ly-00014L-MG
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 07:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078Ab0LBGJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 01:09:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35464 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331Ab0LBGJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 01:09:07 -0500
Received: by gxk1 with SMTP id 1so957776gxk.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bvHPR2jQwTKNga5ZotVrEin7SKq5cK4G9XT2qQTaEQY=;
        b=OEn1rUTMLQ0MzWqwf/d+9mkIXgkoXRuKPIeMrn0Gj6RtB4aDe2nYOkih4DxTyZcdWu
         4yGaIotGg37SkAuYglEQIE/186ljFgjl2gY7vR2R2v9ftjzAYZf2yMJp1OSQjIOXnQ/F
         TzZtaWOKJBl5FNuaWXenYEWywsPtegZnNb4Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vYc6l9WLj+5jI88GnW9HL3Tj/Z+IK7Ba1EV1c3qRCf0+LRMkpP40YLY2jnDsX8J5iJ
         Ec6qfGlIA0moZVq7Lq4dtrq6PAv5fpTsz4x4vcS4HRdKmdluI/dwHujXYShkoE68xvu4
         uRLfDTSU1BHYk3VzPACcbxl2tkwBsNun4lb/0=
Received: by 10.91.139.11 with SMTP id r11mr660166agn.83.1291270146741;
        Wed, 01 Dec 2010 22:09:06 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id v18sm99439yhg.15.2010.12.01.22.09.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 22:09:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201233020.GE31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162674>

Some option types cannot use an argument --- boolean options that
would set a bit or flag or increment a counter, for example.  If
configured in the flag word to accept an argument anyway, the result
is an argument that is advertised in "program -h" output only to be
rejected by parse-options::get_value.

Luckily all current users of these option types use PARSE_OPT_NOARG
and do not use PARSE_OPT_OPTARG.  Add a check to ensure that that
remains true.  The check is run once for each invocation of
parse_option_start().

Improved-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v1:
 - adapt for updated patch 2/10

 parse-options.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 9f6d305..74ab0c8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -330,6 +330,19 @@ static void parse_options_check(const struct option *opts)
 		     opts->long_name))
 			err |= optbug(opts, "uses feature "
 					"not supported for dashless options");
+		switch (opts->type) {
+		case OPTION_BOOLEAN:
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_SET_INT:
+		case OPTION_SET_PTR:
+		case OPTION_NUMBER:
+			if ((opts->flags & PARSE_OPT_OPTARG) ||
+			    !(opts->flags & PARSE_OPT_NOARG))
+				err |= optbug(opts, "should not accept an argument");
+		default:
+			; /* ok. (usually accepts an argument) */
+		}
 	}
 	if (err)
 		exit(128);
-- 
1.7.2.3
