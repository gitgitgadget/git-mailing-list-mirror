From: arjen@yaph.org (Arjen Laarhoven)
Subject: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Sat, 7 Apr 2007 01:48:26 +0200
Message-ID: <20070406234826.GG3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyAT-0003IU-3N
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 01:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452AbXDFXsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 19:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933430AbXDFXsa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 19:48:30 -0400
Received: from regex.yaph.org ([193.202.115.201]:33929 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933452AbXDFXs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 19:48:28 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id DB0115B7CA; Sat,  7 Apr 2007 01:48:26 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43943>

The compiler toolchain supplied by Apple's Xcode environment has an old
version (1.38) of the GNU assembler.  It cannot assemble the optimized
ppc/sha1ppc.S file.  ppc/sha1ppc.S was rewritten into a Perl script
which outputs the same code, but valid for the Xcode assembler.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 Makefile                     |   15 +++-
 ppc/darwin/darwin_ppc_gen.pl |  211 ++++++++++++++++++++++++++++++++++++++++++
 ppc/{ => linux}/sha1ppc.S    |    0 
 3 files changed, 223 insertions(+), 3 deletions(-)
 create mode 100755 ppc/darwin/darwin_ppc_gen.pl
 rename ppc/{ => linux}/sha1ppc.S (100%)

diff --git a/Makefile b/Makefile
index b159ffd..a91fa2a 100644
--- a/Makefile
+++ b/Makefile
@@ -587,9 +587,13 @@ ifdef OLD_ICONV
 	BASIC_CFLAGS += -DOLD_ICONV
 endif
 
-ifdef PPC_SHA1
+ifdef PPC_SHA1_LINUX
 	SHA1_HEADER = "ppc/sha1.h"
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	LIB_OBJS += ppc/sha1.o ppc/linux/sha1ppc.o
+else
+ifdef PPC_SHA1_DARWIN
+	SHA1_HEADER = "ppc/sha1.h"
+	LIB_OBJS += ppc/sha1.o ppc/darwin/sha1ppc.o
 else
 ifdef ARM_SHA1
 	SHA1_HEADER = "arm/sha1.h"
@@ -604,6 +608,7 @@ else
 endif
 endif
 endif
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
@@ -620,6 +625,7 @@ endif
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
 	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_AS       = @echo '   ' AS $@; 
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
@@ -780,6 +786,9 @@ exec_cmd.o: exec_cmd.c GIT-CFLAGS
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
+ppc/darwin/sha1ppc.S:
+	$(QUIET_GEN)$(PERL_PATH) ppc/darwin/darwin_ppc_gen.pl > $@
+
 http.o: http.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
@@ -962,7 +971,7 @@ dist-doc:
 ### Cleaning rules
 
 clean:
-	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
+	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o ppc/darwin/*.[os] ppc/linux/*.o compat/*.o xdiff/*.o \
 		test-chmtime$X $(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
diff --git a/ppc/darwin/darwin_ppc_gen.pl b/ppc/darwin/darwin_ppc_gen.pl
new file mode 100755
index 0000000..346cd71
--- /dev/null
+++ b/ppc/darwin/darwin_ppc_gen.pl
@@ -0,0 +1,211 @@
+#!/usr/bin/perl
+
+# This script generates the PowerPC assembly code for optimized SHA-1
+# hash generation on Darwin (Mac OS X).  It is a rewrite of the original
+# ppc/sha1ppc.S file.
+#
+# The original ppc/sha1ppc.S cannot be assembled with the toolchain
+# supplied with Xcode, as the assembler is (based on) GNU as version
+# 1.38.  The problem is basically that the 1.38 assembler doesn't
+# understand the computed register numbers used in the macros and
+# register numbers without the 'r'.  This script acts as preprocessor
+# and evaluates the # expressions for the register numbers and outputs
+# the final correct # assembly for the 1.38 assembler.
+
+use strict;
+use warnings;
+
+
+sub RA { my ($t) = @_; 'r'.((($t)+4)%5+6) }
+sub RB { my ($t) = @_; 'r'.((($t)+3)%5+6) }
+sub RC { my ($t) = @_; 'r'.((($t)+2)%5+6) }
+sub RD { my ($t) = @_; 'r'.((($t)+1)%5+6) }
+sub RE { my ($t) = @_; 'r'.((($t)+0)%5+6) }
+sub W  { my ($t) = @_; 'r'.(($t)%16+11)   }
+
+sub LOADW { my $s = shift; return "\tlwz ".W($s).','.($s)*4 .'(r4)'; }
+
+sub STEPD0_LOAD {
+    my ($t, $s) = @_;
+
+    return join "\n",
+        "\tadd ".RE($t).','.RE($t).','.W($t),
+        "\tandc r0,".RD($t).','.RB($t),
+        "\tand ".W($s).','.RC($t).','.RB($t),
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\trotlwi r0,".RA($t).',5',
+        "\trotlwi ".RB($t).','.RB($t).',30',
+        "\tadd ".RE($t).','.RE($t).','.W($s),
+        "\tadd r0,r0,r5",
+        "\tlwz ".W($s).','.($s)*4 .'(r4)',
+        "\tadd ".RE($t).','.RE($t).',r0';
+}
+
+sub STEPD0_UPDATE {
+    my ($t, $s, $loadk) = @_;
+
+    return join "\n",
+    "\tadd ".RE($t).','.RE($t).','.W($t),
+    "\tandc r0,".RD($t).','.RB($t),
+    "\txor ".W($s).','.W(($s)-16).','.W(($s)-3),
+    "\tadd ".RE($t).','.RE($t).',r0',
+    "\tand r0,".RC($t).','.RB($t),
+    "\txor ".W($s).','.W($s).','.W(($s)-8),
+    "\tadd ".RE($t).','.RE($t).',r0',
+    "\trotlwi r0,".RA($t).',5',
+    "\txor ".W($s).','.W($s).','.W(($s)-14),
+    "\tadd ".RE($t).','.RE($t).',r5',
+    $loadk || (),
+    "\trotlwi ".RB($t).','.RB($t).',30',
+    "\trotlwi ".W($s).','.W($s).',1',
+    "\tadd ".RE($t).','.RE($t).',r0';
+}
+
+sub STEPD1_UPDATE {
+    my ($t, $s, $loadk) = @_;
+
+    return join "\n",
+        "\tadd ".RE($t).','.RE($t).','.W($t),
+        "\txor r0,".RD($t).','.RB($t),
+        "\txor ".W($s).','.W(($s)-16).','.W(($s)-3),
+        "\tadd ".RE($t).','.RE($t).',r5',
+        $loadk || (),
+        "\txor r0,r0,".RC($t),
+        "\txor ".W($s).','.W($s).','.W(($s)-8),
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\trotlwi r0,".RA($t).',5',
+        "\txor ".W($s).','.W($s).','.W(($s)-14),
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\trotlwi ".RB($t).','.RB($t).',30',
+        "\trotlwi ".W($s).','.W($s).',1';
+}
+
+sub STEPD1 {
+    my ($t) = @_;
+
+    return join "\n",
+        "\tadd ".RE($t).','.RE($t).','.W($t),
+        "\txor r0,".RD($t).','.RB($t),
+        "\trotlwi ".RB($t).','.RB($t).',30',
+        "\tadd ".RE($t).','.RE($t).',r5',
+        "\txor r0,r0,".RC($t),
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\trotlwi r0,".RA($t).',5',
+        "\tadd ".RE($t).','.RE($t).',r0';
+}
+
+sub STEPD2_UPDATE {
+    my ($t, $s, $loadk) = @_;
+
+    return join "\n",
+        "\tadd ".RE($t).','.RE($t).','.W($t),
+        "\tand r0,".RD($t).','.RB($t),
+        "\txor ".W($s).','.W(($s)-16).','.W(($s)-3),
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\txor r0,".RD($t).','.RB($t),
+        "\txor ".W($s).','.W($s).','.W(($s)-8),
+        "\tadd ".RE($t).','.RE($t).',r5',
+        $loadk || (),
+        "\tand r0,r0,".RC($t),
+        "\txor ".W($s).','.W($s).','.W(($s)-14),
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\trotlwi r0,".RA($t).',5',
+        "\trotlwi ".W($s).','.W($s).',1',
+        "\tadd ".RE($t).','.RE($t).',r0',
+        "\trotlwi ".RB($t).','.RB($t).',30',
+}
+
+sub STEP0_LOAD4 {
+    my ($t, $s) = @_;
+
+    return join "\n",
+        STEPD0_LOAD($t, $s),
+        STEPD0_LOAD($t+1, $s+1),
+        STEPD0_LOAD($t+2, $s+2),
+        STEPD0_LOAD($t+3, $s+3);
+}
+
+sub STEPUP4 {
+    my ($fn, $t, $s, $loadk) = @_;
+
+    no strict 'refs';
+    return join "\n",
+        &{'STEP' . $fn . '_UPDATE'}($t, $s),
+        &{'STEP' . $fn . '_UPDATE'}($t+1, $s+1),
+        &{'STEP' . $fn . '_UPDATE'}($t+2, $s+2),
+        &{'STEP' . $fn . '_UPDATE'}($t+3, $s+3, $loadk),
+}
+
+sub STEPUP20 {
+    my ($fn, $t, $s, $loadk) = @_;
+
+    return join "\n",
+        STEPUP4($fn, $t, $s),
+        STEPUP4($fn, $t+4, $s+4),
+        STEPUP4($fn, $t+8, $s+8),
+        STEPUP4($fn, $t+12, $s+12),
+        STEPUP4($fn, $t+16, $s+16, $loadk),
+}
+
+print <<'EOA';
+        .globl  _sha1_core
+_sha1_core:
+        stwu    r1,-80(r1)
+        stmw    r13,4(r1)
+
+        /* Load up A - E */
+        lmw     r27,0(r3)
+
+        mtctr   r5
+
+1:
+EOA
+
+print LOADW(0)."\n";
+print "\tlis r5,0x5a82\n";
+print "\tmr ".RE(0).",r31\n";
+print LOADW(1)."\n";
+print "\tmr ".RD(0).",r30\n";
+print "\tmr ".RC(0).",r29\n";
+print LOADW(2)."\n";
+print "\tori r5,r5,0x7999\n";
+print "\tmr ".RB(0).",r28\n";
+print LOADW(3)."\n";
+print "\tmr ".RA(0).",r27\n";
+
+print STEP0_LOAD4(0, 4)."\n";
+print STEP0_LOAD4(4, 8)."\n";
+print STEP0_LOAD4(8, 12)."\n";
+print STEPUP4("D0", 12, 16,)."\n";
+print STEPUP4("D0", 16, 20, "lis r5,0x6ed9")."\n";
+
+print "\tori r5,r5,0xeba1\n";
+print STEPUP20("D1", 20, 24, "lis r5,0x8f1b")."\n";
+
+print "\tori r5,r5,0xbcdc\n";
+print STEPUP20("D2", 40, 44, "lis r5,0xca62")."\n";
+
+print "\tori r5,r5,0xc1d6\n";
+print STEPUP4("D1", 60, 64,)."\n";
+print STEPUP4("D1", 64, 68,)."\n";
+print STEPUP4("D1", 68, 72,)."\n";
+print STEPUP4("D1", 72, 76,)."\n";
+print "\taddi r4,r4,64\n";
+print STEPD1(76)."\n";
+print STEPD1(77)."\n";
+print STEPD1(78)."\n";
+print STEPD1(79)."\n";
+
+print "\tadd r31,r31,".RE(0)."\n";
+print "\tadd r30,r30,".RD(0)."\n";
+print "\tadd r29,r29,".RC(0)."\n";
+print "\tadd r28,r28,".RB(0)."\n";
+print "\tadd r27,r27,".RA(0)."\n";
+
+print "\tbdnz 1b\n";
+
+print "\tstmw r27,0(r3)\n";
+print "\tlmw  r13,4(r1)\n";
+print "\taddi r1,r1,80\n";
+print "\tblr\n";
+
diff --git a/ppc/sha1ppc.S b/ppc/linux/sha1ppc.S
similarity index 100%
rename from ppc/sha1ppc.S
rename to ppc/linux/sha1ppc.S
-- 
1.5.1.rc3.29.gd8b6
