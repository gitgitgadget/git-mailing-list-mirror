From: Jeff King <peff@peff.net>
Subject: Re: {bug} warning: unable to access 'RelNotes/.gitattributes'
Date: Thu, 13 Sep 2012 17:15:12 -0400
Message-ID: <20120913211512.GA16968@sigill.intra.peff.net>
References: <7vpq5qa0w9.fsf@alter.siamese.dyndns.org>
 <20120913123740.GB4287@sigill.intra.peff.net>
 <7vy5kd7lu0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGkx-00044o-4I
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab2IMVPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:15:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43784 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2IMVPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:15:15 -0400
Received: (qmail 8159 invoked by uid 107); 13 Sep 2012 21:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 17:15:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 17:15:12 -0400
Content-Disposition: inline
In-Reply-To: <7vy5kd7lu0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205426>

On Thu, Sep 13, 2012 at 12:40:39PM -0700, Junio C Hamano wrote:

> > Interesting. I don't get any such warning on repack. And RelNotes points
> > to a file, so I'm not sure why stat() would make us think it was a dir.
> 
> Interesting.  The command in question is
> 
>  git-pack-objects --keep-true-parents --honor-pack-keep --non-empty \
>     --all --reflog --delta-base-offset </dev/null .junk-pack

Weird. I don't see any problems with that command, either (I tried it
with the current 'next'). Thinking that maybe delta reuse was getting in
the way, I also tried it with --no-reuse-delta.

>  - "rev-list --object --all" does not produce "Relnotes/1.7.4.txt"
>    (it does have "Documentation/RelNotes/1.7.4.txt", of course).
>    Somebody in this callchain is screwing the name up.

Yeah, that sounds like a pretty huge bug. But since I can't reproduce,
you're on your own for tracking it down.

>  - Even if the name were correct, we are looking at the path that
>    existed in the past.  The value of checking the attributes file
>    in the working tree for "delta" attribute is dubious.

I don't think it's dubious. Imagine you had a bunch of binary files and
you did:

  $ echo "*.bin -delta" >.gitattributes
  $ git repack -ad

You would expect it to affect all of the .bin files through history, no?
The real issue is that we should be much more lenient, because we have
no clue if the filename has any basis in the working tree.

While it's cool that the ENOTDIR warning has possibly found another bug,
I think in the long run we would want to ignore ENOTDIR along with
ENOENT to handle this situation (and I think it would be safe to do it
all the time, and not worry about this "special" case).

>  - This is done while traversing the commit list and enumerating
>    objects, so even if we have many incarnations of the same path in
>    different commits, the attr stack mechanism would only help
>    objects in the same directory in the same commit.  Perhaps we
>    could do this after collecting all the blobs, check attributes
>    for each path only once (in a sorted order so that we can take
>    advantage of the attr stack), to reduce the cost of "delta"
>    attribute check.

That is a totally separate issue, but it might be a nice optimization.
A good start would be just running "prof" and seeing how much time we
spend on the attr stack now (I suspect it is really not much compared to
the actual packing, but maybe on systems with horribly slow stat() it
would be worse).

> In any case, because the directory that used to exist to house the
> blob in it may no longer exist, giving the warning on ENOTDIR that
> your 11e50b2 (attr: warn on inaccessible attribute files,
> 2012-08-21) is a wrong thing to do (assuming that checking the
> current attribute setting for historical tree is a sensible thing to
> do, that is).

I think that this:

> diff --git i/attr.c w/attr.c
> index f12c83f..056d702 100644
> --- i/attr.c
> +++ w/attr.c
> @@ -353,7 +353,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
>  	int lineno = 0;
>  
>  	if (!fp) {
> -		if (errno != ENOENT)
> +		if (errno != ENOENT && errno != ENOTDIR)
>  			warn_on_inaccessible(path);
>  		return NULL;
>  	}

is the right thing to do. It's cool that it uncovered a bug in this
case, but it is easy to construct a non-bug case that would exhibit the
same bogus warning (just convert a directory into a file).

-Peff
