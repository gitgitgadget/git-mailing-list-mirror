From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] connect: replace inet_ntop with getnameinfo
Date: Fri, 24 Apr 2009 14:16:41 +0200
Message-ID: <49F1ADA9.5030301@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 14:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxKMX-00021R-1y
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 14:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZDXMQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbZDXMQr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 08:16:47 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58554 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbZDXMQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 08:16:46 -0400
Received: by fxm2 with SMTP id 2so1065462fxm.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=6wNvvSWbTRzHeV8vJ5K4gJZL7+a2H+bXsAEEaUqOChk=;
        b=dT7c8SQH92kSDmeH0BDde/rhB3OOcq26l4UUyAyqFQM1qw0vAEhjy+a51G5CAOKQKE
         YRvxGdR0V5zhARZ9QkpJIht9jTiEMPpgsc8CqnhW+uq4Z9wehcWpJC0I5DDK2c1WL3ls
         bsIIbku/tGasK2TrRVDpHeTBpEmXhCLiODits=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=wx3XD4NiOtm4TeRNq8or1pU6hdd5RTNt3tVjVTVjzyJEIbAtAE84fF2nCvB3aHJ7aY
         EV+YrnnvtQfC+R1lQEWdniqK00ortLCTvFyqsqMSoj1PRUV4CQ8TKXQ5/YXvVrl+SOtd
         eCb1kjyke95OHjTR1E+NK1xf7Hj5W5DDGkGv0=
Received: by 10.103.174.16 with SMTP id b16mr1215194mup.28.1240575404588;
        Fri, 24 Apr 2009 05:16:44 -0700 (PDT)
Received: from golden.local (p5B01D793.dip.t-dialin.net [91.1.215.147])
        by mx.google.com with ESMTPS id g1sm2737892muf.26.2009.04.24.05.16.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 05:16:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117430>

inet_ntop is not protocol independent.
getnameinfo(3) is part of POSIX and is available when getaddrinfo(3) is.
This code is only compiled when NO_IPV6 isn't defined.

The old method was buggy anyway, not every ipv6 address was converted
properly because the buffer (addr) was too small.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 connect.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/connect.c b/connect.c
index 7636bf9..f6b8ba6 100644
--- a/connect.c
+++ b/connect.c
@@ -177,18 +177,11 @@ static enum protocol get_protocol(const char *name)
 
 static const char *ai_name(const struct addrinfo *ai)
 {
-	static char addr[INET_ADDRSTRLEN];
-	if ( AF_INET == ai->ai_family ) {
-		struct sockaddr_in *in;
-		in = (struct sockaddr_in *)ai->ai_addr;
-		inet_ntop(ai->ai_family, &in->sin_addr, addr, sizeof(addr));
-	} else if ( AF_INET6 == ai->ai_family ) {
-		struct sockaddr_in6 *in;
-		in = (struct sockaddr_in6 *)ai->ai_addr;
-		inet_ntop(ai->ai_family, &in->sin6_addr, addr, sizeof(addr));
-	} else {
+	static char addr[NI_MAXHOST];
+	if (getnameinfo(ai->ai_addr, ai->ai_addrlen, addr, sizeof(addr), NULL, 0,
+			NI_NUMERICHOST) != 0)
 		strcpy(addr, "(unknown)");
-	}
+
 	return addr;
 }
 
-- 
1.6.3.rc1.53.gadc1
