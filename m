From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BISECTED] git-svn: "Failed to read object ..." during clone
Date: Tue, 27 May 2008 23:32:59 -0700
Message-ID: <7vskw3vsys.fsf@gitster.siamese.dyndns.org>
References: <20080528030128.GA28904@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 28 08:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1FEo-0001Sh-Uo
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 08:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYE1GdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 02:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYE1GdM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 02:33:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYE1GdL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 02:33:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B762A34BE;
	Wed, 28 May 2008 02:33:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A0EDA34BC; Wed, 28 May 2008 02:33:02 -0400 (EDT)
In-Reply-To: <20080528030128.GA28904@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 28 May 2008 05:01:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F070E7F4-2C7F-11DD-847F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83073>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Hi Adam,
>
> when cloning the SVN repository at svn://svn.debian.org/estron/ git-s=
vn bails
> out with:
> Failed to read object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 at
> /usr/local/bin/git-svn line 3195, <GEN36> line 645.

Heh, I should have been more careful.  The series introduces Git::cat_b=
lob
that returns the size of a blob but the interface is broken and signals
error by returning zero.  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 is a
zero sized blob.

Would this be enough?

---

 git-svn.perl |    4 ++--
 perl/Git.pm  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 37976f2..3a6eb1c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3191,7 +3191,7 @@ sub apply_textdelta {
 	if ($fb->{blob}) {
 		print $base 'link ' if ($fb->{mode_a} =3D=3D 120000);
 		my $size =3D $::_repository->cat_blob($fb->{blob}, $base);
-		die "Failed to read object $fb->{blob}" unless $size;
+		die "Failed to read object $fb->{blob}" if ($size < 0);
=20
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
@@ -3570,7 +3570,7 @@ sub chg_file {
 		$self->change_file_prop($fbat,'svn:special',undef);
 	}
 	my $size =3D $::_repository->cat_blob($m->{sha1_b}, $fh);
-	croak "Failed to read object $m->{sha1_b}" unless $size;
+	croak "Failed to read object $m->{sha1_b}" if ($size < 0);
 	$fh->flush =3D=3D 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
=20
diff --git a/perl/Git.pm b/perl/Git.pm
index 6ba8ee5..d05b633 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -811,12 +811,12 @@ sub cat_blob {
 	my $description =3D <$in>;
 	if ($description =3D~ / missing$/) {
 		carp "$sha1 doesn't exist in the repository";
-		return 0;
+		return -1;
 	}
=20
 	if ($description !~ /^[0-9a-fA-F]{40} \S+ (\d+)$/) {
 		carp "Unexpected result returned from git cat-file";
-		return 0;
+		return -1;
 	}
=20
 	my $size =3D $1;
