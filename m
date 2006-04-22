From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 07:04:38 -0400
Message-ID: <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-4--107045785
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:36:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOqX-0003Vx-34
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWDVUgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDVUgq
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:36:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46799 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751159AbWDVUgq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:36:46 -0400
Received: from nile.gnat.com (nile.gnat.com [205.232.38.5])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MB5CUr004973
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 11:05:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 1C86B48CEE6;
	Sat, 22 Apr 2006 07:04:40 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 02188-01-7; Sat, 22 Apr 2006 07:04:39 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id B40C348CEE4;
	Sat, 22 Apr 2006 07:04:39 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
To: Nicolas Pitre <nico@cam.org>
X-Mailer: Apple Mail (2.749.3)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19055>


--Apple-Mail-4--107045785
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Apr 21, 2006, at 23:19, Nicolas Pitre wrote:
> It looks really interesting.
>
> It ignores the max_size argument but that is trivially fixed.
>
> Then it triggers some assertions in the code when running the test
> suite.
Yes, these were errors in the change to the GIT output format.
They were trivially fixed. More importantly, I didn't finalize
the indexing data, since the code was originally used in a stand-alone
program that would terminate after the diff.

> I did reformat it a bit to be more inline with the rest of GIT's  
> coding
> style (and to help me read it).  I'll look at fixing the issues I can
> fix and post it back.

Please apply the attached patch first.

   -Geert

BTW. It's a shame that we don't reuse the index when comparing one  
source
      against multiple targets. Creating the index takes about 70% of  
the time.


--Apple-Mail-4--107045785
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="pat"
Content-Disposition: attachment;
	filename=pat

--- diff-delta.c.orig	2006-04-22 06:53:44.000000000 -0400
+++ diff-delta.c	2006-04-22 06:59:14.000000000 -0400
@@ -29,7 +29,7 @@
 #define RABIN_WINDOW_SIZE 22
 #define RABIN_SHIFT 55
 
-static unsigned long long T[256] =
+static const unsigned long long T[256] =
 { 0x0000000000000000ULL, 0xb15e234bd3792f63ULL, 0x62bc4697a6f25ec6ULL,
   0xd3e265dc758b71a5ULL, 0x7426ae649e9d92efULL, 0xc5788d2f4de4bd8cULL,
   0x169ae8f3386fcc29ULL, 0xa7c4cbb8eb16e34aULL, 0x59137f82ee420abdULL,
@@ -118,7 +118,7 @@
   0xed7b43a0554e9f70ULL
 };
 
-static unsigned long long U[256] =
+static const unsigned long long U[256] =
 { 0x0000000000000000ULL, 0x079343d61ab9f60eULL, 0x0f2687ac3573ec1cULL,
   0x08b5c47a2fca1a12ULL, 0x1e4d0f586ae7d838ULL, 0x19de4c8e705e2e36ULL,
   0x116b88f45f943424ULL, 0x16f8cb22452dc22aULL, 0x3c9a1eb0d5cfb070ULL,
@@ -261,7 +261,7 @@
 static int	copy_count = 0;
 static unsigned max_copies = 0; /* Dynamically increased */
 
-static unsigned *idx;
+static unsigned *idx = 0;
 static unsigned idx_size;
 static unsigned char *idx_data;
 static unsigned idx_data_len;
@@ -406,6 +406,19 @@
     { idx[maxfp[j] % idx_size] = maxofs[j];
 } } }
 
+static void finalize_idx()
+{ if (max_copies > MAX_COPIES)
+  { free (copies);
+    max_copies = 0;
+    copy_count = 0;
+  }
+  if (idx) free (idx);
+  idx = 0;
+  idx_size = 0;
+  idx_data = 0;
+  idx_data_len = 0;
+}
+
 static unsigned header_length (unsigned srclen, unsigned tgtlen)
 { unsigned len = 0;
   assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);
@@ -420,10 +433,12 @@
 }
 
 static unsigned data_length (unsigned length)
-{ assert (length > 0 && length <= MAX_SIZE);
+{ unsigned len = length % 0x7f;
+  assert (length > 0 && length <= MAX_SIZE);
 
   /* Can only include 0x7f data bytes per command */
-  return (length / 0x7f) * 0x80 + length % 0x7f + 1;
+  if (len) len++;
+  return len + (length / 0x7f) * 0x80;
 }
 
 static unsigned copy_length (unsigned offset, unsigned length)
@@ -624,8 +639,7 @@
 
 static unsigned char *
 write_header (unsigned char *patch, unsigned srclen, unsigned tgtlen)
-{ 
-  assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);
+{ assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);
 
   while (srclen >= 0x7f) 
   { *patch++= (srclen & 0x7f) | 0x80;
@@ -658,8 +672,9 @@
 
   *patch++ = (unsigned char) size; 
   memcpy (patch, data, size);
+  patch += size;
 
-  return patch + size;
+  return patch;
 } 
 
 static unsigned char *
@@ -687,6 +702,7 @@
     if (cmd & 0x40) *patch++ = (size >> 16) & 0xff;
     size -= chunksize;
   } 
+
   return patch;
 } 
 
@@ -699,7 +715,9 @@
   unsigned copy_commands = 0;
   int j;
 
+  assert (delta_size - (ptr - delta) >= header_length (idx_data_len, len));
   ptr = write_header (ptr, idx_data_len, len);
+  assert (ptr - delta > 0);
 
   for (j = 0; j < copy_count; j++)
   { CopyInfo *copy = copies + j;
@@ -732,11 +750,17 @@
 void *diff_delta(void *from_buf, unsigned long from_size,
                  void *to_buf, unsigned long to_size,
                  unsigned long *delta_size, unsigned long max_size)
-{ unsigned dsize;
+{ unsigned char *delta = 0;
+  unsigned dsize;
   assert (from_size <= MAX_SIZE && to_size <= MAX_SIZE);
   init_idx (from_buf, from_size, 1); /* Use optimization level 1 */
+
   dsize = calculate_delta (to_buf, to_size);
-  if (!dsize) return 0;
-  *delta_size = dsize;
-  return create_delta (to_buf, to_size, *delta_size);
+  if (dsize && (!max_size || dsize <= max_size))
+  { delta = create_delta (to_buf, to_size, dsize);
+    *delta_size = delta ? dsize : 0;
+  }
+
+  finalize_idx ();
+  return delta;
 }

--Apple-Mail-4--107045785--
