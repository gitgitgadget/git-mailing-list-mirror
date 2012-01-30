From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 30 Jan 2012 16:48:43 -0500
Message-ID: <20120130214842.GA16149@sigill.intra.peff.net>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrz5m-0007nB-9e
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab2A3Vsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:48:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48776
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab2A3Vsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:48:45 -0500
Received: (qmail 24781 invoked by uid 107); 30 Jan 2012 21:55:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jan 2012 16:55:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jan 2012 16:48:43 -0500
Content-Disposition: inline
In-Reply-To: <7v39axc9gp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189431>

On Mon, Jan 30, 2012 at 10:48:54AM -0800, Junio C Hamano wrote:

> Note that I am not saying that we shouldn't add support for special cases
> with special case codepaths.
> 
> Perhaps we would need to sprinkle more special case magic like this (this
> is for the special case that arises from the same cause)?

I like your patch better than trying to pass around "0{40}", but:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7095718..0997e75 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -640,6 +640,13 @@ static int edit_branch_description(const char *branch_name)
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf name = STRBUF_INIT;
>  
> +	strbuf_addf(&name, "refs/heads/%s", branch_name);
> +	if (!ref_exists(name.buf)) {
> +		strbuf_reset(&name);
> +		return error("No such branch '%s'.", branch_name);
> +	}
> +	strbuf_reset(&name);
> +

I wonder if this conditional should have:

  unsigned char sha1[20];
  const char *head_points_at = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
  if (!head_points_at || strcmp(head_points_at, name.buf))
          return error("No such branch '%s'.", branch_name);

to special-case unborn branches that we are actually pointing to.

IOW, the problem with the current code is that it allows typos and other
arbitrary bogus names to be silently described, even though doing so is
probably an error. But since this branch is already in use (even though
its ref does not technically exist yet), it's probably not an error.

As an aside, the strbuf_reset inside the conditional should be
strbuf_release, no? Otherwise we are leaking. And probably the one
outside, too. Even though we release the memory later, there are error
code-paths that do not. (And yes, I know this was a quick sketch and not
a real patch, but I wanted to point it out in case it turns into a real
one).

-Peff
