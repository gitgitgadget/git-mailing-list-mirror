From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: Linus' sha1 is much faster!
Date: Sun, 16 Aug 2009 21:25:11 +0200
Message-ID: <87eirbef3c.fsf@master.homenet>
References: <4A85F270.20703@draigBrady.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bug-coreutils@gnu.org,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
X-From: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org Sun Aug 16 21:27:04 2009
Return-path: <bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org>
Envelope-to: gcgcb-bug-coreutils-616@gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MclNf-00067i-PB
	for gcgcb-bug-coreutils-616@gmane.org; Sun, 16 Aug 2009 21:27:04 +0200
Received: from localhost ([127.0.0.1]:36401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1MclNf-0004uk-3T
	for gcgcb-bug-coreutils-616@gmane.org; Sun, 16 Aug 2009 15:27:03 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1MclNc-0004sz-1B
	for bug-coreutils@gnu.org; Sun, 16 Aug 2009 15:27:00 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1MclNW-0004qm-I3
	for Bug-coreutils@gnu.org; Sun, 16 Aug 2009 15:26:59 -0400
Received: from [199.232.76.173] (port=39624 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1MclNW-0004qi-D2
	for Bug-coreutils@gnu.org; Sun, 16 Aug 2009 15:26:54 -0400
Received: from jack.mail.tiscali.it ([213.205.33.53]:55592)
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <gscrivano@gnu.org>)
	id 1MclNS-0002Gc-OS; Sun, 16 Aug 2009 15:26:51 -0400
Received: from master.homenet (84.223.200.129) by jack.mail.tiscali.it
	(8.0.022) id 499F036C05B6A5E6; Sun, 16 Aug 2009 21:26:37 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1MclLr-0007mw-Sz; Sun, 16 Aug 2009 21:25:12 +0200
In-Reply-To: <4A85F270.20703@draigBrady.com> (=?utf-8?Q?=22P=C3=A1draig?=
	Brady"'s message of "Sat, 15 Aug 2009 00:25:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-detected-operating-system: by monty-python.gnu.org: GNU/Linux 2.6,
	seldom 2.4 (older, 4)
X-BeenThere: bug-coreutils@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "GNU Core Utilities: bug reports and discussion"
	<bug-coreutils.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-coreutils>
List-Post: <mailto:bug-coreutils@gnu.org>
List-Help: <mailto:bug-coreutils-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=subscribe>
Sender: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Errors-To: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126068>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi P=C3=A1draig,

I tried to reproduce your results but I wasn't able to do it.  The
biggest difference on a 300MB file I noticed was approximately 15% using
on both implementations -O2, and 5% using -O3.
My GCC version is "gcc (Debian 4.3.3-14) 4.3.3" and the CPU is: Intel(R)
Pentium(R) D CPU 3.20GHz.

I also spent some time trying to improve the gnulib SHA1 implementation
and it seems a lookup table can improve things a bit.

Can you please try the patch that I have attached and tell me which
performance difference (if any) you get?

Thanks,
Giuseppe



--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-SHA1-use-a-lookup-table-for-faster-hashing.patch

>From b975a5e0849eaa46e5cf410c5bf6e2308f044d61 Mon Sep 17 00:00:00 2001
From: Giuseppe Scrivano <gscrivano@gnu.org>
Date: Sun, 16 Aug 2009 20:53:54 +0200
Subject: [PATCH] SHA1: use a lookup table for faster hashing

* lib/sha1.c (struct sha1_pre): New member.
* lib/sha1.c (sha1_process_block): Use the lookup table to quickly find
indices to use in the current round.
---
 lib/sha1.c |  160 ++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 92 insertions(+), 68 deletions(-)

diff --git a/lib/sha1.c b/lib/sha1.c
index 9c6c7ae..ec18ba7 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -283,6 +283,32 @@ sha1_process_bytes (const void *buffer, size_t len, struct sha1_ctx *ctx)
 #define F3(B,C,D) ( ( B & C ) | ( D & ( B | C ) ) )
 #define F4(B,C,D) (B ^ C ^ D)
 
+struct lookup_t
+{
+  unsigned char l1 : 4;
+  unsigned char l2 : 4;
+  unsigned char l3 : 4;
+  unsigned char l4 : 4;
+};
+
+const static struct lookup_t
+sha1_pre[16] = {{(0 - 3) & 0x0f, (0 - 8) & 0x0f, (0 - 14) & 0x0f},
+                {(1 - 3) & 0x0f, (1 - 8) & 0x0f, (1 - 14) & 0x0f},
+                {(2 - 3) & 0x0f, (2 - 8) & 0x0f, (2 - 14) & 0x0f},
+                {(3 - 3) & 0x0f, (3 - 8) & 0x0f, (3 - 14) & 0x0f},
+                {(4 - 3) & 0x0f, (4 - 8) & 0x0f, (4 - 14) & 0x0f},
+                {(5 - 3) & 0x0f, (5 - 8) & 0x0f, (5 - 14) & 0x0f},
+                {(6 - 3) & 0x0f, (6 - 8) & 0x0f, (6 - 14) & 0x0f},
+                {(7 - 3) & 0x0f, (7 - 8) & 0x0f, (7 - 14) & 0x0f},
+                {(8 - 3) & 0x0f, (8 - 8) & 0x0f, (8 - 14) & 0x0f},
+                {(9 - 3) & 0x0f, (9 - 8) & 0x0f, (9 - 14) & 0x0f},
+                {(10 - 3) & 0x0f, (10 - 8) & 0x0f, (10 - 14) & 0x0f},
+                {(11 - 3) & 0x0f, (11 - 8) & 0x0f, (11 - 14) & 0x0f},
+                {(12 - 3) & 0x0f, (12 - 8) & 0x0f, (12 - 14) & 0x0f},
+                {(13 - 3) & 0x0f, (13 - 8) & 0x0f, (13 - 14) & 0x0f},
+                {(14 - 3) & 0x0f, (14 - 8) & 0x0f, (14 - 14) & 0x0f},
+                {(15 - 3) & 0x0f, (15 - 8) & 0x0f, (15 - 14) & 0x0f}};
+
 /* Process LEN bytes of BUFFER, accumulating context into CTX.
    It is assumed that LEN % 64 == 0.
    Most of this code comes from GnuPG's cipher/sha1.c.  */
@@ -309,9 +335,8 @@ sha1_process_block (const void *buffer, size_t len, struct sha1_ctx *ctx)
 
 #define rol(x, n) (((x) << (n)) | ((uint32_t) (x) >> (32 - (n))))
 
-#define M(I) ( tm =   x[I&0x0f] ^ x[(I-14)&0x0f] \
-		    ^ x[(I-8)&0x0f] ^ x[(I-3)&0x0f] \
-	       , (x[I&0x0f] = rol(tm, 1)) )
+#define M(I) (x[I] = rol (x[sha1_pre[I].l1] ^ x[sha1_pre[I].l2] \
+                          ^ x[sha1_pre[I].l3] ^ x[I], 1))
 
 #define R(A,B,C,D,E,F,K,M)  do { E += rol( A, 5 )     \
 				      + F( B, C, D )  \
@@ -322,7 +347,6 @@ sha1_process_block (const void *buffer, size_t len, struct sha1_ctx *ctx)
 
   while (words < endp)
     {
-      uint32_t tm;
       int t;
       for (t = 0; t < 16; t++)
 	{
@@ -346,70 +370,70 @@ sha1_process_block (const void *buffer, size_t len, struct sha1_ctx *ctx)
       R( c, d, e, a, b, F1, K1, x[13] );
       R( b, c, d, e, a, F1, K1, x[14] );
       R( a, b, c, d, e, F1, K1, x[15] );
-      R( e, a, b, c, d, F1, K1, M(16) );
-      R( d, e, a, b, c, F1, K1, M(17) );
-      R( c, d, e, a, b, F1, K1, M(18) );
-      R( b, c, d, e, a, F1, K1, M(19) );
-      R( a, b, c, d, e, F2, K2, M(20) );
-      R( e, a, b, c, d, F2, K2, M(21) );
-      R( d, e, a, b, c, F2, K2, M(22) );
-      R( c, d, e, a, b, F2, K2, M(23) );
-      R( b, c, d, e, a, F2, K2, M(24) );
-      R( a, b, c, d, e, F2, K2, M(25) );
-      R( e, a, b, c, d, F2, K2, M(26) );
-      R( d, e, a, b, c, F2, K2, M(27) );
-      R( c, d, e, a, b, F2, K2, M(28) );
-      R( b, c, d, e, a, F2, K2, M(29) );
-      R( a, b, c, d, e, F2, K2, M(30) );
-      R( e, a, b, c, d, F2, K2, M(31) );
-      R( d, e, a, b, c, F2, K2, M(32) );
-      R( c, d, e, a, b, F2, K2, M(33) );
-      R( b, c, d, e, a, F2, K2, M(34) );
-      R( a, b, c, d, e, F2, K2, M(35) );
-      R( e, a, b, c, d, F2, K2, M(36) );
-      R( d, e, a, b, c, F2, K2, M(37) );
-      R( c, d, e, a, b, F2, K2, M(38) );
-      R( b, c, d, e, a, F2, K2, M(39) );
-      R( a, b, c, d, e, F3, K3, M(40) );
-      R( e, a, b, c, d, F3, K3, M(41) );
-      R( d, e, a, b, c, F3, K3, M(42) );
-      R( c, d, e, a, b, F3, K3, M(43) );
-      R( b, c, d, e, a, F3, K3, M(44) );
-      R( a, b, c, d, e, F3, K3, M(45) );
-      R( e, a, b, c, d, F3, K3, M(46) );
-      R( d, e, a, b, c, F3, K3, M(47) );
-      R( c, d, e, a, b, F3, K3, M(48) );
-      R( b, c, d, e, a, F3, K3, M(49) );
-      R( a, b, c, d, e, F3, K3, M(50) );
-      R( e, a, b, c, d, F3, K3, M(51) );
-      R( d, e, a, b, c, F3, K3, M(52) );
-      R( c, d, e, a, b, F3, K3, M(53) );
-      R( b, c, d, e, a, F3, K3, M(54) );
-      R( a, b, c, d, e, F3, K3, M(55) );
-      R( e, a, b, c, d, F3, K3, M(56) );
-      R( d, e, a, b, c, F3, K3, M(57) );
-      R( c, d, e, a, b, F3, K3, M(58) );
-      R( b, c, d, e, a, F3, K3, M(59) );
-      R( a, b, c, d, e, F4, K4, M(60) );
-      R( e, a, b, c, d, F4, K4, M(61) );
-      R( d, e, a, b, c, F4, K4, M(62) );
-      R( c, d, e, a, b, F4, K4, M(63) );
-      R( b, c, d, e, a, F4, K4, M(64) );
-      R( a, b, c, d, e, F4, K4, M(65) );
-      R( e, a, b, c, d, F4, K4, M(66) );
-      R( d, e, a, b, c, F4, K4, M(67) );
-      R( c, d, e, a, b, F4, K4, M(68) );
-      R( b, c, d, e, a, F4, K4, M(69) );
-      R( a, b, c, d, e, F4, K4, M(70) );
-      R( e, a, b, c, d, F4, K4, M(71) );
-      R( d, e, a, b, c, F4, K4, M(72) );
-      R( c, d, e, a, b, F4, K4, M(73) );
-      R( b, c, d, e, a, F4, K4, M(74) );
-      R( a, b, c, d, e, F4, K4, M(75) );
-      R( e, a, b, c, d, F4, K4, M(76) );
-      R( d, e, a, b, c, F4, K4, M(77) );
-      R( c, d, e, a, b, F4, K4, M(78) );
-      R( b, c, d, e, a, F4, K4, M(79) );
+      R( e, a, b, c, d, F1, K1, M( 0) );
+      R( d, e, a, b, c, F1, K1, M( 1) );
+      R( c, d, e, a, b, F1, K1, M( 2) );
+      R( b, c, d, e, a, F1, K1, M( 3) );
+      R( a, b, c, d, e, F2, K2, M( 4) );
+      R( e, a, b, c, d, F2, K2, M( 5) );
+      R( d, e, a, b, c, F2, K2, M( 6) );
+      R( c, d, e, a, b, F2, K2, M( 7) );
+      R( b, c, d, e, a, F2, K2, M( 8) );
+      R( a, b, c, d, e, F2, K2, M( 9) );
+      R( e, a, b, c, d, F2, K2, M(10) );
+      R( d, e, a, b, c, F2, K2, M(11) );
+      R( c, d, e, a, b, F2, K2, M(12) );
+      R( b, c, d, e, a, F2, K2, M(13) );
+      R( a, b, c, d, e, F2, K2, M(14) );
+      R( e, a, b, c, d, F2, K2, M(15) );
+      R( d, e, a, b, c, F2, K2, M( 0) );
+      R( c, d, e, a, b, F2, K2, M( 1) );
+      R( b, c, d, e, a, F2, K2, M( 2) );
+      R( a, b, c, d, e, F2, K2, M( 3) );
+      R( e, a, b, c, d, F2, K2, M( 4) );
+      R( d, e, a, b, c, F2, K2, M( 5) );
+      R( c, d, e, a, b, F2, K2, M( 6) );
+      R( b, c, d, e, a, F2, K2, M( 7) );
+      R( a, b, c, d, e, F3, K3, M( 8) );
+      R( e, a, b, c, d, F3, K3, M( 9) );
+      R( d, e, a, b, c, F3, K3, M(10) );
+      R( c, d, e, a, b, F3, K3, M(11) );
+      R( b, c, d, e, a, F3, K3, M(12) );
+      R( a, b, c, d, e, F3, K3, M(13) );
+      R( e, a, b, c, d, F3, K3, M(14) );
+      R( d, e, a, b, c, F3, K3, M(15) );
+      R( c, d, e, a, b, F3, K3, M( 0) );
+      R( b, c, d, e, a, F3, K3, M( 1) );
+      R( a, b, c, d, e, F3, K3, M( 2) );
+      R( e, a, b, c, d, F3, K3, M( 3) );
+      R( d, e, a, b, c, F3, K3, M( 4) );
+      R( c, d, e, a, b, F3, K3, M( 5) );
+      R( b, c, d, e, a, F3, K3, M( 6) );
+      R( a, b, c, d, e, F3, K3, M( 7) );
+      R( e, a, b, c, d, F3, K3, M( 8) );
+      R( d, e, a, b, c, F3, K3, M( 9) );
+      R( c, d, e, a, b, F3, K3, M(10) );
+      R( b, c, d, e, a, F3, K3, M(11) );
+      R( a, b, c, d, e, F4, K4, M(12) );
+      R( e, a, b, c, d, F4, K4, M(13) );
+      R( d, e, a, b, c, F4, K4, M(14) );
+      R( c, d, e, a, b, F4, K4, M(15) );
+      R( b, c, d, e, a, F4, K4, M( 0) );
+      R( a, b, c, d, e, F4, K4, M( 1) );
+      R( e, a, b, c, d, F4, K4, M( 2) );
+      R( d, e, a, b, c, F4, K4, M( 3) );
+      R( c, d, e, a, b, F4, K4, M( 4) );
+      R( b, c, d, e, a, F4, K4, M( 5) );
+      R( a, b, c, d, e, F4, K4, M( 6) );
+      R( e, a, b, c, d, F4, K4, M( 7) );
+      R( d, e, a, b, c, F4, K4, M( 8) );
+      R( c, d, e, a, b, F4, K4, M( 9) );
+      R( b, c, d, e, a, F4, K4, M(10) );
+      R( a, b, c, d, e, F4, K4, M(11) );
+      R( e, a, b, c, d, F4, K4, M(12) );
+      R( d, e, a, b, c, F4, K4, M(13) );
+      R( c, d, e, a, b, F4, K4, M(14) );
+      R( b, c, d, e, a, F4, K4, M(15) );
 
       a = ctx->A += a;
       b = ctx->B += b;
-- 
1.6.3.3


--=-=-=--
