From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] status: store format option as an int
Date: Sat, 16 Apr 2011 00:27:04 -0500
Message-ID: <20110416052704.GA10807@elie>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
 <20110416004544.GA5628@elie>
 <20110416013723.GA23105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 07:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAy2U-000686-6k
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 07:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab1DPF1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 01:27:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45763 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab1DPF1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 01:27:12 -0400
Received: by iwn34 with SMTP id 34so2632992iwn.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 22:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zeLsgR5xC8af+GpdiDWWeRqekRikDdxTApCHHkMVazo=;
        b=QQsvnL6dHGX1kMxB+9uCVugKuV1ZTpUXMJTGD4Ub5Xwl8iFJY4958dfJNdZJuPdG5r
         HySXXvoWJ9Yv87X/znv2a4ul8k+W1Xgt/Nl+6rjE1nrMLsoV60H5Sd4KKegdoaqTKKn1
         C1QEOioztDan0qgIHzGDKQJE3kr3h1YTdbDFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RXuaWIoDhioKT8/eWrKcFLybFu1XgxBBGxPvOQkv5ZUGxBvEibAaqAUEEuasmkyB7p
         wkLGovgtPDGvtjAaKYfjCHjTd/OWKhmoCoGV+WzonjAxcVLrK0CY1oYTwkQvZLtrLqdX
         JOiZ6gTerRgZzukQADJXbchBnjlkuZErESm0s=
Received: by 10.43.69.19 with SMTP id ya19mr3603390icb.324.1302931631761;
        Fri, 15 Apr 2011 22:27:11 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.ameritech.net [69.209.51.5])
        by mx.google.com with ESMTPS id ww2sm1817034icb.15.2011.04.15.22.27.09
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 22:27:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110416013723.GA23105@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171657>

It is unsafe to pass a pointer to a value of enumerated type to
OPT_SET_INT (as v1.7.0-rc0~137^2~14, 2009-0905) does, since it might
have the wrong alignment or width (C99 only says "Each enumerated type
shall be compatible with char, a signed integer type, or an unsigned
integer type.  The choice of type is implementation-defined, but shall
be capable of representing the values of all the members of the
enumeration.)

Probably this didn't come up in practice because by default GCC uses
an 'int' to represent small enums unless passed -fshort-enums (except
on certain architectures where -fshort-enums is the default).

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> Hmm. That does work (with either option, or both), but it is somewhat of
> an accident. There is an enum specifying the format the user wants. We
> hand it to parse-options for those options, telling it that the value is
> an int.

Yikes.  That's an accident waiting to happen.  How about this, to start?

 builtin/commit.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6e32166..b28848d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -94,11 +94,12 @@ static const char *only_include_assumed;
 static struct strbuf message;
 
 static int null_termination;
-static enum {
-	STATUS_FORMAT_LONG,
+enum status_format {
+	STATUS_FORMAT_LONG = 0,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN
-} status_format = STATUS_FORMAT_LONG;
+};
+static int status_format;
 static int status_show_branch;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
-- 
1.7.5.rc2
