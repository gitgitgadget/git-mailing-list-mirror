From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Sun, 8 Apr 2007 22:09:39 +0200
Message-ID: <20070408200939.GL3854@regex.yaph.org>
References: <20070406234826.GG3854@regex.yaph.org> <Pine.LNX.4.64.0704061830350.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 08 22:09:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hadhp-0003Cz-JU
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 22:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbXDHUJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbXDHUJm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 16:09:42 -0400
Received: from regex.yaph.org ([193.202.115.201]:59794 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbXDHUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 16:09:41 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 5312C5B7CA; Sun,  8 Apr 2007 22:09:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704061830350.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44008>

Hi,

On Fri, Apr 06, 2007 at 06:40:53PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 7 Apr 2007, Arjen Laarhoven wrote:
> >
> > The compiler toolchain supplied by Apple's Xcode environment has an old
> > version (1.38) of the GNU assembler.  It cannot assemble the optimized
> > ppc/sha1ppc.S file.  ppc/sha1ppc.S was rewritten into a Perl script
> > which outputs the same code, but valid for the Xcode assembler.
> 
> Ugh. That's just too ugly.

Yes.  Very.  I should've reworked it before sending it to the list.  Ah
well.

> The Linux version of the GNU assembler can certainly take the same limited 
> input as the old Apple one. 
> 
> So how about instea dof having two totally different versions of this 
> file, just having *one*, and having a pre-processor that turns it into 
> something that is acceptable to both?

That is of course the best way to handle it.  See the patch below for
the reworked solution.

[snip excellent pointers]

> So it would just require somebody who knows perl. What's a one-liner perl 
> script to turn a line like
> 
> 	add REG[((0)+0)%5+6],REG[((0)+0)%5+6],REG[(0)%16+11];
> 
> into
> 
> 	add %6,%6,%11
> 
> (ie it just evaluated the expression inside the [] things, and replaced it 
> with the "%<num>" string)?
> 
> <Taunting mode>Or maybe perl can't do that in a single line!</Taunting mode>

Of course it can! :-P

But there are some other issues like the underscore prefix of the symbol
in the assembly and the inability of Apple's assembler to handle
multiple statements per line.  So for the sake of maintainability I've
put it in its own file, and even turned on warnings and strict ;-)

I don't have access to a Linux/PPC machine, so it could very well need
some tweaking.  Someone with a Linux/PPC box want to give it a try?

---snip---
Optimized PowerPC SHA-1 calculation for Darwin

The compiler toolchain from Apple's Xcode environment uses an old
version (1.38) of the GNU assembler which cannot assemble the
optimized SHA-1 calculation in ppc/sha1ppc.S.  The main problem is the
use of calculated register numbers which gas 1.38 doesn't understand.

To create valid assembly code the registers in ppc/sha1ppc.in.S are
represented by R[<register number>].  sha1ppc.in.S is postprocessed by
gen_sha1ppc.pl to generate valid assembly code for gas 1.38.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 Makefile                        |    7 ++-
 ppc/gen_sha1ppc.pl              |   19 +++++++
 ppc/{sha1ppc.S => sha1ppc.in.S} |  110 +++++++++++++++++++-------------------
 3 files changed, 79 insertions(+), 57 deletions(-)
 create mode 100644 ppc/gen_sha1ppc.pl
 rename ppc/{sha1ppc.S => sha1ppc.in.S} (70%)

diff --git a/Makefile b/Makefile
index ac29c62..01b69e7 100644
--- a/Makefile
+++ b/Makefile
@@ -825,7 +825,7 @@ git$X git.spec \
 
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
-%.o: %.S
+%.o: %.s
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
@@ -836,6 +836,9 @@ builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
 http.o: http.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
+ppc/sha1ppc.s: ppc/sha1ppc.in.S
+	$(QUIET_CC)$(CC) -c -E $< | $(PERL_PATH) ppc/gen_sha1ppc.pl > $@
+
 ifdef NO_EXPAT
 http-fetch.o: http-fetch.c http.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
@@ -1032,7 +1035,7 @@ dist-doc:
 ### Cleaning rules
 
 clean:
-	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
+	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.[so] compat/*.o xdiff/*.o \
 		test-chmtime$X $(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
diff --git a/ppc/gen_sha1ppc.pl b/ppc/gen_sha1ppc.pl
new file mode 100644
index 0000000..79ba1a1
--- /dev/null
+++ b/ppc/gen_sha1ppc.pl
@@ -0,0 +1,19 @@
+#!/usr/bin/perl -w
+
+use strict;
+
+my %platform = (
+    # Special extra substitutions that have to be done on this platform
+    darwin => sub {
+        s{sha1_core}{_sha1_core};
+        s{;}{\n}g;
+    },
+);
+
+my $extra = exists $platform{$^O} ? $platform{$^O} : sub {};
+
+while (<>) {
+    $extra->();
+    s{R\[([^]]+)\]}{'r'.eval"$1"}ge;
+    print;
+}
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.in.S
similarity index 70%
rename from ppc/sha1ppc.S
rename to ppc/sha1ppc.in.S
index f132696..11bc2e0 100644
--- a/ppc/sha1ppc.S
+++ b/ppc/sha1ppc.in.S
@@ -32,14 +32,14 @@
  * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
  * the previous values.)
  */
-#define RA(t)	(((t)+4)%5+6)
-#define RB(t)	(((t)+3)%5+6)
-#define RC(t)	(((t)+2)%5+6)
-#define RD(t)	(((t)+1)%5+6)
-#define RE(t)	(((t)+0)%5+6)
+#define RA(t)	R[((t)+4)%5+6]
+#define RB(t)	R[((t)+3)%5+6]
+#define RC(t)	R[((t)+2)%5+6]
+#define RD(t)	R[((t)+1)%5+6]
+#define RE(t)	R[((t)+0)%5+6]
 
 /* We use registers 11 - 26 for the W values */
-#define W(t)	((t)%16+11)
+#define W(t)	R[(t)%16+11]
 
 /* Register 5 is used for the constant k */
 
@@ -86,7 +86,7 @@
 
 /* the initial loads. */
 #define LOADW(s) \
-	lwz	W(s),(s)*4(%r4)
+	lwz	W(s),(s)*4(R[4])
 
 /*
  * Perform a step with F0, and load W(s).  Uses W(s) as a temporary
@@ -97,10 +97,10 @@
  * second line.)  Thus, two iterations take 7 cycles, 3.5 cycles per round.
  */
 #define STEPD0_LOAD(t,s) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t);  and    W(s),RC(t),RB(t); \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;      rotlwi RB(t),RB(t),30;   \
-add RE(t),RE(t),W(s); add    %r0,%r0,%r5;      lwz    W(s),(s)*4(%r4);  \
-add RE(t),RE(t),%r0
+add RE(t),RE(t),W(t); andc   R[0],RD(t),RB(t); and    W(s),RC(t),RB(t); \
+add RE(t),RE(t),R[0]; rotlwi R[0],RA(t),5;     rotlwi RB(t),RB(t),30;   \
+add RE(t),RE(t),W(s); add    R[0],R[0],R[5];   lwz    W(s),(s)*4(R[4]); \
+add RE(t),RE(t),R[0]
 
 /*
  * This is likewise awkward, 13 instructions.  However, it can also
@@ -108,28 +108,28 @@ add RE(t),RE(t),%r0
  * in 9 cycles, 4.5 cycles/round.
  */
 #define STEPD0_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r5;  loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;     \
-add RE(t),RE(t),%r0
+add RE(t),RE(t),W(t); andc   R[0],RD(t),RB(t); xor   W(s),W((s)-16),W((s)-3); \
+add RE(t),RE(t),R[0]; and    R[0],RC(t),RB(t); xor   W(s),W(s),W((s)-8);      \
+add RE(t),RE(t),R[0]; rotlwi R[0],RA(t),5;     xor   W(s),W(s),W((s)-14);     \
+add RE(t),RE(t),R[5]; loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;      \
+add RE(t),RE(t),R[0]
 
 /* Nicely optimal.  Conveniently, also the most common. */
 #define STEPD1_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r5;  loadk; xor %r0,%r0,RC(t);  xor W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1
+add RE(t),RE(t),W(t); xor    R[0],RD(t),RB(t);    xor W(s),W((s)-16),W((s)-3); \
+add RE(t),RE(t),R[5]; loadk; xor R[0],R[0],RC(t); xor W(s),W(s),W((s)-8);    \
+add RE(t),RE(t),R[0]; rotlwi R[0],RA(t),5;   xor    W(s),W(s),W((s)-14);  \
+add RE(t),RE(t),R[0]; rotlwi RB(t),RB(t),30; rotlwi W(s),W(s),1
 
 /*
  * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
  * We could use W(s) as a temp register, but we don't need it.
  */
 #define STEPD1(t) \
-                        add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
-rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   \
-add    RE(t),RE(t),%r0; rotlwi %r0,RA(t),5;     /* spare slot */        \
-add    RE(t),RE(t),%r0
+                        add   RE(t),RE(t),W(t); xor    R[0],RD(t),RB(t); \
+rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),R[5]; xor    R[0],R[0],RC(t);   \
+add    RE(t),RE(t),R[0]; rotlwi R[0],RA(t),5;     /* spare slot */        \
+add    RE(t),RE(t),R[0]
 
 /*
  * 14 instructions, 5 cycles per.  The majority function is a bit
@@ -137,11 +137,11 @@ add    RE(t),RE(t),%r0
  * but it causes a 2-instruction delay, which triggers a stall.
  */
 #define STEPD2_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r5;  loadk; and %r0,%r0,RC(t);  xor W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
+add RE(t),RE(t),W(t); and    R[0],RD(t),RB(t); xor  W(s),W((s)-16),W((s)-3); \
+add RE(t),RE(t),R[0]; xor    R[0],RD(t),RB(t); xor  W(s),W(s),W((s)-8);      \
+add RE(t),RE(t),R[5]; loadk; and R[0],R[0],RC(t);  xor W(s),W(s),W((s)-14);  \
+add RE(t),RE(t),R[0]; rotlwi R[0],RA(t),5;     rotlwi W(s),W(s),1;           \
+add RE(t),RE(t),R[0]; rotlwi RB(t),RB(t),30
 
 #define STEP0_LOAD4(t,s)		\
 	STEPD0_LOAD(t,s);		\
@@ -164,61 +164,61 @@ add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
 
 	.globl	sha1_core
 sha1_core:
-	stwu	%r1,-80(%r1)
-	stmw	%r13,4(%r1)
+	stwu	R[1],-80(R[1])
+	stmw	R[13],4(R[1])
 
 	/* Load up A - E */
-	lmw	%r27,0(%r3)
+	lmw	R[27],0(R[3])
 
-	mtctr	%r5
+	mtctr	R[5]
 
 1:
 	LOADW(0)
-	lis	%r5,0x5a82
-	mr	RE(0),%r31
+	lis	R[5],0x5a82
+	mr	RE(0),R[31]
 	LOADW(1)
-	mr	RD(0),%r30
-	mr	RC(0),%r29
+	mr	RD(0),R[30]
+	mr	RC(0),R[29]
 	LOADW(2)
-	ori	%r5,%r5,0x7999	/* K0-19 */
-	mr	RB(0),%r28
+	ori	R[5],R[5],0x7999	/* K0-19 */
+	mr	RB(0),R[28]
 	LOADW(3)
-	mr	RA(0),%r27
+	mr	RA(0),R[27]
 
 	STEP0_LOAD4(0, 4)
 	STEP0_LOAD4(4, 8)
 	STEP0_LOAD4(8, 12)
 	STEPUP4(D0, 12, 16,)
-	STEPUP4(D0, 16, 20, lis %r5,0x6ed9)
+	STEPUP4(D0, 16, 20, lis R[5],0x6ed9)
 
-	ori	%r5,%r5,0xeba1	/* K20-39 */
-	STEPUP20(D1, 20, 24, lis %r5,0x8f1b)
+	ori	R[5],R[5],0xeba1	/* K20-39 */
+	STEPUP20(D1, 20, 24, lis R[5],0x8f1b)
 
-	ori	%r5,%r5,0xbcdc	/* K40-59 */
-	STEPUP20(D2, 40, 44, lis %r5,0xca62)
+	ori	R[5],R[5],0xbcdc	/* K40-59 */
+	STEPUP20(D2, 40, 44, lis R[5],0xca62)
 
-	ori	%r5,%r5,0xc1d6	/* K60-79 */
+	ori	R[5],R[5],0xc1d6	/* K60-79 */
 	STEPUP4(D1, 60, 64,)
 	STEPUP4(D1, 64, 68,)
 	STEPUP4(D1, 68, 72,)
 	STEPUP4(D1, 72, 76,)
-	addi	%r4,%r4,64
+	addi	R[4],R[4],64
 	STEPD1(76)
 	STEPD1(77)
 	STEPD1(78)
 	STEPD1(79)
 
 	/* Add results to original values */
-	add	%r31,%r31,RE(0)
-	add	%r30,%r30,RD(0)
-	add	%r29,%r29,RC(0)
-	add	%r28,%r28,RB(0)
-	add	%r27,%r27,RA(0)
+	add	R[31],R[31],RE(0)
+	add	R[30],R[30],RD(0)
+	add	R[29],R[29],RC(0)
+	add	R[28],R[28],RB(0)
+	add	R[27],R[27],RA(0)
 
 	bdnz	1b
 
 	/* Save final hash, restore registers, and return */
-	stmw	%r27,0(%r3)
-	lmw	%r13,4(%r1)
-	addi	%r1,%r1,80
+	stmw	R[27],0(R[3])
+	lmw	R[13],4(R[1])
+	addi	R[1],R[1],80
 	blr
-- 
1.5.1.rc3.29.gd8b6
