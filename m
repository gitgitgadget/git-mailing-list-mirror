From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH RESEND] Explicitly truncate bswap operand to uint32_t
Date: Wed, 18 Nov 2009 14:53:27 +0100
Message-ID: <4B03FC57.5000506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:53:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkyi-00086v-B2
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbZKRNx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757082AbZKRNx2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:53:28 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:65154 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbZKRNx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:53:28 -0500
Received: by bwz27 with SMTP id 27so1138406bwz.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=lvTOnkz10OOwP+rr843hgb2r2st8REMeX2O0E4sdoUM=;
        b=XlWnZ1hWZKrczxJQN4pepU96Xt2+UN+kVhqUI+rEAIAxU3EfvXWWw8URIasOsQKHLr
         PWBlM0lIe+d3QJdmfqaee/nQAWH8IR7ZPsbZFxFZmVH9hBM6cUdFYFbxaR+9iMsJYL1o
         om6teaFKQ64nFHRYq9/2ykKgK4vQsZUic55as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=qFoHsWOfjz3MeFjLRRhczK0OKeGmy2tg8Hi7FU2o1Im4/kqkKaUdH8RjSZaFRTPJJw
         rgUZoK9tpdCMmSnUezMmP7FykjVzWfG8SFxXdkMfyFBi1d4TnjtScq3I/k1F7awpnzIz
         T4wA5e4Hgh67Vt5XHJg4WUE1oSaYgdfRi53Ds=
Received: by 10.204.162.137 with SMTP id v9mr1237821bkx.60.1258552413118;
        Wed, 18 Nov 2009 05:53:33 -0800 (PST)
Received: from kallisti.local (p5B01EDE4.dip.t-dialin.net [91.1.237.228])
        by mx.google.com with ESMTPS id 28sm183626fkx.59.2009.11.18.05.53.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 05:53:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133174>

There are some places in git where a long is passed to htonl/ntohl. llvm
doesn't support matching operands of different bitwidths intentionally.
This patch fixes the build with llvm-gcc (and clang) on x86_64.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
Any comments on this patch?

See also:
* http://llvm.org/bugs/show_bug.cgi?id=3373
* http://lkml.org/lkml/2009/1/23/261

 compat/bswap.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 279e0b4..f3b8c44 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -24,7 +24,7 @@ static inline uint32_t default_swab32(uint32_t val)
 	if (__builtin_constant_p(x)) { \
 		__res = default_swab32(x); \
 	} else { \
-		__asm__("bswap %0" : "=r" (__res) : "0" (x)); \
+		__asm__("bswap %0" : "=r" (__res) : "0" ((uint32_t)(x))); \
 	} \
 	__res; })
 
-- 
1.6.5.3.149.g9aa3
