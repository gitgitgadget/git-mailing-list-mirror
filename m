From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 09:03:08 -0400
Message-ID: <20120718130308.GA11769@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
 <20120718120656.GD6726@sigill.intra.peff.net>
 <vpqd33tjlzm.fsf@bauges.imag.fr>
 <20120718122848.GB11482@sigill.intra.peff.net>
 <vpq1uk9jldk.fsf@bauges.imag.fr>
 <20120718125741.GA11605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 15:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTuY-0002Do-1w
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 15:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab2GRNDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 09:03:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39143
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab2GRNDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 09:03:11 -0400
Received: (qmail 19737 invoked by uid 107); 18 Jul 2012 13:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 09:03:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 09:03:08 -0400
Content-Disposition: inline
In-Reply-To: <20120718125741.GA11605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201690>

On Wed, Jul 18, 2012 at 08:57:41AM -0400, Jeff King wrote:

> So since that is a non-issue, I think the second diff I provided above
> is a bit nicer.

And here is a replacement patch 4/4.

-- >8 --
Subject: mw-to-git: use git-credential's URL parser

We can just feed our URL straight to git-credential and it
will parse it for us, saving us some code.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/mw-to-git/git-remote-mediawiki | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index b06f27b..38afa76 100755
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
@@ -206,8 +180,10 @@ sub credential_read {
 sub credential_write {
 	my $credential = shift;
 	my $writer = shift;
+	# url overwrites other fields, so it must come first
+	print $writer "url=$credential->{url}\n" if exists $credential->{url};
 	while (my ($key, $value) = each(%$credential) ) {
-		if (length $value) {
+		if (length $value && $key ne 'url') {
 			print $writer "$key=$value\n";
 		}
 	}
@@ -246,7 +222,7 @@ sub mw_connect_maybe {
 	$mediawiki = MediaWiki::API->new;
 	$mediawiki->{config}->{api_url} = "$url/api.php";
 	if ($wiki_login) {
-		my %credential = credential_from_url($url);
+		my %credential = (url => $url);
 		$credential{username} = $wiki_login;
 		$credential{password} = $wiki_passwd;
 		credential_run("fill", \%credential);
-- 
1.7.10.5.40.g059818d
