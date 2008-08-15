From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] Git.pm: Make File::Spec and File::Temp requirement lazy
Date: Fri, 15 Aug 2008 11:10:32 -0400
Message-ID: <1218813032-18203-1-git-send-email-marcus@griep.us>
References: <20080814065800.GA16918@untitled>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 17:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0xn-0005ej-PO
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbYHOPKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbYHOPKe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:10:34 -0400
Received: from boohaunt.net ([209.40.206.144]:59638 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020AbYHOPKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:10:33 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 4C7B81878CDD; Fri, 15 Aug 2008 11:10:32 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <20080814065800.GA16918@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92485>

This will ensure that the API at large is accessible to nearly
all Perl versions, while only the temp file caching API is tied to
the File::Temp and File::Spec modules being available.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 Eric Wong wrote:
 > What about just lazy requiring inside _temp_cache() so it
 > won't get loaded by folks that don't need it? (completely untested):
 > 
 > 		eval { require File::Temp };
 > 		if ($@) {
 > 			throw Error::Simple("couldn't require File::Temp: $@");
 > 		}
 > 		eval { require File::Spec };
 > 		if ($@) {
 > 			throw Error::Simple("couldn't require File::Spec: $@");
 > 		}
 > 
 > It'll also remove the minor performance hit CGI/gitweb users got since
 > we won't load these extra modules during startup.

 This recommendation is implemented with this patch, but in such a way that only
 the first test will be used, and that result cached.  That way we aren't doing
 a compile _every_ time we want a temporary file, just the first time.

 perl/Git.pm |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 405f68f..9b6b637 100644
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
 
@@ -940,6 +938,7 @@ sub _close_cat_blob {
 { # %TEMP_* Lexical Context
 
 my (%TEMP_LOCKS, %TEMP_FILES);
+my $require_test;
 
 =item temp_acquire ( NAME )
 
@@ -1009,6 +1008,8 @@ sub temp_release {
 sub _temp_cache {
 	my ($name) = @_;
 
+	_verify_require();
+
 	my $temp_fd = \$TEMP_FILES{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_LOCKS{$$temp_fd}) {
@@ -1031,6 +1032,15 @@ sub _temp_cache {
 	$$temp_fd;
 }
 
+sub _verify_require {
+	unless (defined $require_test) {
+		$require_test = "";
+		eval { require File::Temp; require File::Spec; };
+		$require_test .= "$@";
+	}
+	$require_test and throw Error::Simple($require_test);
+}
+
 =item temp_reset ( FILEHANDLE )
 
 Truncates and resets the position of the C<FILEHANDLE>.
-- 
1.6.0.rc2.6.g8eda3
