From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 3/4] Git.pm: Don't require repository instance for ident
Date: Fri, 14 Mar 2008 18:29:29 +0100
Message-ID: <1205515770-3424-4-git-send-email-frank@lichtenheld.de>
References: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
 <1205515770-3424-2-git-send-email-frank@lichtenheld.de>
 <1205515770-3424-3-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDjT-00033R-B0
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbYCNR3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYCNR3g
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:29:36 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:55104 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbYCNR3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:29:34 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDit-0003YJ-MC; Fri, 14 Mar 2008 18:29:39 +0100
Received: from host-82-135-33-74.customer.m-online.net ([82.135.33.74] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDii-000846-ST; Fri, 14 Mar 2008 18:29:28 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JaDil-00013I-6Q; Fri, 14 Mar 2008 18:29:31 +0100
X-Mailer: git-send-email 1.5.4.4.555.g697b7.dirty
In-Reply-To: <1205515770-3424-3-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77259>

git var doesn't require to be called in a repository anymore,
so don't require it either.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 perl/Git.pm |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 67b3749..2e7f896 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -632,15 +632,15 @@ The synopsis is like:
 	"$name <$email>" eq ident_person($name);
 	$time_tz =~ /^\d+ [+-]\d{4}$/;
 
-Both methods must be called on a repository instance.
-
 =cut
 
 sub ident {
-	my ($self, $type) = @_;
+	my ($self, $type) = _maybe_self(@_);
 	my $identstr;
 	if (lc $type eq lc 'committer' or lc $type eq lc 'author') {
-		$identstr = $self->command_oneline('var', 'GIT_'.uc($type).'_IDENT');
+		my @cmd = ('var', 'GIT_'.uc($type).'_IDENT');
+		unshift @cmd, $self if $self;
+		$identstr = command_oneline(@cmd);
 	} else {
 		$identstr = $type;
 	}
@@ -652,8 +652,8 @@ sub ident {
 }
 
 sub ident_person {
-	my ($self, @ident) = @_;
-	$#ident == 0 and @ident = $self->ident($ident[0]);
+	my ($self, @ident) = _maybe_self(@_);
+	$#ident == 0 and @ident = $self ? $self->ident($ident[0]) : ident($ident[0]);
 	return "$ident[0] <$ident[1]>";
 }
 
-- 
1.5.4.4
