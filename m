From: =?iso-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>
Subject: Re: [PATCH 07/19] compat: add endianness helpers
Date: Wed, 30 Oct 2013 18:06:52 +0100
Message-ID: <A98A12FA-A198-46ED-9470-E0E8284EBE15@gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180157.GG24180@sigill.intra.peff.net> <87txg4sbyf.fsf@linux-k42r.v.cablecom.net> <20131030082516.GN11317@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:07:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZEb-0003Ba-0e
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab3J3RHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:07:02 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:54009 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab3J3RHA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 13:07:00 -0400
Received: by mail-ee0-f49.google.com with SMTP id e52so796817eek.22
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z6iVL7gdoYNCiRIsTKkctNd+Q7qsSo3og4SG/y8iM/4=;
        b=j1Hh/NgT9HGQBj51Xhpjey9geBMioJWoRRu4igZxo8z5pRYayu/9f7uV9YB/S4OwAM
         z2FUi+hU4JHoKlE3VACM+H/FOarBEaNp+bE+ZxpWEdJ3or8IbYOtfMWY17Hn1AMZb/8M
         Rg5gFkWPyetnARS9AlYJj5fPCcMUVGh6S+GXYowaVOi4te2prBMQfE7JB4hfQtZH/kIu
         lpF2gDn66jRyabisfNc32xHmYWjHlhl0y9QBaNcHTsPjlkuWQsV5f+CzvDv2cmMvkuwN
         SBsrjFX5JlVWvWiuyWJiP9g/aLALwH0WKmMtexujWOJP8xbtYO+fIzHQ0q1kL+XEgHA9
         WBAg==
X-Received: by 10.14.174.7 with SMTP id w7mr863773eel.112.1383152819528;
        Wed, 30 Oct 2013 10:06:59 -0700 (PDT)
Received: from [172.16.46.19] ([178.19.210.162])
        by mx.google.com with ESMTPSA id h45sm85701535eeg.5.2013.10.30.10.06.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Oct 2013 10:06:57 -0700 (PDT)
In-Reply-To: <20131030082516.GN11317@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1816)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237036>

On Oct 30, 2013, at 9:25 AM, Jeff King <peff@peff.net> wrote:

> On Sat, Oct 26, 2013 at 09:55:36AM +0200, Thomas Rast wrote:
> 
>>> The POSIX standard doesn't currently define a `nothll`/`htonll`
>> 
>> typo: ntohll
> 
> Thanks.
> 
>>> function pair to perform network-to-host and host-to-network
>>> swaps of 64-bit data. These 64-bit swaps are necessary for the on-disk
>>> storage of EWAH bitmaps if they are not in native byte order.
>> [...]
>>> +#		include <byteswap.h>
>> 
>> Do we need a hack on top similar to what ntoh_l and hton_l do, for
>> platforms that do not support unaligned access?
> 
> Ugh, probably. I didn't even know about those. But we do use them when
> reading the ewah bitmaps, which I believe can be at random offsets. We
> should be able to use the same ntoh_l solution.
> 
> -Peff

You are right, when reading mmaps we cannot ensure the alignment of the 8 byte sections. For writing the bitmaps to memory, however, we can make that assumption because the writes will happen to either malloc'ed segments, or the stack.

A proposed fix follows:

>From 0eed934805543390195f8aee231f8a1da33dad0b Mon Sep 17 00:00:00 2001
From: Vicent Marti <tanoku@gmail.com>
Date: Wed, 30 Oct 2013 15:27:20 +0100
Subject: [PATCH] ewah: support non-aligned reads

When reading straight from a mmaped file, some platforms do not support
atomically loading 8 bytes from random positions on memory to perform a
byte swap. To work around this, we `memcpy` the whole area that needs
to be byteswapped to its final destination, and then perform the
byteswap on each 8-byte chunk: the destionation chunks *will* be aligned
because the destination area is a malloc'ed chunk of memory.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
---
 ewah/ewah_io.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index fca93f9..41f6d3d 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -76,6 +76,10 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 	buffer = self->buffer;
 	words_left = self->buffer_size;
 
+	/* buffer is a malloc'ed buffer, which we can assume to
+	 * be at the very least 8-byte aligned */
+	assert((intptr_t)buffer % 8 == 0);
+
 	while (words_left >= words_per_dump) {
 		for (i = 0; i < words_per_dump; ++i, ++buffer)
 			dump[i] = htonll(*buffer);
@@ -117,7 +121,6 @@ int ewah_serialize(struct ewah_bitmap *self, int fd)
 int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 {
 	uint32_t *read32 = map;
-	eword_t *read64;
 	size_t i;
 
 	self->bit_size = ntohl(*read32++);
@@ -128,10 +131,19 @@ int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 	if (!self->buffer)
 		return -1;
 
-	for (i = 0, read64 = (void *)read32; i < self->buffer_size; ++i)
-		self->buffer[i] = ntohll(*read64++);
+#ifdef NEEDS_ALIGNED_ACCESS
+	memcpy(self->buffer, read32, self->buffer_size * sizeof(eword_t));
+	for (i = 0; i < self->buffer_size; ++i)
+		self->buffer[i] = ntohll(self->buffer[i]);
+#else
+	{
+		eword_t *read64 = (void *)read32;
+		for (i = 0; i < self->buffer_size; ++i)
+			self->buffer[i] = ntohll(read64[i]);
+	}
+#endif
 
-	read32 = (void *)read64;
+	read32 += self->buffer_size * sizeof(eword_t) / sizeof(uint32_t);
 	self->rlw = self->buffer + ntohl(*read32++);
 
 	return (3 * 4) + (self->buffer_size * 8);
@@ -175,7 +187,7 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 			return -1;
 
 		for (i = 0; i < words_per_dump; ++i, ++buffer)
-			*buffer = ntohll(dump[i]);
+			*buffer = ntohll(dump[i]); /* aligned on stack */
 
 		words_left -= words_per_dump;
 	}
@@ -185,7 +197,7 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 			return -1;
 
 		for (i = 0; i < words_left; ++i, ++buffer)
-			*buffer = ntohll(dump[i]);
+			*buffer = ntohll(dump[i]); /* aligned on stack */
 	}
 
 	/** 32 bit -- position for the RLW */
-- 
1.8.3.2
