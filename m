From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] Allow git-remote to update named groups of remotes
Date: Tue, 20 Feb 2007 15:13:43 -0500
Message-ID: <11720024234178-git-send-email-tytso@mit.edu>
References: <11720024233629-git-send-email-tytso@mit.edu>
Cc: Theodore Ts'o <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 21:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJbN5-0001TE-00
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 21:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbXBTUNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 15:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbXBTUNs
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 15:13:48 -0500
Received: from thunk.org ([69.25.196.29]:52684 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030411AbXBTUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 15:13:46 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HJbSF-0005KK-FB; Tue, 20 Feb 2007 15:19:15 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HJbMt-0003hI-Cf; Tue, 20 Feb 2007 15:13:43 -0500
X-Mailer: git-send-email 1.5.0.1.38.g392d-dirty
In-Reply-To: <11720024233629-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40259>

In response to a feature request from Shawn Pearce, this patch allows
a user to update a named group of remotes by using "git remote update
<group>", where the group is defined in the config file by
remotes.<group>.  The default if the named group is not specified is
now fetched group remotes.default, instead of remote.fetch, which is
what had been previously used.

In addition, if remotes.default is not defined, all remotes defined in
the config file will be used, as before, but there is now also
possible to request that a particular repository to be skipped by
default by using the boolean configuration parameter
remote.<name>.skipDefaultUpdate.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/config.txt     |   12 ++++++++----
 Documentation/git-remote.txt |   11 +++++++----
 git-remote.perl              |   40 +++++++++++++++++++++++++++++++---------
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d8e696f..c8cba00 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,10 +439,6 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
-remote.fetch::
-	The list of remotes which are fetched by "git remote update".
-	See gitlink:git-remote[1].
-
 remote.<name>.url::
 	The URL of a remote repository.  See gitlink:git-fetch[1] or
 	gitlink:git-push[1].
@@ -455,6 +451,10 @@ remote.<name>.push::
 	The default set of "refspec" for gitlink:git-push[1]. See
 	gitlink:git-push[1].
 
+remote.<name>.skipDefaultUpdate::
+	If true, this remote will be skipped by default when updating 
+	using the remote subcommand of gitlink:git-remote[1].
+
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
 	option \--exec of gitlink:git-push[1].
@@ -463,6 +463,10 @@ remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
 	option \--exec of gitlink:git-fetch-pack[1].
 
+remotes.<group>::
+	The list of remotes which are fetched by "git remote update
+	<group>".  See gitlink:git-remote[1].
+
 repack.usedeltabaseoffset::
 	Allow gitlink:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 06ba2e6..250761f 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git-remote' add <name> <url>
 'git-remote' show <name>
 'git-remote' prune <name>
-'git-remote' update
+'git-remote' update [group]
 
 DESCRIPTION
 -----------
@@ -46,9 +46,12 @@ referenced by <name>, but are still locally available in
 
 'update'::
 
-Fetch updates for the remotes in the repository.  By default all remotes
-are updated, but this can be configured via the configuration parameter
-'remote.fetch'.   (See gitlink:git-config[1]).
+Fetch updates for a named set of remotes in the repository as defined by
+remotes.<group>.  If a named group is not specified on the command line,
+the configuration parameter remotes.default will get used; if
+remotes.default is not defined, all remotes which do not the
+configuration parameter remote.<name>.skipDefaultUpdate set to true will
+be updated.  (See gitlink:git-config[1]).
 
 
 DISCUSSION
diff --git a/git-remote.perl b/git-remote.perl
index 6e473ec..5a4e0ed 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -274,6 +274,31 @@ sub add_remote {
 	}
 }
 
+sub update_remote {
+	my ($name) = @_;
+
+        my $conf = $git->config("remotes." . $name);
+	if (defined($conf)) {
+		@remotes = split(' ', $conf);
+	} elsif ($name eq 'default') {
+	    	undef @remotes;
+		for (sort keys %$remote) {
+			my $do_fetch = $git->config_boolean("remote." . $_ . 
+						    ".skipDefaultUpdate");
+			if (!defined($do_fetch) || $do_fetch ne "true") {
+				push @remotes, $_;
+			}
+		}
+	} else {
+		print STDERR "Remote group $name does not exists.\n";
+		exit(1);
+	}
+	for (@remotes) {
+		print "Updating $_\n";
+		$git->command('fetch', "$_");
+	}
+}
+
 sub add_usage {
 	print STDERR "Usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
 	exit(1);
@@ -304,15 +329,12 @@ elsif ($ARGV[0] eq 'show') {
 	}
 }
 elsif ($ARGV[0] eq 'update') {
-        my $conf = $git->config("remote.fetch");
-	if (defined($conf)) {
-		@remotes = split(' ', $conf);
-	} else {
-	        @remotes = sort keys %$remote;
+	if (@ARGV <= 1) {
+		update_remote("default");
+		exit(1);
 	}
-	for (@remotes) {
-		print "Fetching $_\n";
-		$git->command('fetch', "$_");
+	for ($i = 1; $i < @ARGV; $i++) {
+		update_remote($ARGV[$i]);
 	}
 }
 elsif ($ARGV[0] eq 'prune') {
@@ -372,6 +394,6 @@ else {
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote show <name>\n";
 	print STDERR "       git remote prune <name>\n";
-	print STDERR "       git remote update\n";
+	print STDERR "       git remote update [group]\n";
 	exit(1);
 }
-- 
1.5.0.1.38.g392d-dirty
