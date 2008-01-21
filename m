From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 21 Jan 2008 12:18:14 -0800
Message-ID: <7vejcbx795.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
	<47946F67.5060601@gbarbier.org>
	<7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>
	<47947399.3000507@gbarbier.org>
	<7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801211212010.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Gr=C3=A9goire?= Barbier <devel@gbarbier.org>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:19:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH36d-00032C-8r
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbYAUUSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYAUUSZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:18:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYAUUSY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 15:18:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 71CB04964;
	Mon, 21 Jan 2008 15:18:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AC35D4962;
	Mon, 21 Jan 2008 15:18:17 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801211212010.5731@racer.site> (Johannes
	Schindelin's message of "Mon, 21 Jan 2008 12:17:10 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71326>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> IMHO it is safer to disable it for curl < 7.0xa -- even if it affects a 
> number of distros -- than to give the illusion that it works, when it does 
> not.
>
> As for fixing it in the non-MULTI case, I have a hunch that Mike's 
> cleanups will help that, but that this is a 1.5.5 feature.
>
> So, I would like to read in the ReleaseNotes something like this:
>
> -- snip --
> Support for pushing via HTTP was broken with curl versions prior to 7.16, 
> so we disabled it for now.  However, it is likely that a major cleanup of 
> the http transport code -- scheduled after the release of git 1.5.4 -- 
> will be supported with more curl versions.
> -- snap --

That's tempting but I suspect that it might be a wrong approach.

I think two important questions are:

 * Do we know that the current code is broken for everybody, or
   just broken for the majority of people who do nontrivial
   things?

 * Is the code in 1.5.3.8 any better?  IOW, did we make it worse
   during 1.5.4 cycle?

The feature was added by one person who needed it, and it was
included because the need was satisfid with an implementation,
so at some point in the past, it must have worked for _somebody_
(I am hoping that this is not a regression during 1.5.4 cycle).

Imagine that you are like that somebody who have been happily
using http-push.  Or imagine that you are starting to use git
and are tempted to use http-push.  With the above wording, I
strongly suspect that you would say "Crap --- 1.5.4 does not let
me run http-push, so I'll stay at 1.5.3.8 until 1.5.X lets me
use it again".

Which is _not_ a solution, if 1.5.3.8 has an http-push that is
broken the same way.  You will be choosing a version with the
same brokenness with respect to http-push, and are missing fixes
we made to http-push during 1.5.4 cycle, let alone fixes and
enhancements to other programs that comes with 1.5.4.

So while I strongly agree that we should warn the users about
existing breakages, I think it is better to just revert the code
to limit its use to USE_CURL_MULTI, if that is the case.

Do we even know what exactly is broken?

On the other hand, if the "transport.c" rewrite broke it and the
current one for 1.5.4 is fundamentally much worse than what we
used to have in 1.5.3.8, would it be possible as an interim
measure to revert http-push changes (but keep changes to other
programs that already are converetd to use transport.c) so that
we can ship the same code as 1.5.3.8 only for http-push?
Perhaps copy in selected old sources in a subdirectory to build
and link a standalone http-push program?
