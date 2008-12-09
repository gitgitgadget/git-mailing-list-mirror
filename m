From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: A bit of code cleanup in git_blame()
Date: Tue, 09 Dec 2008 23:48:51 +0100
Message-ID: <20081209224814.28106.83387.stgit@localhost.localdomain>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 23:50:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LABPN-0003bd-JV
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 23:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbYLIWs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 17:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbYLIWs6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 17:48:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:28733 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407AbYLIWs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 17:48:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so97611fgg.17
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 14:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=22K8WKBzR2sV0ag59hsLbQiuvElhPQN7vivAzqGxHZE=;
        b=fgcTSz0E/fcQFQkGTgJz3YQlYwXkdOtMFySsxLcTQkQP36+McZBpxq4x4yHl2E7H92
         zNsZsn3ZuV1Go7RoeXxaQQJ/kwCQzj9GQ02C3M7UnYBLg1ZKw7sEkQ4NBY2wWwDM6Fco
         5GTNI1IGqxIOhXk3tmLRAEe3pbmOsHwZQ7iNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=VlpILVcHtRskXIPq1+aBWWlF6Tr7/1IabFYLbaFCVNCLithJN2lBtvep/iBaxe+rUz
         OabF85isxCyZOScDMiQLyNl6VGahSRI5ZcZTBfXuwQntfRCAfu+YryWim0rAh78KlaD6
         Z8lb9xvOvb0h6Oq+5qVYd5wAv+WL1iVliQq7k=
Received: by 10.86.57.9 with SMTP id f9mr308407fga.32.1228862935391;
        Tue, 09 Dec 2008 14:48:55 -0800 (PST)
Received: from localhost.localdomain (absh60.neoplus.adsl.tpnet.pl [83.8.127.60])
        by mx.google.com with ESMTPS id 12sm693834fgg.43.2008.12.09.14.48.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 14:48:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB9MmpZo028249;
	Tue, 9 Dec 2008 23:48:53 +0100
In-Reply-To: <20081209223703.28106.29198.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102660>

Among others: 
 * move variable declaration closer to the place it is set and used,
   if possible,
 * uniquify and simplify coding style a bit, which includes removing
   unnecessary '()'.
 * check type only if $hash was defined, as otherwise from the way
   git_get_hash_by_path() is called (and works), we know that it is
   a blob,
 * use modern calling convention for git-blame,
 * remove unused variable,
 * don't use implicit variables ($_),
 * add some comments

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Not stricly necessary... but the code looked not very nice

 gitweb/gitweb.perl |   65 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 916396a..68aa3f8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4575,28 +4575,32 @@ sub git_tag {
 }
 
 sub git_blame {
-	my $fd;
-	my $ftype;
-
+	# permissions
 	gitweb_check_feature('blame')
-	    or die_error(403, "Blame view not allowed");
+		or die_error(403, "Blame view not allowed");
 
+	# error checking
 	die_error(400, "No file name given") unless $file_name;
 	$hash_base ||= git_get_head_hash($project);
-	die_error(404, "Couldn't find base commit") unless ($hash_base);
+	die_error(404, "Couldn't find base commit") unless $hash_base;
 	my %co = parse_commit($hash_base)
 		or die_error(404, "Commit not found");
 	if (!defined $hash) {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(404, "Error looking up file");
+	} else {
+		my $ftype = git_get_type($hash);
+		if ($ftype !~ "blob") {
+			die_error(400, "Object is not a blob");
+		}
 	}
-	$ftype = git_get_type($hash);
-	if ($ftype !~ "blob") {
-		die_error(400, "Object is not a blob");
-	}
-	open ($fd, "-|", git_cmd(), "blame", '-p', '--',
-	      $file_name, $hash_base)
+
+	# run git-blame --porcelain
+	open my $fd, "-|", git_cmd(), "blame", '-p',
+		$hash_base, '--', $file_name
 		or die_error(500, "Open git-blame failed");
+
+	# page header
 	git_header_html();
 	my $formats_nav =
 		$cgi->a({-href => href(action=>"blob", -replay=>1)},
@@ -4610,40 +4614,43 @@ sub git_blame {
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
-	my @rev_color = (qw(light2 dark2));
+
+	# page body
+	my @rev_color = qw(light2 dark2);
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
-	my $last_rev;
+	my %metainfo = ();
+
 	print <<HTML;
 <div class="page_body">
 <table class="blame">
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
-	my %metainfo = ();
-	while (1) {
-		$_ = <$fd>;
-		last unless defined $_;
+ LINE:
+	while (my $line = <$fd>) {
+		chomp $line;
+		# the header: <SHA-1> <src lineno> <dst lineno> [<lines in group>]
+		# no <lines in group> for subsequent lines in group of lines
 		my ($full_rev, $orig_lineno, $lineno, $group_size) =
-		    /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/;
+		   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
 		if (!exists $metainfo{$full_rev}) {
 			$metainfo{$full_rev} = {};
 		}
 		my $meta = $metainfo{$full_rev};
-		while (<$fd>) {
-			last if (s/^\t//);
-			if (/^(\S+) (.*)$/) {
+		while (my $data = <$fd>) {
+			chomp $data;
+			last if ($data =~ s/^\t//); # contents of line
+			if ($data =~ /^(\S+) (.*)$/) {
 				$meta->{$1} = $2;
 			}
 		}
-		my $data = $_;
-		chomp $data;
-		my $rev = substr($full_rev, 0, 8);
+		my $short_rev = substr($full_rev, 0, 8);
 		my $author = $meta->{'author'};
-		my %date = parse_date($meta->{'author-time'},
-		                      $meta->{'author-tz'});
+		my %date =
+			parse_date($meta->{'author-time'}, $meta->{'author-tz'});
 		my $date = $date{'iso-tz'};
 		if ($group_size) {
-			$current_color = ++$current_color % $num_colors;
+			$current_color = ($current_color + 1) % $num_colors;
 		}
 		print "<tr id=\"l$lineno\" class=\"$rev_color[$current_color]\">\n";
 		if ($group_size) {
@@ -4654,7 +4661,7 @@ HTML
 			print $cgi->a({-href => href(action=>"commit",
 			                             hash=>$full_rev,
 			                             file_name=>$file_name)},
-			              esc_html($rev));
+			              esc_html($short_rev));
 			print "</td>\n";
 		}
 		my $parent_commit;
@@ -4683,6 +4690,8 @@ HTML
 	print "</div>";
 	close $fd
 		or print "Reading blob failed\n";
+
+	# page footer
 	git_footer_html();
 }
 
