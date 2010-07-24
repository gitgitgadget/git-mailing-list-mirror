From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@MIT.EDU>
Subject: [PATCH] gitweb: move highlight config out of guess_file_syntax()
Date: Sat, 24 Jul 2010 15:46:07 -0400
Message-ID: <1280000767-31895-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 21:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ockkf-0001vB-Fy
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 21:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab0GXTvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 15:51:12 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:43372 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756290Ab0GXTvL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 15:51:11 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2010 15:51:11 EDT
X-AuditID: 1209190c-b7c0dae000000a0c-b9-4c4b43031d1d
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 37.70.02572.3034B4C4; Sat, 24 Jul 2010 15:46:11 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6OJk86c017444;
	Sat, 24 Jul 2010 15:46:08 -0400
Received: from localhost (LOSTWOODS.MIT.EDU [18.238.0.156])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6OJk7ie003652;
	Sat, 24 Jul 2010 15:46:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.2
X-Brightmail-Tracker: AAAAARVG7TA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151666>

Move highlight config out of guess_file_syntax() so that it can be
extended/overridden by system/user configuration.

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 gitweb/gitweb.perl |   47 +++++++++++++++++++++++---------------------=
---
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cedc357..e0e9532 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -232,6 +232,29 @@ our %avatar_size =3D (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload =3D 300;
=20
+# configuration for 'highlight' (http://www.andre-simon.de/)
+# match by basename
+our %highlight_basename =3D (
+	#'Program' =3D> 'py',
+	#'Library' =3D> 'py',
+	'SConstruct' =3D> 'py', # SCons equivalent of Makefile
+	'Makefile' =3D> 'make',
+);
+# match by extension
+our %highlight_ext =3D (
+	# main extensions, defining name of syntax;
+	# see files in /usr/share/highlight/langDefs/ directory
+	map { $_ =3D> $_ }
+		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tc=
l),
+	# alternate extensions, see /etc/highlight/filetypes.conf
+	'h' =3D> 'c',
+	map { $_ =3D> 'cpp' } qw(cxx c++ cc),
+	map { $_ =3D> 'php' } qw(php3 php4),
+	map { $_ =3D> 'pl'  } qw(perl pm), # perhaps also 'cgi'
+	'mak' =3D> 'make',
+	map { $_ =3D> 'xml' } qw(xhtml html htm),
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature =3D (
@@ -3316,30 +3339,6 @@ sub blob_contenttype {
 sub guess_file_syntax {
 	my ($highlight, $mimetype, $file_name) =3D @_;
 	return undef unless ($highlight && defined $file_name);
-
-	# configuration for 'highlight' (http://www.andre-simon.de/)
-	# match by basename
-	my %highlight_basename =3D (
-		#'Program' =3D> 'py',
-		#'Library' =3D> 'py',
-		'SConstruct' =3D> 'py', # SCons equivalent of Makefile
-		'Makefile' =3D> 'make',
-	);
-	# match by extension
-	my %highlight_ext =3D (
-		# main extensions, defining name of syntax;
-		# see files in /usr/share/highlight/langDefs/ directory
-		map { $_ =3D> $_ }
-			qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec t=
cl),
-		# alternate extensions, see /etc/highlight/filetypes.conf
-		'h' =3D> 'c',
-		map { $_ =3D> 'cpp' } qw(cxx c++ cc),
-		map { $_ =3D> 'php' } qw(php3 php4),
-		map { $_ =3D> 'pl'  } qw(perl pm), # perhaps also 'cgi'
-		'mak' =3D> 'make',
-		map { $_ =3D> 'xml' } qw(xhtml html htm),
-	);
-
 	my $basename =3D basename($file_name, '.in');
 	return $highlight_basename{$basename}
 		if exists $highlight_basename{$basename};
--=20
1.7.2
