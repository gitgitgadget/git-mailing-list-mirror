From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (bugfix)] gitweb: Fix 'grep' search for multiple matches in
	file
Date: Wed, 15 Feb 2012 17:37:06 +0100
Message-ID: <20120215163410.26917.84863.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 17:37:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxhr8-0006l7-9h
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 17:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab2BOQhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 11:37:17 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43616 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab2BOQhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 11:37:10 -0500
Received: by eaah12 with SMTP id h12so414265eaa.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 08:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=RBdlQn9rxb9qYAlTAmZppEdoSTwO8Mi+sFVrqFuH7cw=;
        b=PT5V0U6Ofkd5kq7E+x7jdJ2Z9RmbtwQOPeSx2EHmkPdfa2EBDnt1R9NP0qKakOiNWr
         trg3wsZw4emexx7hYhz4LV/uFMth9qkHae4sJKOhCvKNMYxS8wAtZinT9m2EHJO3Pq2y
         gavUZudlnsovOlMORjmUJQP0ZIeM5KxrN3CeA=
Received: by 10.213.112.200 with SMTP id x8mr332985ebp.37.1329323829205;
        Wed, 15 Feb 2012 08:37:09 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id o49sm12732403eeb.7.2012.02.15.08.37.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 08:37:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1FGb6vQ026993;
	Wed, 15 Feb 2012 17:37:07 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190837>

Commit ff7f218 (gitweb: Fix file links in "grep" search, 2012-01-05),
added $file_href variable, to reduce duplication and have the fix
applied in single place.

Unfortunately it made variable defined inside the loop, not taking into
account the fact that $file_href was set only if file changed.
Therefore for files with multiple matches $file_href was undefined for
second and subsequent matches.

Fix this bug by moving $file_href declaration outside loop.


Adds tests for almost all forms of sarch in gitweb, which were missing
from testuite.  Note that it only tests if there are no warnings, and
it doesn't check that gitweb finds what it should find.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Commit ff7f218 is in v1.7.9

 gitweb/gitweb.perl                     |    3 ++
 t/t9500-gitweb-standalone-no-errors.sh |   39 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4932f4b..a2e2023 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6040,9 +6040,10 @@ sub git_search_files {
 	my $alternate = 1;
 	my $matches = 0;
 	my $lastfile = '';
+	my $file_href;
 	while (my $line = <$fd>) {
 		chomp $line;
-		my ($file, $file_href, $lno, $ltext, $binary);
+		my ($file, $lno, $ltext, $binary);
 		last if ($matches++ > 1000);
 		if ($line =~ /^Binary file (.+) matches$/) {
 			$file = $1;
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 81246a6..90bb605 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -638,6 +638,45 @@ test_expect_success \
 	'gitweb_run "p=.git;a=tree"'
 
 # ----------------------------------------------------------------------
+# searching
+
+cat >>gitweb_config.perl <<\EOF
+
+# enable search
+$feature{'search'}{'default'} = [1];
+$feature{'grep'}{'default'} = [1];
+$feature{'pickaxe'}{'default'} = [1];
+EOF
+
+test_expect_success \
+	'search: preparation' \
+	'echo "1st MATCH" >>file &&
+	 echo "2nd MATCH" >>file &&
+	 echo "MATCH" >>bar &&
+	 git add file bar &&
+	 git commit -m "Added MATCH word"'
+
+test_expect_success \
+	'search: commit author' \
+	'gitweb_run "p=.git;a=search;h=HEAD;st=author;s=A+U+Thor"'
+
+test_expect_success \
+	'search: commit message' \
+	'gitweb_run "p=.git;a=search;h=HEAD;st=commitr;s=MATCH"'
+
+test_expect_success \
+	'search: grep' \
+	'gitweb_run "p=.git;a=search;h=HEAD;st=grep;s=MATCH"'
+
+test_expect_success \
+	'search: pickaxe' \
+	'gitweb_run "p=.git;a=search;h=HEAD;st=pickaxe;s=MATCH"'
+
+test_expect_success \
+	'search: projects' \
+	'gitweb_run "a=project_list;s=.git"'
+
+# ----------------------------------------------------------------------
 # non-ASCII in README.html
 
 test_expect_success \
