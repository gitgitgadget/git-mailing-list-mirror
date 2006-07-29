From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3] gitweb: simplify git_get_hash_by_path
Date: Sat, 29 Jul 2006 22:55:01 +0200
Message-ID: <200607292255.01425.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 29 22:54:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6vpj-0007lJ-Dr
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 22:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWG2Uys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 16:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWG2Uys
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 16:54:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:58778 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932234AbWG2Uyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 16:54:47 -0400
Received: by ug-out-1314.google.com with SMTP id m3so207936ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 13:54:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dMYAaNxIPgg2EwNqmtEXTa+6t2aHt/YUV9seAvO1iSmJwFhm46aGU2xJFWiC5lGoiUkiEQPLK7c/gSSN5/BEpyzPgSZQx1h0XfGMsPEHx/eiBvNH4MkcfjZ1i/8k8jOZA9g8mQvZm21WM2ZGkArZefzUprGu8J0Z6W9dP0Vg5Hk=
Received: by 10.67.29.12 with SMTP id g12mr996203ugj;
        Sat, 29 Jul 2006 13:54:45 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k2sm2314429ugf.2006.07.29.13.54.45;
        Sat, 29 Jul 2006 13:54:45 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24435>

Simplify git_get_hash_by_path by using git-ls-tree to do path
limiting, instead of finding correct ttree and parsing unconstrained
git-ls-tree output.

_Should_ be slightly faster.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Testing speed before and after this patch using ApacheBench 
on git.git repository has shown speedup withing error. Perhaps
sample size was too small...

Speedup should be larger for deeper nested projects with larger number
of files in a directory.

Not extensively tested!

 gitweb/gitweb.cgi |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 9a17f87..e1a817b 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1525,29 +1525,15 @@ sub git_get_hash_by_path {
 	my $path = shift || return undef;
 
 	my $tree = $base;
-	my @parts = split '/', $path;
-	while (my $part = shift @parts) {
-		open my $fd, "-|", $GIT, "ls-tree", $tree or die_error(undef, "Open git-ls-tree failed.");
-		my (@entries) = map { chomp; $_ } <$fd>;
-		close $fd or return undef;
-		foreach my $line (@entries) {
-			#'100644	blob	0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-			$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
-			my $t_mode = $1;
-			my $t_type = $2;
-			my $t_hash = $3;
-			my $t_name = validate_input(unquote($4));
-			if ($t_name eq $part) {
-				if (!(@parts)) {
-					return $t_hash;
-				}
-				if ($t_type eq "tree") {
-					$tree = $t_hash;
-				}
-				last;
-			}
-		}
-	}
+
+	open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
+		or die_error(undef, "Open git-ls-tree failed.");
+	my $line = <$fd>;
+	close $fd or return undef;
+
+	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+	return $3;
 }
 
 sub mimetype_guess_file {
-- 
1.4.0
