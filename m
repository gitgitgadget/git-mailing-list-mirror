From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 3/8] Prepare Git::SVN::Migration for extraction from git-svn.
Date: Thu, 26 Jul 2012 17:26:02 -0700
Message-ID: <1343348767-86446-4-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOH-0004JO-Pf
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab2G0A0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41590 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2G0A0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4044857pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LNg04NWIJgLtC8MbyXgPNqRmfFutWpmjX+fAe6Z6C2A=;
        b=Pm1pqmrGbCfy8JCDPMzSP9oPU1ynfYLKrs2/zI47eQjvzjDxQ2NStHJP9J4EQFO0u/
         Clfg4rgF25ZSIb4+4vIj4/JQuIdEMUHopnjzpx36I4Q8flvwnP/nm2JYd7VM3Ucf/RW5
         sRefLar0NaIkBk8nQdDBREvBCi9tcubgemg0rmIBeAFKj5FWbEenQbEeqNP8Rhd5o1Rz
         TtcBl8Yc2KBNiCHFcMZMvl/pRPDm4H4f8nRsTpptBEjrw1s/vIL4Bg9/VebzQs/H/MlC
         z81PxQrJw9mgO1V9QbRw0Zshc69+59FowmheBqdqwC3IKGMjw/gOloIZdm/migFxAg1n
         3MoA==
Received: by 10.68.240.73 with SMTP id vy9mr7084814pbc.156.1343348803096;
        Thu, 26 Jul 2012 17:26:43 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202324>

From: "Michael G. Schwern" <schwern@pobox.com>

* Load Git command functions on its own.
* Load Git::SVN modules on its own.

Drive by refactorings...
* Use our() instead of use vars.
* Eliminate the auto loading of Git functions.
---
 git-svn.perl | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7c8da44..db60984 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -14,6 +14,18 @@ use Git::SVN;
 use Git::SVN::Log;
 use Git::SVN::Utils qw(fatal can_compress);
 
+use Git qw(
+    git_cmd_try
+    command
+    command_oneline
+    command_noisy
+    command_output_pipe
+    command_close_pipe
+    command_bidi_pipe
+    command_close_bidi_pipe
+);
+
+
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
 	command_oneline([qw/rev-parse --show-prefix/], STDERR => 0)
@@ -75,7 +87,6 @@ use File::Spec;
 use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
-use Git;
 use Git::SVN::Editor qw//;
 use Git::SVN::Fetcher qw//;
 use Git::SVN::Ra qw//;
@@ -83,16 +94,6 @@ use Git::SVN::Prompt qw//;
 use Memoize;  # core since 5.8.0, Jul 2002
 
 BEGIN {
-	# import functions from Git into our packages, en masse
-	no strict 'refs';
-	foreach (qw/command command_oneline command_noisy command_output_pipe
-	            command_input_pipe command_close_pipe
-	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Migration),
-			__PACKAGE__) {
-			*{"${package}::$_"} = \&{"Git::$_"};
-		}
-	}
 	Memoize::memoize 'Git::config';
 	Memoize::memoize 'Git::config_bool';
 }
@@ -2080,7 +2081,14 @@ use warnings;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Basename qw/dirname basename/;
-use vars qw/$_minimize/;
+
+our $_minimize;
+use Git qw(
+	command
+	command_noisy
+	command_output_pipe
+	command_close_pipe
+);
 
 sub migrate_from_v0 {
 	my $git_dir = $ENV{GIT_DIR};
@@ -2189,6 +2197,7 @@ sub migrate_from_v2 {
 	read_old_urls(\%l_map, '', "$ENV{GIT_DIR}/svn");
 	my $migrated = 0;
 
+	require Git::SVN;
 	foreach my $ref_id (sort keys %l_map) {
 		eval { Git::SVN->init($l_map{$ref_id}, '', undef, $ref_id) };
 		if ($@) {
@@ -2200,6 +2209,9 @@ sub migrate_from_v2 {
 }
 
 sub minimize_connections {
+	require Git::SVN;
+	require Git::SVN::Ra;
+
 	my $r = Git::SVN::read_all_remotes();
 	my $new_urls = {};
 	my $root_repos = {};
-- 
1.7.11.1
