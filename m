From: Jim Klimov <jim@jimklimov.com>
Subject: [PATCH 3/6] gitweb.perl : added ability to DEBUG progression through
 "git archive"
Date: Fri, 11 Mar 2016 14:24:46 +0100
Message-ID: <1457702689-9084-3-git-send-email-jim@jimklimov.com>
References: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
Content-Transfer-Encoding: 7BIT
Cc: Jim Klimov <jim@jimklimov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9T-0000v6-CC
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbcCKNan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:43 -0500
Received: from relay-mtc.cos.ru ([81.5.113.8]:54710 "EHLO relay-mtc.cos.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbcCKNaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:35 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 08:30:29 EST
Received: from sunmail.cos.ru (mail.cos.ru [81.5.113.73])
	by relay-mta.cos.ru (8.14.3+Sun/8.14.3) with ESMTP id u2BDOxJn025365
	for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:25:06 +0300 (MSK)
Received: from debian8.roz.lab.etn.com. ([31.7.243.238])
 by sunmail.cos.ru (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26
 2008; 64bit)) with ESMTPA id <0O3V0013IMPRKC00@sunmail.cos.ru> for
 git@vger.kernel.org; Fri, 11 Mar 2016 16:27:34 +0300 (MSK)
X-Mailer: git-send-email 2.8.0.rc1.4.ge2bf47e.dirty
In-reply-to: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
X-Greylist-Inspected: inspected by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:07 +0300 (MSK) for IP:'81.5.113.73' DOMAIN:'mail.cos.ru' HELO:'sunmail.cos.ru' FROM:'jim@jimklimov.com'
X-Greylist: Sender IP whitelisted, ACL 386 matched, not delayed by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:07 +0300 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288684>

---
 gitweb/gitweb.perl | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c715472..fc5b62d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -891,6 +891,7 @@ sub evaluate_query_params {
 # now read PATH_INFO and update the parameter list for missing parameters
 sub evaluate_path_info {
 	return if defined $input_params{'project'};
+	printf STDERR "path_info='$path_info'\n" if $DEBUG;
 	return if !$path_info;
 	$path_info =~ s,^/+,,;
 	return if !$path_info;
@@ -7336,6 +7337,24 @@ sub git_snapshot {
 	if (!@snapshot_fmts) {
 		die_error(403, "Snapshots not allowed");
 	}
+
+	if ($DEBUG) {
+		my $v; my $i;
+		printf STDERR "path_info='".$path_info."'\n";
+		printf STDERR "input_params: { ";
+		foreach $i (keys (%input_params)) {
+			$v = $input_params{$i};
+			if (defined ($v)) {
+				if ($i eq "extra_options" ) {
+					printf STDERR "  '$i' => [".@{$v}."] ; ";
+				} else {
+				printf STDERR "  '$i' => '$v' ; ";
+				}
+			}
+		}
+		printf STDERR "} \n";
+	}
+
 	# default to first supported snapshot format
 	$format ||= $snapshot_fmts[0];
 	if ($format !~ m/^[a-z0-9]+$/) {
@@ -7367,6 +7386,13 @@ sub git_snapshot {
 	my ($name, $prefix) = snapshot_name($project, $hash);
 	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
 
+	if ($DEBUG) {
+		# name of the tarball to generate
+		if (defined $filename)  { printf STDERR "filename='$filename'\n"; }
+		# value of the 'f=' URL parameter
+		if (defined $file_name) { printf STDERR "file_name='$file_name'\n"; }
+	}
+
 	my %co = parse_commit($hash);
 	exit_if_unmodified_since($co{'committer_epoch'}) if %co;
 
@@ -7398,12 +7424,15 @@ sub git_snapshot {
 		%co ? (-last_modified => $latest_date{'rfc2822'}) : (),
 		-status => '200 OK');
 
+	printf STDERR "Starting git-archive: $cmd\n" if $DEBUG;
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
+	printf STDERR "Started git-archive...\n" if $DEBUG;
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
+	printf STDERR "Finished posting output of git-archive...\n" if $DEBUG;
 }
 
 sub git_log_generic {
-- 
2.1.4
