X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method  HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 00:57:49 -0800
Message-ID: <7vfyc9cjci.fsf@assigned-by-dhcp.cox.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu> <7v64
	d5keke.fsf@assigned-by-dhcp.cox.net>
	<67mz6h6xmb.fsf@poseidon.eteo.mondragon.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 08:57:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <67mz6h6xmb.fsf@poseidon.eteo.mondragon.edu> (Ignacio Arenaza's
	message of "Fri, 24 Nov 2006 09:46:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32200>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWsc-0001Ra-AH for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934520AbWKXI5v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 03:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934521AbWKXI5v
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:57:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12750 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S934520AbWKXI5v
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:57:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124085750.MBGU20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 03:57:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qYxy1V00A1kojtg0000000; Fri, 24 Nov 2006
 03:57:58 -0500
To: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Sender: git-owner@vger.kernel.org

Ignacio Arenaza <iarenuno@eteo.mondragon.edu> writes:

> ... Will send a new patch with all the
> comments made so far in a few hours.

Let's save a bit of trouble from you.  Here is what I've queued
for 'master', with fixes from the discussion so far.

---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index b54a948..4310dea 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -161,8 +161,22 @@ sub new {
 sub conn {
 	my $self = shift;
 	my $repo = $self->{'fullrep'};
-	if($repo =~ s/^:pserver:(?:(.*?)(?::(.*?))?@)?([^:\/]*)(?::(\d*))?//) {
-		my($user,$pass,$serv,$port) = ($1,$2,$3,$4);
+	if($repo =~ s/^:pserver(?:([^:]*)):(?:(.*?)(?::(.*?))?@)?([^:\/]*)(?::(\d*))?//) {
+		my($param,$user,$pass,$serv,$port) = ($1,$2,$3,$4,$5);
+
+		my($proxyhost,$proxyport);
+		if($param && ($param =~ m/proxy=([^;]+)/)) {
+			$proxyhost = $1;
+			# Default proxyport, if not specified, is 8080.
+			$proxyport = 8080;
+			if($ENV{"CVS_PROXY_PORT"}) {
+				$proxyport = $ENV{"CVS_PROXY_PORT"};
+			}
+			if($param =~ m/proxyport=([^;]+)/){
+				$proxyport = $1;
+			}
+		}
+
 		$user="anonymous" unless defined $user;
 		my $rr2 = "-";
 		unless($port) {
@@ -187,13 +201,43 @@ sub conn {
 		}
 		$pass="A" unless $pass;
 
-		my $s = IO::Socket::INET->new(PeerHost => $serv, PeerPort => $port);
-		die "Socket to $serv: $!\n" unless defined $s;
+		my ($s, $rep);
+		if($proxyhost) {
+
+			# Use a HTTP Proxy. Only works for HTTP proxies that
+			# don't require user authentication
+			#
+			# See: http://www.ietf.org/rfc/rfc2817.txt
+
+			$s = IO::Socket::INET->new(PeerHost => $proxyhost, PeerPort => $proxyport);
+			die "Socket to $proxyhost: $!\n" unless defined $s;
+			$s->write("CONNECT $serv:$port HTTP/1.1\r\nHost: $serv:$port\r\n\r\n")
+	                        or die "Write to $proxyhost: $!\n";
+	                $s->flush();
+
+			$rep = <$s>;
+
+			# The answer should look like 'HTTP/1.x 2yy ....'
+			if(!($rep =~ m#^HTTP/1\.. 2[0-9][0-9]#)) {
+				die "Proxy connect: $rep\n";
+			}
+			# Skip up to the empty line of the proxy server output
+			# including the response headers.
+			while ($rep = <$s>) {
+				last if (!defined $rep ||
+					 $rep eq "\n" ||
+					 $rep eq "\r\n");
+			}
+		} else {
+			$s = IO::Socket::INET->new(PeerHost => $serv, PeerPort => $port);
+			die "Socket to $serv: $!\n" unless defined $s;
+		}
+
 		$s->write("BEGIN AUTH REQUEST\n$repo\n$user\n$pass\nEND AUTH REQUEST\n")
 			or die "Write to $serv: $!\n";
 		$s->flush();
 
-		my $rep = <$s>;
+		$rep = <$s>;
 
 		if($rep ne "I LOVE YOU\n") {
 			$rep="<unknown>" unless $rep;
