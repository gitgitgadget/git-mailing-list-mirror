From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] support older versions of libcurl
Date: Thu, 28 Jul 2005 19:24:13 -0700
Message-ID: <7vll3qqrhu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507281648390.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 04:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKY2-0008QB-58
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVG2CYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVG2CYS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:24:18 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1750 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262184AbVG2CYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:24:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022410.EGJD1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:24:10 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Some newer features of libcurl are used which are not strictly necessary
> for http-pull. Use them only if libcurl is new enough to know about them.

Do you need to check against that many versions?  Especially
cleanup and init not depending on the same version number looks
really suspicious.

Assuming that the answer is still yes, how about doing things
this way instead?

---

diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -6,6 +6,16 @@
 #include <curl/curl.h>
 #include <curl/easy.h>
 
+#if LIBCURL_VERSION_NUM < 0x070704
+#define curl_global_cleanup() do { /* nothing */ } while(0)
+#endif
+#if LIBCURL_VERSION_NUM < 0x070800
+#define curl_global_init(a) do { /* nothing */ } while(0)
+#endif
+#if LIBCURL_VERSION_NUM < 0x070907
+#define curl_easy_setopt(a, b, c) do { /* nothing */ } while(0)
+#endif
+
 static CURL *curl;
 
 static char *base;
