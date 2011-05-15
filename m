From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH resend] status: store format option as an int
Date: Sat, 14 May 2011 23:05:01 -0500
Message-ID: <20110515040501.GA28948@elie>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
 <20110416004544.GA5628@elie>
 <20110416013723.GA23105@sigill.intra.peff.net>
 <20110416052704.GA10807@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 15 06:05:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLSZx-0004eU-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 06:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab1EOEFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 00:05:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43002 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab1EOEFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 00:05:08 -0400
Received: by iyb14 with SMTP id 14so2973809iyb.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 21:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R7uQ6ZnsXyJvGXxXSyWq+7B/guPAHy/LJIX2dazj/OQ=;
        b=BPXubWVu5vWGVO0+6Ov9h7OLXYO3scHjV+srJGQw4sogcnTqWf2wq2w3k5IWSeOoq6
         ZUVG7TuiKSOBuzDitLJ4t0PVbYf1FGUR91b+y3QJf883wWFUTDLVGHG3wAUp5Bg/7wol
         Xp8lvBhX0p4vCyHcrjHLUUmuzejrVYXxwZIfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U5YTKI9wyjkPQT1likW2Uu1tkGgPZSWzHNIsmColCt1cScdWgQDxDbdofMRJ5N8X74
         S5OnndxlfzQUXtKgPo1Pa9DqGCHMMN4TY0VNPwoFmEkNxDLcfGhRTZCEYWmQhABxRb5X
         EHCO7WS5jug953JL5gKnF1e6wgvo64/8VEh3k=
Received: by 10.42.59.74 with SMTP id l10mr3814736ich.62.1305432308057;
        Sat, 14 May 2011 21:05:08 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id wu17sm1475982icb.23.2011.05.14.21.05.06
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 21:05:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110416052704.GA10807@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173619>

It is unsafe to pass a pointer to a value of enumerated type to
OPT_SET_INT (as v1.7.0-rc0~137^2~14, 2009-09-05, does), since it might
have the wrong alignment or width.  C99 only says "Each enumerated
type shall be compatible with char, a signed integer type, or an
unsigned integer type.  The choice of type is implementation-defined,
but shall be capable of representing the values of all the members of
the enumeration."

Probably this hasn't come up in practice because GCC uses an 'int' to
represent small enums unless passed -fshort-enums, except on certain
architectures where -fshort-enums is the default.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jeff King <peff@peff.net>
---
I last sent this about a month ago and it seemed ok.  The changes
since last time are to the commit message:

 - hopefully it parses as English now
 - adding Jeff's ack

Thanks again, both.

 builtin/commit.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 411d5e4..64808aa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -108,11 +108,12 @@ static const char *only_include_assumed;
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
1.7.5.1
