From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: [PATCH not ready]: allow cvsimport to use compression when talking to remote cvs server
Date: Sat, 02 Aug 2008 16:05:58 +0200
Message-ID: <g71pk6$eki$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 16:07:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPHlR-0001zS-VS
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 16:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYHBOGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2008 10:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYHBOGQ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 10:06:16 -0400
Received: from main.gmane.org ([80.91.229.2]:41074 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbYHBOGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 10:06:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KPHkH-0006AB-2w
	for git@vger.kernel.org; Sat, 02 Aug 2008 14:06:09 +0000
Received: from chello089076022019.chello.pl ([89.76.22.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 14:06:09 +0000
Received: from arekm by chello089076022019.chello.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 14:06:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chello089076022019.chello.pl
User-Agent: KNode/0.10.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91147>


This patch adds ability to git cvsimport use compression
when talking to remote cvs pserver (in normal cvs client using compress=
ion
makes things a lot faster so it should help here, too).

Unfortunately it doesn't work due to: new IO::Uncompress::RawInflate()
hanging at constructor. No idea why constructor wants to do read()
over a socket. Maybe whole IO::Compress stuff isn't ready to work over
sockets (that's the question to perl gurus).

=46ell free to make it working/improve it. I have no idea how to make i=
t work
at this moment.

--- git-cvsimport.org   2008-08-02 12:00:25.342934972 +0200
+++ git-cvsimport       2008-08-02 16:01:33.588363079 +0200
@@ -27,6 +27,15 @@
 use POSIX qw(strftime dup2 ENOENT);
 use IPC::Open2;
=20
+my $compress_support =3D 1;
+eval "use IO::Compress::RawDeflate; use IO::Uncompress::RawInflate";
+$compress_support =3D 0 if ($@);
+if ($compress_support) {
+       use IO::Compress::RawDeflate;
+       use IO::Uncompress::RawInflate;
+}
+
+
 $SIG{'PIPE'}=3D"IGNORE";
 $ENV{'TZ'}=3D"UTC";
=20
@@ -312,7 +321,9 @@
                my @cvs =3D ($cvs, 'server');
                my ($local, $user, $host);
                $local =3D $repo =3D~ s/:local://;
-               if (!$local) {
+               if ($local) {
+                   $compress_support =3D 0;
+               } else {
                    $repo =3D~ s/:ext://;
                    $local =3D !($repo =3D~ s/^(?:([^\@:]+)\@)?([^:]+):=
//);
                    ($user, $host) =3D ($1, $2);
@@ -356,6 +367,12 @@
        die "validReply: $res\n" if $res ne "ok";
=20
        $self->{'socketo'}->write("UseUnchanged\n") if $rep =3D~ /\bUse=
Unchanged\b/;
+       if ($compress_support and $rep =3D~ /\bGzip-stream\b/) {
+               my $level =3D 3; # make it cmd line option
+               $self->{'socketo'}->write("Gzip-stream $level\n");
+               $self->{'socketo'} =3D new IO::Compress::RawDeflate $se=
lf->{'socketo'},
Level =3D> $level or die("Setting up gzip compression failed:
$IO::Compress::RawDeflate::RawDeflateError\n");
+               $self->{'socketi'} =3D new IO::Uncompress::RawInflate $=
self->{'socketi'},
Transparent =3D> 0 or die("Setting up gzip uncompression failed:
$IO::Uncompress::RawInflate::RawInflateError\n");
+       }
        $self->{'repo'} =3D $repo;
 }
=20


--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
