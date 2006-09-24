From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Consolidate escaping/validation of query string
Date: Sun, 24 Sep 2006 13:39:32 +0200
Message-ID: <20060924113932.11208.33780.stgit@rover>
References: <ef4csl$7vk$1@sea.gmane.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 24 13:39:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSKf-0007PO-VG
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWIXLjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 07:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIXLjf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:39:35 -0400
Received: from rover.dkm.cz ([62.24.64.27]:13228 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1750973AbWIXLje (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 07:39:34 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 055398B49C;
	Sun, 24 Sep 2006 13:39:32 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <ef4csl$7vk$1@sea.gmane.org>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27660>

Consider:

	http://repo.or.cz/?p=glibc-cvs.git;a=tree;h=2609cb0411389325f4ee2854cc7159756eb0671e;hb=2609cb0411389325f4ee2854cc7159756eb0671e

(click on the funny =__ify file)

We ought to handle anything in filenames and I actually see no reason why
we don't, modulo very little missing escaping that this patch hopefully
also fixes.

I have also made esc_param() escape [?=&;]. Not escaping [&;] was downright
buggy and [?=] just feels better escaped. ;-) YMMV.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2c6b197..f3c5bd8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -212,19 +212,9 @@ if (defined $project) {
 	}
 }
 
+# We have to handle those containing any characters:
 our $file_name = $cgi->param('f');
-if (defined $file_name) {
-	if (!validate_input($file_name)) {
-		die_error(undef, "Invalid file parameter");
-	}
-}
-
 our $file_parent = $cgi->param('fp');
-if (defined $file_parent) {
-	if (!validate_input($file_parent)) {
-		die_error(undef, "Invalid file parent parameter");
-	}
-}
 
 our $hash = $cgi->param('h');
 if (defined $hash) {
@@ -305,7 +295,7 @@ sub evaluate_path_info {
 			$action  ||= "blob_plain";
 		}
 		$hash_base ||= validate_input($refname);
-		$file_name ||= validate_input($pathname);
+		$file_name ||= $pathname;
 	} elsif (defined $refname) {
 		# we got "project.git/branch"
 		$action ||= "shortlog";
@@ -416,7 +406,7 @@ # quote unsafe chars, but keep the slash
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
 	my $str = shift;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@])/sprintf("%%%02X", ord($1))/eg;
 	$str =~ s/\+/%2B/g;
 	$str =~ s/ /\+/g;
 	return $str;
@@ -1289,7 +1279,7 @@ sub git_header_html {
 		if (defined $action) {
 			$title .= "/$action";
 			if (defined $file_name) {
-				$title .= " - $file_name";
+				$title .= " - " . esc_html($file_name);
 				if ($action eq "tree" && $file_name !~ m|/$|) {
 					$title .= "/";
 				}
@@ -2439,7 +2429,7 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "blame", '-l', '--', $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -3135,7 +3125,7 @@ sub git_blobdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => qq(inline; filename="${file_name}.patch"));
+			-content_disposition => qq(inline; filename=") . quotemeta($file_name) . qq(.patch"));
 
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
@@ -3155,8 +3145,8 @@ sub git_blobdiff {
 
 	} else {
 		while (my $line = <$fd>) {
-			$line =~ s!a/($hash|$hash_parent)!a/$diffinfo{'from_file'}!g;
-			$line =~ s!b/($hash|$hash_parent)!b/$diffinfo{'to_file'}!g;
+			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_html($diffinfo{'from_file'})!eg;
+			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_html($diffinfo{'to_file'})!eg;
 
 			print $line;
 
@@ -3585,7 +3575,7 @@ XML
 			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
 				next;
 			}
-			my $file = validate_input(unquote($7));
+			my $file = esc_html(unquote($7));
 			$file = decode("utf8", $file, Encode::FB_DEFAULT);
 			print "$file<br/>\n";
 		}
