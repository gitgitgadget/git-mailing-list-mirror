From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd .gitignore behaviour
Date: Thu, 15 Nov 2007 14:13:19 -0800
Message-ID: <7vabpf40ow.fsf@gitster.siamese.dyndns.org>
References: <80ir431xny.fsf@tiny.isode.net>
	<alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
	<80ir43e04o.fsf@tiny.isode.net>
	<7vir4341ok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ismy4-0004iM-Ny
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933789AbXKOWNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933768AbXKOWNc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:13:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48995 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933747AbXKOWNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 17:13:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 61B292EF;
	Thu, 15 Nov 2007 17:13:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A8D996197;
	Thu, 15 Nov 2007 17:13:45 -0500 (EST)
In-Reply-To: <7vir4341ok.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 15 Nov 2007 13:51:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65172>

Junio C Hamano <gitster@pobox.com> writes:

> Bruce Stephens <bruce.stephens@isode.com> writes:
>
>> So I think the output from git-ls-files is as expected (as I interpret
>> the manpage and your explanation).  So is git-add just using some
>> different code?
>
> No, you found one of the longstanding bugs in dir.c:read_directory().
>
> The funny thing is that I just sent out a message pointing out
> bogus handling of per-directory exclude files in ls-files last
> night.  Somehow people have a tendency to encounter the bugs in
> the same vicinity independently.

By the way, about the problem I described briefly last night.

I never understood the intended use of -i option to ls-files,
but in your test repository (the one that has subsubdir), you
can do:

	$ git ls-files -i --exclude='a*'

to see "What paths have I already _staged_ that would have been
ignored if the exclude pattern were 'a*'".  You can abuse this
to list all the staged header files with:

	$ git ls-files -i --exclude='*.h'

but

	$ git ls-files -- '*.h'

is much simpler for that ;-).

In any case, it appears to me that the codepath used for that
"feature", and also the codepath used for -d (show deleted
files) and -m (show modified files) makes calls to excluded()
function to consult the exclusion mechanism without setting it
up properly, and I do not think

	$ git ls-files -i --exclude-per-directory=.gitignore

does what we would want.

The codepath for -o (show others) do use read_directory() which
sets up the exclusion mechanism with push/pop per-directory
exclude API, so that option should work.  But I suspect even it
did not work from a subdirectory because of the problem the
message I am responding to addresses.
