From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: action in path with use_pathinfo
Date: Wed,  3 Sep 2008 11:57:15 +0200
Message-ID: <1220435839-29360-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kap8P-0000SL-23
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbYICJ5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYICJ5a
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:57:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:39013 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYICJ52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:57:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2146168fkq.5
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pEs8iIKF+df8y+tE258Kj2KFNEVWYlYAuQIfC/yCMBc=;
        b=A6N4CNgn191XIwRPGb73Xt0pJlHb9KkGdr1yNSqmRiWef5IVq0+RRmSyNC1jfw6zU6
         jl5Iv7/RotWUhYHbaUbUQGcRqdFrOe1+b6P+6XNXWZZr6y8O0eUnwqpBKGjHBYBYNMbf
         3IEZZlK8ps86ed0OYtDKLGxtd6jCeR2Xm/Pj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hs3GyIygE2R0yO1O6JWm2a8xj7wuOWzMmil1X8/MUGhIy3iy2rO+Et4VIQ534lEgDn
         grKNGFqIJQU5I1nrwbQ9D3sKA467mt5BLT/Yjvx0p0iq2sY49UPVTLJwZ2ZtmpcyK4hk
         Ot0BOooTjl/26aCYneY1eW92M4hqlh7IjiQ9k=
Received: by 10.180.236.20 with SMTP id j20mr6738156bkh.57.1220435846018;
        Wed, 03 Sep 2008 02:57:26 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id h7sm47783981nfh.4.2008.09.03.02.57.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:57:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94775>

When using path info, reduce the number of CGI parameters by embedding
the action in the path. The typicial cgiweb path is thus
$project/$action/$hash_base:$file_name or $project/$action/$hash

This is mostly backwards compatible with the old-style gitweb paths,
except when $project/$branch was used to access a branch whose name
matches a gitweb action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |  109 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 29e2156..496dce4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -488,6 +488,37 @@ if (defined $searchtext) {
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
@@ -512,6 +543,16 @@ sub evaluate_path_info {
 	# do not change any parameters if an action is given using the query string
 	return if $action;
 	$path_info =~ s,^\Q$project\E/*,,;
+
+	# next comes the action
+	$action = $path_info;
+	$action =~ s,/.*$,,;
+	if (exists $actions{$action}) {
+		$path_info =~ s,^\Q$action\E/*,,;
+	} else {
+		$action  = undef;
+	}
+
 	my ($refname, $pathname) = split(/:/, $path_info, 2);
 	if (defined $pathname) {
 		# we got "project.git/branch:filename" or "project.git/branch:dir/"
@@ -525,10 +566,12 @@ sub evaluate_path_info {
 		}
 		$hash_base ||= validate_refname($refname);
 		$file_name ||= validate_pathname($pathname);
+		$hash      ||= git_get_hash_by_path($hash_base, $file_name);
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
@@ -537,37 +580,6 @@ evaluate_path_info();
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
@@ -624,8 +636,13 @@ sub href (%) {
 	if ($params{-replay}) {
 		while (my ($name, $symbol) = each %mapping) {
 			if (!exists $params{$name}) {
-				# to allow for multivalued params we use arrayref form
-				$params{$name} = [ $cgi->param($symbol) ];
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
@@ -636,10 +653,28 @@ sub href (%) {
 		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
 		delete $params{'project'};
 
-		# Summary just uses the project path URL
-		if (defined $params{'action'} && $params{'action'} eq 'summary') {
+		# Summary just uses the project path URL, any other action come next
+		# in the URL
+		if (defined $params{'action'}) {
+			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
 			delete $params{'action'};
 		}
+
+		# next, we put either hash_base:file_name or hash
+		if (defined $params{'hash_base'}) {
+			$href .= "/".esc_url($params{'hash_base'});
+			if (defined $params{'file_name'}) {
+				$href .= ":".esc_url($params{'file_name'});
+				delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
+				delete $params{'file_name'};
+			} else {
+				delete $params{'hash'} if $params{'hash'} eq $params{'hash_base'};
+			}
+			delete $params{'hash_base'};
+		} elsif (defined $params{'hash'}) {
+			$href .= "/".esc_url($params{'hash'});
+			delete $params{'hash'};
+		}
 	}
 
 	# now encode the parameters explicitly
-- 
1.5.6.5
