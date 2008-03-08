From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Sat, 08 Mar 2008 17:57:20 +0100
Message-ID: <20080308165245.15343.62914.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 17:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY2N0-00020A-Av
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 17:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYCHQ5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 11:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbYCHQ5X
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 11:57:23 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:59013 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYCHQ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 11:57:22 -0500
Received: by py-out-1112.google.com with SMTP id u52so1633327pyb.10
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=NtwE4mEyGndZYGn6lT0VSqQUzEhjSS/JPi2JtGBRnFs=;
        b=kyz54ICJNpgCH6zG1U2qbledsTmf0pPZSytAlJDoNOECCv83PToihgl9HyynkK5UXJgzuqYXvxxrELdTmEtR+EKjNf2XOvPuq1iY344m9TcLtQcLkNvUawyFojDUApdkBK6cuOb5N4nHjTutc48/a70Kp+EW42BbEmqjgquCSHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=BOADACeIYcr7xX/M5+7XhlZiPtPhInVvheyzwqZHBXgwacMyhlkq+TO6t4wGHrsqkFCiLUayNNLTdHi1yBofFAn7LljkQ32lith2HyDFQb4c5faII2pNUR8pZPVsDJXokZcbbrpRDdAxnVMdUqKMlWw549T5JfNOtIBDWxgHo7o=
Received: by 10.64.193.2 with SMTP id q2mr4547023qbf.13.1204995439484;
        Sat, 08 Mar 2008 08:57:19 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.176])
        by mx.google.com with ESMTPS id 25sm6937179ugn.23.2008.03.08.08.57.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 08:57:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m28GvKj7015420
	for <git@vger.kernel.org>; Sat, 8 Mar 2008 17:57:22 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76566>

Add output_pipeline subroutine, which allows to use list form of
pipeline; instead of
  open my $fh, "-|", "cmd_1 option | cmd_2 argument"
we can now write
  my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
which allows to avoid troubles with shell quoting, and avoid spawning
shell.  Code is based on snippet http://www.perlmonks.org/?node_id=246397
simplified a bit.

It is then used in git_snapshot subroutine, where we sometimes open
pipeline from git-archive to compressor.

While at it, ensure that snapshot saved as <basename>.<suffix>
uncompresses to <basename>/

NOTE: this commit prepares way for adding syntax highlighting support
using external filter (external tool), like GNU Source-highlight or
Andre Simon's Highlight.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is an RFC, and doesn't really meant to be applied.
I'd like opinion on this code from resident Perl experts.  It
should work, though; it was rudimentarly tested.

 gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a5df2fe..ba97a7b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1455,6 +1455,35 @@ sub git_cmd_str {
 	return join(' ', git_cmd());
 }
 
+# my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
+# is equivalent to (is the "list form" of) the following
+# open my $fh, "-|", "cmd_1 option | cmd_2 argument"
+#
+# Based on http://www.perlmonks.org/?node_id=246397
+#
+sub output_pipeline {
+	my @commands_list = @_;
+	exit unless @commands_list;
+
+	my $pid = open(my $fh, "-|");
+	#die "Couldn't fork: $!" unless defined $pid;
+
+	if ($pid) { # parent
+		return $fh;
+	}
+
+	# child
+ COMMAND:
+	while (my $command = pop @commands_list) {
+		my $pid = @commands_list ? open(STDIN, "-|") : -1;
+		#die "Couldn't fork: $!" unless defined $pid;
+
+		next COMMAND unless ($pid); # parent
+		exec @$command;             # child
+		#die "Couldn't exec \"@$command\": $!";
+	}
+}
+
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
 	my $project = shift;
@@ -4545,27 +4574,26 @@ sub git_snapshot {
 		$hash = git_get_head_hash($project);
 	}
 
-	my $git_command = git_cmd_str();
 	my $name = $project;
-	$name =~ s,([^/])/*\.git$,$1,;
+	$name =~ s,([^/])/*\.git$,$1,; # strip '.git' or '/.git'
 	$name = basename($name);
-	my $filename = to_utf8($name);
-	$name =~ s/\047/\047\\\047\047/g;
-	my $cmd;
-	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
-	$cmd = "$git_command archive " .
-		"--format=$known_snapshot_formats{$format}{'format'} " .
-		"--prefix=\'$name\'/ $hash";
+	$name = to_utf8($name);  # or only for filename, not prefix?
+	$name .= "-$hash";
+
+	my @cmds = ([git_cmd(), "archive",
+		"--format=$known_snapshot_formats{$format}{'format'}",
+		"--prefix=$name/", $hash]);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
-		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
+		push @cmds, $known_snapshot_formats{$format}{'compressor'};
 	}
 
 	print $cgi->header(
 		-type => $known_snapshot_formats{$format}{'type'},
-		-content_disposition => 'inline; filename="' . "$filename" . '"',
+		-content_disposition => 'inline; filename="' .
+			"$filename$known_snapshot_formats{$format}{'suffix'}" . '"',
 		-status => '200 OK');
 
-	open my $fd, "-|", $cmd
+	my $fd = output_pipeline(@cmds)
 		or die_error(undef, "Execute git-archive failed");
 	binmode STDOUT, ':raw';
 	print <$fd>;

