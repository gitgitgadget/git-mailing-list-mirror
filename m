From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitweb.perl - Optionally send archives as .zip files
Date: Sun, 20 May 2007 11:46:46 -0400
Message-ID: <11796760064103-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 17:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpncu-0001cU-KO
	for gcvg-git@gmane.org; Sun, 20 May 2007 17:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545AbXETPrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 11:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756770AbXETPrP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 11:47:15 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:46681 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbXETPrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 11:47:14 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.225])
 by vms046.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JIC00EM6JTZWDO2@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 20 May 2007 10:46:48 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.rc3.95.gb3c7e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47846>

git-archive already knows how to generate an archive as a tar or a zip
file, but gitweb did not. zip archvies are much more usable in a Windows
environment due to native support and this patch allows a site admin the
option to deliver zip rather than tar files. The selection is done by
inserting

$feature{'snapshot'}{'default'} = ['x-zip', 'zip', ''];

in gitweb_config.perl.

Tar files remain the default option.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitweb/gitweb.perl |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 21864c6..273cad2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -129,7 +129,7 @@ our %feature = (
 	# $feature{'snapshot'}{'default'} = [undef];
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'snapshot'}{'override'} = 1;
-	# and in project config gitweb.snapshot = none|gzip|bzip2;
+	# and in project config gitweb.snapshot = none|gzip|bzip2|zip;
 	'snapshot' => {
 		'sub' => \&feature_snapshot,
 		'override' => 0,
@@ -227,6 +227,8 @@ sub feature_snapshot {
 		return ('x-gzip', 'gz', 'gzip');
 	} elsif ($val eq 'bzip2') {
 		return ('x-bzip2', 'bz2', 'bzip2');
+	} elsif ($val eq 'zip') {
+		return ('x-zip', 'zip', '');
 	} elsif ($val eq 'none') {
 		return ();
 	}
@@ -3912,19 +3914,26 @@ sub git_snapshot {
 		$hash = git_get_head_hash($project);
 	}

-	my $filename = decode_utf8(basename($project)) . "-$hash.tar.$suffix";
+	my $git = git_cmd_str();
+	my $name = $project;
+	$name =~ s/\047/\047\\\047\047/g;
+	my $filename = decode_utf8(basename($project));
+	my $cmd;
+	if ($suffix eq 'zip') {
+		$filename .= "-$hash.$suffix";
+		$cmd = "$git archive --format=zip --prefix=\'$name\'/ $hash";
+	} else {
+		$filename .= "-$hash.tar.$suffix";
+		$cmd = "$git archive --format=tar --prefix=\'$name\'/ $hash | $command";
+	}

 	print $cgi->header(
 		-type => "application/$ctype",
 		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');

-	my $git = git_cmd_str();
-	my $name = $project;
-	$name =~ s/\047/\047\\\047\047/g;
-	open my $fd, "-|",
-		"$git archive --format=tar --prefix=\'$name\'/ $hash | $command"
-		or die_error(undef, "Execute git-tar-tree failed");
+	open my $fd, "-|", $cmd
+		or die_error(undef, "Execute git-archive failed");
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
--
1.5.2.rc3.95.gb3c7e
