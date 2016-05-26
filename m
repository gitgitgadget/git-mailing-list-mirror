From: Jeff King <peff@peff.net>
Subject: [PATCH] archive-tar: convert snprintf to xsnprintf
Date: Thu, 26 May 2016 00:28:08 -0400
Message-ID: <20160526042807.GA6756@sigill.intra.peff.net>
References: <CO2PR0801MB599926424BC99D7DFC2622B8E4F0@CO2PR0801MB599.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Green, Paul" <Paul.Green@stratus.com>
X-From: git-owner@vger.kernel.org Thu May 26 06:28:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5muE-00075Q-LE
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 06:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbcEZE2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 00:28:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:44427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750716AbcEZE2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 00:28:11 -0400
Received: (qmail 5033 invoked by uid 102); 26 May 2016 04:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:28:10 -0400
Received: (qmail 16843 invoked by uid 107); 26 May 2016 04:28:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 00:28:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 00:28:08 -0400
Content-Disposition: inline
In-Reply-To: <CO2PR0801MB599926424BC99D7DFC2622B8E4F0@CO2PR0801MB599.namprd08.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295628>

On Tue, May 24, 2016 at 12:44:24AM +0000, Green, Paul wrote:

> While examining (relatively) recent changes to git, my eye happened to
> notice the following inconsistency on line 184 of the current version
> of archive-tar.c. 
> 
> -    sprintf(header->chksum, "%07o", ustar_header_chksum(header));
> +    snprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
> 
> I believe the author meant to invoke the xsnprintf function, not the
> snprintf function. I say this because all of the other references to
> sprintf were indeed changed to xsnprintf, with the necessary
> additional 2nd argument.

Yep, it was indeed just a typo. Thanks for noticing.

-- >8 --
Subject: archive-tar: convert snprintf to xsnprintf

Commit f2f0267 (archive-tar: use xsnprintf for trivial
formatting, 2015-09-24) converted cases of "sprintf" to
"xsnprintf", but accidentally left one as just "snprintf".
This meant that we could silently truncate the resulting
buffer instead of flagging an error.

In practice, this is impossible to achieve, as we are
formatting a ustar checksum, which can be at most 7
characters. But the point of xsnprintf is to document and
check for "should be impossible" conditions; this site was
just accidentally mis-converted during f2f0267.

Noticed-by: Paul Green <Paul.Green@stratus.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 501ca97..cb99df2 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -181,7 +181,7 @@ static void prepare_header(struct archiver_args *args,
 	memcpy(header->magic, "ustar", 6);
 	memcpy(header->version, "00", 2);
 
-	snprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
+	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
 }
 
 static int write_extended_header(struct archiver_args *args,
-- 
2.9.0.rc0.307.gc679867
