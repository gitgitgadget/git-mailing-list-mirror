From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCHv2 2/2] for-each-ref: Fix sort with multiple keys
Date: Tue, 21 Aug 2012 09:47:26 +0200
Message-ID: <fb5ad43b1c1ed627412ea6695875c66d6454cc0e.1345534654.git.draenog@pld-linux.org>
References: <91678e1e50f23bdb2c3b2c5716f92d870a233e77.1345534654.git.draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 09:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3jBo-0007HW-1B
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 09:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab2HUHrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 03:47:47 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34384 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab2HUHrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 03:47:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 4B2CD5F0047;
	Tue, 21 Aug 2012 09:48:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TyDXhxgL94WO; Tue, 21 Aug 2012 09:48:28 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 3C4045F0048;
	Tue, 21 Aug 2012 09:48:28 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id CE7AE46745; Tue, 21 Aug 2012 09:47:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <91678e1e50f23bdb2c3b2c5716f92d870a233e77.1345534654.git.draenog@pld-linux.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203951>

The linked list describing sort options was not correctly set up in
opt_parse_sort. In the result, contrary to the documentation, only the
last of multiple --sort options to git-for-each-ref was taken into
account. This commit fixes it.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 builtin/for-each-ref.c  | 4 +++-
 t/t6300-for-each-ref.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b01d76a..0c5294e 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -962,7 +962,9 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 	if (!arg) /* should --no-sort void the list ? */
 		return -1;
 
-	*sort_tail = s = xcalloc(1, sizeof(*s));
+	s = xcalloc(1, sizeof(*s));
+	s->next = *sort_tail;
+	*sort_tail = s;
 
 	if (*arg == '-') {
 		s->reverse = 1;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a0d82d4..752f5cb 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -461,7 +461,7 @@ cat >expected <<\EOF
 90b5ebede4899eda64893bc2a4c8f1d6fb6dfc40 <committer@example.com> refs/tags/bogo
 EOF
 
-test_expect_failure 'Verify sort with multiple keys' '
+test_expect_success 'Verify sort with multiple keys' '
 	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
-- 
1.7.12.rc3
