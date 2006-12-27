From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] gitweb: Re-enable rev-list --parents for parse_commit.
Date: Wed, 27 Dec 2006 14:22:21 +0000
Message-ID: <20061227142221.GC6558@localhost>
References: <11669707092427-git-send-email-robfitz@273k.net> <11669707094097-git-send-email-robfitz@273k.net> <empkcf$qp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 15:22:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzZfs-0007oJ-3j
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 15:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbWL0OW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 09:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWL0OW2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 09:22:28 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:58860 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbWL0OW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 09:22:27 -0500
Received: from 213-202-172-175.bas504.dsl.esat.net ([213.202.172.175] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GzZfN-0000kD-TN; Wed, 27 Dec 2006 14:22:02 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <empkcf$qp$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35472>

Re-enable rev-list --parents for parse_commit which was removed in
(208b2dff95bb48682c351099023a1cbb0e1edf26).  rev-list --parents is not
just used to return the parent headers in the commit object, it
includes any grafts which are vaild for the commit.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---


> Actually --header output gives us original parents. Rewritten parents
> (available with --parents) include also grafts and shallow clone grafts.
> For parse_commit we want --parents, for parse_commits we don't want it
> because --parents affects --full-history.

Heres a patch the re-enables --parents for parse_commit.

Robert


 gitweb/gitweb.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 65fcdb0..da12be7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1271,7 +1271,7 @@ sub parse_tag {
 }
 
 sub parse_commit_text {
-	my ($commit_text) = @_;
+	my ($commit_text, $withparents) = @_;
 	my @commit_lines = split '\n', $commit_text;
 	my %co;
 
@@ -1281,13 +1281,12 @@ sub parse_commit_text {
 	if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
 		return;
 	}
-	$co{'id'} = $header;
-	my @parents;
+	($co{'id'}, my @parents) = split ' ', $header;
 	while (my $line = shift @commit_lines) {
 		last if $line eq "\n";
 		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
 			$co{'tree'} = $1;
-		} elsif ($line =~ m/^parent ([0-9a-fA-F]{40})$/) {
+		} elsif ((!defined $withparents) && ($line =~ m/^parent ([0-9a-fA-F]{40})$/)) {
 			push @parents, $1;
 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
 			$co{'author'} = $1;
@@ -1373,12 +1372,13 @@ sub parse_commit {
 	local $/ = "\0";
 
 	open my $fd, "-|", git_cmd(), "rev-list",
+		"--parents",
 		"--header",
 		"--max-count=1",
 		$commit_id,
 		"--",
 		or die_error(undef, "Open git-rev-list failed");
-	%co = parse_commit_text(<$fd>);
+	%co = parse_commit_text(<$fd>, 1);
 	close $fd;
 
 	return %co;
-- 
1.4.4.3.g6934
