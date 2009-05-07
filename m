From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 07 May 2009 14:22:32 +0200
Message-ID: <4A02D288.6040804@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 14:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22cg-0007GR-EJ
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbZEGMWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbZEGMWg
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:22:36 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40547 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZEGMWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:22:35 -0400
Received: by fxm2 with SMTP id 2so746385fxm.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=+3h1A2qTWRn62sz8gveK00i1zyBNU6oNrb8nkybk4Ns=;
        b=oocvYV6OUPnW5bpKjbehPOC0RL4hLS6AbGZY9stT6VmVtdeS0LDUWyN3rNouBrmtBD
         uCZ8QiYLMmbxYLuQqY8aljKVXRwKa9gz/y6u99eQHRmF3UEyM/fOMT4T54/d9ElLojR2
         YkyVSLc6kdTj2cJKhO0QY4dThFVwueXFxzQS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=e+qoFQrVsn8rOGODtZm83aFJq+7PcRy49k4HM/xHyHyVLwOs8VQ/rM7sVoXqJY0IuA
         UFKHawNpAEQS9CRO8Dtulq0RaVvvBPFfJ4eCi1BxeQ3nCwLK+sYw4j5gy2b5RUnkAQXA
         88Sp1ILO5FAEB3DaS43dcB+RT1mQPft4k/m5Q=
Received: by 10.103.193.13 with SMTP id v13mr1606223mup.1.1241698954891;
        Thu, 07 May 2009 05:22:34 -0700 (PDT)
Received: from golden.local (p5B01CB42.dip.t-dialin.net [91.1.203.66])
        by mx.google.com with ESMTPS id s10sm2839609mue.38.2009.05.07.05.22.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 05:22:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118469>

git daemon's interpolated paths didn't support IPv6.
Every IPv6 address was being converted to `0.0.0.0'.

Fix this by replacing inet_ntop(3) with the protocol
agnostic getnameinfo(3) API.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---

With this patch we'll have colons in the per-IP directories
for IPv6 addresses. Creating files with a : in the name fails
on some OSes (e.g. Windows).

Is this OK for git or do we need to special case IPv6 addresses?

 daemon.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index daa4c8e..339d7ab 100644
--- a/daemon.c
+++ b/daemon.c
@@ -446,17 +446,15 @@ static void parse_extra_args(char *extra_args, int buflen)
 		struct addrinfo hints;
 		struct addrinfo *ai;
 		int gai;
-		static char addrbuf[HOST_NAME_MAX + 1];
+		static char addrbuf[NI_MAXHOST];
 
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
 		gai = getaddrinfo(hostname, 0, &hints, &ai);
 		if (!gai) {
-			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
-
-			inet_ntop(AF_INET, &sin_addr->sin_addr,
-				  addrbuf, sizeof(addrbuf));
+			getnameinfo(ai->ai_addr, ai->ai_addrlen, addrbuf,
+				    sizeof(addrbuf), NULL, 0, NI_NUMERICHOST);
 			free(ip_address);
 			ip_address = xstrdup(addrbuf);
 
-- 
1.6.3.1.g882bf
