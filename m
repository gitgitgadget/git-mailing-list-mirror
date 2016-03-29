From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 10:21:45 -0700
Message-ID: <xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257938-17389-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Mar 29 19:22:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akxL7-0006sP-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 19:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803AbcC2RVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 13:21:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757493AbcC2RVy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 13:21:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6A404F873;
	Tue, 29 Mar 2016 13:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZExWhbfcD7mC
	NC6THL5F/FZuHEA=; b=uWcVy0v4KN4+MXK5+ppI8YwYYb3oSBjL9ltaDnc2l74U
	YCZGpeu2JhM+uYhhAeWQk/EgimMKUPPaymjzTIa/QvkQR2cyduolgIoukTEEzVAQ
	Z+/EBLzDhhhNnvCMrYqEDYsqN1yHnsOoo5TB9LoALd/uKLMXIs1HyJcQsbUBgsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oq3taa
	DSsBHIKkfQTRhv1tnei/7UBY2T4tVqphRHtQvBjb8IPEyUg3G0NaLhw+mTgMSsFi
	LJhNoR7ajUoD08xESakbaXAzJU15cgJqeMIwBhK2lSOH+EAy02n4Sya4PuW7WTGx
	I8u2wyrkvqgCh53OBVxermLfnkFFH+n+/gLLs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD94C4F872;
	Tue, 29 Mar 2016 13:21:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 23F014F86F;
	Tue, 29 Mar 2016 13:21:47 -0400 (EDT)
In-Reply-To: <1459257938-17389-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Tue, 29 Mar 2016 15:25:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7488372-F5D2-11E5-BF16-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290148>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> git blame reports lines as not "Not Committed Yet" when they have
> CRLF in the index, CRLF in the worktree and e.g. core.autocrlf is tru=
e.
>
> Since commit c48053 "new safer autocrlf handling", files that have CR=
LF
> in the index are not normalized at commit when e.g. core.autocrl is s=
et.
>
> Whenever a CLRF conversion is needed (or any filter us set), load the
> index temporally, before calling convert_to_git()

Sorry, but I do not understand what problem you are trying to
address here.

Under the same condition described in the first paragraph, what
would "git diff" and "git diff HEAD" say?  They should show that you
would be making a commit that corrects the line ending of the blob
recorded in the history.

The "Not Committed Yet" output from "git blame" is the same thing.
It is telling you that the commit you would be making by adding
that path from the working tree in its current state will become
the one that is responsible for the final state of the line.

So it is absolutely the right thing that these lines are shown as
"Not Commited Yet".  You will be making the line-ending correction
for the entire blob, and you should be made aware of it.

Now, it would be a very good idea for such a correction change to
have no other change, and it would be a very good idea to give users
a tool to see if there is any change other than the eol correction.
There is "git blame -w" to ignore whitespace changes, and I think
that would hide the CRLF/LF correction, but that hides all other kinds
of whitespace changes, so it is too broad for the purpose.

I do not think I'd be opposed to a new option to allow the command
to ignore _only_ eol changes (this applies not just to "blame" but
also to "diff", too).  That way:

 * The users can more easily make sure that the set of changes being
   prepared does not do anything other than correcting eol;

 * "git blame" can be told to relieve a commit of the responsibility
   for lines if the only change it did to them is to correct eol
   when digging the history (i.e. this will not just help "Not
   Committed Yet" changes in the working tree, but for digging
   through historical events).
