From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Show submodule entries in the 'tree' view
Date: Sat, 28 Jul 2007 16:27:31 +0200
Message-ID: <11856328523162-git-send-email-jnareb@gmail.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 16:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEnGz-00071f-HE
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 16:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXG1O1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 10:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbXG1O1o
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 10:27:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:42523 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbXG1O1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 10:27:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so836245ugf
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 07:27:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=BSW3knuw9TMN2c0gYQTf1oyEJvBYOKuAZK5Q5Xc7VnWUBYlecgKrVmluAhLmEBR1CmWhWyuGziUPMPZgO6sE/aDQrGjCR+1dyUIvydlApPdTcrFU4aq59azxBvoX/RnC4hvM48uE2ppQZ6qXEu//v2s8s0kNk3j9jx699vPscbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=cyrKfGzBiwCKJd0Gh/NYea8ckr/rHiQi7JlojYVw1g9dU6AF9a+QlC0dzvqevBhQKoqobHmbYGQa8tp3xyEg+9Uk1mUMw8Moq4ELh0i8XwYar/3IbBMgDIqclq8yeO1lzCL4Ri+5hYotifWs5LEiDLdBu5A4lEhzVbs8JQbEuoA=
Received: by 10.67.101.10 with SMTP id d10mr3748490ugm.1185632861686;
        Sat, 28 Jul 2007 07:27:41 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id z37sm1664562ikz.2007.07.28.07.27.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2007 07:27:40 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6SERaK9023421;
	Sat, 28 Jul 2007 16:27:37 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6SERWew023420;
	Sat, 28 Jul 2007 16:27:32 +0200
X-Mailer: git-send-email 1.5.3.rc3.14.g0bd7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54035>

Add S_ISGITLINK subroutine and S_IFGITLINK, S_IFINVALID constants.
Add support for "commit" (submodule) entries in the tree object to
mode_str ('m---------', following cgit), file_type and file_type_long
('submodule') subroutines.

There is only link to the history of submodule entry in the
supermodule (current repository) for now, because gitweb doesn't know
where to search for submodule repository objects.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Tested on repositories from t/t3040-subprojects-basic.sh and
t/t7400-submodule-basic.sh tests.

The 'm---------' symbolic mode is taken from cgit, C CGI web interface
for git; see:
  http://hjemli.net/git/cgit/tree

The S_ISGITLINK subroutine and S_IFGITLINK, S_IFINVALID constants
are taken from cache.h

 gitweb/gitweb.perl |   38 +++++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b381692..1aceede 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -890,11 +890,25 @@ sub age_string {
 	return $age_str;
 }
 
+use constant {
+	S_IFINVALID => 0030000,
+	S_IFGITLINK => 0160000,
+};
+
+# submodule/subproject, a commit object reference
+sub S_ISGITLINK($) {
+	my $mode = shift;
+
+	return (($mode & S_IFMT) == S_IFGITLINK)
+}
+
 # convert file mode in octal to symbolic file mode string
 sub mode_str {
 	my $mode = oct shift;
 
-	if (S_ISDIR($mode & S_IFMT)) {
+	if (S_ISGITLINK($mode)) {
+		return 'm---------';
+	} elsif (S_ISDIR($mode & S_IFMT)) {
 		return 'drwxr-xr-x';
 	} elsif (S_ISLNK($mode)) {
 		return 'lrwxrwxrwx';
@@ -920,7 +934,9 @@ sub file_type {
 		$mode = oct $mode;
 	}
 
-	if (S_ISDIR($mode & S_IFMT)) {
+	if (S_ISGITLINK($mode)) {
+		return "submodule";
+	} elsif (S_ISDIR($mode & S_IFMT)) {
 		return "directory";
 	} elsif (S_ISLNK($mode)) {
 		return "symlink";
@@ -941,7 +957,9 @@ sub file_type_long {
 		$mode = oct $mode;
 	}
 
-	if (S_ISDIR($mode & S_IFMT)) {
+	if (S_ISGITLINK($mode)) {
+		return "submodule";
+	} elsif (S_ISDIR($mode & S_IFMT)) {
 		return "directory";
 	} elsif (S_ISLNK($mode)) {
 		return "symlink";
@@ -2707,6 +2725,20 @@ sub git_print_tree_entry {
 			              "history");
 		}
 		print "</td>\n";
+	} else {
+		# unknown object: we can only present history for it
+		# (this includes 'commit' object, i.e. submodule support)
+		print "<td class=\"list\">" .
+		      esc_path($t->{'name'}) .
+		      "</td>\n";
+		print "<td class=\"link\">";
+		if (defined $hash_base) {
+			print $cgi->a({-href => href(action=>"history",
+			                             hash_base=>$hash_base,
+			                             file_name=>"$basedir$t->{'name'}")},
+			              "history");
+		}
+		print "</td>\n";
 	}
 }
 
-- 
1.5.2.4
