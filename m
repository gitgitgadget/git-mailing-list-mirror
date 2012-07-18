From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 08:57:41 -0400
Message-ID: <20120718125741.GA11605@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
 <20120718120656.GD6726@sigill.intra.peff.net>
 <vpqd33tjlzm.fsf@bauges.imag.fr>
 <20120718122848.GB11482@sigill.intra.peff.net>
 <vpq1uk9jldk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTp8-0001WB-1v
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab2GRM5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:57:46 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39138
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab2GRM5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:57:44 -0400
Received: (qmail 19635 invoked by uid 107); 18 Jul 2012 12:57:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:57:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:57:41 -0400
Content-Disposition: inline
In-Reply-To: <vpq1uk9jldk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201689>

On Wed, Jul 18, 2012 at 02:37:27PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I started with a version that did that, but there are two complications:
> >
> >   1. credential_write needs to know that the 'url' field must come
> >      first, as it overwrites the other fields. So we end up
> >      special-casing it either way.
> 
> Right, I didn't think of that. But you'd have to special-case it only
> within credential_run, and not for the caller.

Yeah. It would look like this:

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c9ac416..e1392b0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -190,9 +190,11 @@ sub credential_write {
 sub credential_run {
 	my $op = shift;
 	my $credential = shift;
-	my $url = shift;
 	my $pid = open2(my $reader, my $writer, "git credential $op");
-	print $writer "url=$url\n" if defined $url;
+	if (exists $credential->{url}) {
+		print $writer "url=$credential->{url}\n";
+		delete $credential->{url};
+	}
 	credential_write($credential, $writer);
 	print $writer "\n";
 	close($writer);

which is still kind of ugly. We could also push it down into
credential_write, like:

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c9ac416..0a821fd 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -180,8 +180,9 @@ sub credential_read {
 sub credential_write {
 	my $credential = shift;
 	my $writer = shift;
+	print $writer "url=$credential->{url}\n" if exists $credential->{url};
 	while (my ($key, $value) = each(%$credential) ) {
-		if (length $value) {
+		if (length $value && $key ne 'url') {
 			print $writer "$key=$value\n";
 		}
 	}
@@ -190,9 +191,7 @@ sub credential_write {
 sub credential_run {
 	my $op = shift;
 	my $credential = shift;
-	my $url = shift;
 	my $pid = open2(my $reader, my $writer, "git credential $op");
-	print $writer "url=$url\n" if defined $url;
 	credential_write($credential, $writer);
 	print $writer "\n";
 	close($writer);

which is probably the least gross. I was originally hesitant because the
issue (2) I brought up, but...

> >   2. Git hands us back the broken-down version, which we add to the
> >      credential.
> 
> We don't add it, but already replace the whole structure. This is
> somehow needed because "git credential fill" can remove fields from the
> structure (the path attribute is removed with
> credential.useHttpPath=false). So, this point doesn't seem problematic.

Hmph. I considered that we might do it and even checked, but I somehow
read the code wrong (I think I was thrown off by the pass-by-reference
to credential_run, but of course it overwrites it inside that function).

So since that is a non-issue, I think the second diff I provided above
is a bit nicer.

-Peff
