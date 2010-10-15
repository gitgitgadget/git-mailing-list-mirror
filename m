From: Jeff King <peff@peff.net>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 15:48:51 -0400
Message-ID: <20101015194851.GA31131@sigill.intra.peff.net>
References: <loom.20101012T114900-532@post.gmane.org>
 <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
 <loom.20101014T095743-275@post.gmane.org>
 <i9a6kn$d7o$1@dough.gmane.org>
 <20101015184302.GA22990@burratino>
 <20101015185539.GA30380@sigill.intra.peff.net>
 <20101015193252.GA23082@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 21:48:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6qGX-0005J5-Fh
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 21:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440Ab0JOTs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 15:48:27 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34700 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932378Ab0JOTs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 15:48:27 -0400
Received: (qmail 19712 invoked by uid 111); 15 Oct 2010 19:48:23 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 15 Oct 2010 19:48:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Oct 2010 15:48:51 -0400
Content-Disposition: inline
In-Reply-To: <20101015193252.GA23082@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159135>

On Fri, Oct 15, 2010 at 02:32:52PM -0500, Jonathan Nieder wrote:

> > git commit -o|--only, which is the same as "git commit <paths>". Of
> > course it still uses an index, to create the tree, but it uses a
> > temporary one based on HEAD instead of the current index contents.
> 
> Ah, it's stranger than that.
> 
> 	 * A partial commit.
> 	 *
> 	 * (0) find the set of affected paths;
> 	 * (1) get lock on the real index file;
> 	 * (2) update the_index with the given paths;
> 	 * (3) write the_index out to the real index (still locked);
> 	 * (4) get lock on the false index file;
> 	 * (5) reset the_index from HEAD;
> 	 * (6) update the_index the same way as (2);
> 	 * (7) write the_index out to the false index file;
> 	 * (8) return the name of the false index file (still locked);
> 
> The net effect being that the index will match the work tree for the
> listed paths when the operation is over, while other files are
> untouched.

Well, yeah, it does have to update those files in the regular index. Any
other semantics would be insane; the change would appear reverted
looking at the difference between HEAD and the index.

With respect to your proposed change:

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 42fb1f5..6bb3eff 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -191,9 +191,10 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
>  --only::
>  	Make a commit only from the paths specified on the
>  	command line, disregarding any contents that have been
> -	staged so far. This is the default mode of operation of
> -	'git commit' if any paths are given on the command line,
> -	in which case this option can be omitted.
> +	staged so far.  The state of other files in the index is
> +	preserved and will not affect the commit.  This is the
> +	default mode of operation of 'git commit' if any paths are given
> +	on the command line, in which case this option can be omitted.

I always assumed that "disregarding any contents that have been staged"
meant "we will leave unmentioned paths alone". But I don't think it
hurts to be explicit. So your change looks fine to me.

-Peff
