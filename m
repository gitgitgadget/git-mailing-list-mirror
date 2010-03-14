From: Jeff King <peff@peff.net>
Subject: Re: 'git add' regression in git-1.7?
Date: Sun, 14 Mar 2010 16:44:59 -0400
Message-ID: <20100314204459.GA31564@coredump.intra.peff.net>
References: <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <20100309223729.GA25265@sigill.intra.peff.net>
 <20100309230931.GC25265@sigill.intra.peff.net>
 <7veijsmza0.fsf@alter.siamese.dyndns.org>
 <20100311071543.GA8750@sigill.intra.peff.net>
 <7veijns96t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 21:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqugh-0006nQ-Re
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 21:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab0CNUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 16:45:15 -0400
Received: from peff.net ([208.65.91.99]:58311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932227Ab0CNUpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 16:45:13 -0400
Received: (qmail 15748 invoked by uid 107); 14 Mar 2010 20:45:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Mar 2010 16:45:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Mar 2010 16:44:59 -0400
Content-Disposition: inline
In-Reply-To: <7veijns96t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142153>

On Sat, Mar 13, 2010 at 10:34:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Another option is to declare the current behavior wrong. Letting the
> > shell glob produces different results for obvious reasons:
> >
> >   $ git add b* ;# will fail, because we see individual pathspecs
> >
> > but perhaps that is the "feature" of letting add glob itself. Personally
> > I have never asked "git add" to glob on my behalf, so I don't know why
> > people would do it.
> 
> I know of one reason:
> 
>     $ git add '*.[ch]'
> 
> will add a/b.c and c/d/f.h for you.

Hrm, that makes handling globs with ignores a bit trickier. If I have:

  $ touch root.c
  $ mkdir subdir && touch subdir/file.c
  $ echo subdir >.gitignore
  $ git add '*.[ch]'

what should happen? I would say it should probably not generate an
error, but just add 'root.c'.

In which case, I think we perhaps actively _don't_ want to complain
about ignored globs at all. If they match nothing except excluded files,
we will already complain that the pathspec was useless. And if they do
match some other files, we will silently except. The only "downside"
versus handling globs in the ignore code is that for the no-matches case
we say "pathspec did not match" and not "it _could_ have matched, but
these files were ignored, and you need -f to add them".

But I don't think that latter message even makes sense for a glob. If
you show me just the glob, then it isn't helpful; I don't know which
ignored files matched the glob. And if you show me the list of files, it
is likely to contain unhelpful cruft like "build/generated.c". So I
won't just repeat my command with "-f" anyway; I will find the ignored
file I was interested in adding and specify it explicitly.

So if that reasoning is sound, I think we want to just leave git-add's
behavior as it is currently (with my patch from earlier in this thread
applied, of course). You get different error messages for "git add *.c"
and "git add '*.c'", but that is only natural. You also get different
_behavior_, and that is intentional.

Other callers of COLLECT_IGNORED could conceivably want different
globbing behavior, but right now git-add is the only caller. So it's
certainly not worth caring about at this point.

-Peff
