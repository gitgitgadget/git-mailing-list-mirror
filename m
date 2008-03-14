From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/4] Git.pm: Don't require a repository instance for config
Date: Fri, 14 Mar 2008 18:29:28 +0100
Message-ID: <1205515770-3424-3-git-send-email-frank@lichtenheld.de>
References: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
 <1205515770-3424-2-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDjU-00033R-0s
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbYCNR3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYCNR3i
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:29:38 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:55107 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbYCNR3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:29:34 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDit-0003YL-WC; Fri, 14 Mar 2008 18:29:40 +0100
Received: from host-82-135-33-74.customer.m-online.net ([82.135.33.74] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDii-000844-Sg; Fri, 14 Mar 2008 18:29:28 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JaDil-00013F-2H; Fri, 14 Mar 2008 18:29:31 +0100
X-Mailer: git-send-email 1.5.4.4.555.g697b7.dirty
In-Reply-To: <1205515770-3424-2-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77257>

git config itself doesn't require to be called in a repository,
do don't add arbitrary restrictions.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 perl/Git.pm |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index a2812ea..67b3749 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -487,22 +487,20 @@ does. In scalar context requires the variable to be set only one time
 (exception is thrown otherwise), in array context returns allows the
 variable to be set multiple times and returns all the values.
 
-Must be called on a repository instance.
-
 This currently wraps command('config') so it is not so fast.
 
 =cut
 
 sub config {
-	my ($self, $var) = @_;
-	$self->repo_path()
-		or throw Error::Simple("not a repository");
+	my ($self, $var) = _maybe_self(@_);
 
 	try {
+		my @cmd = ('config');
+		unshift @cmd, $self if $self;
 		if (wantarray) {
-			return $self->command('config', '--get-all', $var);
+			return command(@cmd, '--get-all', $var);
 		} else {
-			return $self->command_oneline('config', '--get', $var);
+			return command_oneline(@cmd, '--get', $var);
 		}
 	} catch Git::Error::Command with {
 		my $E = shift;
@@ -522,20 +520,17 @@ Retrieve the bool configuration C<VARIABLE>. The return value
 is usable as a boolean in perl (and C<undef> if it's not defined,
 of course).
 
-Must be called on a repository instance.
-
 This currently wraps command('config') so it is not so fast.
 
 =cut
 
 sub config_bool {
-	my ($self, $var) = @_;
-	$self->repo_path()
-		or throw Error::Simple("not a repository");
+	my ($self, $var) = _maybe_self(@_);
 
 	try {
-		my $val = $self->command_oneline('config', '--bool', '--get',
-					      $var);
+		my @cmd = ('config', '--bool', '--get', $var);
+		unshift @cmd, $self if $self;
+		my $val = command_oneline(@cmd);
 		return undef unless defined $val;
 		return $val eq 'true';
 	} catch Git::Error::Command with {
@@ -557,19 +552,17 @@ or 'g' in the config file will cause the value to be multiplied
 by 1024, 1048576 (1024^2), or 1073741824 (1024^3) prior to output.
 It would return C<undef> if configuration variable is not defined,
 
-Must be called on a repository instance.
-
 This currently wraps command('config') so it is not so fast.
 
 =cut
 
 sub config_int {
-	my ($self, $var) = @_;
-	$self->repo_path()
-		or throw Error::Simple("not a repository");
+	my ($self, $var) = _maybe_self(@_);
 
 	try {
-		return $self->command_oneline('config', '--int', '--get', $var);
+		my @cmd = ('config', '--int', '--get', $var);
+		unshift @cmd, $self if $self;
+		return command_oneline(@cmd);
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {
-- 
1.5.4.4
