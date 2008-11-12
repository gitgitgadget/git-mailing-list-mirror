From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [take 2] git send-email updates
Date: Tue, 11 Nov 2008 16:14:20 -0800
Message-ID: <7vk5b9x0kj.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
 <7v4p2e0zus.fsf@gitster.siamese.dyndns.org>
 <20081111221351.GE10073@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03On-0007aK-4n
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYKLAOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYKLAOm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:14:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbYKLAOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:14:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F040960E8;
	Tue, 11 Nov 2008 19:14:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 56B29960E5; Tue,
 11 Nov 2008 19:14:22 -0500 (EST)
In-Reply-To: <20081111221351.GE10073@artemis.corp> (Pierre Habouzit's message
 of "Tue, 11 Nov 2008 23:13:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E60BC092-B04E-11DD-B7EB-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100699>

Pierre Habouzit <madcoder@debian.org> writes:

> Oh you mean that if one use --no-format-patch you don't wan't _any_
> option to be passed to format-patch?

The option name --no-format-patch sounded like "I do not want you to act
as a frontend, ever", i.e. if you type master..next by mistake on the
command line, the command would barf when the option is given.  Not even
"pass to format-patch", but "do not run format-patch to begin with".

It is not a big deal especially for interactive use (and that is why I
said "somewhat" unfortunate).

> If we're really doing this, then maybe we want a 5-state kind of option:
>   1 disallow any file name ;
>   2 if conflict, chose the revision ;
>   3 barf if any conflict arises (default) ;
>   4 if conflict chose the file ;
>   5 disallow any kind of revision argument.
>
> My proposal implements 2 as --format-patch, 3 as default, and 4 as
> --no-format-patch. You propose basically (5) for --no-format-patch
> instead, well I say this makes sense, but it's somehow "sad" not to have
> (1) too in that case.

Actually, "send-email --format-patch master..fixes Documentation/" may be
a useful command to send out only documentation fixes.  For such a usage,
Documentation/ should not be taken as a maildir.  If we would want to
support such usage (and I'd say why not), a token can fall into one (or
two) of three categories:

    - can it be a rev?

    - is it a tracked path (either blob or a leading dir)?

    - is it a file/dir that is not tracked?

The first two would be format-patch candidate.  The last one is the
traditional mail source.  Because the latter two are disjoint set, and
because it does not matter if you have a tracked file 'master' and a
branch 'master' in your repo (either will be passed to format-patch
anyway), the actual disambiguity is reduced, but it still is different
from what you have in your patch, I suspect.

As to options, how about doing this:

    --no-format-patch means never ever run format-patch, behave exactly as
    before;

    --format-patch means what you have in your patch.  guess and favor 
    format-patch parameter when ambiguous;

    without either option, guess and favor mbox/maildir but still run
    format-patch if remaining parameters and options need to
    (e.g. "send-email my-cover-letter origin/master..master" will find
    my-cover-letter which is not tracked and take it as mbox, and grab
    patches from commits between origin/master..master, and send all of
    them).
