From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/3] git send-email: interpret unknown files as revision lists
Date: Fri, 31 Oct 2008 11:57:11 +0100
Message-ID: <1225450632-7230-3-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225450632-7230-2-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 11:58:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvriD-0001ag-Ml
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 11:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbYJaK5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 06:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbYJaK5R
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 06:57:17 -0400
Received: from pan.madism.org ([88.191.52.104]:53957 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbYJaK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 06:57:15 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9760E3B56B;
	Fri, 31 Oct 2008 11:57:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B987E5EE242; Fri, 31 Oct 2008 11:57:12 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.759.g40a2.dirty
In-Reply-To: <1225450632-7230-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99570>

Instead of skipping unkown files on the command line, pass them through
git format-patch into a safe temporary directory. This allow no
complicated rev-list option lists combining "--all" "--not" and so on, but
allow to use ranges which are quite enough for most of the use cases.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-send-email.txt |    2 +-
 git-send-email.perl              |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 82f5056..cafff1a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -8,7 +8,7 @@ git-send-email - Send a collection of patches as emails
 
 SYNOPSIS
 --------
-'git send-email' [options] <file|directory> [... file|directory]
+'git send-email' [options] <file|directory|rev-list>...
 
 
 DESCRIPTION
diff --git a/git-send-email.perl b/git-send-email.perl
index 94ca5c8..0d50ee2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -22,6 +22,7 @@ use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
 use Term::ANSIColor;
+use File::Temp qw/ tempdir /;
 use Git;
 
 package FakeTerm;
@@ -38,7 +39,7 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory>...
+git send-email [options] <file | directory | rev-list >
 
   Composing:
     --from                  <str>  * Email From:
@@ -378,7 +379,8 @@ for my $f (@ARGV) {
 	} elsif (-f $f or -p $f) {
 		push @files, $f;
 	} else {
-		print STDERR "Skipping $f - not found.\n";
+		my $tempdir = tempdir(CLEANUP => 1);
+		push @files, $repo->command('format-patch', '-o', $tempdir, $f);
 	}
 }
 
-- 
1.6.0.3.759.g40a2.dirty
