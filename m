From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v2] test suite: add a check that all test numbers are unique
Date: Fri, 21 Aug 2009 15:13:23 +0200
Message-ID: <4A8E9D73.1090604@viscovery.net>
References: <4A8E68AF.8040001@viscovery.net> <20090821125324.GA6280@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 15:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeTw1-0000Fy-5T
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbZHUNN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbZHUNN1
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:13:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25885 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbZHUNN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:13:26 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MeTvn-00081Y-Sp; Fri, 21 Aug 2009 15:13:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 913669F88; Fri, 21 Aug 2009 15:13:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090821125324.GA6280@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126708>

Jeff King schrieb:
> Why not the much shorter:
> 
> tests() {
>   ls | sed -n 's/^\(t[0-9][0-9][0-9][0-9]\)-.*\.sh$/\1/p'
> }
> dups=`tests | uniq -d`
> 
> instead of the long shell loop?

Because it's faster on Windows ;-) No, seriously, I didn't know about
uniq -d.

Here is a replacement patch.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t/Makefile: add a check that all test numbers are unique

The test runs only if 'make all' is used. Its purpose is to alert our
valued integrator if different branches are merged that happen to
introduce the same test number.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index bd09390..ed8281a 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,10 @@ T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)

 all: pre-clean
+	@dups=`ls | sed -n 's/^\(t[0-9][0-9][0-9][0-9]\)-.*\.sh$$/\1/p' | \
+			uniq -d` && \
+		test -z "$$dups" || { \
+		echo "duplicate test numbers:" $$dups; exit 1; }
 	$(MAKE) aggregate-results-and-cleanup

 $(T):
-- 
1.6.4.204.g6aad7
