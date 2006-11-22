X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Inaki Arenaza <iarenuno@eteo.mondragon.edu>
Subject: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x 
	proxying
Date: Wed, 22 Nov 2006 23:26:57 +0100
Message-ID: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 22 Nov 2006 22:27:33 +0000 (UTC)
Cc: =?utf-8?q?I=F1aki_Arenaza?= <iarenuno@eteo.mondragon.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
X-Mailer: git-send-email 1.4.4
X-imss-version: 2.044
X-imss-result: Passed
X-imss-scores: Clean:66.98338 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32106>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn0Yv-00009m-Tl for gcvg-git@gmane.org; Wed, 22 Nov
 2006 23:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757093AbWKVW1R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 17:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757095AbWKVW1R
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 17:27:17 -0500
Received: from mx.eteo.mondragon.edu ([193.146.78.131]:8102 "EHLO
 mx.eteo.mondragon.edu") by vger.kernel.org with ESMTP id S1757093AbWKVW1O
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 17:27:14 -0500
Received: by mx.eteo.mondragon.edu (Postfix, from userid 1001) id 26C18B6B2;
 Wed, 22 Nov 2006 23:27:11 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (poseidon.eteo.mondragon.edu
 [172.31.3.4]) by mx.eteo.mondragon.edu (Postfix) with ESMTP id 46B16B6B1 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 23:27:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by
 localhost.eteo.mondragon.edu (Postfix) with SMTP id 2DD002FE1A for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 23:27:05 +0100 (CET)
Received: by poseidon.eteo.mondragon.edu (Postfix, from userid 1072)id 
 2F59D2FE11; Wed, 22 Nov 2006 23:26:57 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

=46rom: =3D?utf-8?q?I=3DF1aki_Arenaza?=3D <iarenuno@eteo.mondragon.edu>

Quoting from the CVS info manual:

=2E....................................................................=
=2E
     The `gserver' and `pserver' connection methods all accept optional
  method options, specified as part of the METHOD string, like so:

       :METHOD[;OPTION=3DARG...]:

     Currently, the only two valid connection options are `proxy', whic=
h
  takes a hostname as an argument, and `proxyport', which takes a port
  number as an argument.  These options can be used to connect via an H=
TTP
  tunnel style web proxy.  For example, to connect pserver via a web pr=
oxy
  at www.myproxy.net and port 8000, you would use a method of:

       :pserver;proxy=3Dwww.myproxy.net;proxyport=3D8000:

     *NOTE: The rest of the connection string is required to connect to
  the server as noted in the upcoming sections on password authenticati=
on,
  gserver and kserver.  The example above would only modify the METHOD
  portion of the repository name.*

     PROXY must be supplied to connect to a CVS server via a proxy
  server, but PROXYPORT will default to port 8080 if not supplied.
  PROXYPORT may also be set via the CVS_PROXY_PORT environment variable=
=2E
=2E....................................................................=
=2E

This patch adds support for 'proxy' and 'proxyport' connection options
when using the pserver method for the CVS Root.

It has been tested with a Squid 2.5.x proxy server.

Please, CC me as I am not in the list.

Signed-off-by: I=F1aki Arenaza <iarenuno@eteo.mondragon.edu>
---
 git-cvsimport.perl |   49 ++++++++++++++++++++++++++++++++++++++++++++=
-----
 1 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index b54a948..394f3c3 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -161,8 +161,22 @@ sub new {
 sub conn {
 	my $self =3D shift;
 	my $repo =3D $self->{'fullrep'};
-	if($repo =3D~ s/^:pserver:(?:(.*?)(?::(.*?))?@)?([^:\/]*)(?::(\d*))?/=
/) {
-		my($user,$pass,$serv,$port) =3D ($1,$2,$3,$4);
+	if($repo =3D~ s/^:pserver(?:([^:]*)):(?:(.*?)(?::(.*?))?@)?([^:\/]*)(=
?::(\d*))?//) {
+		my($param,$user,$pass,$serv,$port) =3D ($1,$2,$3,$4,$5);
+
+		my($proxyhost,$proxyport);
+		if($param && ($param =3D~ m/proxy=3D([^;]+)/)) {
+			$proxyhost =3D $1;
+			# Default proxyport, if not specified, is 8080.
+			$proxyport =3D 8080;
+			if($ENV{"CVS_PROXY_PORT"}) {
+				$proxyport =3D $ENV{"CVS_PROXY_PORT"};
+			}
+			if($param =3D~ m/proxyport=3D([^;]+)/){
+				$proxyport =3D $1;
+			}
+		}
+
 		$user=3D"anonymous" unless defined $user;
 		my $rr2 =3D "-";
 		unless($port) {
@@ -187,13 +201,38 @@ sub conn {
 		}
 		$pass=3D"A" unless $pass;
=20
-		my $s =3D IO::Socket::INET->new(PeerHost =3D> $serv, PeerPort =3D> $=
port);
-		die "Socket to $serv: $!\n" unless defined $s;
+		my ($s, $rep);
+		if($proxyhost) {
+
+			# Use a HTTP Proxy. Only works for HTTP proxies that
+			# don't require user authentication
+			#
+			# See: http://www.ietf.org/rfc/rfc2817.txt
+
+			$s =3D IO::Socket::INET->new(PeerHost =3D> $proxyhost, PeerPort =3D=
> $proxyport);
+			die "Socket to $proxyhost: $!\n" unless defined $s;
+			$s->write("CONNECT $serv:$port HTTP/1.1\r\nHost: $serv:$port\r\n\r\=
n")
+	                        or die "Write to $proxyhost: $!\n";
+	                $s->flush();
+
+			$rep =3D <$s>;
+
+			# The answer should loook like 'HTTP/1.x 2yy ....'
+			if(!($rep =3D~ m#^HTTP/1\.. 2[0-9][0-9]#)) {
+				die "Proxy connect: $rep\n";
+			}
+			# Skip the empty line of the proxy server output
+			<$s>;
+		} else {
+			my $s =3D IO::Socket::INET->new(PeerHost =3D> $serv, PeerPort =3D> =
$port);
+			die "Socket to $serv: $!\n" unless defined $s;
+		}
+
 		$s->write("BEGIN AUTH REQUEST\n$repo\n$user\n$pass\nEND AUTH REQUEST=
\n")
 			or die "Write to $serv: $!\n";
 		$s->flush();
=20
-		my $rep =3D <$s>;
+		$rep =3D <$s>;
=20
 		if($rep ne "I LOVE YOU\n") {
 			$rep=3D"<unknown>" unless $rep;
--=20
1.4.4

