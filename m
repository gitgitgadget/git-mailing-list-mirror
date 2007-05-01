From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: gitweb search page link slightly wrong
Date: Tue, 01 May 2007 12:22:50 +0200
Message-ID: <1178014970.3483.15.camel@johannes.berg>
References: <1177706593.3565.59.camel@johannes.berg>
	 <1178014409.3483.12.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 12:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HipUz-0004bv-Mj
	for gcvg-git@gmane.org; Tue, 01 May 2007 12:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161684AbXEAKWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 06:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161677AbXEAKWK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 06:22:10 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:46941 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161686AbXEAKWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 06:22:08 -0400
Received: from [84.135.254.215] (helo=[10.0.0.4])
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.66)
	(envelope-from <johannes@sipsolutions.net>)
	id 1HipUl-0007in-4K
	for git@vger.kernel.org; Tue, 01 May 2007 11:22:07 +0100
In-Reply-To: <1178014409.3483.12.camel@johannes.berg>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45940>

On Tue, 2007-05-01 at 12:13 +0200, Johannes Berg wrote:
> This seems to fix it but I have no idea what it breaks. Command
> injection should be stopped a few lines above that, and no other
> parameter is ever quoted using quotemeta, so I'm not sure what the point
> is, but I suppose it is actually necessary because the search text is
> then wrapped into a regular expression or something?

Ah, I understand now. Here's a possibly complete fix.

From: Johannes Berg <johannes@sipsolutions.net>
Subject: quote $searchtext only before use

$searchtext is used in two ways
 (1) to do the search
 (2) to put it back into the output

For (1) it needs to have meta chars quoted, but for (2) not, so quote
them only when needed.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- git.orig/gitweb/gitweb.perl	2007-05-01 11:58:27.000000000 +0200
+++ git/gitweb/gitweb.perl	2007-05-01 12:20:27.000000000 +0200
@@ -368,7 +368,6 @@ if (defined $searchtext) {
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
-	$searchtext = quotemeta $searchtext;
 }
 
 our $searchtype = $cgi->param('st');
@@ -2927,6 +2926,7 @@ sub git_heads_body {
 
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
+	my $_searchtext = quotemeta $searchtext;
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
@@ -2951,7 +2951,7 @@ sub git_search_grep_body {
 			       esc_html(chop_str($co{'title'}, 50)) . "<br/>");
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
-			if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
+			if ($line =~ m/^(.*)($_searchtext)(.*)$/i) {
 				my $lead = esc_html($1) || "";
 				$lead = chop_str($lead, 30, 10);
 				my $match = esc_html($2) || "";
@@ -4325,7 +4325,7 @@ sub git_search {
 		} elsif ($searchtype eq 'committer') {
 			$greptype = "--committer=";
 		}
-		$greptype .= $searchtext;
+		$greptype .= quotemeta $searchtext;
 		my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
 
 		my $paging_nav = '';
@@ -4374,8 +4374,9 @@ sub git_search {
 		my $alternate = 1;
 		$/ = "\n";
 		my $git_command = git_cmd_str();
+		my $_searchtext = quotemeta $searchtext;
 		open my $fd, "-|", "$git_command rev-list $hash | " .
-			"$git_command diff-tree -r --stdin -S\'$searchtext\'";
+			"$git_command diff-tree -r --stdin -S\'$_searchtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
