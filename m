From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2] gitweb: Fix and simplify pickaxe search
Date: Wed, 05 Mar 2008 09:31:55 +0100
Message-ID: <20080305083019.20727.66526.stgit@localhost.localdomain>
References: <20080304230905.17447.32472.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 09:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWp2x-0000ru-KY
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbYCEIbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbYCEIbl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:31:41 -0500
Received: from ik-out-1112.google.com ([66.249.90.177]:58581 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYCEIbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:31:40 -0500
Received: by ik-out-1112.google.com with SMTP id c28so1911276ika.5
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=y3/DnBMxbN8Na0KpSTzNW5Xzj1AYDrdEY4QJplNiCVg=;
        b=lvMzowiTulaHk4w10m9sBeXGQ3BEgfOH71Uad1FF8Frv4Ol9O6DZikLYbmkWARUjGmQmF4zls9EEOl2zQW4h/DugRAHIuQNPk7Woa+C4kCN5XfehHDMoW+YsV19k6x3IlIEib+9pmR0wBFE/2a3z+bvVX0A8wu1BS8452Y0+9bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=Yc9tY8lhjhkPxoG1PHdNjsaLVeF3gvFfsULFQGJU7H+zLW4rI0O1l5YNyTOREp+FKiAWF4YxZaQ+jNgp/OZ3V4EGUAjJdlaVPN8E2bA6w2FKB+D6NB4dDUX8WCL/AJTNEQhyHwS66S03leXbbq5qIWk5tjZ3G7B5+eNxL+UOc7w=
Received: by 10.78.173.20 with SMTP id v20mr4038340hue.73.1204705897508;
        Wed, 05 Mar 2008 00:31:37 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.32])
        by mx.google.com with ESMTPS id d27sm950531nfh.2.2008.03.05.00.31.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 00:31:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m258VtAO020776
	for <git@vger.kernel.org>; Wed, 5 Mar 2008 09:31:56 +0100
In-Reply-To: <20080304230905.17447.32472.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76191>

Instead of using "git-rev-list | git-diff-tree" pipeline for pickaxe
search, use git-log with appropriate options.  Besides reducing number
of forks by one, this allows to use list form of open, which in turn
allow to not worry about quoting arguments and to avoid forking shell.

The options to git-log were chosen to reduce required changes in
pickaxe git command output parsing; gitweb still parses returned
commits one by one.

Parsing "pickaxe" output is simplified: git_search now reuses
parse_difftree_raw_line and writes affected files as they arrive using
the fact that commit name goes always before [raw] diff.

While at it long bug of pickaxe search was fixed, namely that the last
commit found by pickaxe search was never shown.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I forgot to include @diff_opts in git-log invocation, therefore for
example pickaxe was run without (default) rename detection.

 gitweb/gitweb.perl |   85 ++++++++++++++++++++++++++--------------------------
 1 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 922dee9..ec73cb1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5305,51 +5305,19 @@ sub git_search {
 		print "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
 		$/ = "\n";
-		my $git_command = git_cmd_str();
-		my $searchqtext = $searchtext;
-		$searchqtext =~ s/'/'\\''/;
-		my $pickaxe_flags = $search_use_regexp ? '--pickaxe-regex' : '';
-		open my $fd, "-|", "$git_command rev-list $hash | " .
-			"$git_command diff-tree -r --stdin -S\'$searchqtext\' $pickaxe_flags";
+		open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
+			'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
+			($search_use_regexp ? '--pickaxe-regex' : ());
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
-			if (%co && $line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/) {
-				my %set;
-				$set{'file'} = $6;
-				$set{'from_id'} = $3;
-				$set{'to_id'} = $4;
-				$set{'id'} = $set{'to_id'};
-				if ($set{'id'} =~ m/0{40}/) {
-					$set{'id'} = $set{'from_id'};
-				}
-				if ($set{'id'} =~ m/0{40}/) {
-					next;
-				}
-				push @files, \%set;
-			} elsif ($line =~ m/^([0-9a-fA-F]{40})$/){
+			chomp $line;
+			next unless $line;
+
+			my %set = parse_difftree_raw_line($line);
+			if (defined $set{'commit'}) {
+				# finish previous commit
 				if (%co) {
-					if ($alternate) {
-						print "<tr class=\"dark\">\n";
-					} else {
-						print "<tr class=\"light\">\n";
-					}
-					$alternate ^= 1;
-					my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
-					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-					      "<td><i>" . $author . "</i></td>\n" .
-					      "<td>" .
-					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
-					              -class => "list subject"},
-					              chop_and_escape_str($co{'title'}, 50) . "<br/>");
-					while (my $setref = shift @files) {
-						my %set = %$setref;
-						print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
-						                             hash=>$set{'id'}, file_name=>$set{'file'}),
-						              -class => "list"},
-						              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
-						      "<br/>\n";
-					}
 					print "</td>\n" .
 					      "<td class=\"link\">" .
 					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
@@ -5358,11 +5326,44 @@ sub git_search {
 					print "</td>\n" .
 					      "</tr>\n";
 				}
-				%co = parse_commit($1);
+
+				if ($alternate) {
+					print "<tr class=\"dark\">\n";
+				} else {
+					print "<tr class=\"light\">\n";
+				}
+				$alternate ^= 1;
+				%co = parse_commit($set{'commit'});
+				my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
+				print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+				      "<td><i>$author</i></td>\n" .
+				      "<td>" .
+				      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
+				              -class => "list subject"},
+				              chop_and_escape_str($co{'title'}, 50) . "<br/>");
+			} elsif (defined $set{'to_id'}) {
+				next if ($set{'to_id'} =~ m/^0{40}$/);
+
+				print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
+				                             hash=>$set{'to_id'}, file_name=>$set{'to_file'}),
+				              -class => "list"},
+				              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
+				      "<br/>\n";
 			}
 		}
 		close $fd;
 
+		# finish last commit (warning: repetition!)
+		if (%co) {
+			print "</td>\n" .
+			      "<td class=\"link\">" .
+			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+			      " | " .
+			      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
+			print "</td>\n" .
+			      "</tr>\n";
+		}
+
 		print "</table>\n";
 	}
 

