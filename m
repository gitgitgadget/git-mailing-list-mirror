From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] correct verify_path for Windows
Date: Tue, 7 Oct 2008 07:26:23 +0400
Message-ID: <20081007032623.GX21650@dpotapov.dyndns.org>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 05:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn3JR-0000rF-NO
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 05:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYJGD0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 23:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYJGD0a
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 23:26:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37601 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbYJGD03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 23:26:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2173928fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 20:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e/qGlSP4QvSSjgLaR88Q8fzNk3nkKYWdTL7THwenPAQ=;
        b=tnLXik/qfP/tzWAgUbvMFhtxXvU5rH9efZvsCmI9hJdUtNy6jZv8J0mMSj4odpcLMn
         JPScnRn4omVoj/1aYVIa8imZP9onF6Pa+53cuO0zQNFj2TPdbbQkm193HmMxuu/3JE/0
         R/pJR85HXqOBqfySzOrBJYpy6GEnP5RibS67k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d/aTt1u+mhhB3ekEOeTmGBl2wwK5GBW+a2uqLGmgCQHCcr5XTWWhAEoW3amUvz2Un5
         yvAQQC+pAMUsSlbLmuu8nFvk9uSVLE3JLXtLLpni+tEmpDa6IhKZSj3o+tRmpykJMWRI
         +dRHH0GM1psrphLkeLxKq4jyb/0Yl2Wm67Wh0=
Received: by 10.86.74.4 with SMTP id w4mr5274827fga.58.1223349987336;
        Mon, 06 Oct 2008 20:26:27 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id e20sm12523251fga.1.2008.10.06.20.26.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 20:26:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97661>

Colon and backslash in names may be used on Windows to overwrite files
outside of the working directory. Due to the file-system being case-
insensitive, .git can be written as any combination of upper and lower
characters, so we should check that too.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
In this version, I have added the check that files in .git/ will not
be overwritten by checkout. Overwriting such files as .git/config is
potentially exploitable.

Josh,

Does OS X need the same check below? I believe it has case-insensitive
filesystem, so it needs that too, but I am not sure what is the right
define should be used.

Thanks,
Dmitry

 read-cache.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index aff6390..7f855ee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -668,10 +668,19 @@ static int verify_dotfile(const char *rest)
 	 * shares the path end test with the ".." case.
 	 */
 	case 'g':
+#if defined(_WIN32) || defined(__CYGWIN__)
+	/* On Windows, file names are case-insensitive */
+	case 'G':
+		if ((rest[1]|0x20) != 'i')
+			break;
+		if ((rest[2]|0x20) != 't')
+			break;
+#else
 		if (rest[1] != 'i')
 			break;
 		if (rest[2] != 't')
 			break;
+#endif
 		rest += 2;
 	/* fallthrough */
 	case '.':
@@ -703,6 +712,16 @@ inside:
 			}
 			return 0;
 		}
+#if defined(_WIN32) || defined(__CYGWIN__)
+		/*
+		 * There is a bunch of other characters that are not allowed
+		 * in Win32 API, but the following two create a security hole
+		 * by allowing to overwrite files outside of the working tree,
+		 * therefore they are explicitly prohibited.
+		 */
+		else if (c == ':' || c == '\\')
+			return 0;
+#endif
 		c = *path++;
 	}
 }
-- 
1.6.0
