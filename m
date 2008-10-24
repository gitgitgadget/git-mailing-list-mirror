From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Fri, 24 Oct 2008 02:13:30 -0700
Message-ID: <20081024091330.GA27362@untitled>
References: <20081018213919.GC3107@atjola.homenet> <20081018224728.GD3107@atjola.homenet> <20081021211131.GA21606@yp-box.dyndns.org> <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org> <20081022081653.GC14966@untitled> <7viqrkv4vd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 11:15:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtIl3-0003p5-Ta
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 11:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYJXJNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Oct 2008 05:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbYJXJNd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 05:13:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46139 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbYJXJNc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 05:13:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EF51B2DC01A;
	Fri, 24 Oct 2008 02:13:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viqrkv4vd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99022>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> The patch may make a path with '~' work, but it (neither in the pa=
tch text
> >> nor in the commit log message) does not have much to give readers =
enough
> >> confidence that the code after the patch is the _final_ one, as op=
posed to
> >> being just a band-aid for a single symptom that happened to have b=
een
> >> discovered this time.
> >
> > This is definitely a band-aid fix until I or somebody else takes th=
e
> > time to figure out:
> >
> >  1. exactly which characters need to be escaped
> >  2. for which protocols those characters need to be escaped
> >  3. which part(s) of the URI they need to be escaped for
> >     (repository root vs SVN path)
> >  4. which versions of SVN needs more (or less) escaping rules
> >
> > (I vote for somebody else, especially for #4 :)
>=20
> Item 3. above disturbs me.  Do you mean that in:
>=20
>     https://sucs.org/~welshbyte/svn/backuptool/trunk/foo~bar.txt
>=20
> the two tildes might have to be sent to libsvn-perl differently?

Yes, something like this is unfortunately a possibility (as is
having to worry about this at all in git-svn).

> Even if that is the case, I am inclined suggest taking the patch in t=
he
> meantime as an interim workaround, with the understanding that we kno=
w the
> patch improves the situation for the tilde before welshbyte and even
> though we do not know if the patch regresses for the latter one betwe=
en
> foo and bar, it would be much rarer to have tilde in such places.
>=20
> Care to come up with an updated log message?

=46rom aa4f2cdcf64934e13886fabb3b5e986a5cda79f6 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Tue, 21 Oct 2008 14:12:15 -0700
Subject: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

This change only fixes the tilde case in the repository URL.  A
more comprehensive set of escaping rules and tests will be
needed in the future for complete compatibility when using
uncommon characters.

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
