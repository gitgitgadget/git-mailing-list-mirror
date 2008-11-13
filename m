From: "Marten Svanfeldt (dev)" <developer@svanfeldt.com>
Subject: [PATCH fixed] Git.pm: Make _temp_cache use the repository directory
Date: Thu, 13 Nov 2008 20:04:09 +0800
Message-ID: <491C17B9.2070106@svanfeldt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: msysgit@googlegroups.com, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0axM-0003y1-4P
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 13:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbYKMMEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 07:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYKMMEg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 07:04:36 -0500
Received: from mail.anarazel.de ([217.115.131.40]:58823 "EHLO smtp.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYKMMEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 07:04:35 -0500
Received: by smtp.anarazel.de (Postfix, from userid 108)
	id 1A1FE448005; Thu, 13 Nov 2008 13:04:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [140.114.202.94] (x970003.HUNG.ab.nthu.edu.tw [140.114.202.94])
	by smtp.anarazel.de (Postfix) with ESMTPSA id 3BA88448004;
	Thu, 13 Nov 2008 13:04:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100867>

Update the usage of File::Temp->tempfile to place the temporary files
within the repository directory instead of just letting Perl decide what
directory to use, given there is a repository specified when requesting
the temporary file.

This is needed to be able to fix git-svn on msys as msysperl generates
paths with UNIX-style paths (/tmp/xxx) while the git tools expect natvie
path format (c:/..). The repository dir is stored in native format so by
using it as the base directory for temporary files we always get a
usable native full path.

Signed-off-by: Marten Svanfeldt <developer@svanfeldt.com>
---
Hi,
Reworked the second part of the commit message after comments to make it
more obvious why this patch is needed.



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
1.6.0.3.1439.gc9385a.dirty
