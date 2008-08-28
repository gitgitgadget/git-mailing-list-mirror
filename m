From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix '--dirstat' with cross-directory renaming
Date: Thu, 28 Aug 2008 16:19:08 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808281608580.3300@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqmx-0000Kt-UJ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbYH1XTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbYH1XTX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:19:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36713 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872AbYH1XTX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 19:19:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7SNJ90f030220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 16:19:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7SNJ83n019657;
	Thu, 28 Aug 2008 16:19:08 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.433 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94205>


The dirstat code depends on the fact that we always generate diffs with 
the names sorted, since it then just does a single-pass walk-over of the 
sorted list of names and how many changes there were. The sorting means 
that all files are nicely grouped by directory.

That all works fine.

Except when we have rename detection, and suddenly the nicely sorted list 
of pathnames isn't all that sorted at all. And now the single-pass dirstat 
walk gets all confused, and you can get results like this:

  [torvalds@nehalem linux]$ git diff --dirstat=2 -M v2.6.27-rc4..v2.6.27-rc5
     3.0% arch/powerpc/configs/
     6.8% arch/arm/configs/
     2.7% arch/powerpc/configs/
     4.2% arch/arm/configs/
     5.6% arch/powerpc/configs/
     8.4% arch/arm/configs/
     5.5% arch/powerpc/configs/
    23.3% arch/arm/configs/
     8.6% arch/powerpc/configs/
     4.0% arch/
     4.4% drivers/usb/musb/
     4.0% drivers/watchdog/
     7.6% drivers/
     3.5% fs/

The trivial fix is to add a sorting pass, fixing it to:

  [torvalds@nehalem linux]$ git diff --dirstat=2 -M v2.6.27-rc4..v2.6.27-rc5
    43.0% arch/arm/configs/
    25.5% arch/powerpc/configs/
     5.3% arch/
     4.4% drivers/usb/musb/
     4.0% drivers/watchdog/
     7.6% drivers/
     3.5% fs/

Spot the difference. In case anybody wonders: it's because of a ton of 
renames from {include/asm-blackfin => arch/blackfin/include/asm} that just 
totally messed up the file ordering in between arch/arm and arch/powerpc.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 diff.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 18fa7a7..135dec4 100644
--- a/diff.c
+++ b/diff.c
@@ -1060,6 +1060,13 @@ static long gather_dirstat(FILE *file, struct dirstat_dir *dir, unsigned long ch
 	return this_dir;
 }
 
+static int dirstat_compare(const void *_a, const void *_b)
+{
+	const struct dirstat_file *a = _a;
+	const struct dirstat_file *b = _b;
+	return strcmp(a->name, b->name);
+}
+
 static void show_dirstat(struct diff_options *options)
 {
 	int i;
@@ -1119,6 +1126,7 @@ static void show_dirstat(struct diff_options *options)
 		return;
 
 	/* Show all directories with more than x% of the changes */
+	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
 	gather_dirstat(options->file, &dir, changed, "", 0);
 }
 
