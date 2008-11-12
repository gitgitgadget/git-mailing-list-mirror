From: "Marten Svanfeldt (dev)" <developer@svanfeldt.com>
Subject: [PATCH] git-svn: Update git-svn to use the ability to place temporary
 files within repository directory
Date: Wed, 12 Nov 2008 22:33:25 +0800
Message-ID: <491AE935.4040406@svanfeldt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 15:35:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0GoB-00032M-GM
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 15:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYKLOds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 09:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbYKLOds
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 09:33:48 -0500
Received: from mail.anarazel.de ([217.115.131.40]:43613 "EHLO smtp.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbYKLOdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 09:33:47 -0500
Received: by smtp.anarazel.de (Postfix, from userid 108)
	id 82A10448005; Wed, 12 Nov 2008 15:33:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [140.114.202.94] (x970003.HUNG.ab.nthu.edu.tw [140.114.202.94])
	by smtp.anarazel.de (Postfix) with ESMTPSA id C3829448004;
	Wed, 12 Nov 2008 15:33:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100754>

This fixes git-svn within msys where Perl will provide temporary files
with path such as /tmp while the git suit expects native Windows paths.

Signed-off-by: Marten Svanfeldt <developer@svanfeldt.com>
---
 git-svn.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef6d773..f09f981 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3312,11 +3312,11 @@ sub change_file_prop {

 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
-	my $fh = Git::temp_acquire('svn_delta');
+	my $fh = $_repository->temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
-	my $base = Git::temp_acquire('git_blob');
+	my $base = $_repository->temp_acquire('git_blob');
 	if ($fb->{blob}) {
 		print $base 'link ' if ($fb->{mode_a} == 120000);
 		my $size = $::_repository->cat_blob($fb->{blob}, $base);
@@ -3357,7 +3357,8 @@ sub close_file {
 				warn "$path has mode 120000",
 						" but is not a link\n";
 			} else {
-				my $tmp_fh = Git::temp_acquire('svn_hash');
+				my $tmp_fh = $_repository->temp_acquire(
+					'svn_hash');
 				my $res;
 				while ($res = sysread($fh, my $str, 1024)) {
 					my $out = syswrite($tmp_fh, $str, $res);
@@ -3745,7 +3746,7 @@ sub change_file_prop {

 sub _chg_file_get_blob ($$$$) {
 	my ($self, $fbat, $m, $which) = @_;
-	my $fh = Git::temp_acquire("git_blob_$which");
+	my $fh = $_repository->temp_acquire("git_blob_$which");
 	if ($m->{"mode_$which"} =~ /^120/) {
 		print $fh 'link ' or croak $!;
 		$self->change_file_prop($fbat,'svn:special','*');
-- 
1.6.0.3.1437.g6c121.dirty
