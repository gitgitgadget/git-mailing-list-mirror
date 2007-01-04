From: Junio C Hamano <junkio@cox.net>
Subject: Re: git completely non-operational w/ curl 7.16.0
Date: Wed, 03 Jan 2007 22:45:54 -0800
Message-ID: <7vvejnmgrh.fsf@assigned-by-dhcp.cox.net>
References: <20070104023150.GA31151@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 07:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2MMY-0006Em-GB
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 07:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXADGp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbXADGp5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 01:45:57 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63680 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbXADGp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 01:45:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104064555.NBAD97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 01:45:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6umA1W0071kojtg0000000; Thu, 04 Jan 2007 01:46:10 -0500
To: felix-git@fefe.de
In-Reply-To: <20070104023150.GA31151@codeblau.de> (felix-git@fefe.de's message
	of "Thu, 4 Jan 2007 03:31:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35918>

felix-git@fefe.de writes:

> I'm using git 1.4.4.3 on x86_64-linux with curl 7.16.0, glibc 2.5, gcc
> 4.1.1 and binutils 2.17.  All of these are as far as I know the current
> release versions.

This may be related to a bug in cURL 7.16.0, which is reported
to be fixed in their current CVS version:

	http://curl.haxx.se/mail/archive-2006-12/0085.html

In the meantime, we have a workaround for this particular
problem the above URL mentions since last week.

Please try "master" (or anything later than v1.5.0-rc0) to see
if it still breaks for you.

The fix also should apply cleanly on top of 1.4.4.3.

-- >8 --
[PATCH] Work around http-fetch built with cURL 7.16.0

It appears that curl_easy_duphandle() from libcurl 7.16.0
returns a curl session handle which fails GOOD_MULTI_HANDLE()
check in curl_multi_add_handle().  This causes fetch_ref() to
fail because start_active_slot() cannot start the request.

For now, check for 7.16.0 to work this issue around.

Signed-off-by: Junio C Hamano <junkio@cox.net>

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
 
