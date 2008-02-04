From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH] git-cvsimport: Detect cvs without support for server mode
Date: Mon, 04 Feb 2008 16:27:33 +0100
Message-ID: <47A72EE5.2080904@gmx.ch>
References: <47A5DD98.6000606@gmx.ch> <200802031908.28115.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 16:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM3Ex-0001Iw-Oe
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYBDP1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 10:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbYBDP1i
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:27:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:32882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751162AbYBDP1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:27:37 -0500
Received: (qmail invoked by alias); 04 Feb 2008 15:27:35 -0000
Received: from 20-13.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.13.20]
  by mail.gmx.net (mp055) with SMTP; 04 Feb 2008 16:27:35 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX190TTcCMvV0fSKDSyBksewywnibJY+B5IWaoNs1ck
	dYpJvS+QkDU5zd
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <200802031908.28115.robin.rosenberg.lists@dewire.com>
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72517>

git-cvsimport now exits less noisily and prints an appropriate
message when the installed cvs binary doesn't know the 'server'
subcommand; this happens when cvs is ./configure'ed with
--disable-server.  The test t9600-cvsimport.sh now also tests for
this and skips instead of failing.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---

Robin Rosenberg wrote:
> s=F6ndagen den 3 februari 2008 skrev Jean-Luc Herren:
>> cvs (1.12.12) can be compiled with --disable-server to omit
>> support for cvs servers.  Although this is not ./configure's
>> default, it was the default on my distro (gentoo).  git-cvsimport
>> fails loudly as pasted below (note that this command is part of
>> the test t9600-cvsimport.sh).  Nicer behavior would of course be
>> to detect the situation and inform the user that server support is
>> missing (and to skip the test).
>>
>> $ git-cvsimport -a -z 0 -C module-git module
>=20
> I'm guessing now, but try -Z '--cvs-direct'.

git-cvsimport doesn't have a -Z option, maybe you meant "-p
--cvs-direct" to pass --cvs-direct to cvsps.  However this is not
a problem with cvsps, it's about cvs not knowing the server
subcommand, which is required when specifying a cvsroot that is a
local path.

Note that if cvs misses the server subcommand, it will spit out
the list of available commands to stderr, which is not useful in
this situation.  It seemed to me that redirecting stderr to
/dev/null is a bad idea, as cvs (when it works properly) might
potentially print out useful informations to stderr.  Maybe
someone has an idea about how to eliminate the help message
properly.

jlh

 git-cvsimport.perl   |   11 +++++++++--
 t/t9600-cvsimport.sh |    7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 5694978..e1bcf0e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -207,6 +207,7 @@ sub new {
 sub conn {
 	my $self =3D shift;
 	my $repo =3D $self->{'fullrep'};
+	my $ownserver;
 	if ($repo =3D~ s/^:pserver(?:([^:]*)):(?:(.*?)(?::(.*?))?@)?([^:\/]*)=
(?::(\d*))?//) {
 		my ($param,$user,$pass,$serv,$port) =3D ($1,$2,$3,$4,$5);
=20
@@ -285,6 +286,7 @@ sub conn {
 		$s->flush();
=20
 		$rep =3D <$s>;
+		die "Remote end hung up unexpectedly" unless defined $rep;
=20
 		if ($rep ne "I LOVE YOU\n") {
 			$rep=3D"<unknown>" unless $rep;
@@ -293,6 +295,7 @@ sub conn {
 		$self->{'socketo'} =3D $s;
 		$self->{'socketi'} =3D $s;
 	} else { # local or ext: Fork off our own cvs server.
+		$ownserver =3D 1;
 		my $pr =3D IO::Pipe->new();
 		my $pw =3D IO::Pipe->new();
 		my $pid =3D fork();
@@ -325,7 +328,7 @@ sub conn {
 			dup2($pr->fileno(),1);
 			$pr->close();
 			$pw->close();
-			exec(@cvs);
+			exec(@cvs) or exit 1;
 		}
 		$pw->writer();
 		$pr->reader();
@@ -340,7 +343,11 @@ sub conn {
 	$self->{'socketo'}->write("valid-requests\n");
 	$self->{'socketo'}->flush();
=20
-	chomp(my $rep=3D$self->readline());
+	my $rep=3D$self->readline();
+	if (!defined $rep) {
+		die $ownserver ? "'cvs server' failed; make sure you have a cvs with=
 server support" : "Remote end hung up unexpectedly";
+	}
+	chomp $rep;
 	if ($rep !~ s/^Valid-requests\s*//) {
 		$rep=3D"<unknown>" unless $rep;
 		die "Expected Valid-requests from server, but got: $rep\n";
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 7706430..d8cbfd0 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -10,6 +10,13 @@ then
 	exit
 fi
=20
+if echo -n | cvs server 2>&1 | grep 'Unknown command' > /dev/null
+then
+	say 'skipping cvsimport tests, cvs has support for server mode'
+	test_done
+	exit
+fi
+
 cvsps_version=3D`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
 2.1)
--=20
1.5.3.8
