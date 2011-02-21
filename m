From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-svn fails to rename files with %20 in filename
Date: Mon, 21 Feb 2011 07:31:16 -0500
Message-ID: <20110221123115.GB23033@sigill.intra.peff.net>
References: <1298283144.2772.7.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrUvF-00084K-23
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab1BUMbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 07:31:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755899Ab1BUMbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 07:31:18 -0500
Received: (qmail 24251 invoked by uid 111); 21 Feb 2011 12:31:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 21 Feb 2011 12:31:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Feb 2011 07:31:16 -0500
Content-Disposition: inline
In-Reply-To: <1298283144.2772.7.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167475>

On Mon, Feb 21, 2011 at 10:12:24AM +0000, Will Palmer wrote:

> Someone accidentally checked some files containing "%20" in their names
> into our svn repository, which is accessed with either svn or git-svn
> depending on the developer.
> When I attempted to correct this by renaming the file, I received (on
> dcommit):
> Filesystem has no item: File not found: revision 1, path
> '/theBeginningOfTheOriginalFileName theRestOfTheOriginalFilename'
> at /home/wpalmer/libexec/git-core/git-svn line 576
> 
> A recipe for reproducing this bug is as follows:
> [...]

Thanks for the thorough test case. It seems to pass for me if with this
applied:

diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..7daf63c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4556,9 +4556,7 @@ sub repo_path {
 
 sub url_path {
 	my ($self, $path) = @_;
-	if ($self->{url} =~ m#^https?://#) {
-		$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
-	}
+	$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
 	$self->{url} . '/' . $self->repo_path($path);
 }
 

IOW, it looks like the path we hand to svn needs url-encoding even for
the local case (which make sense, as it is a file:// url). But I know
nothing about svn, so probably I am breaking some other weird non-url
local case. :)

-Peff
