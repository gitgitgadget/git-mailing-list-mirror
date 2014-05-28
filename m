From: "Naumov, Michael (North Sydney)" <Michael.Naumov@Fiserv.com>
Subject: [PATCH] sideband.c: Get rid of ANSI sequences for non-terminal shell
Date: Wed, 28 May 2014 03:12:15 +0000
Message-ID: <81E85F13A4BE084BAF4B1AA24173EDA012924D8B@JWPKEXMBX03.corp.checkfree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "peff@peff.net" <peff@peff.net>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"j6t@kdbg.org" <j6t@kdbg.org>, "nico@cam.org" <nico@cam.org>,
	"junkio@cox.net" <junkio@cox.net>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	"mnaoumov@gmail.com" <mnaoumov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 28 05:13:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpUIu-0007wt-Hf
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 05:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbaE1DNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 23:13:18 -0400
Received: from mail1.checkfree.com ([204.95.150.32]:50732 "EHLO
	mail1.checkfree.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbaE1DNS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 23:13:18 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2014 23:13:18 EDT
X-IronPort-AV: E=Sophos;i="4.98,924,1392181200"; 
   d="scan'208";a="24750406"
Received: from iwpdlpem04.corp.checkfree.com (HELO iwpexht01.corp.checkfree.com) ([10.132.91.28])
  by iapiron02.corp.checkfree.com with ESMTP; 27 May 2014 23:12:16 -0400
Received: from JWPKEXHT01.corp.checkfree.com (10.141.82.33) by
 iwpexht01.corp.checkfree.com (10.132.91.140) with Microsoft SMTP Server (TLS)
 id 8.3.279.5; Tue, 27 May 2014 23:12:16 -0400
Received: from JWPKEXMBX03.corp.checkfree.com ([169.254.5.251]) by
 JWPKEXHT01.corp.checkfree.com ([10.141.82.33]) with mapi id 14.02.0342.003;
 Tue, 27 May 2014 23:12:15 -0400
Thread-Topic: [PATCH] sideband.c: Get rid of ANSI sequences for non-terminal
 shell
Thread-Index: Ac96Im92MGNFpZ4kRCKYl87yS9me0A==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.121.1]
X-CFilter-Loop: True
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250258>

Some git tools such as GitExtensions for Windows use environment variable TERM=msys which causes the weird ANSI sequence shown for the messages returned from server-side hooks
We add those ANSI sequences to help format sideband data on the user's terminal. However, GitExtensions is not using a terminal, and the ANSI sequences just confuses it. We can recognize this use by checking isatty().
See https://github.com/gitextensions/gitextensions/issues/1313 for more details

NOTE: I considered to cover the case that a pager has already been started. But decided that is probably not worth worrying about here, though, as we shouldn't be using a pager for commands that do network communications (and if we do, omitting the magic line-clearing signal is probably a sane thing to do).

Signed-off-by: Michael Naumov <mnaoumov@gmail.com>
Thanks-to: Erik Faye-Lund <kusmabite@gmail.com>
Thanks-to: Jeff King <peff@peff.net>
---
 sideband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index d1125f5..7f9dc22 100644
--- a/sideband.c
+++ b/sideband.c
@@ -30,7 +30,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
-	if (term && strcmp(term, "dumb"))
+	if (isatty(2) && term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
 	else
 		suffix = DUMB_SUFFIX;
-- 
1.8.3.msysgit.0

P.S. I gave up trying to send this letter from gmail, it eats my tab character
P.S 2. Sorry, my tab character has been eaten again!

Regards,
Michael
