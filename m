From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] Explicitly truncate bswap operand to uint32_t
Date: Thu, 29 Oct 2009 18:43:54 +0100
Message-ID: <4AE9D45A.9010805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Z2a-0003h3-H8
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 18:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbZJ2Rny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756536AbZJ2Rny
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 13:43:54 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:56442 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbZJ2Rny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 13:43:54 -0400
Received: by bwz27 with SMTP id 27so2594134bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=RRtwBG0bKNWjswX3djhXEsPbrwo56zVCSnM/Zb6C0hE=;
        b=DiZ8FHTi1mXgyRDA5eXM+Dg4c4SUhyrPJ1jx8fyD/WRwz4MSPI4SjD9lf/9oXdBENP
         jZsZY6kIm1ytWmDLsd+zbMpFu85JorXFZKeyQgTh4P1DcwbNnUaCkt4lFr06OVmndSmp
         nUI84rdCQdL7DeZZdZfhXJH/xC3c3v87YN8EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=IEovGrr0ugsLAkPo6PA9DDGRa1ndjHKKTI+OcgXxgu+DEgScwoDYfOVdK4MtbwSdsQ
         K3C48ojROCgiQdoT+iXAXJfviFo9kpg6/lRUnEz0PZgltRv92zL1sUu1FiXbuOMHPtQe
         purOFuD4m+t1RFRhf69f73XOHgzdx93VYZszg=
Received: by 10.204.35.12 with SMTP id n12mr234406bkd.147.1256838237750;
        Thu, 29 Oct 2009 10:43:57 -0700 (PDT)
Received: from golden.local (p5B01E7B3.dip.t-dialin.net [91.1.231.179])
        by mx.google.com with ESMTPS id 22sm4601503fkr.47.2009.10.29.10.43.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 10:43:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131619>

There are some places in git where a long is passed to htonl/ntohl. llvm
doesn't support matching operands of different bitwidths intentionally.
This patch fixes the build with llvm-gcc (and clang) on x86_64.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
See also:
* http://llvm.org/bugs/show_bug.cgi?id=3373
* http://lkml.org/lkml/2009/1/23/261

 compat/bswap.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 5cc4acb..52fc7b6 100644
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
1.6.5.2.102.g442a9
