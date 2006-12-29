From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFT] Work around http-fetch built with cURL 7.16.0
Date: Thu, 28 Dec 2006 16:40:13 -0800
Message-ID: <7vfyazttzm.fsf_-_@assigned-by-dhcp.cox.net>
References: <skimo@kotnet.org>
	<200612271457.kBREvkj2011916@laptop13.inf.utfsm.cl>
	<7vlkkt5d49.fsf@assigned-by-dhcp.cox.net>
	<7v8xgt57wu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 29 01:40:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H05nI-0006ca-H6
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 01:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWL2AkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 19:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWL2AkQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 19:40:16 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54580 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965040AbWL2AkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 19:40:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229004014.NUAU20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 19:40:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4QgU1W0041kojtg0000000; Thu, 28 Dec 2006 19:40:28 -0500
To: git@vger.kernel.org
In-Reply-To: <7v8xgt57wu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 27 Dec 2006 13:46:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35570>

It appears that curl_easy_duphandle() from libcurl 7.16.0
returns a curl session handle which fails GOOD_MULTI_HANDLE()
check in curl_multi_add_handle().  This causes fetch_ref() to
fail because start_active_slot() cannot start the request.

For now, check for 7.16.0 to work this issue around.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I think people who were having trouble with cURL 7.16.0 want
   to have the issue resolved before v1.5.0-rc1.  Please test
   and report, or else ;-).

 http.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http.h b/http.h
index 6e12e41..324fcf4 100644
--- a/http.h
+++ b/http.h
@@ -18,7 +18,7 @@
 #define curl_global_init(a) do { /* nothing */ } while(0)
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070c04
+#if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
-- 
1.5.0.rc0.gf5c587
