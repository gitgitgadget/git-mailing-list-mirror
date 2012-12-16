From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 3/3] Makefile: use -Wdeclaration-after-statement if supported
Date: Sun, 16 Dec 2012 19:36:01 +0000
Message-ID: <1355686561-1057-4-git-send-email-git@adamspiers.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkK0s-0000fB-It
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab2LPTgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:36:06 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41240 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab2LPTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:36:04 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 0B7582E663
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 19:36:04 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355686561-1057-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211607>

CodingGuidelines requests that code should be nice to older C compilers.
Since modern gcc can warn on code written using newer dialects such as C99,
it makes sense to take advantage of this by auto-detecting this capability
and enabling it when found.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
If we adopt this approach, it may make sense to enable other flags
where available (e.g. -Wzero-as-null-pointer-constant, maybe even
-ansi).  In that case, something like this might be a more efficient
way of writing it:

    GCC_FLAGS=-Wdeclaration-after-statement,-Wanother-flag,-Wand-another
    GCC_FLAGS_REGEXP=$(shell echo $(GCC_FLAGS) | sed 's/,/\\|/g')
    GCC_SUPPORTED_FLAGS=$(shell cc --help -v 2>&1 | \
            sed -n '/.* \($(GCC_FLAGS_REGEXP)\) .*/{s//\1/;p}')

 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a49d1db..aae70d4 100644
--- a/Makefile
+++ b/Makefile
@@ -331,8 +331,13 @@ endif
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
+GCC_DECL_AFTER_STATEMENT = \
+	$(shell $(CC) --help -v 2>&1 | \
+		grep -q -- -Wdeclaration-after-statement && \
+	  echo -Wdeclaration-after-statement)
+GCC_FLAGS = $(GCC_DECL_AFTER_STATEMENT)
+ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS) $(GCC_FLAGS)
 LDFLAGS =
-ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
-- 
1.7.12.1.396.g53b3ea9
