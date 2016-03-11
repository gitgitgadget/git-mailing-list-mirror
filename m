From: Jim Klimov <jim@jimklimov.com>
Subject: [PATCH 1/6] gitweb.perl : added ability to "git archive" just certain
 paths (files or subdirs, not whole repo) via gitweb interface
Date: Fri, 11 Mar 2016 14:24:44 +0100
Message-ID: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
Content-Transfer-Encoding: 7BIT
Cc: Jim Klimov <jim@jimklimov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9R-0000v6-1u
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbcCKNai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:38 -0500
Received: from relay-mta.cos.ru ([93.175.31.8]:43370 "EHLO relay-mta.cos.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbcCKNad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:33 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 08:30:25 EST
Received: from sunmail.cos.ru (mail.cos.ru [81.5.113.73])
	by relay-mta.cos.ru (8.14.3+Sun/8.14.3) with ESMTP id u2BDOxJj025365
	for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:25:06 +0300 (MSK)
Received: from debian8.roz.lab.etn.com. ([31.7.243.238])
 by sunmail.cos.ru (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26
 2008; 64bit)) with ESMTPA id <0O3V0013IMPRKC00@sunmail.cos.ru> for
 git@vger.kernel.org; Fri, 11 Mar 2016 16:27:31 +0300 (MSK)
X-Mailer: git-send-email 2.8.0.rc1.4.ge2bf47e.dirty
X-Greylist-Inspected: inspected by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:06 +0300 (MSK) for IP:'81.5.113.73' DOMAIN:'mail.cos.ru' HELO:'sunmail.cos.ru' FROM:'jim@jimklimov.com'
X-Greylist: Sender IP whitelisted, ACL 386 matched, not delayed by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:06 +0300 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288683>

---
 gitweb/gitweb.perl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05d7910..030d429 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7328,6 +7328,15 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
+	if (!defined($hash)) {
+		$hash="";
+		if ( $file_name && $file_name =~ /^([^:]*):(.*)$/ ) {
+			$hash = "$1";
+			$file_name = "$2";
+		}
+		if ( $hash eq "") { $hash = "HEAD"; }
+		printf STDERR "Defaulted hash to '$hash' ('h=' URL argument was missing)\n";
+	}
 	my $type = git_get_type("$hash^{}");
 	if (!$type) {
 		die_error(404, 'Object does not exist');
@@ -7345,6 +7354,14 @@ sub git_snapshot {
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
 		"--prefix=$prefix/", $hash);
+	if ($file_name) {
+		# To fetch several pathnames use space-separation, e.g.
+		# "...git-web?p=proj.git;a=snapshot;f=file1%20file2
+		# To fetch pathnames with spaces, escape them, e.g.
+		# "...git-web?p=proj.git;a=snapshot;f=file\%20name
+		$cmd .= " " . $file_name;
+	}
+
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
-- 
2.1.4
