From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2] Git.pm: Make File::Spec and File::Temp requirement lazy
Date: Fri, 15 Aug 2008 15:53:59 -0400
Message-ID: <1218830039-11567-1-git-send-email-marcus@griep.us>
References: <1218813032-18203-1-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 21:55:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU5O5-00026w-2t
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbYHOTyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 15:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbYHOTyB
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 15:54:01 -0400
Received: from boohaunt.net ([209.40.206.144]:59328 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975AbYHOTyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 15:54:00 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id AFF481878CDD; Fri, 15 Aug 2008 15:53:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc3.10.g5a13c
In-Reply-To: <1218813032-18203-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92515>

This will ensure that the API at large is accessible to nearly
all Perl versions, while only the temp file caching API is tied to
the File::Temp and File::Spec modules being available.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 Even shorter and sweeter now that I understand a bit more about Perl's
 exec functionality. This patch no longer has unnecessary caching and is
 about as short and sweet as it gets. Thanks for helping me learn more
 about Perl, Bryan.

 perl/Git.pm |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 405f68f..102e6a4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -100,8 +100,6 @@ use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
 use IPC::Open2 qw(open2);
-use File::Temp ();
-require File::Spec;
 use Fcntl qw(SEEK_SET SEEK_CUR);
 }
 
@@ -1009,6 +1007,8 @@ sub temp_release {
 sub _temp_cache {
 	my ($name) = @_;
 
+	_verify_require();
+
 	my $temp_fd = \$TEMP_FILES{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_LOCKS{$$temp_fd}) {
@@ -1031,6 +1031,11 @@ sub _temp_cache {
 	$$temp_fd;
 }
 
+sub _verify_require {
+	eval { require File::Temp; require File::Spec; };
+	$@ and throw Error::Simple($@);
+}
+
 =item temp_reset ( FILEHANDLE )
 
 Truncates and resets the position of the C<FILEHANDLE>.
-- 
1.6.0.rc3.10.g5a13c
