From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/3] daemon: handle gethostbyname() error
Date: Wed, 01 Oct 2014 12:16:17 +0200
Message-ID: <542BD471.3000308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:17:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZGyF-000679-4c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaJAKRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:17:15 -0400
Received: from mout.web.de ([212.227.15.4]:55970 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaJAKRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 06:17:14 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MLP9u-1XYj0J2I7O-000YNV; Wed, 01 Oct 2014 12:17:09
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:m6MUfLXR1rkjcvBSMqiWdgiA6QmKBZVfyMplt+z/P61C+tpU15x
 TlzkZIMLv5agY/xxPn8XtDi2Wyx76qkh1qRsPT5852CdvgcJNNpoS7Hzhge9GtmXN5WHMSs
 EtjSxDNlW8ylbVhUz1G5Ag1a1nIdXSJPMDqTB+l7lrBf2eE8E8cPQ2azduhgEiWPfEsjjWw
 FtCZRtD4GwDMcPjAoAFOA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257696>

If the user-supplied hostname can't be found then we should not use it.
We already avoid doing that in the non-NO_IPV6 case by checking if the
return value of getaddrinfo() is zero (success).  Do the same in the
NO_IPV6 case and make sure the return value of gethostbyname() isn't
NULL before dereferencing this pointer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Most lines are just re-indented, not actually changed.

 daemon.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4dcfff9..a6f467e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -553,20 +553,21 @@ static void parse_host_arg(char *extra_args, int buflen)
 		static char addrbuf[HOST_NAME_MAX + 1];
 
 		hent = gethostbyname(hostname);
+		if (hent) {
+			ap = hent->h_addr_list;
+			memset(&sa, 0, sizeof sa);
+			sa.sin_family = hent->h_addrtype;
+			sa.sin_port = htons(0);
+			memcpy(&sa.sin_addr, *ap, hent->h_length);
+
+			inet_ntop(hent->h_addrtype, &sa.sin_addr,
+				  addrbuf, sizeof(addrbuf));
 
-		ap = hent->h_addr_list;
-		memset(&sa, 0, sizeof sa);
-		sa.sin_family = hent->h_addrtype;
-		sa.sin_port = htons(0);
-		memcpy(&sa.sin_addr, *ap, hent->h_length);
-
-		inet_ntop(hent->h_addrtype, &sa.sin_addr,
-			  addrbuf, sizeof(addrbuf));
-
-		free(canon_hostname);
-		canon_hostname = xstrdup(hent->h_name);
-		free(ip_address);
-		ip_address = xstrdup(addrbuf);
+			free(canon_hostname);
+			canon_hostname = xstrdup(hent->h_name);
+			free(ip_address);
+			ip_address = xstrdup(addrbuf);
+		}
 #endif
 	}
 }
-- 
2.1.2
