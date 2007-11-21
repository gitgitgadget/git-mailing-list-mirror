From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Wed, 21 Nov 2007 01:11:00 -0800
Message-ID: <7vmyt8gdzv.fsf@gitster.siamese.dyndns.org>
References: <1195503174-29387-1-git-send-email-pkufranky@gmail.com>
	<474308A5.8070301@viscovery.net>
	<46dff0320711201838g5affba6bo21a8c837b0bef681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 10:11:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IulcG-0006rG-97
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 10:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbXKUJLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 04:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXKUJLK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 04:11:10 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36835 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXKUJLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 04:11:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CB99A2F2;
	Wed, 21 Nov 2007 04:11:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EF20962CE;
	Wed, 21 Nov 2007 04:11:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65621>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Nov 21, 2007 12:17 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> ...
>> This way the change is more local without affecting well-tested other callers.
>
> This way works, but it is a tricky one, not a natural or graceful one.

I do not know about "natural".  That largely would depend on
where one starts thinking about the issues from.

But I think an API definition that says "These fds are closed
after the call, so if you are going to use them, you can dup()
them beforehand" is equally valid, and I suspect that forgetting
to dup() is easier to detect than forgetting to close() --- you
will notice the former mistake immediately because your read and
write say "oops, nobody on the other end" but the latter mistake
will result in a hung process.  And for that reason, I think it
can be called more "graceful".  So ...

>> Furthermore, I don't think that it's correct to just set the .close_in or
>> .close_out flags. This will close the fd only in finish_command(), which can
>> be too late: Think again of a writable pipe end that remains open and keeps
>> the reader waiting for input that is not going to happen.
>
> This may happen. However, i have scanned all the git codes using the
> auto closing behaviour and i don't discover the problem you mentioned.
> So i think it deserves to correct the misbehaviour after carefully
> testing. And we can make a clarification for that if necessary.

... I do not necessarily agree that your patch is correcting the
misbehaviour.
