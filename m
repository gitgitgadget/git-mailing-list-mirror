From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 07:44:28 +0200
Message-ID: <4A7A6DBC.9010107@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <4A7A5723.6070704@gmail.com> <alpine.LFD.2.01.0908052120330.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYvmS-00028y-2u
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 07:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZHFFoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 01:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZHFFoc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 01:44:32 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35304 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbZHFFob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 01:44:31 -0400
Received: by ewy10 with SMTP id 10so528677ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=GNZ94hRf604iUQQtcgmixzinytcbYKfbMwy7O0IyjOE=;
        b=bEiWYuCdnamdYuAqIyaGw/Iyn2sjURSRaSQvi8FgSZjSX3XkDZ0z2iZXwf1IsCNJFV
         EAdI7fEpNptE9D5VWcZJHlUupoDUWKWxR4LczxUlLdKXeB6eXqtF8Y8bn6Rb+SK1+xRx
         FinnwzYQdE1VqVUWhIAb7Q2f8bY2VYrwMssdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=XDHEEo+9n4Vgc97cEO1IpRCN/WHNICP41C4rSb7SKuh7Yqz7t66OgqNNNkJ+8wRXkM
         7+J2T7NPtwGfM22rdeCe2X8J7yz5HWy6wjX9TtbXcUvjZwtnFAhv2nXMP7wHiEJeXC+c
         qfLKLbjzlvk6gl1jbJm6N5NCta3Stblvag6Eo=
Received: by 10.210.41.1 with SMTP id o1mr11225325ebo.10.1249537470908;
        Wed, 05 Aug 2009 22:44:30 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-83-15.multimo.pl [89.174.83.15])
        by mx.google.com with ESMTPS id 28sm3411392eye.44.2009.08.05.22.44.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 22:44:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908052120330.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125043>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
>>> The way it's written, I can easily make it do one or the other by just 
>>> turning the macro inside a loop (and we can have a preprocessor flag to 
>>> choose one or the other), but let me work on it a bit more first.
>> that's of course how i measured it.. :)
> 
> Well, with my "rolling 512-bit array" I can't do that easily any more.
> 
> Now it actually depends on the compiler being able to statically do that 
> circular list calculation. If I were to turn it back into the chunks of 
> loops, my new code would suck, because it would have all those nasty 
> dynamic address calculations.

i did try (obvious patch below) and in fact the loops still win on p4:

#Initializing... Rounds: 1000000, size: 62500K, time: 1.428s, speed: 42.76MB/s
#             TIME[s] SPEED[MB/s]
rfc3174         1.437       42.47
rfc3174         1.438       42.45
linus          0.5791       105.4
linusas        0.5052       120.8
mozilla         1.525       40.01
mozillaas       1.192       51.19

artur

--- block-sha1/sha1.c	2009-08-06 06:45:03.407322970 +0200
+++ block-sha1/sha1as.c	2009-08-06 07:36:41.332318683 +0200
@@ -107,13 +107,17 @@
 
 #define T_0_15(t) \
 	TEMP = htonl(data[t]); array[t] = TEMP; \
-	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E + 0x5a827999; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
+	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP + 0x5a827999; \
 
+#if UNROLL
 	T_0_15( 0); T_0_15( 1); T_0_15( 2); T_0_15( 3); T_0_15( 4);
 	T_0_15( 5); T_0_15( 6); T_0_15( 7); T_0_15( 8); T_0_15( 9);
 	T_0_15(10); T_0_15(11); T_0_15(12); T_0_15(13); T_0_15(14);
 	T_0_15(15);
+#else
+	for (int t = 0; t <= 15; t++) { T_0_15(t); }
+#endif
 
 /* This "rolls" over the 512-bit array */
 #define W(x) (array[(x)&15])
@@ -125,37 +129,53 @@
 	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E + 0x5a827999; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
 
+#if UNROLL
 	T_16_19(16); T_16_19(17); T_16_19(18); T_16_19(19);
+#else
+	for (int t = 16; t <= 19; t++) { T_16_19(t); }
+#endif
 
 #define T_20_39(t) \
 	SHA_XOR(t); \
-	TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0x6ed9eba1; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
+	TEMP += SHA_ROL(A,5) + (B^C^D) + E; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP + 0x6ed9eba1;
 
+#if UNROLL
 	T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
 	T_20_39(25); T_20_39(26); T_20_39(27); T_20_39(28); T_20_39(29);
 	T_20_39(30); T_20_39(31); T_20_39(32); T_20_39(33); T_20_39(34);
 	T_20_39(35); T_20_39(36); T_20_39(37); T_20_39(38); T_20_39(39);
+#else
+	for (int t = 20; t <= 39; t++) { T_20_39(t); }
+#endif
 
 #define T_40_59(t) \
 	SHA_XOR(t); \
-	TEMP += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E + 0x8f1bbcdc; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
+	TEMP += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP + 0x8f1bbcdc;
 
+#if UNROLL
 	T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
 	T_40_59(45); T_40_59(46); T_40_59(47); T_40_59(48); T_40_59(49);
 	T_40_59(50); T_40_59(51); T_40_59(52); T_40_59(53); T_40_59(54);
 	T_40_59(55); T_40_59(56); T_40_59(57); T_40_59(58); T_40_59(59);
+#else
+	for (int t = 40; t <= 59; t++) { T_40_59(t); }
+#endif
 
 #define T_60_79(t) \
 	SHA_XOR(t); \
 	TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0xca62c1d6; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
+#if UNROLL
 	T_60_79(60); T_60_79(61); T_60_79(62); T_60_79(63); T_60_79(64);
 	T_60_79(65); T_60_79(66); T_60_79(67); T_60_79(68); T_60_79(69);
 	T_60_79(70); T_60_79(71); T_60_79(72); T_60_79(73); T_60_79(74);
 	T_60_79(75); T_60_79(76); T_60_79(77); T_60_79(78); T_60_79(79);
+#else
+	for (int t = 60; t <= 79; t++) { T_60_79(t); }
+#endif
 
 	ctx->H[0] += A;
 	ctx->H[1] += B;
