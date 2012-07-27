From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 5/8] Load all the modules in one place and before running code.
Date: Thu, 26 Jul 2012 17:26:04 -0700
Message-ID: <1343348767-86446-6-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOc-0004ZF-R0
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab2G0A0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56174 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2G0A0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:46 -0400
Received: by yhmm54 with SMTP id m54so2641441yhm.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zbOKlAZ1a64o+TFfnY6d5tBWVmWSJyi8S+0bCxNtLzk=;
        b=ELjDEMa32wW3bTbTYMhls3nVZLAeE8MwBbIVhkwNuqoKhBK2gM4/Xdh4J28UTiuNPd
         GQPsPLRv2JawHjYlf8xThZEveIcePsZRkYlqq5ngQypmpNVxIjuRzMJ5FF4C82iU+gN6
         YaWkfco15ylwxbGnX5GlI7eWUmk5H+vUk8ZcqNegrgCoXPo2czZmQZY7stWH4NZ9h+3T
         kcjTDua69hqg2QkqVIExhfx+MjshT6Zh3OzJu6RzUkDj4sy8qklli94Anux2ddS0iqnd
         uS6tBmi0/az2zW7Iohkl8hHM70HcDji30RJaLJbln0pmqsL0VzIZU4rTm2YPV7YZmONr
         WrsA==
Received: by 10.66.78.73 with SMTP id z9mr1395788paw.9.1343348805403;
        Thu, 26 Jul 2012 17:26:45 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202329>

From: "Michael G. Schwern" <schwern@pobox.com>

Just makes the code easier to follow.  No functional change.

Also eliminate an unused lexical $SVN.
---
 git-svn.perl | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3741e2e..fc49ad6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -10,11 +10,26 @@ use vars qw/	$AUTHOR $VERSION
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
+use Carp qw/croak/;
+use Digest::MD5;
+use IO::File qw//;
+use File::Basename qw/dirname basename/;
+use File::Path qw/mkpath/;
+use File::Spec;
+use File::Find;
+use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
+use IPC::Open3;
+use Memoize;
+
 use Git::SVN;
+use Git::SVN::Editor;
+use Git::SVN::Fetcher;
+use Git::SVN::Ra;
+use Git::SVN::Prompt;
 use Git::SVN::Log;
 use Git::SVN::Migration;
-use Git::SVN::Utils qw(fatal can_compress);
 
+use Git::SVN::Utils qw(fatal can_compress);
 use Git qw(
     git_cmd_try
     command
@@ -26,6 +41,11 @@ use Git qw(
     command_close_bidi_pipe
 );
 
+BEGIN {
+	Memoize::memoize 'Git::config';
+	Memoize::memoize 'Git::config_bool';
+}
+
 
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
@@ -79,28 +99,6 @@ sub _req_svn {
 	}
 }
 
-use Carp qw/croak/;
-use Digest::MD5;
-use IO::File qw//;
-use File::Basename qw/dirname basename/;
-use File::Path qw/mkpath/;
-use File::Spec;
-use File::Find;
-use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
-use IPC::Open3;
-use Git::SVN::Editor qw//;
-use Git::SVN::Fetcher qw//;
-use Git::SVN::Ra qw//;
-use Git::SVN::Prompt qw//;
-use Memoize;  # core since 5.8.0, Jul 2002
-
-BEGIN {
-	Memoize::memoize 'Git::config';
-	Memoize::memoize 'Git::config_bool';
-}
-
-my ($SVN);
-
 $sha1 = qr/[a-f\d]{40}/;
 $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
-- 
1.7.11.1
