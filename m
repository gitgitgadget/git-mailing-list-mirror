From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Teach 'git remote' how to cleanup stale tracking branches.
Date: Fri, 2 Feb 2007 00:06:08 -0500
Message-ID: <20070202050608.GB20505@spearce.org>
References: <58b74d176fd10417a58d42d9437c631d03f4c4f6.1170392736.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 06:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCqcx-0003Nf-3e
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 06:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbXBBFGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 00:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423019AbXBBFGO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 00:06:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35901 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423017AbXBBFGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 00:06:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCqcY-00085p-9I; Fri, 02 Feb 2007 00:05:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D647120FBAE; Fri,  2 Feb 2007 00:06:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <58b74d176fd10417a58d42d9437c631d03f4c4f6.1170392736.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38454>

Since it can be annoying to manually cleanup 40 tracking branches
which were removed by the remote system, 'git remote prune <n>'
can now be used to delete any tracking branches under <n> which
are no longer available on the remote system.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Be nice if this made it into 1.5.0.  :-)

 Documentation/git-remote.txt |    5 +++++
 git-remote.perl              |   39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 358c1ac..817651e 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git-remote'
 'git-remote' add <name> <url>
 'git-remote' show <name>
+'git-remote' prune <name>
 
 DESCRIPTION
 -----------
@@ -26,6 +27,10 @@ update remote-tracking branches <name>/<branch>.
 
 In the third form, gives some information about the remote <name>.
 
+In the fourth form, deletes all stale tracking branches under <name>.
+These stale branches have already been removed from the remote repository
+referenced by <name>, but are still locally available in "remotes/<name>".
+
 The remote configuration is achieved using the `remote.origin.url` and
 `remote.origin.fetch` configuration variables.  (See
 gitlink:git-config[1]).
diff --git a/git-remote.perl b/git-remote.perl
index 969d33b..f16ff21 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -200,7 +200,7 @@ sub show_mapping {
 		print "    @$new\n";
 	}
 	if (@$stale) {
-		print "  Stale tracking branches in remotes/$name (you'd better remove them)\n";
+		print "  Stale tracking branches in remotes/$name (use 'git remote prune')\n";
 		print "    @$stale\n";
 	}
 	if (@$tracked) {
@@ -209,6 +209,23 @@ sub show_mapping {
 	}
 }
 
+sub prune_remote {
+	my ($name, $ls_remote) = @_;
+	if (!exists $remote->{$name}) {
+		print STDERR "No such remote $name\n";
+		return;
+	}
+	my $info = $remote->{$name};
+	update_ls_remote($ls_remote, $info);
+
+	my ($new, $stale, $tracked) = list_mapping($name, $info);
+	my $prefix = "refs/remotes/$name";
+	foreach my $to_prune (@$stale) {
+		my @v = $git->command(qw(rev-parse --verify), "$prefix/$to_prune");
+		$git->command(qw(update-ref -d), "$prefix/$to_prune", $v[0]);
+	}
+}
+
 sub show_remote {
 	my ($name, $ls_remote) = @_;
 	if (!exists $remote->{$name}) {
@@ -270,6 +287,25 @@ elsif ($ARGV[0] eq 'show') {
 		show_remote($ARGV[$i], $ls_remote);
 	}
 }
+elsif ($ARGV[0] eq 'prune') {
+	my $ls_remote = 1;
+	my $i;
+	for ($i = 1; $i < @ARGV; $i++) {
+		if ($ARGV[$i] eq '-n') {
+			$ls_remote = 0;
+		}
+		else {
+			last;
+		}
+	}
+	if ($i >= @ARGV) {
+		print STDERR "Usage: git remote prune <remote>\n";
+		exit(1);
+	}
+	for (; $i < @ARGV; $i++) {
+		prune_remote($ARGV[$i], $ls_remote);
+	}
+}
 elsif ($ARGV[0] eq 'add') {
 	if (@ARGV != 3) {
 		print STDERR "Usage: git remote add <name> <url>\n";
@@ -281,5 +317,6 @@ else {
 	print STDERR "Usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote show <name>\n";
+	print STDERR "       git remote prune <name>\n";
 	exit(1);
 }
-- 
1.5.0.rc3.1.ge4b0e
