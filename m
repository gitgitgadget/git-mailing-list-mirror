From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 18:59:13 -0400
Message-ID: <20121017225913.GC21742@sigill.intra.peff.net>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:59:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOcaF-0002VZ-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 00:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab2JQW7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 18:59:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56985 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2JQW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 18:59:15 -0400
Received: (qmail 30805 invoked by uid 107); 17 Oct 2012 22:59:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 18:59:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 18:59:13 -0400
Content-Disposition: inline
In-Reply-To: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207946>

On Wed, Oct 17, 2012 at 02:58:41PM +0200, Felipe Contreras wrote:

> I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
> slow, or to difficult to setup, etc.

I run into this every few months, evaluate all of the options, and come
to the same conclusion. So I am excited at the prospect of something
simple that just works out of the box.

Unfortunately, when I tried it, it did not work for me. :(

Details below.

>  contrib/remote-hd/git-remote-hg | 231 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100755 contrib/remote-hd/git-remote-hg

Is this "hd" a typo, or is there something clever I am missing?

> --- /dev/null
> +++ b/contrib/remote-hd/git-remote-hg
> @@ -0,0 +1,231 @@
> +#!/usr/bin/python2

I do not have /usr/bin/python2. I do have (on my Debian box):

  $ ls -l /usr/bin/python* | perl -lne 'print $& if m{/.*}'
  /usr/bin/python -> python2.7
  /usr/bin/python2.6
  /usr/bin/python2.7
  /usr/bin/python3 -> python3.2
  /usr/bin/python3.2 -> python3.2mu
  /usr/bin/python3.2mu
  /usr/bin/python3mu -> python3.2mu

Obviously a minor, easily fixable issue, but I wonder if it should ship
with a more portable default (like just "/usr/bin/python", or even
"/usr/bin/env python").

> +# Inspired by Rocco Rutte's hg-fast-export
> +
> +# Just copy to your ~/bin, or anywhere in your $PATH.
> +# Then you can clone with:
> +# hg::file:///path/to/mercurial/repo/

The first thing I tried was:

  $ git clone hg::https://code.google.com/p/dactyl/ 
  Cloning into 'dactyl'...
  fatal: Unable to find remote helper for 'hg'
  sigill:~/compile/dactyl$ git clone hg::https://code.google.com/p/dactyl/ 
  Cloning into 'dactyl'...
  Traceback (most recent call last):
    File "/home/peff/local/bin/git-remote-hg", line 231, in <module>
      sys.exit(main(sys.argv))
    File "/home/peff/local/bin/git-remote-hg", line 222, in main
      do_list(repo, args)
    File "/home/peff/local/bin/git-remote-hg", line 159, in do_list
      head = repo.dirstate.branch()
  AttributeError: 'httpsrepository' object has no attribute 'dirstate'

So we are failing here:

> +def do_list(repo, args):
> +    global branches
> +
> +    head = repo.dirstate.branch()
> +    for branch in repo.branchmap():
> +        heads = repo.branchheads(branch)
> +        if len(heads):
> +            branches[branch] = heads

Is there a way to get this information for remote repos?

I worked around it by doing an hg-clone and trying to git-clone from
that local clone. But that didn't work either:

  $ hg clone https://code.google.com/p/dactyl/ hg
  [... clone eventually completes ...]

  $ git clone hg::$PWD/hg git
  Cloning into 'git'...
  progress revision 99 'pentadactyl-1.0b5-branch' (100/5367)
  [... many more progress updates ...]
  progress revision 6766 'cpg-hack' (1400/1467)
  ERROR: Branch 'default' has more than one head
  error: refs/tags/VIMPERATOR_2_2_b1 does not point to a valid object!
  error: refs/tags/muttator-0.5 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b1 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b2 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b3 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b4 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b4.1 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b4.2 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b4.3 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b5 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b5.1 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b6 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b7 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0b7.1 does not point to a valid object!
  error: refs/tags/pentadactyl-1.0rc1 does not point to a valid object!
  error: refs/tags/vimperator-0.4.1 does not point to a valid object!
  error: refs/tags/vimperator-0.5 does not point to a valid object!
  error: refs/tags/vimperator-0.5-branch-HEAD-merge-1 does not point to a valid object!
  error: refs/tags/vimperator-0.5.1 does not point to a valid object!
  error: refs/tags/vimperator-0.5.2 does not point to a valid object!
  error: refs/tags/vimperator-0.5.3 does not point to a valid object!
  error: refs/tags/vimperator-1.0 does not point to a valid object!
  error: refs/tags/vimperator-1.1 does not point to a valid object!
  error: refs/tags/vimperator-1.2 does not point to a valid object!
  error: refs/tags/vimperator-2.0 does not point to a valid object!
  error: refs/tags/vimperator-2.0a1 does not point to a valid object!
  error: refs/tags/vimperator-2.1 does not point to a valid object!
  error: refs/tags/vimperator-2.2 does not point to a valid object!
  error: refs/tags/vimperator-2.2b1 does not point to a valid object!
  error: refs/tags/xulmus-0.1 does not point to a valid object!

I seem to remember getting this with other importers, too (probably
because they were also based on the same script).

We do not need to fix every bug before bringing a script into git
(especially into contrib/), but I am wondering if this script errs too
much on the side of "simple" and not enough on "works out of the box".
Maybe this repo is really complex and unusual, and the multi-heads thing
is not common enough to worry about. But I feel cloning a remote is the
first thing most people are going to try, and it doesn't work.

-Peff
