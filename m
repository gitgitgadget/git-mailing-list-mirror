From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/4] contrib/git-svn: ensure repo-config returns a value before using it
Date: Mon, 03 Apr 2006 15:18:48 -0700
Message-ID: <11441027292908-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 04 00:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXOf-0002qQ-Qp
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWDCWTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWDCWTf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:19:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:237 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751809AbWDCWTf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:19:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D72072DC01A;
	Mon,  3 Apr 2006 15:19:34 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email 1.3.0.rc1.g595e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18355>

fetching from repos without an authors-file defined was broken.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

029626bf987cff7ba42d8158c687cf4902765968
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index edfb19c..e7fff46 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -77,10 +77,13 @@ foreach my $o (keys %opts) {
 	$arg .= ' --bool' if ($o !~ /=[sfi]$/);
 	$arg .= " svn.$key"; # $key only matches [a-z\-], always shell-safe
 	if (ref $v eq 'ARRAY') {
-		chomp(@$v = `$arg`);
+		chomp(my @tmp = `$arg`);
+		@$v = @tmp if @tmp;
 	} else {
-		chomp($$v = `$arg`);
-		$$v = 0 if $$v eq 'false';
+		chomp(my $tmp = `$arg`);
+		if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
+			$$v = $tmp;
+		}
 	}
 }
 
-- 
1.3.0.rc1.g595e
