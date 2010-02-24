From: josh robb <josh_robb@fastmail.fm>
Subject: [PATCH] git svn: delay importing SVN::Base until it is needed
Date: Wed, 24 Feb 2010 16:13:50 +1300
Message-ID: <13237f021002231913m77d9bc0aqd045546da3cf5a95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 04:14:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk7hy-00074I-8Y
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 04:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab0BXDNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 22:13:54 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50370 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040Ab0BXDNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 22:13:51 -0500
Received: by pwj8 with SMTP id 8so4467209pwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 19:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=kPigPsB9lp66GoFlI7i8LOcDZbJx1oe+QAHb8dA6YvE=;
        b=FwlbNelHtmM6zQ/9ejxruxxz+4qAwsjbCfrYI3+91z2veUqUTKHLsgDBGCaJcMBfKi
         3qJW8/pXRdKR92QmEq+iX26fOlGZeKbPSMQ0NXX6CD2uc6118GokFs7ybSGYt+/mfHXU
         IaK2lSPTqhr4/n2UpRR3ERZ6E2VytQRE3FJqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=XVnQPc+YO82sOyt6nq58bA9i3loMDcGk5gShOk0Ts1++VTROKbQmKbdC0EexNhnO/9
         5qTAtFfFITPJ4FXF47Eqqwamq5OSBXMVyW6yAHPWaLE9bC5PfH+tkYqJ2Hi/WhUle+0c
         pQdx3FG6rJpNkHEdhtfLz7E6U6bx0yy56iyPI=
Received: by 10.115.101.39 with SMTP id d39mr1018206wam.207.1266981230384; 
	Tue, 23 Feb 2010 19:13:50 -0800 (PST)
X-Google-Sender-Auth: ec9d467f3354eb12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140892>

Importing functions from a .dll into Git for Windows' perl is pretty slow,
so let's avoid importing if it is not necessary.

This seems particularly slow in virtualized enviroments. Before this
change (on my machine):

$ time perl /libexec/git-core/git-svn rebase
Current branch master is up to date.

real 2m56.750s
user 0m3.129s
sys 2m39.232s

Afterwards:

$ time perl /libexec/git-core/git-svn rebase
Current branch master is up to date.

real 0m33.407s
user 0m1.409s
sys 0m23.054s

git svn rebase -n goes from 3m7.046s to 0m10.312s.

Signed-off-by: Josh Robb <josh_robb@fastmail.fm>
---
 git-svn.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 265852f..0e4572f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -36,11 +36,13 @@ $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT

 sub fatal (@) { print STDERR "@_\n"; exit 1 }
-require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
-require SVN::Ra;
-require SVN::Delta;
-if ($SVN::Core::VERSION lt '1.1.0') {
-	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
+sub _req_svn {
+	require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
+	require SVN::Ra;
+	require SVN::Delta;
+	if ($SVN::Core::VERSION lt '1.1.0') {
+		fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
+	}
 }
 my $can_compress = eval { require Compress::Zlib; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
@@ -730,6 +732,8 @@ sub cmd_branch {
 		$src=~s/^http:/https:/;
 	}

+	::_req_svn();
+
 	my $ctx = SVN::Client->new(
 		auth    => Git::SVN::Ra::_auth_providers(),
 		log_msg => sub {
@@ -4859,6 +4863,8 @@ sub new {
 	$url =~ s!/+$!!;
 	return $RA if ($RA && $RA->{url} eq $url);

+	::_req_svn();
+
 	SVN::_Core::svn_config_ensure($config_dir, undef);
 	my ($baton, $callbacks) = SVN::Core::auth_open_helper(_auth_providers);
 	my $config = SVN::Core::config_get_config($config_dir);
-- 
1.7.0
