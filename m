From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] daemon.c: fix segfault on OS X
Date: Sun, 26 Apr 2009 22:01:35 +0200
Message-ID: <49F4BD9F.6070709@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyAZH-0005WK-G3
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 22:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbZDZUBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbZDZUBk
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 16:01:40 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:51480 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZDZUBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 16:01:40 -0400
Received: by bwz7 with SMTP id 7so1941857bwz.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=9zb8ACaeA1IzJcTeE4r2qkXL7pDNe8rgdJZa28h+thY=;
        b=xB9XxlGHmSgLhVWei4qfnWxhh3jWz14kJuTb4HIU9FvJGNRhaURy9mR5KU+cRD1uUf
         FKyRqS02+uy5Ec+ryOV8+7XUmXB8Jib6sARNNAL3pyJvXPU03y23CE626ym9Ik5Xs22n
         JaxRe1ApBm3SU9+GqPrkPIC/ewFWt/0inF97E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=v60svH35AG6THEiBGtz/jx6FxU9knKjApKVLDCaSPAOImugjPd75xbIKmYLjqoghRB
         ESXCGgOmWliib1KakothUdychOIjkS8xa/AWEh/hEsJVvl/j+Uy1VPqVbJwC+KlZ4fAq
         NcJlOmNjfF3rgfiiHvPdlX84KnHB+03Vm3Ztk=
Received: by 10.103.244.10 with SMTP id w10mr2708843mur.71.1240776098442;
        Sun, 26 Apr 2009 13:01:38 -0700 (PDT)
Received: from golden.local (p5B01B827.dip.t-dialin.net [91.1.184.39])
        by mx.google.com with ESMTPS id 7sm3348927mup.39.2009.04.26.13.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 13:01:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117619>

On OS X (and maybe other unices) getaddrinfo(3) returns NULL
in the ai_canonname field if it is called with an IP address.

steps to reproduce:
$ git daemon --export-all
$ git clone git://127.0.0.1/frotz
=> git daemon's fork (silently) segfaults.

Remove the pointless loop while at it.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 daemon.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/daemon.c b/daemon.c
index 13401f1..5f455ab 100644
--- a/daemon.c
+++ b/daemon.c
@@ -444,27 +444,27 @@ static void parse_extra_args(char *extra_args, int buflen)
 	if (hostname) {
 #ifndef NO_IPV6
 		struct addrinfo hints;
-		struct addrinfo *ai, *ai0;
+		struct addrinfo *ai;
 		int gai;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		gai = getaddrinfo(hostname, 0, &hints, &ai0);
+		gai = getaddrinfo(hostname, 0, &hints, &ai);
 		if (!gai) {
-			for (ai = ai0; ai; ai = ai->ai_next) {
-				struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
+			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
 
-				inet_ntop(AF_INET, &sin_addr->sin_addr,
-					  addrbuf, sizeof(addrbuf));
+			inet_ntop(AF_INET, &sin_addr->sin_addr,
+				  addrbuf, sizeof(addrbuf));
+			free(ip_address);
+			ip_address = xstrdup(addrbuf);
+
+			if (ai->ai_canonname) {
 				free(canon_hostname);
 				canon_hostname = xstrdup(ai->ai_canonname);
-				free(ip_address);
-				ip_address = xstrdup(addrbuf);
-				break;
 			}
-			freeaddrinfo(ai0);
+			freeaddrinfo(ai);
 		}
 #else
 		struct hostent *hent;
-- 
1.6.3.rc2.9.g76386
