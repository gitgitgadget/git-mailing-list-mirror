From: Aleksey Vasenev <margtu-fivt@ya.ru>
Subject: [PATCH] git-svn: Support svn:global-ignores property
Date: Thu, 21 Nov 2013 16:28:28 +0400
Message-ID: <1385036908-10392-1-git-send-email-margtu-fivt@ya.ru>
References: <528DE354.1050804@ya.ru>
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Aleksey Vasenev <margtu-fivt@ya.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 13:35:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjTTn-0000oo-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 13:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab3KUMf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 07:35:27 -0500
Received: from forward9l.mail.yandex.net ([84.201.143.142]:60586 "EHLO
	forward9l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab3KUMf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 07:35:27 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2013 07:35:26 EST
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward9l.mail.yandex.net (Yandex) with ESMTP id A7731E610F6;
	Thu, 21 Nov 2013 16:28:53 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 50C501E074F;
	Thu, 21 Nov 2013 16:28:53 +0400 (MSK)
Received: from atlas252-147.me12.ru (atlas252-147.me12.ru [91.210.252.147])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id pMCX7DDZiZ-SqDe1PIS;
	Thu, 21 Nov 2013 16:28:52 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1385036932;
	bh=ez7SfEx9+XO1psXlyiY6kM28y/MmC85Cuazns1MFL68=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=oi2swxPM8hUVRajLBEa7ZitnmvreNTF4Vd+iLKaR/ylYtJb038GRLV379GrRC1XHg
	 mjAIqoAOMeuyrTvVKelihkWZSm1zAwBWwCArKIZAC9GYvRrR02entvoCtYgs02re6O
	 9xYCZPqMdACOBfhbdBlCoeSP0pZcY5T05+odMbzs=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@ya.ru
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <528DE354.1050804@ya.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238121>

---
 Documentation/git-svn.txt | 12 ++++++------
 git-svn.perl              | 46 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 30c5ee2..0c1cd46 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -405,14 +405,14 @@ Any other arguments are passed directly to 'git log'
 	independently of 'git svn' functions.
 
 'create-ignore'::
-	Recursively finds the svn:ignore property on directories and
-	creates matching .gitignore files. The resulting files are staged to
-	be committed, but are not committed. Use -r/--revision to refer to a
-	specific revision.
+	Recursively finds svn:ignore and svn:global-ignores properties on
+	directories and creates matching .gitignore files. The resulting
+	files are staged to be committed, but are not committed.
+	Use -r/--revision to refer to a specific revision.
 
 'show-ignore'::
-	Recursively finds and lists the svn:ignore property on
-	directories.  The output is suitable for appending to
+	Recursively finds and lists svn:ignore and svn:global-ignores
+	properties on directories. The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
 'mkdirs'::
diff --git a/git-svn.perl b/git-svn.perl
index 7349ffe..a2565e1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1261,6 +1261,15 @@ sub cmd_rebase {
 	}
 }
 
+sub get_svn_ignore {
+	my ($props, $prop) = @_;
+	my $s = $props->{$prop} or return;
+	$s =~ s/[\r\n]+/\n/g;
+	$s =~ s/^\n+//;
+	chomp $s;
+	return $s;
+}
+
 sub cmd_show_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
@@ -1268,12 +1277,17 @@ sub cmd_show_ignore {
 	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
-		my $s = $props->{'svn:ignore'} or return;
-		$s =~ s/[\r\n]+/\n/g;
-		$s =~ s/^\n+//;
-		chomp $s;
-		$s =~ s#^#$path#gm;
-		print STDOUT "$s\n";
+		my $s = &get_svn_ignore($props, 'svn:ignore');
+		my $s_global = &get_svn_ignore($props, 'svn:global-ignores');
+		$s or $s_global or return;
+		if ($s) {
+			$s =~ s#^#$path#gm;
+			print STDOUT "$s\n";
+		}
+		if ($s_global) {
+			$s_global =~ s#^#$path**/#gm;
+			print STDOUT "$s_global\n";
+		}
 	});
 }
 
@@ -1304,16 +1318,20 @@ sub cmd_create_ignore {
 		# which git won't track
 		mkpath([$path]) unless -d $path;
 		my $ignore = $path . '.gitignore';
-		my $s = $props->{'svn:ignore'} or return;
+		my $s = &get_svn_ignore($props, 'svn:ignore');
+		my $s_global = &get_svn_ignore($props, 'svn:global-ignores');
+		$s or $s_global or return;
 		open(GITIGNORE, '>', $ignore)
 		  or fatal("Failed to open `$ignore' for writing: $!");
-		$s =~ s/[\r\n]+/\n/g;
-		$s =~ s/^\n+//;
-		chomp $s;
-		# Prefix all patterns so that the ignore doesn't apply
-		# to sub-directories.
-		$s =~ s#^#/#gm;
-		print GITIGNORE "$s\n";
+		if ($s) {
+			# Prefix all patterns so that the ignore doesn't apply
+			# to sub-directories.
+			$s =~ s#^#/#gm;
+			print GITIGNORE "$s\n";
+		}
+		if ($s_global) {
+			print GITIGNORE "$s_global\n";
+		}
 		close(GITIGNORE)
 		  or fatal("Failed to close `$ignore': $!");
 		command_noisy('add', '-f', $ignore);
-- 
1.8.3.msysgit.0
