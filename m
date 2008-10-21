From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Tue, 21 Oct 2008 14:12:15 -0700
Message-ID: <20081021211131.GA21606@yp-box.dyndns.org>
References: <20081018213919.GC3107@atjola.homenet> <20081018224728.GD3107@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 23:13:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsOXi-00027R-Du
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 23:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbYJUVMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYJUVMR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 17:12:17 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42177 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbYJUVMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 17:12:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DE7122DC01A;
	Tue, 21 Oct 2008 14:12:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081018224728.GD3107@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98818>

Thanks to Jose Carlos Garcia Sogo and Bj=F6rn Steinbrink for the
bug report.

On 2008.10.18 23:39:19 +0200, Bj=F6rn Steinbrink wrote:
> Hi,
>
> Jose Carlos Garcia Sogo reported on #git that a git-svn clone of this
> svn repo fails for him:
> https://sucs.org/~welshbyte/svn/backuptool/trunk
>
> I can reproduce that here with:
> git-svn version 1.6.0.2.541.g46dc1.dirty (svn 1.5.1)
>
> The error message I get is:
> Apache got a malformed URI: Unusable URI: it does not refer to this
> repository at /usr/local/libexec/git-core/git-svn line 4057
>
> strace revealed that git-svn url-encodes ~ while svn does not do that=
=2E
>
> For svn we have:
> write(5, "<S:update-report send-all=3D\"true\" xmlns:S=3D\"svn:\">
> <S:src-path>https://sucs.org/~welshbyte/svn/backuptool/trunk</S:src-p=
ath>...
>
> While git-svn shows:
> write(7, "<S:update-report send-all=3D\"true\" xmlns:S=3D\"svn:\">
> <S:src-path>https://sucs.org/%7Ewelshbyte/svn/backuptool/trunk</S:src=
-path>...

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef6d773..a97049a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -852,7 +852,7 @@ sub escape_uri_only {
 	my ($uri) =3D @_;
 	my @tmp;
 	foreach (split m{/}, $uri) {
-		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
 		push @tmp, $_;
 	}
 	join('/', @tmp);
@@ -3537,7 +3537,7 @@ sub repo_path {
 sub url_path {
 	my ($self, $path) =3D @_;
 	if ($self->{url} =3D~ m#^https?://#) {
-		$path =3D~ s/([^a-zA-Z0-9_.-])/uc sprintf("%%%02x",ord($1))/eg;
+		$path =3D~ s/([^~a-zA-Z0-9_.-])/uc sprintf("%%%02x",ord($1))/eg;
 	}
 	$self->{url} . '/' . $self->repo_path($path);
 }
@@ -3890,7 +3890,7 @@ sub escape_uri_only {
 	my ($uri) =3D @_;
 	my @tmp;
 	foreach (split m{/}, $uri) {
-		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
 		push @tmp, $_;
 	}
 	join('/', @tmp);
--=20
Eric Wong
