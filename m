From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Sat, 26 May 2007 00:47:09 -0700
Message-ID: <7vps4om3gi.fsf@assigned-by-dhcp.cox.net>
References: <465750FE.9000406@iii.hu>
	<20070526004028.GA8940@sigill.intra.peff.net>
	<20070526011036.GA4169@gondor.apana.org.au>
	<20070526034236.GA18169@coredump.intra.peff.net>
	<7vps4onps0.fsf@assigned-by-dhcp.cox.net>
	<20070526060748.GA20715@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Szekeres Istvan <szekeres@iii.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 09:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrqzh-0000cs-MD
	for gcvg-git@gmane.org; Sat, 26 May 2007 09:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXEZHrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 03:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbXEZHrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 03:47:16 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39936 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbXEZHrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 03:47:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526074711.YDNH22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 03:47:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3jn91X0071kojtg0000000; Sat, 26 May 2007 03:47:09 -0400
In-Reply-To: <20070526060748.GA20715@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 26 May 2007 02:07:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48458>

Jeff King <peff@peff.net> writes:

> On Fri, May 25, 2007 at 09:59:43PM -0700, Junio C Hamano wrote:
>
>>  * I suspect we would declare either "war on echo" or "harder push
>>    for builtins" triggered by these.
>
> Cry havoc! More fixes below (just a diff -- maybe we want to aggregate
> these into a single commit?).
>
> These are the ones I noticed that use commit messages (which are
> probably the most likely to use backslash). There are _tons_ of uses for
> heads and filenames. I think we either should stop with commit messages,
> or go all-out and simply remove all uses of echo (because there are
> literally hundreds otherwise).

At least the ones you did look very sane to me.  Will apply with
appropriate log message, credit to you.

Thanks.

I do not think we need to do all the uses of 'echo'.  Many of
them are clearly fixed string we know about, object names we
parsed out of plumbing output, refnames and refspecs, all of
which should be safe.

Other worrisome ones are pathnames, but (1) I do not think
anybody is insane enough to have slashed funnies in their
pathname components, (2) half the pathnames we deal with come
from plumbing output which use '/' as path component separator
even on Windows, (3) users can use forward slash as path
component separator in their input even on Windows, and (4) even
though we try to use -z output from plumbing and read it with -0
capable downstream in some of our pipelines, many pure-shell
scripts read non-z output using shell built-in "read" and do not
unquote c-quoted ones, so they do not work correctly if you have
HT or LF in your pathnames anyway (notable exception is that
pipelines between git plumbing, e.g. "ls-files | update-index
--stdin", are safe without -z, as the downstream knows how to
unquote c-quoted paths).

I would expect that by the time we run out of more important
things to worry about and start worrying about truly funny
pathnames, we would have rewritten more of the remaining
Porcelains shell scripts in C, which automatically would make
this problem go away.
