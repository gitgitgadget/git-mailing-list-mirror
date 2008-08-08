From: Jeff King <peff@peff.net>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Fri, 8 Aug 2008 17:19:16 -0400
Message-ID: <20080808211916.GA30583@sigill.intra.peff.net>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com> <20080604192916.GB17327@sigill.intra.peff.net> <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com> <20080604230858.GA27136@sigill.intra.peff.net> <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Baptiste Quenot <jbq@caraldi.com>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 23:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRZNj-0006fh-UG
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 23:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbYHHVTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 17:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYHHVTS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 17:19:18 -0400
Received: from peff.net ([208.65.91.99]:4738 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbYHHVTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 17:19:17 -0400
Received: (qmail 23560 invoked by uid 111); 8 Aug 2008 21:19:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 08 Aug 2008 17:19:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Aug 2008 17:19:16 -0400
Content-Disposition: inline
In-Reply-To: <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91717>

On Wed, Aug 06, 2008 at 01:06:51PM +0200, Jonas Fonseca wrote:

> Sorry for restarting this old thread ...

I am glad you got a chance to look at it. :)

> I actually added something that let's you alter the command executed
> for each view. So here is another possibility that can be used:
> 
> function tignowalk ()
> {
>    tmp=$(mktemp) # or .git/tigfiles or similar
>    # Safe stuff from "stdin" and run tig with custom rev-list command
>    cat > "$tmp
>    TIG_MAIN_CMD="git rev-list --pretty=raw --no-walk --stdin < $tmp"
> tig < /dev/tty
>    rm "$tmp"
> }

Neat, if a bit hack-ish. :) You are missing a closing quotation mark
after

  cat > "$tmp

and the line break between TIG_MAIN_CMD and tig is obviously problematic
(presumably an artifact of the email, but it confused my cut and paste
efforts for a minute). One other thing to note is that even though you
try to handle a $tmp with whitespace in the cat and rm commands, I
suspect it would fail when tig hands TIG_MAIN_CMD to the shell. That
would require double-quoting.

So here is my cut-and-pastable version:

  tignowalk() {
    tmp=$(mktemp)
    cat >"$tmp"
    TIG_MAIN_CMD="git rev-list --pretty=raw --no-walk --stdin <$tmp" \
      tig </dev/tty
    rm "$tmp"
  }

The output looks great, though. Doing

  git show-ref --heads | cut -d' ' -f2 | tignowalk

is nice. :)

> The problem is that --no-walk doesn't seem to play nice with the
> --boundary flag that tig add by default. When the user requests
> --no-walk boundary commits are probably not interesting. My fix below
> has more information. I don't know if having only the "commit" line
> show up is a bug in git. At least there are no tests to confirm this
> or not.

Sorry, I don't know if that is intentional or not.

-Peff
