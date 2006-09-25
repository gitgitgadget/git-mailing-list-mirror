From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Quote filename in HTTP Content-Disposition: header
Date: Tue, 26 Sep 2006 01:59:43 +0200
Message-ID: <200609260159.43684.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 02:00:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS0NF-0005hZ-65
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 02:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWIZAAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 20:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWIZAAQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 20:00:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45144 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751786AbWIZAAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 20:00:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so538800ugd
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 17:00:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R2oV343xAuWcX0S7jTE/zZmdRL6jHolkAQ9onbu55qXJAhOXgwHWgwwP9sYLp6jXu+Euh4DGyCPbPbY78kfB9gU3Odq/AtAIZh2Ms4LcM/rgKG0AxKccYaWO9GKD0+zOCgwiniLdW1VW7NKbqg6pz/yLC8hZVK7YODEPY0ZEfC0=
Received: by 10.67.97.7 with SMTP id z7mr88633ugl;
        Mon, 25 Sep 2006 17:00:05 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id s1sm2153117uge.2006.09.25.17.00.04;
        Mon, 25 Sep 2006 17:00:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609260153.08503.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27759>

Finish work started by a2f3db2f5de2a3667b0e038aa65e3e097e642e7d commit
(although not documented in commit message) of quoting using quotemeta
the filename in HTTP -content_disposition header.  Uniquify output.

Just in case filename contains end of line character.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b51e061..4dd7a5d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2326,7 +2326,7 @@ sub git_project_index {
 	print $cgi->header(
 		-type => 'text/plain',
 		-charset => 'utf-8',
-		-content_disposition => qq(inline; filename="index.aux"));
+		-content_disposition => 'inline; filename="index.aux"');
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
@@ -2672,7 +2672,7 @@ sub git_blob_plain {
 	print $cgi->header(
 		-type => "$type",
 		-expires=>$expires,
-		-content_disposition => "inline; filename=\"$save_as\"");
+		-content_disposition => 'inline; filename="' . quotemeta($save_as) . '"');
 	undef $/;
 	binmode STDOUT, ':raw';
 	print <$fd>;
@@ -2846,10 +2846,11 @@ sub git_snapshot {
 
 	my $filename = basename($project) . "-$hash.tar.$suffix";
 
-	print $cgi->header(-type => 'application/x-tar',
-	                   -content_encoding => $ctype,
-	                   -content_disposition => "inline; filename=\"$filename\"",
-	                   -status => '200 OK');
+	print $cgi->header(
+		-type => 'application/x-tar',
+		-content_encoding => $ctype,
+		-content_disposition => 'inline; filename="' . quotemeta($filename) . '"',
+		-status => '200 OK');
 
 	my $git_command = git_cmd_str();
 	open my $fd, "-|", "$git_command tar-tree $hash \'$project\' | $command" or
@@ -3159,7 +3160,7 @@ sub git_blobdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => qq(inline; filename=") . quotemeta($file_name) . qq(.patch"));
+			-content_disposition => 'inline; filename="' . quotemeta($file_name) . '.patch"');
 
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
@@ -3262,7 +3263,7 @@ sub git_commitdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => qq(inline; filename="$filename"));
+			-content_disposition => 'inline; filename="' . quotemeta($filename) . '"');
 		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 		print <<TEXT;
 From: $co{'author'}
-- 
1.4.2.1
