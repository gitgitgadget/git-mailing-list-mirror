From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] compat: make gcc bswap an inline function
Date: Wed, 16 Mar 2011 02:00:49 -0500
Message-ID: <20110316070049.GC5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkj5-0005eA-Qy
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab1CPHAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:00:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39215 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab1CPHAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:00:54 -0400
Received: by gxk21 with SMTP id 21so539835gxk.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zKjGqRPcIMcMuDuBUDSaB7V+TsEYyOqCAA1bSyxeMiY=;
        b=SZ1KYlx2BHT9hQL+JSYp+juoP4vfA8beOY1gtoTMLQu8x1JNMrPly6vg4fl6L+Pion
         xZtTuLOSvt9JxwoH1T/vqJpa3Li2hshoPFx9QFxZho6Os1+2pLkZvGirgRckKTnLSRo3
         q/CptZIvG7QJuh8b6cN/Np5iQHBkbDx3Xo3Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SNwcCAimA1csKYXHoD/7c1bEKoQuEO/hR7NLMqkZTSxJ9wgfiLew3aEt9Sy1qMDW3g
         EoEX6pL9GBmlKdD1i3ceoTvdq5VdYYrcA/io/++yubRqNZC48eXNTT2HuwMpH3Qpc27M
         ALDElKS5QrxscChizubVpUuRs1/tJkgE0oFdA=
Received: by 10.150.58.4 with SMTP id g4mr968286yba.155.1300258853774;
        Wed, 16 Mar 2011 00:00:53 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id p23sm3369925ybk.9.2011.03.16.00.00.52
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:00:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169110>

Without this change, gcc -pedantic warns:

 cache.h: In function 'ce_to_dtype':
 cache.h:270:21: warning: ISO C forbids braced-groups within expressions [-pedantic]

An inline function is more readable anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 compat/bswap.h |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 54756db..5061214 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -21,14 +21,16 @@ static inline uint32_t default_swab32(uint32_t val)
 
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
-#define bswap32(x) ({ \
-	uint32_t __res; \
-	if (__builtin_constant_p(x)) { \
-		__res = default_swab32(x); \
-	} else { \
-		__asm__("bswap %0" : "=r" (__res) : "0" ((uint32_t)(x))); \
-	} \
-	__res; })
+#define bswap32 git_bswap32
+static inline uint32_t git_bswap32(uint32_t x)
+{
+	uint32_t result;
+	if (__builtin_constant_p(x))
+		result = default_swab32(x);
+	else
+		__asm__("bswap %0" : "=r" (result) : "0" (x));
+	return result;
+}
 
 #elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
 
-- 
1.7.4.1
