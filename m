From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Sun, 18 Feb 2007 23:00:00 -0500
Message-ID: <E1HIzh2-0001Ph-T2@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 05:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIzhR-0002zo-6o
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 05:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbXBSEAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 23:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbXBSEAF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 23:00:05 -0500
Received: from thunk.org ([69.25.196.29]:43169 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbXBSEAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 23:00:03 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HIzmM-0003WC-SK; Sun, 18 Feb 2007 23:05:31 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HIzh2-0001Ph-T2; Sun, 18 Feb 2007 23:00:00 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This allows users to use the command "git remote update" to update all
remotes that are being tracked in the repository.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/config.txt     |    4 ++++
 Documentation/git-remote.txt |   10 +++++++++-
 git-remote.perl              |   13 +++++++++++++
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3865535..d8e696f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,6 +439,10 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
+remote.fetch::
+	The list of remotes which are fetched by "git remote update".
+	See gitlink:git-remote[1].
+
 remote.<name>.url::
 	The URL of a remote repository.  See gitlink:git-fetch[1] or
 	gitlink:git-push[1].
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a60c31a..eed7aa2 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git-remote' add <name> <url>
 'git-remote' show <name>
 'git-remote' prune <name>
+'git-remote' update
 
 DESCRIPTION
 -----------
@@ -40,7 +41,14 @@ Gives some information about the remote <name>.
 
 Deletes all stale tracking branches under <name>.
 These stale branches have already been removed from the remote repository
-referenced by <name>, but are still locally available in "remotes/<name>".
+referenced by <name>, but are still locally available in
+"remotes/<name>".
+
+'update'::
+
+Fetch updates for the remotes in the repository.  By default all remotes
+are updated, but this can be configured via the configuration parameter 
+'remote.fetch'.   (See gitlink:git-config[1]).
 
 
 DISCUSSION
diff --git a/git-remote.perl b/git-remote.perl
index c56c5a8..1db9901 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -303,6 +303,18 @@ elsif ($ARGV[0] eq 'show') {
 		show_remote($ARGV[$i], $ls_remote);
 	}
 }
+elsif ($ARGV[0] eq 'update') {
+        my $conf = $git->config("remote.fetch");
+	if (defined($conf)) {
+	    	@remotes = split(' ', $conf);
+	} else {
+	        @remotes = sort keys %$remote;
+	}
+	for (@remotes) {
+		print "Fetching $_\n";
+		$git->command('fetch', "$_");
+	}
+}
 elsif ($ARGV[0] eq 'prune') {
 	my $ls_remote = 1;
 	my $i;
@@ -360,5 +372,6 @@ else {
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote show <name>\n";
 	print STDERR "       git remote prune <name>\n";
+	print STDERR "       git remote update\n";
 	exit(1);
 }
-- 
1.5.0.50.gb75812-dirty
