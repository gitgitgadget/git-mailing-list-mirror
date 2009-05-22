From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Fri, 22 May 2009 19:54:14 +0200
Message-ID: <87eiuhdnw9.fsf@meyering.net>
References: <87k549dyne.fsf@meyering.net>
	<7vvdnt869j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Ywy-0006yD-0H
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 19:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310AbZEVRyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 13:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757243AbZEVRyW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 13:54:22 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:58479 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757201AbZEVRyV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 13:54:21 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 2A8084B00B9
	for <git@vger.kernel.org>; Fri, 22 May 2009 19:54:17 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 4A3B44B011B
	for <git@vger.kernel.org>; Fri, 22 May 2009 19:54:15 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id E521C2AD05; Fri, 22 May 2009 19:54:14 +0200 (CEST)
In-Reply-To: <7vvdnt869j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 May 2009 09:14:00 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119746>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>> git-diff's --quiet option works how I'd expect with --ignore-space-at-eol
>> as long as I'm also using --no-index:
>>
>>     $ echo>b; echo \ >c; git diff --no-index --quiet --ignore-space-at-eol b c \
>>       && echo good
>>     good
>>
>> But in what I think of as normal operation (i.e., without --no-index),
>> --exit-code (or --quiet) makes git-diff say there were differences,
>> even when they have been ignored:
>>
>>     # do this in an empty directory
>>     $ git init -q; echo>k; git add .; git commit -q -m. .; echo \ >k
>>     $ git diff --ignore-space-at-eol --quiet || echo bad
>>     bad
>
> I am slightly torn about this, in that I can picture myself saying that
> this is unintuitive on some different days, but not today ;-)

Thanks for the quick reply.  Here's why I noticed:

I wanted to ensure that the only changes induced by commit C were
to trailing blanks.  I wrote something like this, expecting to be able
to deal with the exception:

    git --quiet --ignore-space-at-eol --quiet C^..C || handle_unexpected

But handle_unexpected was always being invoked.
I was surprised because GNU diff's --ignore-all-space (-w) option does
work the way I expected:

    $ echo>b; echo \ >c; diff -w b c && echo $?
    0

> If you look at the output (i.e. no --quiet), you would see that the blob
> changes are still reported for the path.  E.g.  you would see something
> like...
>
> 	$ git diff --ignore-space-at-eol
>         diff --git a/k b/k
>         index 8b13789..8d1c8b6 100644
>
> The "index" line is still showing that there _is_ a difference.

I did see that, to my chagrin:
if using a --ignore-... option had also suppressed those, I could
have tested for empty output instead of exit status.

> The --ignore-* options are there merely to tell git what changes are not
> worth _showing_ in the textual part of the patch, in order to cut down the
> amount of the output.  It never affects the outcome.
>
> So if anything, I think --no-index codepath is what's buggy; if it does
> not report the blob difference that is a different matter, though.

If need be, I can work around it.
