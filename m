From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 01:21:53 -0400
Message-ID: <20090814052153.GA2881@coredump.intra.peff.net>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 07:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbpEq-0006xO-LL
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 07:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbZHNFVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 01:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbZHNFVy
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 01:21:54 -0400
Received: from peff.net ([208.65.91.99]:44800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbZHNFVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 01:21:53 -0400
Received: (qmail 14810 invoked by uid 107); 14 Aug 2009 05:21:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 Aug 2009 01:21:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Aug 2009 01:21:53 -0400
Content-Disposition: inline
In-Reply-To: <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125897>

On Thu, Aug 13, 2009 at 10:05:48PM -0700, Sverre Rabbelier wrote:

> Those new to git have a hard time learning how to delete a remote
> ref. This makes it easier for them to find out how by providing a
> flag to git push.

Should this also impact refs read from the config? E.g., if I do "git
push --delete" will it try to impact matching refs (which is almost
certainly a mistake), or refs I have in my remote.$X.push (which is
probably also a mistake)?

>From reading your patch, it looks like it just touches the command-line.
I think that's the right thing to do, but I think it makes sense to
think half a second to make sure.

And with the way you have it, "git push --delete" will silently ignore
the --delete and push configured refspecs. Probably it should say
"--delete is useless without refspecs on the command line".

>     Currently `git push --delete master:master` results in a somewhat
>     cryptic error message. It seems unlikely however, that those new
>     to git would use the 'old:new' notation, so I haven't bothered
>     guarding against it and settled for documenting it.

It seems like it would be simple enough to just check whether the
refspec contains a colon; if so, silently leave it alone. That could
also protect configured refspecs, as mentioned above, but I wouldn't
rule out somebody have a single-name refspec in their config (in fact, I
think "remote.$X.push = HEAD" is reasonable -- should that delete the
HEAD on "git push --delete"?).

> +--delete::
> +    Delete the specified refs. Prefixes all refs with ':' to tell the
> +    push machinery to delete the specified ref. As such, the refs
> +    that are to be deleted should not contain a ':' specifier.
> +

This impacts _all_ refspecs. Remember that we can have multiple refspecs
on the command-line. So I can "move" a ref remotely with:

  git push :old-name old-name:new-name

but I can't do:

  git push --delete old-name old-name:new-name

Ignoring colon-less refspecs would make that work, but would not allow
the similar:

  # branch has already been renamed to new-name locally
  git push --delete old-name new-name

So maybe it would make more sense for it to be "--delete <ref>" and
impact only a single ref. The simple case of "git push --delete foo"
would remain unchanged.

The counter-argument is that "--delete" does not necessarily need to be
as powerful as the ":ref" syntax, but I don't see the downside in making
it so.

-Peff
