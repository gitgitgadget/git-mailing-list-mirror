From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Allow project description in project_index file
Date: Fri, 2 May 2008 12:30:04 +0200
Message-ID: <200805021230.05907.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 12:31:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrsXn-00041G-5z
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 12:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759854AbYEBKaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 06:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194AbYEBKaW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 06:30:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:14682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518AbYEBKaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 06:30:21 -0400
Received: by ug-out-1314.google.com with SMTP id h3so56218ugf.16
        for <git@vger.kernel.org>; Fri, 02 May 2008 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=EaV2ZPcYrKVoXQ7tY2Gui6o5I2ZDX6fxj38jUOjOs18=;
        b=MvyvTN+Nrt9AuFiYAiZ3OF/hjOdcPqn6DIaDGpNEYKf+QHTSP6jogS/8DbPcrx6xYi1CgeuuDl8agF09N0r/gKD8nFZBp+y1XDTrM3PwzEHEGFIWXXs1+7Q8t476fGsvcsxoBiwGHh2Yu2Dy2x8e10JgojWNeWjFt4hwoRs4maI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Olh3pF9hna9p6IwDQPwzkniXGyugjpVotHgGadpp9I3s5wHkrbd64x4zhGfOwmj0+PzBBTnW9Bcnrnowm8yo7W4rnBP2sKM7AQiFmS/8xaqtIeMEKFpLD9uMoSPTKyXEOzvsnylnQgFwVKTWhT5AXeCL2vnykOgI3oRM86vUYJ4=
Received: by 10.67.24.18 with SMTP id b18mr35705ugj.86.1209724218095;
        Fri, 02 May 2008 03:30:18 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.103])
        by mx.google.com with ESMTPS id y37sm5051577iky.8.2008.05.02.03.30.14
        (version=SSLv3 cipher=OTHER);
        Fri, 02 May 2008 03:30:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200805011220.58871.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80977>

Change format of $projects_list file from
  <URI-encoded path> SPC <URI-encoded owner> LF
to
  <URI-encoded path> SPC <URI-encoded owner> [SPC <description>] LF
with optional project description.  To make it easier to read and edit
$projects_list file the description _is not_ URI encoded.  Please
remember that only single line of repository (project) description is
supported.  Note that SPC can be replaced by any whitespace
character.

This change required modifying git_get_projects_list() subroutine
(part when $projects_list is a file, not a directory to be scanned),
and git_get_project_description() subroutine.

The 'project_index' action creates projects list index file in the new
format, with project description.

Thi change is backwards compatibile: older gitweb with new projects
list format would work as it used to work; new gitweb with old format
would get (try to get) project description from other sources.


While at it some comments describing changes and changed subroutines
were added, and information about $projects_list format was updated in
gitweb/README.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is second patch in the yet to be written series improving projects
list page and related things.  I'm sending an early version of patch to
ask for comments.

The reason why it is an RFC is the decision to _not_ URI-decode (to not
force URI-encoding of e.g. spaces) in the project (repository)
description part of projects list page.  It makes projects index file
easier to read and to edit, but it closes possibility of extending this
format further.  And there is another thing that could be reasonably put
in this file: future project *categories* support.  So should I try to
add categories support first?

Note that without this patch future patches, dividing projects list page
into 100-items long pages, and adding projects search page, which are
meant to bring preformance improvements, would get less performance
improvements without this patch.

Comments appreciated...

 gitweb/README      |    9 +++++--
 gitweb/gitweb.perl |   61 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 8f7ea36..e58fe18 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -157,9 +157,12 @@ not include variables usually directly set during build):
  * $projects_list
    Source of projects list, either directory to scan, or text file
    with list of repositories (in the "<URI-encoded repository path> SPC
-   <URI-encoded repository owner>" format).  Set to $GITWEB_LIST
-   during installation.  If empty, $projectroot is used to scan for
-   repositories.
+   <URI-encoded repository owner>" line format, or optionally with
+   project description in "<URI-encoded repository path> SPC
+   <URI-encoded repository owner> SPC <single line description>";
+   actually there can be any whitespace in place of SPC).  Set to
+   $GITWEB_LIST during installation.  If empty, $projectroot is used
+   to scan for repositories.
  * $my_url, $my_uri
    URL and absolute URL of gitweb script; you might need to set those
    variables if you are using 'pathinfo' feature: see also below.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6a28dca..dc3f99a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1702,13 +1702,43 @@ sub git_get_path_by_hash {
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
+# this is helper function for git_get_project_description()
+sub git_get_project_description_from_list {
+	my $path = shift;
+
+	open(my $fd, $projects_list)
+		or return;
+	while (my $line = <$fd>) {
+		chomp $line;
+		my ($pr, undef, $descr) = split(' ', $line, 3);
+		$pr = unescape($pr);
+		if ($pr eq $path) {
+			close $fd;
+			return $descr;
+		}
+	}
+	close $fd;
+	return;
+}
+
+# sources for project description are
+#  * project_list, if $project_list is a file, and it uses new format:
+#    URI_encoded(<path>) SPC URI_encoded(<owner>) SPC <description> LF
+#  * $GIT_DIR/description file in project repository, if it exists
+#  * gitweb.description configuration variable for a project
 sub git_get_project_description {
 	my $path = shift;
+	my $descr;
+
+	if (-f $projects_list) {
+		$descr = git_get_project_description_from_list($path);
+		return $descr if (defined $descr); # try other sources if needed
+	}
 
 	$git_dir = "$projectroot/$path";
 	open my $fd, "$git_dir/description"
 		or return git_get_project_config('description');
-	my $descr = <$fd>;
+	$descr = <$fd>;
 	close $fd;
 	if (defined $descr) {
 		chomp $descr;
@@ -1774,20 +1804,24 @@ sub git_get_projects_list {
 		}, "$dir");
 
 	} elsif (-f $projects_list) {
-		# read from file(url-encoded):
+		# read from file (whitespace separated, url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		# optionally with description (which isn't url-encoded)
+		# 'git/git.git Junio+C+Hamano The core git plumbing'
+		# 'libs/klibc/klibc.git H.+Peter+Anvin klibc main development tree'
+		# 'linux/hotplug/udev.git Kay+Sievers udev development tree'
 		my %paths;
 		open my ($fd), $projects_list or return;
 	PROJECT:
 		while (my $line = <$fd>) {
 			chomp $line;
-			my ($path, $owner) = split ' ', $line;
+			my ($path, $owner, $descr) = split(' ', $line, 3);
 			$path = unescape($path);
 			$owner = unescape($owner);
 			if (!defined $path) {
-				next;
+				next PROJECT;
 			}
 			if ($filter ne '') {
 				# looking for forks;
@@ -1818,9 +1852,14 @@ sub git_get_projects_list {
 			}
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
-					path => $path,
+					path =>  to_utf8($path),
 					owner => to_utf8($owner),
 				};
+				if (defined $descr) {
+					$descr = to_utf8($descr);
+					$pr->{'descr_long'} = $descr;
+					$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
+				}
 				push @list, $pr;
 				(my $forks_path = $path) =~ s/\.git$//;
 				$paths{$forks_path}++;
@@ -4006,21 +4045,27 @@ sub git_project_index {
 	print $cgi->header(
 		-type => 'text/plain',
 		-charset => 'utf-8',
-		-content_disposition => 'inline; filename="index.aux"');
+		-content_disposition => 'inline; filename="projects_index.aux"');
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}");
+			$pr->{'owner'} = to_utf8($pr->{'owner'});
+		}
+		if (!exists $pr->{'descr_long'}) {
+			$pr->{'descr_long'} = git_get_project_description($pr->{'path'}) || "";
+			$pr->{'descr_long'} = to_utf8($pr->{'descr_long'});
 		}
 
-		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
+		my ($path, $owner, $descr) = 
+			($pr->{'path'}, $pr->{'owner'}, $pr->{'descr_long'});
 		# quote as in CGI::Util::encode, but keep the slash, and use '+' for ' '
 		$path  =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
 		$owner =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
 		$path  =~ s/ /\+/g;
 		$owner =~ s/ /\+/g;
 
-		print "$path $owner\n";
+		print "$path $owner $descr\n";
 	}
 }
 
-- 
1.5.5
