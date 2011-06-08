From: "Theo Niessink" <theo@taletn.com>
Subject: RE: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Wed, 8 Jun 2011 14:04:41 +0200
Message-ID: <187961B7EDE84635BD7B3C9A4EF688C3@martinic.local>
References: <DAFDEB13CE4944C18AAF3F20994AEF2E@martinic.local> <BANLkTinTJh9oOTHi5js7n-sy8+pmMa_vtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>,
	<johannes.schindelin@gmx.de>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 14:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUHVB-0005Of-0M
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 14:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab1FHMEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 08:04:43 -0400
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:2737 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213Ab1FHMEn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 08:04:43 -0400
Received: from cpbrm-ews03.kpnxchange.com ([10.94.84.134]) by cpsmtpb-ews07.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 8 Jun 2011 14:04:41 +0200
Received: from CPSMTPM-CMT106.kpnxchange.com ([195.121.3.22]) by cpbrm-ews03.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 8 Jun 2011 14:04:42 +0200
Received: from pc0003 ([77.168.115.212]) by CPSMTPM-CMT106.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Wed, 8 Jun 2011 14:04:41 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
thread-index: AcwlyYjCD9K2H2mHQaiWelyzZq1fKwAClmOw
In-Reply-To: <BANLkTinTJh9oOTHi5js7n-sy8+pmMa_vtQ@mail.gmail.com>
X-OriginalArrivalTime: 08 Jun 2011 12:04:41.0189 (UTC) FILETIME=[3F482950:01CC25D4]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175361>

Erik Faye-Lund wrote:
> This looks obviously correct to me. Thanks for spotting the problem.
> 
> Would you mind writing up a commit-message and supply a sign-off?

Like this you mean?

-- >8 --
Subject: [PATCH] verify_dotfile(): do not assume '/' is the path seperator

verify_dotfile() currently assumes that the path seperator is '/', but on
Windows it can also be '\\', so use is_dir_sep() instead.
    
Signed-off-by: Theo Niessink <theo@taletn.com>
---
 read-cache.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 282c0c1..72be7cd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -726,11 +726,12 @@ static int verify_dotfile(const char *rest)
 	 * has already been discarded, we now test
 	 * the rest.
 	 */
-	switch (*rest) {
+
 	/* "." is not allowed */
-	case '\0': case '/':
+	if (*rest == '\0' || is_dir_sep(*rest))
 		return 0;
 
+	switch (*rest) {
 	/*
 	 * ".git" followed by  NUL or slash is bad. This
 	 * shares the path end test with the ".." case.
@@ -743,7 +744,7 @@ static int verify_dotfile(const char *rest)
 		rest += 2;
 	/* fallthrough */
 	case '.':
-		if (rest[1] == '\0' || rest[1] == '/')
+		if (rest[1] == '\0' || is_dir_sep(rest[1]))
 			return 0;
 	}
 	return 1;
-- 
1.7.5.3776.g5dcaf.dirty
