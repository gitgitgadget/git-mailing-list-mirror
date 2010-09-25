From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Fri, 24 Sep 2010 23:51:50 -0400
Message-ID: <1285386710-27905-1-git-send-email-stevenrwalter@gmail.com>
References: <20100924162704.GA4513@dcvr.yhbt.net>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 05:52:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzLoJ-0001Yb-Sr
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 05:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab0IYDwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 23:52:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54587 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab0IYDwV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 23:52:21 -0400
Received: by gyd8 with SMTP id 8so1181052gyd.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 20:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=cPP0+9kR8gJsLw/QRi3HzUVXEId6zNzqjyGDeOU5xZk=;
        b=EfpCMjUJN7mV0O2Ht4LCrrkU9X+FfJFpSMj7PYaLL1yPfMUBA8YlnE+e8ZqXKfQboe
         YTTHt0DFMnMGlfA1J4g5Ogi9Qo4WOGxwAyDb2mMuofDQaSlbC0tMhQibW9+bTL2Tr0wR
         32OwApMYYqK8rd5sYGpGiNtamo+hSAuOOLBh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J0u3ZrYV/7uVMx0M+hD/jqAbgYx0341XjePHYuhvC1NyzOFSPRH3T9n+P7kWoJKy7T
         qwGKXqS8LNPyfMaDR0LqDEo+P2zOoAwBFs6XNu4RTU63+60p5Q/xkxygnMpWWJKF896i
         R+B9mwQvbrCY3qYaKLsQCAhw2YaQuplg23h2E=
Received: by 10.100.131.18 with SMTP id e18mr4681340and.219.1285386740777;
        Fri, 24 Sep 2010 20:52:20 -0700 (PDT)
Received: from brock (adsl-234-158-248.bgk.bellsouth.net [74.234.158.248])
        by mx.google.com with ESMTPS id d4sm4531917and.19.2010.09.24.20.52.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 20:52:19 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.72)
	(envelope-from <srwalter@dervierte>)
	id 1OzLo9-0007Ge-6m; Fri, 24 Sep 2010 23:52:17 -0400
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <20100924162704.GA4513@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157113>

As a first step towards preserving merges across dcommit, we need a
mechanism to update the svn:mergeinfo property.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl                 |   15 ++++++++++++++-
 t/t9157-git-svn-mergeinfo.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletions(-)
 create mode 100644 t/t9157-git-svn-mergeinfo.sh

diff --git a/git-svn.perl b/git-svn.perl
index c7c4dcd..1612fd7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -83,7 +83,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url, $_tag);
+	$_git_format, $_commit_url, $_tag, $_merge_info);
 $Git::SVN::_follow_parent = 1;
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
@@ -153,6 +153,7 @@ my %cmd = (
 			  'commit-url=s' => \$_commit_url,
 			  'revision|r=i' => \$_revision,
 			  'no-rebase' => \$_no_rebase,
+			  'mergeinfo=s' => \$_merge_info,
 			%cmt_opts, %fc_opts } ],
 	branch => [ \&cmd_branch,
 	            'Create a branch in the SVN repository',
@@ -568,6 +569,7 @@ sub cmd_dcommit {
 			                       print "Committed r$_[0]\n";
 			                       $cmt_rev = $_[0];
 			                },
+					mergeinfo => $_merge_info,
 			                svn_path => '');
 			if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
@@ -4449,6 +4451,7 @@ sub new {
 	$self->{path_prefix} = length $self->{svn_path} ?
 	                       "$self->{svn_path}/" : '';
 	$self->{config} = $opts->{config};
+	$self->{mergeinfo} = $opts->{mergeinfo};
 	return $self;
 }
 
@@ -4758,6 +4761,11 @@ sub change_file_prop {
 	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
 }
 
+sub change_dir_prop {
+	my ($self, $pbat, $pname, $pval) = @_;
+	$self->SUPER::change_dir_prop($pbat, $pname, $pval, $self->{pool});
+}
+
 sub _chg_file_get_blob ($$$$) {
 	my ($self, $fbat, $m, $which) = @_;
 	my $fh = $::_repository->temp_acquire("git_blob_$which");
@@ -4851,6 +4859,11 @@ sub apply_diff {
 			fatal("Invalid change type: $f");
 		}
 	}
+
+	if (defined($self->{mergeinfo})) {
+		$self->change_dir_prop($self->{bat}{''}, "svn:mergeinfo",
+			               $self->{mergeinfo});
+	}
 	$self->rmdirs if $_rmdir;
 	if (@$mods == 0) {
 		$self->abort_edit;
diff --git a/t/t9157-git-svn-mergeinfo.sh b/t/t9157-git-svn-mergeinfo.sh
new file mode 100644
index 0000000..8337e44
--- /dev/null
+++ b/t/t9157-git-svn-mergeinfo.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Steven Walter
+#
+
+test_description='git svn mergeinfo propagation'
+
+. ./lib-git-svn.sh
+
+say 'define NO_SVN_TESTS to skip git svn tests'
+
+test_expect_success \
+    'initialize source svn repo' '
+        svn_cmd mkdir -m x "$svnrepo"/trunk &&
+        svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+        cd "$SVN_TREE" &&
+        touch foo &&
+        svn_cmd add foo &&
+        svn_cmd commit -m "initial commit" &&
+        cd .. &&
+        rm -rf "$SVN_TREE"'
+
+test_expect_success \
+    'clone svn repo' '
+        git svn init "$svnrepo"/trunk &&
+        git svn fetch'
+
+test_expect_success \
+    'change svn:mergeinfo' '
+        touch bar &&
+        git add bar &&
+        git commit -m "bar" &&
+        git svn dcommit --mergeinfo="/branches/foo:1-10"'
+
+test_expect_success \
+    'verify svn:mergeinfo' '
+        [ `svn_cmd propget svn:mergeinfo "$svnrepo"/trunk` == "/branches/foo:1-10" ]'
+
+test_done
-- 
1.6.3.3
