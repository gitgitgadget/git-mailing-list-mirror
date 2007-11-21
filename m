From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/3] sha1_file.c: Fix size_t related printf format warnings
Date: Wed, 21 Nov 2007 21:27:19 +0100
Message-ID: <11956768412804-git-send-email-prohaska@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 21:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuwAf-0008IP-Li
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 21:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbXKUU10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 15:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbXKUU1Z
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 15:27:25 -0500
Received: from mailer.zib.de ([130.73.108.11]:42014 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbXKUU1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 15:27:23 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lALKRM8A007521
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 21:27:22 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lALKRLdG013767;
	Wed, 21 Nov 2007 21:27:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11956768414090-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65701>

The old way of fixing warnings did not succeed on MinGW.  MinGW
does not support C99 printf format strings for size_t [1].  But
gcc on MinGW issues warnings if C99 printf format is not used.
Hence, the old stragegy to avoid warnings fails.

[1] http://www.mingw.org/MinGWiki/index.php/C99

This commits passes arguments of type size_t through a tiny
helper functions that casts to the type expected by the format
string.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 sha1_file.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f007874..4f68e53 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,8 +25,10 @@
 
 #ifdef NO_C99_FORMAT
 #define SZ_FMT "lu"
+static unsigned long sz_fmt(size_t s) { return (unsigned long)s; }
 #else
 #define SZ_FMT "zu"
+static size_t sz_fmt(size_t s) { return s; }
 #endif
 
 const unsigned char null_sha1[20];
@@ -423,9 +425,9 @@ void pack_report(void)
 		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
-		(size_t) getpagesize(),
-		packed_git_window_size,
-		packed_git_limit);
+		sz_fmt(getpagesize()),
+		sz_fmt(packed_git_window_size),
+		sz_fmt(packed_git_limit));
 	fprintf(stderr,
 		"pack_report: pack_used_ctr            = %10u\n"
 		"pack_report: pack_mmap_calls          = %10u\n"
@@ -435,7 +437,7 @@ void pack_report(void)
 		pack_used_ctr,
 		pack_mmap_calls,
 		pack_open_windows, peak_pack_open_windows,
-		pack_mapped, peak_pack_mapped);
+		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
 }
 
 static int check_packed_git_idx(const char *path,  struct packed_git *p)
-- 
1.5.3.5.750.g8692
