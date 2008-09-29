From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Mon, 29 Sep 2008 17:26:54 +0200
Message-ID: <1222702017-4496-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222702017-4496-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 17:28:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKfC-0003R0-3Z
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbYI2P0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbYI2P0b
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:26:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbYI2P0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:26:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1465125fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zEJ3PqhzJfNQmyVoZMV7ALKf/utw8c5BNKt2aTPwgfo=;
        b=fAT1vst0Jzf7pWvaGw36isLmuPJumyCfEldrcp0qib23pyMUsqPdr6KraU049I/RkK
         Y1dD9WOzhSmIB3jvz/9il0e1389HRxvZuRrsghc8MEkyRos/mlylPPx2EGT8Fovss7R5
         4hxSZNNYvPV6wMPvE3OYfsRZwXpD/lWR/SjRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VZ6t6SHAf5PRd/BZ0IvG5u+223doM6ATJU+68uo1ZSZ4FdBS7YfHCkQ6AAMxBqRkmo
         DtjJ4uO3a/WyEBTIDVkb6ru+WHUAe0cSRtv8pQVjVeCBtOd1i+wVJCelkCnC+loOMk6t
         0k07H8AX09AFOub0jBjiPkE8ujtco4zQsTV+I=
Received: by 10.180.238.17 with SMTP id l17mr2394114bkh.65.1222701989440;
        Mon, 29 Sep 2008 08:26:29 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id b17sm311668fka.7.2008.09.29.08.26.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 08:26:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222702017-4496-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97023>

This patch enables gitweb to parse URLs with more information embedded
in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
path is now $project/$action/$hash_base:$file_name or
$project/$action/$hash

This is mostly backwards compatible with the old-style gitweb paths,
except when $project/$branch was used to access a branch whose name
matches a gitweb action.
---
 gitweb/gitweb.perl |   90 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ffe3dbf..a3076bd 100755
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
