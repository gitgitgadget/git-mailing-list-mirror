From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 2/2] for-each-ref: Fix sort with multiple keys
Date: Sun, 19 Aug 2012 23:15:44 +0200
Message-ID: <2b3624458d79a1ec0b1437172437fbd78b3a0537.1345410836.git.draenog@pld-linux.org>
References: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:45:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3DJ5-0006fF-36
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 23:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab2HSVpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 17:45:11 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:43238 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab2HSVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 17:45:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 431D15F004B
	for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:16:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id onWsXII4qTAZ for <git@vger.kernel.org>;
	Sun, 19 Aug 2012 23:16:45 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id D564A5F0047
	for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:16:45 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 444E846743; Sun, 19 Aug 2012 23:15:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203737>

The linked list describing sort options was not correctly set up in
opt_parse_sort. In the result, contrary to the documentation. only the
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
index 3d59bfc..4c5d8ba 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -260,7 +260,7 @@ cat >expected <<\EOF
 32fca05e9f638021a123a84226acf17756acc18b commit	refs/heads/Branch1
 EOF
 
-test_expect_failure 'Verify sort with multiple keys' '
+test_expect_success 'Verify sort with multiple keys' '
 	git for-each-ref --sort=objectname --sort=committerdate refs/heads > actual &&
 	test_cmp expected actual
 '
-- 
1.7.12.rc3
