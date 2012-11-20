From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH] git-send-email: don't return undefined value in extract_valid_address()
Date: Tue, 20 Nov 2012 13:20:53 +0100
Message-ID: <1353414053-25261-1-git-send-email-krzysiek@podlesie.net>
Cc: Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 13:22:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tamq3-00066p-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 13:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab2KTMVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 07:21:49 -0500
Received: from [93.179.225.50] ([93.179.225.50]:50046 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab2KTMVs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 07:21:48 -0500
Received: from geronimo.kss.ia.polsl.pl (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 4E2C0632;
	Tue, 20 Nov 2012 13:21:46 +0100 (CET)
X-Mailer: git-send-email 1.8.0.283.gc57d856
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210098>

In the fallback check, when Email::Valid is not available, the
extract_valid_address() does not check for success of matching regex,
and $1, which can be undefined, is always returned. Now if match
fails an empty string is returned.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
This fixes following warnings:
Use of uninitialized value in string eq at ./git-send-email.perl line 1017.
Use of uninitialized value in quotemeta at ./git-send-email.perl line 1017.
W: unable to extract a valid address from: x a.patch

when invalid email address was added by --cc-cmd,
./git-send-email.perl --dry-run --to a@podlesie.net --cc-cmd=echo x a.patch

 git-send-email.perl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a7c29d..045f25f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -831,12 +831,12 @@ sub extract_valid_address {
 	$address =~ s/^\s*<(.*)>\s*$/$1/;
 	if ($have_email_valid) {
 		return scalar Email::Valid->address($address);
-	} else {
-		# less robust/correct than the monster regexp in Email::Valid,
-		# but still does a 99% job, and one less dependency
-		$address =~ /($local_part_regexp\@$domain_regexp)/;
-		return $1;
 	}
+
+	# less robust/correct than the monster regexp in Email::Valid,
+	# but still does a 99% job, and one less dependency
+	return $1 if $address =~ /($local_part_regexp\@$domain_regexp)/;
+	return "";
 }
 
 # Usually don't need to change anything below here.
-- 
1.8.0.283.gc57d856
