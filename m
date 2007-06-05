From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] remote: add 'rm' subcommand
Date: Tue,  5 Jun 2007 19:25:23 -0400
Message-ID: <11810859232541-git-send-email-jbowes@dangerouslyinc.com>
To: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 01:27:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HviR5-0002U7-RI
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 01:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763545AbXFEX1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbXFEX1K
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 19:27:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46006 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763545AbXFEX1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 19:27:08 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l55NR5PZ000761;
	Tue, 5 Jun 2007 19:27:05 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l55NR5N1011249;
	Tue, 5 Jun 2007 19:27:05 -0400
Received: from localhost.localdomain (vpn-14-161.rdu.redhat.com [10.11.14.161])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l55NR4PU028925;
	Tue, 5 Jun 2007 19:27:04 -0400
X-Mailer: git-send-email 1.5.2.1.851.g432c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49235>

Introduce git-remote rm <name> which will:
 - Remove the remote config entry for <name>.
 - Remove any config entries for tracking branches of <name>.
 - Remove any stored remote branches of <name>.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

Here's a quick patch to implement the reverse of 'git-remote add', as
was asked about recently on the list[1]. Tested minimally with a
collection of on-disk repositories.

If there is any interest in this, I'll follow up later with additions
to the docs.

-James

[1] http://article.gmane.org/gmane.comp.version-control.git/49222

 git-remote.perl |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 5763799..05aa8d6 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -313,6 +313,34 @@ sub update_remote {
 	}
 }
 
+sub rm_remote {
+    my ($name) = @_;
+	if (!exists $remote->{$name}) {
+		print STDERR "No such remote $name\n";
+		return;
+	}
+
+	$git->command('config', '--remove-section', "remote.$name");
+
+	eval {
+	    my @trackers = $git->command('config', '--get-regexp',
+			'branch.*.remote', $name);
+		for (@trackers) {
+			/^branch\.(.*)?\.remote/;
+			$git->config('--unset', "branch.$1.remote");
+			$git->config('--unset', "branch.$1.merge");
+		}
+	};
+
+
+    my @refs = $git->command('for-each-ref',
+		'--format=%(refname) %(objectname)', "refs/remotes/$name");
+	for (@refs) {
+		($ref, $object) = split;
+		$git->command(qw(update-ref -d), $ref, $object);
+	}
+}
+
 sub add_usage {
 	print STDERR "Usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
 	exit(1);
@@ -403,9 +431,19 @@ elsif ($ARGV[0] eq 'add') {
 	}
 	add_remote($ARGV[1], $ARGV[2], \%opts);
 }
+elsif ($ARGV[0] eq 'rm') {
+	if (@ARGV <= 1) {
+		print STDERR "Usage: git remote rm <remote>\n";
+	}
+    else {
+        rm_remote($ARGV[1]);
+	}
+    exit(1);
+}
 else {
 	print STDERR "Usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
+	print STDERR "       git remote rm <name>\n";
 	print STDERR "       git remote show <name>\n";
 	print STDERR "       git remote prune <name>\n";
 	print STDERR "       git remote update [group]\n";
-- 
1.5.2.1.851.g432c
