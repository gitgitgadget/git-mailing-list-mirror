From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 07:38:55 -0400
Message-ID: <20100512113855.GB23847@coredump.intra.peff.net>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
 <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
 <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
 <20100508053025.GG14998@coredump.intra.peff.net>
 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
 <19429.3589.823244.270582@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 12 13:39:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCAHQ-000422-E2
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 13:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab0ELLi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 07:38:57 -0400
Received: from peff.net ([208.65.91.99]:57671 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab0ELLi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 07:38:56 -0400
Received: (qmail 3017 invoked by uid 107); 12 May 2010 11:38:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 07:38:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 07:38:55 -0400
Content-Disposition: inline
In-Reply-To: <19429.3589.823244.270582@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146941>

On Sat, May 08, 2010 at 03:08:53AM -0400, Eli Barzilay wrote:

> So I think that it would really help if (1) the diff options in the
> git-log man page move to after its own options, and (2) they appeared
> after a title saying that these are the diff options, (3) `--follow'
> moves up before the few preceding options that seem to me less
> important.  To clarify, I added a simple patch to the end of this
> message.  (`git-format-patch' has the same thing, but there it looks
> more sensible to leave it as is.)

I have no opinion on moving --follow around, but I definitely agree that
more clearly marking the diff-options (and including them after
revision traversal options) is much better.

> How about these options:
> 
>   git config log.follow if-single-file
>     makes it use --follow only when there's a single file path given,
>     ignoring it otherwise (with no confusion about it now)
> 
>   git config log.follow if-possible
>     makes it do the same, but might also do it for more cases if/when
>     they become available (so this is the "do the best you can"
>     option)
> 
>   git config log.follow true
>     invalid until it is always possible to use --follow

I'm not thrilled with it. It still leaves the confusing behavior, but
because we forced the user to pick the confusing behavior, we get to
claim it is their fault. So while we may be guilt-free, I'm not happy
with an option that produces such confusing behavior.

I really wonder if it would be that hard to just fix the code to follow
several files. It shouldn't be conceptually different. When any file
matching the pathspec we're following has a creation event going from
the parent to the commit in question, then we would do rename detection
for that file (and any others created in the same commit). Any detected
sources get added to the pathspec.

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index fb184ba..6bc7064 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -24,7 +24,6 @@ OPTIONS
>  -------
>  
>  :git-log: 1
> -include::diff-options.txt[]

This ":git-log: 1" magic should probably follow the include. It sets up
an attribute for diff-options.txt to conditionally include some
log-specific bits.

-Peff
