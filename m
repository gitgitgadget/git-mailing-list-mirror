From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: action in path with use_pathinfo
Date: Fri,  1 Aug 2008 14:23:45 +0200
Message-ID: <1217593425-28314-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 14:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOtge-0002eq-1T
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 14:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbYHAMXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 08:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbYHAMXr
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 08:23:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:33027 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbYHAMXq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 08:23:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so408074nfc.21
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=k5VTsWMl9U62FLV0AnEzqJZbzo4PAXpbmPPF+0OGgnw=;
        b=GfJsRiZDj0qEC0Y+6CnSauc7GZON5BLXNUciUFgLgH5Y7nac1l2VVZM/RI8sqp6lqn
         g0NXXqtWwEEaXHzfbK3/jdbOHe/o70H45KFfFlip2BvLzRLTw5Do7gVi+4ZQbJn+A802
         TGSEmbP9u6gT2mvW0HQsqfJSo4p5fTVH5M2pA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Kdqg0WXs/xvI92gov/9p2EDY4dO7pRHWTUBKBqkH4qwSmlwJ0phwC4mPoqTcdNlAkT
         iOAKJoTnCl/pYaxB2y1apE73tMayE1syCzQ4hGTLPQyCB3zu8u+jtCLwZ6VazlbW1cNp
         k5IGuD3d5sdfrDBSYMEPN2b/dnm7ULM+uOwCc=
Received: by 10.210.113.16 with SMTP id l16mr12219201ebc.195.1217593422122;
        Fri, 01 Aug 2008 05:23:42 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id y34sm3294709iky.10.2008.08.01.05.23.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 05:23:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91063>

When using path info, reduce the number of CGI parameters by embedding
the action in the path. The typicial cgiweb path is thus
$project/$action/$hash_base:$file_name or $project/$action/$hash

This is mostly backwards compatible with the old-style gitweb paths,
except when $project/$branch was used to access a branch whose name
matches a gitweb action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

I've been thinking a long time about the best way to get rid of most
CGI parameters when using path info, and I think that the attached
patch solves the problem pretty well, since it makes most simple
(one-paramater) actions accessible as plain paths.

The only weak point I see in my approach is with -replay=>1. Since in
our case there are no CGI parameters to be replayed, I use the
corresponding variables. An alternative, safer method would probably
be to store the various request parameters in a separate hash,
obtained by merging the CGI data with the one extracted from the
request path. I didn't follow the latter route because the simpler
approach implemented in this patch seems to work without problems.

 gitweb/gitweb.perl |  111 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aa8c27c..d4ed401 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -512,6 +512,37 @@ if (defined $searchtext) {
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
@@ -536,6 +568,16 @@ sub evaluate_path_info {
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
@@ -549,10 +591,12 @@ sub evaluate_path_info {
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
@@ -561,37 +605,6 @@ evaluate_path_info();
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
@@ -649,8 +661,13 @@ sub href (%) {
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
@@ -661,10 +678,28 @@ sub href (%) {
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
1.5.6.3
