From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 12:45:53 +0200
Message-ID: <4A8A8661.5060908@gmail.com>
References: <4A8A552D.6020407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 12:46:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdMCx-0000qE-9K
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 12:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056AbZHRKqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 06:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbZHRKqE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 06:46:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39573 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZHRKqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 06:46:02 -0400
Received: by fg-out-1718.google.com with SMTP id e21so833780fga.17
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Y9IPGKC+nqk88jNw/+qS+b2Nq6osh402oN8I+TNZlVI=;
        b=CHmX4AEZ5efRRGKxuNAbAGuNzzOIDZV43kbKv6xW5XxY8sfj/47VWFMW19eRGq7A2o
         xf88rTtOqSjiXyzqmoeCI2dVe6EjUpJPoZTY/Hx0FW+vrq6piGQ2VvtCx6EzYa4Mya12
         C5vLj11UNAXkOzc9OPr52BnevEyuYXm9S41cE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sVtcB34CoJBwO7lrDVuhs1NwHZ09OEw28vLNiaJuR0yd9xBiElWLaHH6IvcAJThXpg
         QUuFixDJmLFUKq6LIlGaEQtdaONygbdz4JWtju979lQrq+luQRve6FQWzkVyhVZHnq8o
         gfpC5qXuYWJ8d3h2dIGezHoKn4V9GteKL/Qmc=
Received: by 10.86.228.16 with SMTP id a16mr3155928fgh.49.1250592362927;
        Tue, 18 Aug 2009 03:46:02 -0700 (PDT)
Received: from ?192.168.1.19? (91-67-62-226-dynip.superkabel.de [91.67.62.226])
        by mx.google.com with ESMTPS id l19sm10521190fgb.2.2009.08.18.03.46.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 03:46:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <4A8A552D.6020407@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126372>

> This is a minimal fix to compile block-sha1 on Windows. I did not do any
> benchmarks whether the implementation of ntohl() is actually faster than
> bytewise access and shifts.

As ntohl()/htonl() are function calls (that internally do shifts), I 
doubt they're faster than the shift macros, though I haven't measured 
it. However, I do not suggest to go for the macros on Windows/Intel, but 
to apply the following patch on top of your patch:

 From 34402f0e5691ca46cd63c930eef8fc9cadf80493 Mon Sep 17 00:00:00 2001
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Tue, 18 Aug 2009 12:33:35 +0200
Subject: [PATCH] block-sha1: On Intel, use bswap built-in in favor of 
ntohl()/htonl()

On Windows/Intel, ntohl()/htonl() are function calls that do shifts to 
swap the
byte order. Using the native bswap instruction boths gets rid of the 
shifts and
the function call overhead to gain some performance.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
  block-sha1/sha1.c |   15 ++++++++++-----
  1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index f2830c0..07f2937 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -66,15 +66,20 @@

  /*
   * Performance might be improved if the CPU architecture is OK with
- * unaligned 32-bit loads and a fast ntohl() is available.
+ * unaligned 32-bit loads and a fast ntohl() is available. On Intel,
+ * use the bswap built-in to get rid of the function call overhead.
   * Otherwise fall back to byte loads and shifts which is portable,
   * and is faster on architectures with memory alignment issues.
   */

-#if defined(__i386__) || defined(__x86_64__) || \
-    defined(__ppc__) || defined(__ppc64__) || \
-    defined(__powerpc__) || defined(__powerpc64__) || \
-    defined(__s390__) || defined(__s390x__)
+#if defined(__i386__) || defined(__x86_64__)
+
+#define get_be32(p)	__builtin_bswap32(*(unsigned int *)(p))
+#define put_be32(p, v)	do { *(unsigned int *)(p) = 
__builtin_bswap32(v); } while (0)
+
+#elif defined(__ppc__) || defined(__ppc64__) || \
+      defined(__powerpc__) || defined(__powerpc64__) || \
+      defined(__s390__) || defined(__s390x__)

  #define get_be32(p)	ntohl(*(unsigned int *)(p))
  #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
-- 
1.6.4.169.g64d5.dirty
