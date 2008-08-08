From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] tests: Clarify dependencies between tests, 'aggregate-results'
 and 'clean'
Date: Fri, 8 Aug 2008 07:59:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808080753500.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 07:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRKxE-0000ND-8s
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 07:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYHHFyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 01:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYHHFyq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 01:54:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752408AbYHHFyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 01:54:45 -0400
Received: (qmail invoked by alias); 08 Aug 2008 05:54:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 08 Aug 2008 07:54:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L4E05HvoLKJ+Rgng8aKrcoT2XJtxJRbk+Zs5YI+
	Xxhd1vgKMN4teg
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91623>


The Makefile targets 'aggregate-results' and 'clean' pretended to be
independent.  This is not true, of course, since aggregate-results
needs the results _before_ they are removed.

Likewise, the tests should have been run already when the results are
to be aggregated.

However, as it is legitimate to run only a few tests, and then aggregate
just those results, so another target is introduced, that depends on all
tests, then aggregates the results, and only then removes the results.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 0d65ced..aa952e1 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -14,7 +14,8 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
-all: pre-clean $(T) aggregate-results clean
+all: pre-clean
+	$(MAKE) aggregate-results-and-cleanup
 
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
@@ -25,6 +26,10 @@ pre-clean:
 clean:
 	$(RM) -r 'trash directory' test-results
 
+aggregate-results-and-cleanup: $(T)
+	$(MAKE) aggregate-results
+	$(MAKE) clean
+
 aggregate-results:
 	'$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*
 
-- 
1.6.0.rc2.23.gd08e9
