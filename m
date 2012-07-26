From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 4/4] Move initialization of Git::SVN variables into Git::SVN.
Date: Thu, 26 Jul 2012 16:22:25 -0700
Message-ID: <1343344945-3717-5-git-send-email-schwern@pobox.com>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 01:23:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuXOh-0005KE-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab2GZXXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:23:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41890 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab2GZXXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:23:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3965600pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 16:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ysQkK7tCq43t+SdR6cretzLx0YYibOJAglThbMDjet0=;
        b=r6F4BfSLR6Sy8AemnYJzGctQau6deDIdOyjVU1IX9T9qfw2e1+Mk0KYCmnyihJ6faK
         i6JpLLPP65cHMKKe2+Ss07ey89kn+c8RKZwfh2A8ve90UMMObwWH/HrItoChmXIISnYG
         2CT3m1u2mLkLg0ShjQUEno4iY1dKgnxgUB0w2Q0Aw6HUqs+MKhERH2/dX3q+8AH+BxMp
         wuWIQF/oyciZXNEHbE6pT+s0lgz5Vk5IMNof4nHxdF/NHrkU3oQ9wFlbJN+dvdT0YsDA
         Xc51uB4II5XgTrtnFQsj+k+BxWoUfJ+JiGwMiHdYhjjbMAxAJDg0mx+VyOdOQyLJzmdt
         ineg==
Received: by 10.68.227.201 with SMTP id sc9mr8517565pbc.163.1343344981879;
        Thu, 26 Jul 2012 16:23:01 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id oo6sm596728pbc.22.2012.07.26.16.23.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 16:23:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343344945-3717-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202319>

From: "Michael G. Schwern" <schwern@pobox.com>

Also it can compile on its own now, yay!
---
 git-svn.perl          | 4 ----
 perl/Git/SVN.pm       | 9 +++++++--
 t/Git-SVN/00compile.t | 3 ++-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4c77f69..ef10f6f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -20,10 +20,7 @@ my $cmd_dir_prefix = eval {
 
 my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
 $ENV{GIT_DIR} ||= '.git';
-$Git::SVN::default_repo_id = 'svn';
-$Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
-$Git::SVN::_minimize_url = 'unset';
 
 if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
 	$ENV{SVN_SSH} = $ENV{GIT_SSH};
@@ -114,7 +111,6 @@ my ($_stdin, $_help, $_edit,
 # This is a refactoring artifact so Git::SVN can get at this git-svn switch.
 sub opt_prefix { return $_prefix || '' }
 
-$Git::SVN::_follow_parent = 1;
 $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index c71c041..2e0d7f0 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -3,9 +3,9 @@ use strict;
 use warnings;
 use Fcntl qw/:DEFAULT :seek/;
 use constant rev_map_fmt => 'NH40';
-use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
+use vars qw/$_no_metadata
             $_repack $_repack_flags $_use_svm_props $_head
-            $_use_svnsync_props $no_reuse_existing $_minimize_url
+            $_use_svnsync_props $no_reuse_existing
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
@@ -30,6 +30,11 @@ BEGIN {
 	$can_use_yaml = eval { require Git::SVN::Memoize::YAML; 1};
 }
 
+our $_follow_parent  = 1;
+our $_minimize_url   = 'unset';
+our $default_repo_id = 'svn';
+our $default_ref_id  = $ENV{GIT_SVN_ID} || 'git-svn';
+
 my ($_gc_nr, $_gc_period);
 
 # properties that we do not log:
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index a7aa85a..97475d9 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,6 +3,7 @@
 use strict;
 use warnings;
 
-use Test::More tests => 1;
+use Test::More tests => 2;
 
 require_ok 'Git::SVN::Utils';
+require_ok 'Git::SVN';
-- 
1.7.11.1
