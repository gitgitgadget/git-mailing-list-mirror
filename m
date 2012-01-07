From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Fix actionless dispatch for non-existent objects
Date: Sat, 07 Jan 2012 11:47:38 +0100
Message-ID: <20120107104552.26867.41282.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 11:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjToe-0004BD-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 11:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab2AGKry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 05:47:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53129 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab2AGKrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 05:47:53 -0500
Received: by eaad14 with SMTP id d14so1359352eaa.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=CsSaOhu3AFuK73062qvoWUI1Ot4hPPZ7qjBCmHc1ZAY=;
        b=oqRnTs3sYL01+rQwo1Eplvp0ulycKh82ij282sPDnTGTqohFA3iSDRoF/tCJK6mBiY
         JefDZ6zB8Oe4myh56n28ARnvGAaiJ4ArQ/gFgDL42GbfeWkmyvipoSExWNJo9z28/X9Q
         HGRMG16Tldd+3CfY99mjgVXJ8t42r7xMeMHRc=
Received: by 10.213.112.200 with SMTP id x8mr238092ebp.106.1325933272384;
        Sat, 07 Jan 2012 02:47:52 -0800 (PST)
Received: from localhost.localdomain (abvu192.neoplus.adsl.tpnet.pl. [83.8.218.192])
        by mx.google.com with ESMTPS id b49sm229256644eec.9.2012.01.07.02.47.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Jan 2012 02:47:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q07AldVg026917;
	Sat, 7 Jan 2012 11:47:47 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188067>

When gitweb URL does not provide action explicitly, e.g.

  http://git.example.org/repo.git/branch

dispatch() tries to guess action (view to be used) based on remaining
parameters.  Among others it is based on the type of requested object,
which gave problems when asking for non-existent branch or file (for
example misspelt name).

Now undefined $action from dispatch() should not result in problems.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm not sure if this is the way to fix it, by erroring-out in
dispatch() and leaving $action undefined.

Testsuite passes, but I have not examined output intensively.

 gitweb/gitweb.perl                     |    4 +++-
 t/t9500-gitweb-standalone-no-errors.sh |    8 ++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f884dfe..e2e04df 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1123,8 +1123,10 @@ sub dispatch {
 	if (!defined $action) {
 		if (defined $hash) {
 			$action = git_get_type($hash);
+			$action or die_error(404, "Object does not exist");
 		} elsif (defined $hash_base && defined $file_name) {
 			$action = git_get_type("$hash_base:$file_name");
+			$action or die_error(404, "File or directory does not exist");
 		} elsif (defined $project) {
 			$action = 'summary';
 		} else {
@@ -2391,7 +2393,7 @@ sub get_feed_info {
 	return unless (defined $project);
 	# some views should link to OPML, or to generic project feed,
 	# or don't have specific feed yet (so they should use generic)
-	return if ($action =~ /^(?:tags|heads|forks|tag|search)$/x);
+	return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
 
 	my $branch;
 	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index ab24917..0f771c6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -475,6 +475,14 @@ test_expect_success \
 	'gitweb_run "" "/.git/master:foo/"'
 
 test_expect_success \
+	'path_info: project/branch (non-existent)' \
+	'gitweb_run "" "/.git/non-existent"'
+
+test_expect_success \
+	'path_info: project/branch:filename (non-existent branch)' \
+	'gitweb_run "" "/.git/non-existent:non-existent"'
+
+test_expect_success \
 	'path_info: project/branch:file (non-existent)' \
 	'gitweb_run "" "/.git/master:non-existent"'
 
