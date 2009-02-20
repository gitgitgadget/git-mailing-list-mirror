From: Jeff King <peff@peff.net>
Subject: Re: CVS import [SOLVED]
Date: Fri, 20 Feb 2009 10:28:49 -0500
Message-ID: <20090220152849.GA3826@coredump.intra.peff.net>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 16:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaXKq-00024f-68
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 16:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666AbZBTP2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758655AbZBTP2x
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 10:28:53 -0500
Received: from peff.net ([208.65.91.99]:47512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758638AbZBTP2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 10:28:52 -0500
Received: (qmail 2959 invoked by uid 107); 20 Feb 2009 15:29:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 10:29:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 10:28:49 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110855>

On Mon, Feb 16, 2009 at 09:59:29PM +0100, Johannes Schindelin wrote:

> > I'm working on it now, and did some more testing: it's actually the 
> > safecrlf setting, not the autocrlf option.
> 
> Oh.  That probably means that cvsimport gets confused by the extra 
> warnings.
> 
> However, I think it is not correct to run cvsimport with autocrlf set to 
> anything than false anyway (and safecrlf would not trigger then, right?).
> 
> So IMHO the solution is still to force autocrlf off.

I don't think that's right. What is happening is that git-hash-object is
barfing, and git-cvsimport is not properly detecting the error.
something like this (untested) would make that better:

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e439202..65e7990 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -926,6 +926,7 @@ while (<CVS>) {
 			my $sha = <$F>;
 			chomp $sha;
 			close $F;
+			$? and die "hash-object reported failure";
 			my $mode = pmode($cvs->{'mode'});
 			push(@new,[$mode, $sha, $fn]); # may be resurrected!
 		}

But the problem is not autocrlf. It is that the combination of "autocrlf
= input" and "safecrlf" is nonsensical. Just try this:

  $ git init
  $ git config core.autocrlf input
  $ git config core.safecrlf true
  $ printf 'DOS\r\n' >file
  $ git add file
  fatal: CRLF would be replaced by LF in file.

which makes sense. SafeCRLF is about making sure that the file will be
the same on checkin and checkout. But it won't, because we are only
doing CRLF conversion half the time.

So the best workaround is disabling safecrlf, which makes no sense with
his autocrlf setting. But I also think safecrlf could be smarter by
treating autocrlf=input as autocrlf=true. That is, we don't care if in
our _particular_ config it will come out the same; we care about whether
one could, if so inclined, get the CRLF's back to create a byte-for-byte
identical object.

-Peff
