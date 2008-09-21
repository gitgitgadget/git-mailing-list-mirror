From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Sun, 21 Sep 2008 22:57:38 +0200
Message-ID: <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW14-0002jI-EG
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYIUU5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYIUU5e
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:34 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:65005 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYIUU5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:33 -0400
Received: by ey-out-2122.google.com with SMTP id 6so347648eyi.37
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0iJGhPPG6ASupEjfaKV4IASJoMDyK02EW0xbr7rKFg8=;
        b=pnNaCpBZ1zeRyrM7/Yb+cIXXMcpw0I5UgVrVAq2aPtaJaCsVrtJI80vi4ukNH0Cfoj
         mNJkGZq6PNPGWp6+Z3u4zoC21FZifrOgYQuIhhcyvHSA9tuhGZCjmeIWw/Op6aMu808b
         qrPypExP2MbjaTSSfvCopwYub+Yle1cT4q6LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dhq96wCY8Mait1dMg1mhjeR+zbQSviBoiSMHHctVKdabgIjLDMRDEymrwQnGfvf1oo
         2ePpwOJz6/Hwav0xHWzZVdMe3ozBU73o6o1tnj/K9nXJzbWHVHxUxCMQxKGaHRn9bqZP
         NFTpFlYrneMa8Tk6eU46QNYR4t4KDTrIelbM0=
Received: by 10.210.49.7 with SMTP id w7mr3818175ebw.109.1222030651111;
        Sun, 21 Sep 2008 13:57:31 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 3sm6202140eyj.3.2008.09.21.13.57.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96433>

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
index da474d0..e783d12 100755
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
