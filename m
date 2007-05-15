From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] git name-rev writes beyond the end of malloc() with large generations
Date: Tue, 15 May 2007 17:33:25 +0100
Message-ID: <2be2ad34be511217dc735a15490f4536@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 18:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho080-00077K-11
	for gcvg-git@gmane.org; Tue, 15 May 2007 18:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761652AbXEOQnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761455AbXEOQnt
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 12:43:49 -0400
Received: from 85-210-246-255.dsl.pipex.com ([85.210.246.255]:45131 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761018AbXEOQns (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 12:43:48 -0400
X-Greylist: delayed 632 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 May 2007 12:43:47 EDT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1Hnzxl-0006kF-BG
	for git@vger.kernel.org; Tue, 15 May 2007 17:33:25 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47357>


When using git name-rev on my kernel tree I triggered a malloc()
corruption warning from glibc.

apw@pinky$ git log --pretty=one $N/base.. | git name-rev --stdin
*** glibc detected *** malloc(): memory corruption: 0x0bff8950 ***
Aborted

This comes from name_rev() which is building the name of the revision
in a malloc'd string, which it sprintf's into:

	char *new_name = xmalloc(len + 8);
	[...]
		sprintf(new_name, "%.*s~%d^%d", len, tip_name,
				generation, parent_number);

This allocation is only sufficient if the generation number is
less than 5 digits, in my case generation was 13432.  In reality
parent_number can be up to 16 so that also can require two digits,
reducing us to 3 digits before we are at risk of blowing this
allocation.

This patch introduces a decimal_length() which approximates the
number of digits a type may hold, it produces the following:

Type                 Longest Value          Len  Est
----                 -------------          ---  ---
unsigned char        256                      3    4
unsigned short       65536                    5    6
unsigned long        4294967296              10   11
unsigned long long   18446744073709551616    20   21
char                 -128                     4    4
short                -32768                   6    6
long                 -2147483648             11   11
long long            -9223372036854775808    20   21

This is then used to size the new_name.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---

	This patch is against current next.  I have confirmed that
	at least GCC can optimise this away to a constant.
---
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index c022224..ef16385 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -58,7 +58,10 @@ copy_data:
 			parents = parents->next, parent_number++) {
 		if (parent_number > 1) {
 			int len = strlen(tip_name);
-			char *new_name = xmalloc(len + 8);
+			char *new_name = xmalloc(len +
+				1 + decimal_length(generation) +  /* ~<n> */
+				1 + 2 +				  /* ^NN */
+				1);
 
 			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
 				len -= 2;
diff --git a/git-compat-util.h b/git-compat-util.h
index c08688c..25b8274 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -19,6 +19,9 @@
 #define TYPEOF(x)
 #endif
 
+/* Approximation of the length of the decimal representation of this type. */
+#define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
+
 #define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (sizeof(x) * 8 - (bits))))
 
 #if !defined(__APPLE__) && !defined(__FreeBSD__)
