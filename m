From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 08:06:56 -0400
Message-ID: <20120718120656.GD6726@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:07:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrT21-0002Ag-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2GRMHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:07:00 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39079
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab2GRMG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:06:59 -0400
Received: (qmail 19001 invoked by uid 107); 18 Jul 2012 12:07:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:07:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:06:56 -0400
Content-Disposition: inline
In-Reply-To: <20120718120307.GA6399@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201680>

We can just feed our URL straight to git-credential and it
will parse it for us, saving us some code.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/mw-to-git/git-remote-mediawiki | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index b06f27b..c9ac416 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -163,32 +163,6 @@ while (<STDIN>) {
 
 ## credential API management (generic functions)
 
-sub credential_from_url {
-	my $url = shift;
-	my $parsed = URI->new($url);
-	my %credential;
-
-	if ($parsed->scheme) {
-		$credential{protocol} = $parsed->scheme;
-	}
-	if ($parsed->host) {
-		$credential{host} = $parsed->host;
-	}
-	if ($parsed->path) {
-		$credential{path} = $parsed->path;
-	}
-	if ($parsed->userinfo) {
-		if ($parsed->userinfo =~ /([^:]*):(.*)/) {
-			$credential{username} = $1;
-			$credential{password} = $2;
-		} else {
-			$credential{username} = $parsed->userinfo;
-		}
-	}
-
-	return %credential;
-}
-
 sub credential_read {
 	my %credential;
 	my $reader = shift;
@@ -216,7 +190,9 @@ sub credential_write {
 sub credential_run {
 	my $op = shift;
 	my $credential = shift;
+	my $url = shift;
 	my $pid = open2(my $reader, my $writer, "git credential $op");
+	print $writer "url=$url\n" if defined $url;
 	credential_write($credential, $writer);
 	print $writer "\n";
 	close($writer);
@@ -246,10 +222,10 @@ sub mw_connect_maybe {
 	$mediawiki = MediaWiki::API->new;
 	$mediawiki->{config}->{api_url} = "$url/api.php";
 	if ($wiki_login) {
-		my %credential = credential_from_url($url);
+		my %credential;
 		$credential{username} = $wiki_login;
 		$credential{password} = $wiki_passwd;
-		credential_run("fill", \%credential);
+		credential_run("fill", \%credential, $url);
 		my $request = {lgname => $credential{username},
 			       lgpassword => $credential{password},
 			       lgdomain => $wiki_domain};
-- 
1.7.10.5.40.g059818d
