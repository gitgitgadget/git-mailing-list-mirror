From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Thu, 23 Sep 2010 20:52:33 -0400
Message-ID: <1285289553-17998-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 02:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OywWq-0001Uj-Me
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 02:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919Ab0IXAwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 20:52:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49506 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab0IXAwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 20:52:38 -0400
Received: by gwj17 with SMTP id 17so799900gwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=OKEVUp0YAOYuvWZ76MHEybId0Ph4nYuDE4OKZ87xxlU=;
        b=P5VvfL/Ted7qSI5n/Lb/VC1BXwRfdJbVRpluCBv9QvgiHOfC7Iiuc9yjU6ViwNVnUF
         IvXEAwp4MiEQqVCtYPJ7D0T18Lde4NgcNBKRwNeFoCRc69bWlqxZC3cDtItxQnehyk39
         fo7aUP+zSqWmCLINqsXf05pzRQQQ6zVEs0Tr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nM/HqQEskhtaIZRd4DhZ87Q/y3NojLgwaquAKli6EIlj7dkPZ473p+Nva7wdmGUpAJ
         IFNc2CX4suqwo2TjoOgZom1qOMOUIoQ/4zJMtd6duyNOLi01Nxj99H0ZZeMxwdVqdtM0
         sGhuDw2jSCCspA8lMm2m6j+87L3AAdrl+Pu3I=
Received: by 10.150.229.17 with SMTP id b17mr3756511ybh.379.1285289557986;
        Thu, 23 Sep 2010 17:52:37 -0700 (PDT)
Received: from brock (adsl-234-158-248.bgk.bellsouth.net [74.234.158.248])
        by mx.google.com with ESMTPS id 36sm363372ybr.8.2010.09.23.17.52.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 17:52:37 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.72)
	(envelope-from <srwalter@dervierte>)
	id 1OywWg-0004gm-Vw; Thu, 23 Sep 2010 20:52:35 -0400
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156928>

As a first step towards preserving merges across dcommit, we need a
mechanism to update the svn:mergeinfo property.
---
 git-svn.perl |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

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
-- 
1.7.3.4.g4d78d
