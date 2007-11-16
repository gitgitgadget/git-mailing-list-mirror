From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Thu, 15 Nov 2007 22:39:26 -0800
Message-ID: <7vfxz61yox.fsf@gitster.siamese.dyndns.org>
References: <473D3593.9080806@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 07:39:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isurq-0007vD-7s
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 07:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbXKPGje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 01:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXKPGje
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 01:39:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45986 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbXKPGjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 01:39:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8128E2EF;
	Fri, 16 Nov 2007 01:39:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0545293636;
	Fri, 16 Nov 2007 01:39:51 -0500 (EST)
In-Reply-To: <473D3593.9080806@zwell.net> (Dan Zwell's message of "Fri, 16 Nov
	2007 00:15:47 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65197>

Dan Zwell <dzwell@gmail.com> writes:

> Previously, the Git->repository()->config('non-existent.key')
> evaluated to as true in a vector context. Return an empty list
> instead.
> ---
> I don't know whether this breaks anything, because I don't use most of
> the git perl scripts. I can't imagine that there is a script that
> relies on the fact that config('non-existent.key') actually returns
> (''), in an array context. Is this a reasonable change?

I did not examine the callers but my gut feeling is that it
would be simpler and cleaner to always return () without
checking the context.  In scalar context:

	sub null {
        	...
                return ();
	}
	my $scalar = null();

would assign undef to $scalar anyway.

I generally try to stay away from functions that changes their
return values depending on the context, because they tend to
make reading the callers to find bugs more difficult.  An
exception is a function that tries to mimic a built-in operator,
because reading the callers to such a function, as long as it is
clear which built-in the function is imitating, can apply the
same knowledge on how the callee would behave you already have
by knowing Perl itself.

The same thing can be said about functions with prototypes to
force certain context on the caller's side.  Avoid it unless
there is a good reason.

Maybe it is just me, but that's my reaction.
