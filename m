From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC] Git.pm: stat the FD to ensure the file is really open
Date: Thu, 30 Oct 2014 22:08:36 +0000
Message-ID: <20141030220836.GA7873@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxtZ-00060a-KU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 23:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161384AbaJ3WIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 18:08:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38858 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161019AbaJ3WIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 18:08:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id E7C6C1F7EC;
	Thu, 30 Oct 2014 22:08:36 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a (currently) unknown reason, Git::SVN::Fetcher::close_file
sometimes triggers "Bad file descriptor" errors on syswrite when
writing symlink contents on the "svn_hash" tempfile.

The current IO::Handle::opened call in Git.pm is not a
sufficient check, as the underlying file descriptor is closed
without the PerlIO layer knowing about it.  This is likely a bug
inside libsvn (1.6.17), as none of the Git.pm or Git::SVN
modules close IOs without the knowledge of the PerlIO layer.

Cc: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Kyle/Junio: thoughts?  I'm running out of time to track this down
 so it might be necessary for 2.2-rc0.  What's even stranger is
 I cannot always reproduce the problem even without this patch,
 so it may be only triggered by network latency...
 Thanks.

 perl/Git.pm | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index b5905ee..f1f210b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -99,7 +99,7 @@ increase notwithstanding).
 =cut
 
 
-use Carp qw(carp croak); # but croak is bad - throw instead
+use Carp qw(carp croak cluck); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
@@ -1206,6 +1206,16 @@ sub temp_acquire {
 	$temp_fd;
 }
 
+sub _temp_really_open {
+	my ($fh) = @_;
+
+	if (defined($fh) && $fh->opened) {
+		return 1 if stat($fh);
+		cluck("$fh closed independently of PerlIO\n");
+	}
+	return 0;
+}
+
 =item temp_is_locked ( NAME )
 
 Returns true if the internal lock created by a previous C<temp_acquire()>
@@ -1232,7 +1242,7 @@ sub temp_is_locked {
 	my ($self, $name) = _maybe_self(@_);
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 
-	defined $$temp_fd && $$temp_fd->opened && $TEMP_FILES{$$temp_fd}{locked};
+	_temp_really_open($$temp_fd) && $TEMP_FILES{$$temp_fd}{locked};
 }
 
 =item temp_release ( NAME )
@@ -1264,7 +1274,7 @@ sub temp_release {
 		carp "Attempt to release temp file '",
 			$temp_fd, "' that has not been locked";
 	}
-	temp_reset($temp_fd) if $trunc and $temp_fd->opened;
+	temp_reset($temp_fd) if $trunc && _temp_really_open($temp_fd);
 
 	$TEMP_FILES{$temp_fd}{locked} = 0;
 	undef;
@@ -1276,7 +1286,7 @@ sub _temp_cache {
 	_verify_require();
 
 	my $temp_fd = \$TEMP_FILEMAP{$name};
-	if (defined $$temp_fd and $$temp_fd->opened) {
+	if (_temp_really_open($$temp_fd)) {
 		if ($TEMP_FILES{$$temp_fd}{locked}) {
 			throw Error::Simple("Temp file with moniker '" .
 				$name . "' already in use");
-- 
EW
