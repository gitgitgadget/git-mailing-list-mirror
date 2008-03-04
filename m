From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix and simplify pickaxe search
Date: Wed, 05 Mar 2008 00:15:53 +0100
Message-ID: <20080304230905.17447.32472.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 00:16:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWgMr-0001b1-Ri
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 00:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934868AbYCDXPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 18:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934894AbYCDXPk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 18:15:40 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:47126 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934888AbYCDXPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 18:15:37 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1149373fkz.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 15:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=MWnK9g89h3XMEeyi1Rp1jkw1FwM/AIQ9ditIRpvpSaM=;
        b=V8zBpLULBNmuLBhR5RytcVSflzLZ1wg/JWlarZ76/w6tJiypLvjqSWajvqXKKMFnGn9vLCGfU5IwKn/E4qCSmLEkj0838pNwQpouK+G3ZznjlFo9V/Wfi44w1bMVI8MK/rf/s4R5JnhbKUxF9jzWCM+PIWbNNCJr0cW0VV5rjhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=O80+R1ubnbmvuUA+y8tyOq3SlZxI57dvqD5rw7NopgbaV41tMbVfxMIC9i1AN0ZfxzNsh+vO97Nhqn2EcB+UzdNrngUjelxFg9OMLiZJm6vaiTevnfTfWItBb3G9uh6lRPIK9n4KzXQt4N5XG+CejxJDsi1svnO5/U+NIJ8Y7eo=
Received: by 10.82.153.5 with SMTP id a5mr5483007bue.5.1204672534839;
        Tue, 04 Mar 2008 15:15:34 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id c22sm351857ika.3.2008.03.04.15.15.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 15:15:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24NFrEt017541
	for <git@vger.kernel.org>; Wed, 5 Mar 2008 00:15:53 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76154>

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
On linux using 'git-log' instead of 'git-rev-list' ... 'git-diff-tree'
pipeline improves performance only insignificantly, at least on
Linux. But that might differ on fork-performance challenged operating
systems.

Loooong time bug: if I have checked correctly, it was there from
introduction of pickaxe search in c994d62 (v220), when gitweb was
developed separately, mainly by Kay Sievers.

 gitweb/gitweb.perl |   85 ++++++++++++++++++++++++++--------------------------
 1 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 922dee9..0bf679e 100755
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
+		open my $fd, '-|', git_cmd(), '--no-pager', 'log',
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
 


-- 
Stacked GIT 0.14.1
git version 1.5.4.2
Python version 2.4.3 (#1, Jun 13 2006, 16:41:18) 
[GCC 4.0.2 20051125 (Red Hat 4.0.2-8)]
