From: "Theo Niessink" <theo@taletn.com>
Subject: RE: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Mon, 30 May 2011 12:58:59 +0200
Message-ID: <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org> <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, <gitster@pobox.com>,
	<johannes.schindelin@gmx.de>
To: <kusmabite@gmail.com>, "'Johannes Sixt'" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 30 13:14:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR0QO-0005rU-04
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 13:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab1E3LOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 07:14:14 -0400
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:1166 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816Ab1E3LOO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 07:14:14 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2011 07:14:13 EDT
Received: from cpbrm-ews02.kpnxchange.com ([10.94.84.133]) by cpsmtpb-ews02.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 30 May 2011 12:59:00 +0200
Received: from CPSMTPM-CMT103.kpnxchange.com ([195.121.3.19]) by cpbrm-ews02.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 30 May 2011 12:59:00 +0200
Received: from pc0003 ([77.168.115.212]) by CPSMTPM-CMT103.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Mon, 30 May 2011 12:58:59 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcwerJ1Z+dPpRXpZQhKtVlmIhstsxgACkwaw
In-Reply-To: <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
X-OriginalArrivalTime: 30 May 2011 10:58:59.0758 (UTC) FILETIME=[9449C4E0:01CC1EB8]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174738>

Erik Faye-Lund wrote:
> But I think I might have been a bit too care-less; I didn't fix the
> switch-case to check for multiple backslashes on Windows. It's not
> immediately obvious if this is needed or not, but I don't think it can
> cause harm; we should never have created an index like that anyway.
> 
> So something like this on top, perhaps?

Nitpick: If you already know that c != '\0' and !is_dir_sep(c), then why do
continue? It will check for '\0' and is_dir_sep(c) again, but you already
know that both ifs will be false. So you could just as easy jump straight to
c = *path++, which IMHO also makes the code easier to follow:

diff --git a/read-cache.c b/read-cache.c
index 68faa51..089cd3e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -763,17 +763,15 @@ int verify_path(const char *path)
 		if (is_dir_sep(c)) {
 inside:
 			c = *path++;
-			switch (c) {
-			default:
-				continue;
-			case '/': case '\0':
-				break;
-			case '.':
+			if (c == '.') {
+				
 				if (verify_dotfile(path))
 					continue;
-			}
+			} else if (!is_dir_sep(c) && c != '\0')
+				goto next;
 			return 0;
 		}
+next:
 		c = *path++;
 	}
 }
