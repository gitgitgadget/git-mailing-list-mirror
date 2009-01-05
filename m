From: Jeff King <peff@peff.net>
Subject: Re: git-branch --print-current
Date: Mon, 5 Jan 2009 00:50:10 -0500
Message-ID: <20090105055010.GA13189@coredump.intra.peff.net>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu> <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com> <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu> <20090104033839.GD21154@genesis.frugalware.org> <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu> <7vzli73b1g.fsf@gitster.siamese.dyndns.org> <9b18b3110901040535m1f67cb7er95823d31443ee971@mail.gmail.com> <7v1vvitwio.fsf@gitster.siamese.dyndns.org> <20090105021832.GA20973@spearce.org> <7vsknys8y1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	demerphq <demerphq@gmail.com>, Karl Chen <quarl@cs.berkeley.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 06:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJiNL-0000Zw-IQ
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 06:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbZAEFuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 00:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZAEFuP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 00:50:15 -0500
Received: from peff.net ([208.65.91.99]:48841 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbZAEFuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 00:50:14 -0500
Received: (qmail 9959 invoked by uid 107); 5 Jan 2009 05:50:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Jan 2009 00:50:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jan 2009 00:50:10 -0500
Content-Disposition: inline
In-Reply-To: <7vsknys8y1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104563>

On Sun, Jan 04, 2009 at 07:55:34PM -0800, Junio C Hamano wrote:

> > I agree, its nuts to be there.  But this also does show up in 1.6.1.
> > What's odd is the output of rev-parse --git-dir is wrong:
> >
> >   $ cd .git/refs
> >   $ git rev-parse --git-dir
> >   .
> >
> > Its *not* ".", its "..", I'm *in* the directory.  This throws off
> > a lot of the other operations we do in __git_ps1, like detecting
> > the repository state by checking MERGE_HEAD or rebase-apply.
> >
> > I think we should fix rev-parse --git-dir if we can, not the bash
> > completion code.
> 
> Sigh, yeah, that is what I thought would be happening.

I took a quick look at this. I think there is something fundamentally
wrong with the logic for reporting relative git-dir. It basically ends
up doing something like (this is in setup_git_directory_gently, but the
value is just printed directly in rev-parse):

  while (1) {
    if (is_git_dir(".")) {
      setenv("GIT_DIR", ".");
      break;
    }
    chdir("..");
  }

So yes, it's true at the end of that loop that we the git dir _is_ ".",
but that isn't suitable for telling any other processes who didn't
follow the chdir with us.

The quick fix is for rev-parse to turn that into an absolute path. I
don't know if that breaks any callers.

A better fix is probably for setup_git_directory to not require changing
the directory (or to chdir back to the original at the end, and set the
GIT_DIR in a properly relative manner).

-Peff
