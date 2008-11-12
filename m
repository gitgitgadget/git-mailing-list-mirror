From: "Marten Svanfeldt (dev)" <developer@svanfeldt.com>
Subject: [PATCH] Git.pm: Make _temp_cache use the repository directory
Date: Wed, 12 Nov 2008 22:28:26 +0800
Message-ID: <491AE80A.5060807@svanfeldt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 15:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0GjN-0000wz-3K
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 15:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYKLO2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 09:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYKLO2u
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 09:28:50 -0500
Received: from mail.anarazel.de ([217.115.131.40]:38816 "EHLO smtp.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbYKLO2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 09:28:49 -0500
Received: by smtp.anarazel.de (Postfix, from userid 108)
	id 9A68B448005; Wed, 12 Nov 2008 15:28:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [140.114.202.94] (x970003.HUNG.ab.nthu.edu.tw [140.114.202.94])
	by smtp.anarazel.de (Postfix) with ESMTPSA id 15D73448004;
	Wed, 12 Nov 2008 15:28:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100752>

Update the usage of File::Temp->tempfile to place the temporary files
within the repository directory instead of just letting Perl decide what
directory to use, given there is a repository specified when requesting
the temporary file.

This fixes issues when the Perl in use uses a different format for paths
than in use by native code in the git tools such as msysgit with msys-perl.

Signed-off-by: Marten Svanfeldt <developer@svanfeldt.com>
---
 perl/Git.pm |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6aab712..4b71dad 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -961,9 +961,7 @@ issue.
 =cut

 sub temp_acquire {
-	my ($self, $name) = _maybe_self(@_);
-
-	my $temp_fd = _temp_cache($name);
+	my $temp_fd = _temp_cache(@_);

 	$TEMP_FILES{$temp_fd}{locked} = 1;
 	$temp_fd;
@@ -1005,7 +1003,7 @@ sub temp_release {
 }

 sub _temp_cache {
-	my ($name) = @_;
+	my ($self, $name) = _maybe_self(@_);

 	_verify_require();

@@ -1022,9 +1020,16 @@ sub _temp_cache {
 				"' was closed. Opening replacement.";
 		}
 		my $fname;
+
+		my $tmpdir;
+		if (defined $self) {
+			$tmpdir = $self->repo_path();
+		}
+		
 		($$temp_fd, $fname) = File::Temp->tempfile(
-			'Git_XXXXXX', UNLINK => 1
+			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
+
 		$$temp_fd->autoflush;
 		binmode $$temp_fd;
 		$TEMP_FILES{$$temp_fd}{fname} = $fname;
-- 
1.6.0.3.1437.g6c121.dirty
