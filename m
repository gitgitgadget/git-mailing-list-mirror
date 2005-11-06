From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Support for passing path to custom map in git-shortlog.perl
Date: Mon, 07 Nov 2005 00:07:57 +0100
Message-ID: <20051106230757.24941.19267.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 00:09:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYtcK-0007nL-BV
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 00:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVKFXIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKFXIA
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 18:08:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23514 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751283AbVKFXH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 18:07:59 -0500
Received: (qmail 24957 invoked from network); 7 Nov 2005 00:07:57 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2005 00:07:57 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11237>

Aside of looking into .mailmap, add support for -m MAPFILE.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-shortlog.txt |   10 +++++++++-
 git-shortlog.perl              |   10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 65ca77f..c8de78e 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,13 +8,21 @@ git-shortlog - Summarize 'git log' outpu
 
 SYNOPSIS
 --------
-'git-log --pretty=short | git shortlog'
+'git-log --pretty=short | git shortlog [-m MAILMAP_FILE]'
 
 DESCRIPTION
 -----------
 Summarizes 'git log' output in a format suitable for inclusion
 in release announcements.
 
+OPTIONS
+-------
+-m MAILMAP_FILE::
+	File containing the email-to-realname mappings to be used
+	in case of the realname missing in the "Author" field of
+	the commit. In addition, the '.mailmap' file and few predefined
+	mappings are also always searched.
+
 
 Author
 ------
diff --git a/git-shortlog.perl b/git-shortlog.perl
index 7283159..cd83dbe 100755
--- a/git-shortlog.perl
+++ b/git-shortlog.perl
@@ -1,6 +1,7 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Getopt::Std;
 
 my (%mailmap);
 my (%email);
@@ -9,6 +10,9 @@ my $pstate = 1;
 my $n_records = 0;
 my $n_output = 0;
 
+my (%opts);
+getopts('m:', \%opts);
+
 sub shortlog_entry($$) {
 	my ($name, $desc) = @_;
 	my $key = $name;
@@ -132,6 +136,12 @@ sub setup_mailmap {
 		read_mailmap($fh, \%mailmap);
 		close $fh;
 	}
+	if ($opts{'m'}) {
+		my $fh = undef;
+		open($fh, '<', $opts{'m'}) or die "Cannot open mailmap $opts{m}: $!";
+		read_mailmap($fh, \%mailmap);
+		close($fh);
+	}
 }
 
 sub finalize {
