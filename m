From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 2/4] Prepare Git::SVN for extraction into its own file.
Date: Tue, 24 Jul 2012 23:01:04 -0700
Message-ID: <1343196066-81319-3-git-send-email-schwern@pobox.com>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, "Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 08:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StufG-0007sS-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745Ab2GYGBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:01:36 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:55394 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719Ab2GYGBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:01:36 -0400
Received: by gglu4 with SMTP id u4so333671ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 23:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DIuiM0ZSPJyRzRgGinPwPXPpqbYEFNVUemwXVLkuy4A=;
        b=0JhhWrWMBXZeDP11/Y8zesabYKVEoFBD/XVHYsvKS7JiholFt6vxlgf9eXuHXQomhT
         LUU5tNQKO7Jh2y9KqaX6mNNnK7+An71dFyImAccLHOucuRC8FxayOWKb6zHMYasg3h32
         sepkzMAhNSv4cpvfFA6/g/2+9C2YwtHURPoVwNGK08weyO/rj1/5rwqW2fnDQAMDFrSU
         LloqO1HylOckhcf0eXryHDtrtdPDTGPgd3y73PU8wvRSXhdVyRmS1REejdNluRyqOSNm
         YVklaMA0XbDLSQZfI4OwaCPuEftt+bCEZNsfujElyVagElX8vG3hJ+63s+baQal/2wBB
         bp1Q==
Received: by 10.66.83.200 with SMTP id s8mr10191379pay.10.1343196094693;
        Tue, 24 Jul 2012 23:01:34 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id oy8sm13681630pbc.52.2012.07.24.23.01.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:01:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343196066-81319-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202126>

From: "Michael G. Schwern" <schwern@pobox.com>

This means it should be able to load without git-svn being loaded.

* Load Git.pm on its own and all the needed command functions.

* It needs to grab at a git-svn lexical $_prefix representing the --prefix
  option.  Provide opt_prefix() for that.  This is a refactoring artifact.
  The prefix should really be passed into Git::SVN->new.

* Unqualify unnecessarily fully qualified globals like
  $Git::SVN::default_repo_id.

* Lexically isolate the class just to make sure nothing is leaking out.
---
 git-svn.perl | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 79fe4a4..9cdf6fc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -89,7 +89,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Migration Git::SVN::Log Git::SVN),
+		for my $package ( qw(Git::SVN::Migration Git::SVN::Log),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -109,6 +109,10 @@ my ($_stdin, $_help, $_edit,
 	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
+
+# This is a refactoring artifact so Git::SVN can get at this git-svn switch.
+sub opt_prefix { return $_prefix || '' }
+
 $Git::SVN::_follow_parent = 1;
 $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
@@ -2038,6 +2042,7 @@ sub gc_directory {
 	}
 }
 
+{
 package Git::SVN;
 use strict;
 use warnings;
@@ -2056,6 +2061,13 @@ use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
 
+use Git qw(
+    command
+    command_oneline
+    command_noisy
+    command_output_pipe
+    command_close_pipe
+);
 use Git::SVN::Utils qw(fatal can_compress);
 
 my $can_use_yaml;
@@ -4280,12 +4292,13 @@ sub find_rev_after {
 sub _new {
 	my ($class, $repo_id, $ref_id, $path) = @_;
 	unless (defined $repo_id && length $repo_id) {
-		$repo_id = $Git::SVN::default_repo_id;
+		$repo_id = $default_repo_id;
 	}
 	unless (defined $ref_id && length $ref_id) {
-		$_prefix = '' unless defined($_prefix);
+		# Access the prefix option from the git-svn main program if it's loaded.
+		my $prefix = defined &::opt_prefix ? ::opt_prefix() : "";
 		$_[2] = $ref_id =
-		             "refs/remotes/$_prefix$Git::SVN::default_ref_id";
+		             "refs/remotes/$prefix$default_ref_id";
 	}
 	$_[1] = $repo_id;
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
@@ -4347,6 +4360,7 @@ sub uri_decode {
 sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
+}
 
 package Git::SVN::Log;
 use strict;
-- 
1.7.11.1
