X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rerere: add clear, diff, and status commands
Date: Fri,  8 Dec 2006 13:29:55 -0800
Message-ID: <11656133963055-git-send-email-normalperson@yhbt.net>
References: <20061208212830.GB13944@localdomain>
NNTP-Posting-Date: Fri, 8 Dec 2006 21:30:11 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061208212830.GB13944@localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33749>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnIE-00088o-4u for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947291AbWLHV37 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947276AbWLHV37
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:29:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:48156 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947275AbWLHV36
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:29:58 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id C69DA2DC034; Fri,  8 Dec 2006 13:29:56 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 13:29:56 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

git-am and git-rebase will be updated to use 'clear', and
diff/status can be used to aid the user in tracking progress in
the resolution process.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-rerere.txt |   27 +++++++++++++++++++++++++--
 git-rerere.perl              |   25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 8b6b651..22494b2 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,8 +7,7 @@ git-rerere - Reuse recorded resolve
 
 SYNOPSIS
 --------
-'git-rerere'
-
+'git-rerere' [clear|diff|status]
 
 DESCRIPTION
 -----------
@@ -167,6 +166,30 @@ would conflict the same way the test merge you resolved earlier.
 `git-rerere` is run by `git rebase` to help you resolve this
 conflict.
 
+COMMANDS
+--------
+
+Normally, git-rerere is run without arguments or user-intervention.
+However, it has several commands that allow it to interact with
+its working state.
+
+'clear'::
+
+This resets the metadata used by rerere if a merge resolution is to be
+is aborted.  Calling gitlink:git-am[1] --skip or gitlink:git-rebase[1]
+[--skip|--abort] will automatcally invoke this command.
+
+'diff'::
+
+This displays diffs for the current state of the resolution.  It is
+useful for tracking what has changed while the user is resolving
+conflicts.  Additional arguments are passed directly to the system
+diff(1) command installed in PATH.
+
+'status'::
+
+Like diff, but this only prints the filenames that will be tracked
+for resolutions.
 
 Author
 ------
diff --git a/git-rerere.perl b/git-rerere.perl
index d3664ff..2703d01 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -172,6 +172,31 @@ sub merge {
 -d "$rr_dir" || exit(0);
 
 read_rr();
+
+if (my $arg = shift @ARGV) {
+	if ($arg eq 'clear') {
+		for my $path (keys %merge_rr) {
+			my $name = $merge_rr{$path};
+			if (-d "$rr_dir/$name" && ! -f "$rr_dir/$name/postimage") {
+				rmtree(["$rr_dir/$name"]);
+			}
+		}
+		unlink $merge_rr;
+	} elsif ($arg eq 'status') {
+		for my $path (keys %merge_rr) {
+			print $path, "\n";
+		}
+	} elsif ($arg eq 'diff') {
+		for my $path (keys %merge_rr) {
+			my $name = $merge_rr{$path};
+			system(qw/diff/, @ARGV,
+				'-L', "a/$path", '-L', "b/$path",
+				"$rr_dir/$name/preimage", $path);
+		}
+	}
+	exit 0;
+}
+
 my %conflict = map { $_ => 1 } find_conflict();
 
 # MERGE_RR records paths with conflicts immediately after merge
-- 
1.4.4.2.g860f4
