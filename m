From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Split validate_input into validate_pathname and validate_refname
Date: Tue, 26 Sep 2006 01:57:02 +0200
Message-ID: <200609260157.03035.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 02:00:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS0NG-0005hZ-Kg
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 02:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWIZAAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 20:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWIZAAM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 20:00:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:47960 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751782AbWIZAAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 20:00:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so538808ugd
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 17:00:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AlYldCG0Q9dYjpOjvpqw9EhBGmI1YZ95t0EykT4jV2viGV6fqqVccrPmFNtSER04wEe33qY2bxTL6HIDt1aMiJ2KXWqUHgHHtZUo+di02IafPxb8nYFSh6XST8j5AhOx6l3i7Fsvh57n/478ULeMjB+Yq8QLS1sLbeCUax4ozGc=
Received: by 10.66.224.19 with SMTP id w19mr85859ugg;
        Mon, 25 Sep 2006 17:00:03 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id s1sm2153117uge.2006.09.25.17.00.02;
        Mon, 25 Sep 2006 17:00:02 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609260153.08503.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27762>

Split validate_input subroutine into validate_pathname which is used
for $project, $file_name and $file_parent parameters, and
validate_refname which is used for $hash, $hash_base, $hash_parent and
$hash_parent_base parameters.  Reintroduce validation of $file_name
and $file_parent parameters, removed in a2f3db2f5de2a3667b0e038aa65e3

validate_pathname in addition to what validate_input did checks also
for doubled slashes and NUL character. It does not check if input is
textual hash, and does not check if all characters are from the
following set: [a-zA-Z0-9_\x80-\xff\ \t\.\/\-\+\#\~\%].

validate_refname first check if the input is textual hash, then checks
if it is valid pathname, then checks for invalid characters (according
to git-check-ref-format manpage). It does not check if all charactes
are from the [a-zA-Z0-9_\x80-\xff\ \t\.\/\-\+\#\~\%] set.

We do not reintroduce validating pathnames we got from git.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
At last.

 gitweb/gitweb.perl |   66 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6458d7b..7fce9a6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -200,9 +200,10 @@ if (defined $action) {
 	}
 }
 
+# parameters which are pathnames
 our $project = $cgi->param('p');
 if (defined $project) {
-	if (!validate_input($project) ||
+	if (!validate_pathname($project) ||
 	    !(-d "$projectroot/$project") ||
 	    !(-e "$projectroot/$project/HEAD") ||
 	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
@@ -212,38 +213,50 @@ if (defined $project) {
 	}
 }
 
-# We have to handle those containing any characters:
 our $file_name = $cgi->param('f');
+if (defined $file_name) {
+	if (!validate_pathname($file_name)) {
+		die_error(undef, "Invalid file parameter");
+	}
+}
+
 our $file_parent = $cgi->param('fp');
+if (defined $file_parent) {
+	if (!validate_pathname($file_parent)) {
+		die_error(undef, "Invalid file parent parameter");
+	}
+}
 
+# parameters which are refnames
 our $hash = $cgi->param('h');
 if (defined $hash) {
-	if (!validate_input($hash)) {
+	if (!validate_refname($hash)) {
 		die_error(undef, "Invalid hash parameter");
 	}
 }
 
 our $hash_parent = $cgi->param('hp');
 if (defined $hash_parent) {
-	if (!validate_input($hash_parent)) {
+	if (!validate_refname($hash_parent)) {
 		die_error(undef, "Invalid hash parent parameter");
 	}
 }
 
 our $hash_base = $cgi->param('hb');
 if (defined $hash_base) {
-	if (!validate_input($hash_base)) {
+	if (!validate_refname($hash_base)) {
 		die_error(undef, "Invalid hash base parameter");
 	}
 }
 
 our $hash_parent_base = $cgi->param('hpb');
 if (defined $hash_parent_base) {
-	if (!validate_input($hash_parent_base)) {
+	if (!validate_refname($hash_parent_base)) {
 		die_error(undef, "Invalid hash parent base parameter");
 	}
 }
 
+# other parameters
 our $page = $cgi->param('pg');
 if (defined $page) {
 	if ($page =~ m/[^0-9]/) {
@@ -273,7 +286,7 @@ sub evaluate_path_info {
 		$project =~ s,/*[^/]*$,,;
 	}
 	# validate project
-	$project = validate_input($project);
+	$project = validate_pathname($project);
 	if (!$project ||
 	    ($export_ok && !-e "$projectroot/$project/$export_ok") ||
 	    ($strict_export && !project_in_list($project))) {
@@ -294,12 +307,12 @@ sub evaluate_path_info {
 		} else {
 			$action  ||= "blob_plain";
 		}
-		$hash_base ||= validate_input($refname);
-		$file_name ||= $pathname;
+		$hash_base ||= validate_refname($refname);
+		$file_name ||= validate_pathname($pathname);
 	} elsif (defined $refname) {
 		# we got "project.git/branch"
 		$action ||= "shortlog";
-		$hash   ||= validate_input($refname);
+		$hash   ||= validate_refname($refname);
 	}
 }
 evaluate_path_info();
@@ -387,16 +400,37 @@ sub href(%) {
 ## ======================================================================
 ## validation, quoting/unquoting and escaping
 
-sub validate_input {
-	my $input = shift;
+sub validate_pathname {
+	my $input = shift || return undef;
 
-	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
-		return $input;
+	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
+	# at the beginning, at the end, and between slashes.
+	if ($input =~ m!(^|/)(|\.|\.\.)(/|$)!) {
+		return undef;
 	}
-	if ($input =~ m/(^|\/)(|\.|\.\.)($|\/)/) {
+	# no doubled slashes
+	if ($input =~ m!//!) {
 		return undef;
 	}
-	if ($input =~ m/[^a-zA-Z0-9_\x80-\xff\ \t\.\/\-\+\#\~\%]/) {
+	# no null characters
+	if ($input =~ m!\0!) {
+		return undef;
+	}
+	return $input;
+}
+
+sub validate_refname {
+	my $input = shift || return undef;
+
+	# textual hashes are O.K.
+	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
+		return $input;
+	}
+	# it must be correct pathname
+	$input = validate_pathname($input)
+		or return undef;
+	# restrictions on ref name according to git-check-ref-format
+	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
 		return undef;
 	}
 	return $input;
-- 
1.4.2.1
