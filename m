From: "Theo Niessink" <niessink@martinic.com>
Subject: RE: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Wed, 8 Jun 2011 11:55:08 +0200
Organization: Martinic
Message-ID: <DAFDEB13CE4944C18AAF3F20994AEF2E@martinic.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>,
	<johannes.schindelin@gmx.de>
To: "'Junio C Hamano'" <gitster@pobox.com>, <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUFZE-0004iJ-I9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab1FHKAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 06:00:47 -0400
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:3220 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289Ab1FHKAq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 06:00:46 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jun 2011 06:00:46 EDT
Received: from cpbrm-ews16.kpnxchange.com ([10.94.84.147]) by cpsmtpb-ews07.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 8 Jun 2011 11:55:10 +0200
Received: from CPSMTPM-CMT106.kpnxchange.com ([195.121.3.22]) by cpbrm-ews16.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 8 Jun 2011 11:55:09 +0200
Received: from ntserver.martinic.local ([77.168.115.212]) by CPSMTPM-CMT106.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Wed, 8 Jun 2011 11:55:09 +0200
Received: from pc0003 ([192.168.87.16])
	by ntserver.martinic.local
	; Wed, 8 Jun 2011 11:55:08 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
thread-index: AcwlwiZlgU4i/QzgRReT9Gpx++uICA==
X-OriginalArrivalTime: 08 Jun 2011 09:55:09.0569 (UTC) FILETIME=[27090F10:01CC25C2]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175347>

Junio C Hamano wrote:
> Here is what I queued last night. If it looks Ok then I'll merge it down
> to 'next'.

I have run a couple of quick tests, and everything seems OK, except the
following backslashed paths, which are verified OK while they should be
rejected:

foo\.\bar
foo\..\bar

This is caused by verify_dotfile(), which doesn't use is_dir_sep(). So I
propose this patch on verify_dotfile():

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
