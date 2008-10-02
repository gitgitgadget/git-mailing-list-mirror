From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Thu,  2 Oct 2008 02:10:29 +0200
Message-ID: <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnH-00017h-NE
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbYJBAKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYJBAKG
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:15510 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYJBAKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:10:04 -0400
Received: by ug-out-1314.google.com with SMTP id k3so937095ugf.37
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sDVj01IfehNqDOkBClN2OjeRlZy7+wi3BvMbET/WGZ8=;
        b=Z1bQpNh8ZjrojHwKHG4cX6G56wID1FvbX4flFngn0NfyuUm8LvuiJ5pKtXzV3eKsu5
         8/xx07wWozZ4HX7iQ73KKpVbnjqPj5bSRpZYNIuV6MIISagQkfHxzhY5BIcCgXDUC10y
         si55nXzItAtNKv0qjEy+cN+kOihQ9pjSS3cJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OaP6cIP7PWocuZR0NoyEHaEqaeax1ZmASXepqiSGM07rKOKeQAIMGa8ohTfbx2Ak1p
         PVx0dJkVh/SswcJg3wakxmdSbWEud15IbHH2g2hD/OGgvNrOdrFCqNFNXUvjOtZY0X0Q
         6RI5SQVbB6naTubv73penqfwGin/ZT3FfgkqM=
Received: by 10.210.123.2 with SMTP id v2mr10466481ebc.186.1222906201785;
        Wed, 01 Oct 2008 17:10:01 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 7sm1116908eyb.1.2008.10.01.17.09.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:10:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97285>

This patch enables gitweb to parse URLs with more information embedded
in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
path is now $project/$action/$hash_base:$file_name or
$project/$action/$hash

This is mostly backwards compatible with the old-style gitweb paths,
except when $project/$branch was used to access a branch whose name
matches a gitweb action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   90 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e7e4d6b..f088681 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -495,6 +495,37 @@ if (defined $searchtext) {
 	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
 
+# dispatch
+my %actions = (
+	"blame" => \&git_blame,
+	"blobdiff" => \&git_blobdiff,
+	"blobdiff_plain" => \&git_blobdiff_plain,
+	"blob" => \&git_blob,
+	"blob_plain" => \&git_blob_plain,
+	"commitdiff" => \&git_commitdiff,
+	"commitdiff_plain" => \&git_commitdiff_plain,
+	"commit" => \&git_commit,
+	"forks" => \&git_forks,
+	"heads" => \&git_heads,
+	"history" => \&git_history,
+	"log" => \&git_log,
+	"rss" => \&git_rss,
+	"atom" => \&git_atom,
+	"search" => \&git_search,
+	"search_help" => \&git_search_help,
+	"shortlog" => \&git_shortlog,
+	"summary" => \&git_summary,
+	"tag" => \&git_tag,
+	"tags" => \&git_tags,
+	"tree" => \&git_tree,
+	"snapshot" => \&git_snapshot,
+	"object" => \&git_object,
+	# those below don't need $project
+	"opml" => \&git_opml,
+	"project_list" => \&git_project_list,
+	"project_index" => \&git_project_index,
+);
+
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
@@ -519,9 +550,19 @@ sub evaluate_path_info {
 	# do not change any parameters if an action is given using the query string
 	return if $action;
 	$path_info =~ s,^\Q$project\E/*,,;
+
+	# next comes the action
+	$action = $path_info;
+	$action =~ s,/.*$,,;
+	if (exists $actions{$action}) {
+		$path_info =~ s,^$action/*,,;
+	} else {
+		$action  = undef;
+	}
+
 	my ($refname, $pathname) = split(/:/, $path_info, 2);
 	if (defined $pathname) {
-		# we got "project.git/branch:filename" or "project.git/branch:dir/"
+		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
 		$pathname =~ s,^/+,,;
 		if (!$pathname || substr($pathname, -1) eq "/") {
@@ -534,8 +575,9 @@ sub evaluate_path_info {
 		$file_name ||= validate_pathname($pathname);
 	} elsif (defined $refname) {
 		# we got "project.git/branch"
-		$action ||= "shortlog";
-		$hash   ||= validate_refname($refname);
+		$action    ||= "shortlog";
+		$hash      ||= validate_refname($refname);
+		$hash_base ||= validate_refname($refname);
 	}
 }
 evaluate_path_info();
@@ -544,37 +586,6 @@ evaluate_path_info();
 our $git_dir;
 $git_dir = "$projectroot/$project" if $project;
 
-# dispatch
-my %actions = (
-	"blame" => \&git_blame,
-	"blobdiff" => \&git_blobdiff,
-	"blobdiff_plain" => \&git_blobdiff_plain,
-	"blob" => \&git_blob,
-	"blob_plain" => \&git_blob_plain,
-	"commitdiff" => \&git_commitdiff,
-	"commitdiff_plain" => \&git_commitdiff_plain,
-	"commit" => \&git_commit,
-	"forks" => \&git_forks,
-	"heads" => \&git_heads,
-	"history" => \&git_history,
-	"log" => \&git_log,
-	"rss" => \&git_rss,
-	"atom" => \&git_atom,
-	"search" => \&git_search,
-	"search_help" => \&git_search_help,
-	"shortlog" => \&git_shortlog,
-	"summary" => \&git_summary,
-	"tag" => \&git_tag,
-	"tags" => \&git_tags,
-	"tree" => \&git_tree,
-	"snapshot" => \&git_snapshot,
-	"object" => \&git_object,
-	# those below don't need $project
-	"opml" => \&git_opml,
-	"project_list" => \&git_project_list,
-	"project_index" => \&git_project_index,
-);
-
 if (!defined $action) {
 	if (defined $hash) {
 		$action = git_get_type($hash);
@@ -631,8 +642,15 @@ sub href (%) {
 	if ($params{-replay}) {
 		while (my ($name, $symbol) = each %mapping) {
 			if (!exists $params{$name}) {
-				# to allow for multivalued params we use arrayref form
-				$params{$name} = [ $cgi->param($symbol) ];
+				# the parameter we want to recycle may be either part of the
+				# list of CGI parameter, or recovered from PATH_INFO
+				if ($cgi->param($symbol)) {
+					# to allow for multivalued params we use arrayref form
+					$params{$name} = [ $cgi->param($symbol) ];
+				} else {
+					no strict 'refs';
+					$params{$name} = $$name if $$name;
+				}
 			}
 		}
 	}
-- 
1.5.6.5
