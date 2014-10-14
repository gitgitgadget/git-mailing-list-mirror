From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [kernel] completion: silence "fatal: Not a git repository" error
Date: Tue, 14 Oct 2014 15:14:06 -0700
Message-ID: <xmqqiojmxpsh.fsf@gitster.dls.corp.google.com>
References: <1413283785-505-1-git-send-email-john@szakmeister.net>
	<xmqqfveqzeqy.fsf@gitster.dls.corp.google.com>
	<CAEBDL5V_Mzxwc4fnybg9=fmeotGV91XerzTccHMWLV79bE+mVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 00:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeAMC-0002RF-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbaJNWOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 18:14:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932592AbaJNWOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 18:14:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31FAB15480;
	Tue, 14 Oct 2014 18:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aQIZeLRNhsmnlw8Jk5/YHKNXN4Y=; b=bSyRkBokxHDuqSIMXh66
	VTmOIsBT1fMR2SJUb9FZb+0fwf5gGkepaKrqjrYd5MnwntgMANIKi2HjmkLcJiBo
	CjRM6B2DC+ME4Am9Mvq+bsG49liK9TgNbiGlh7AIdEmftuWD2WqA/QUZW24cjoHE
	eDeV0fCk/XjDaQPoCwNGkj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=r/ZCRr6xr6dXx/yGGAY6RlDfjbX6r0Xxs6ulkMrnlz8wqG
	CkBQMgoMAkWoq3xB+6Ft1cw1E2ju6CXWgePi6YM6bNVku/0SREoPzV5rTeYaX8xn
	ut1+5fk9Hp2vPurAUkWR52I94AmoHmqauBJnZv2fXdzXAXCR7j4VOW8FskerM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 278F81547F;
	Tue, 14 Oct 2014 18:14:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A26E51547D;
	Tue, 14 Oct 2014 18:14:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A7BE1B4-53EF-11E4-BB66-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Szakmeister <john@szakmeister.net> writes:

> On Tue, Oct 14, 2014 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Hmph, do you mean this one?
>>
>>     $ cd /var/tmp ;# not a git repository
>>     $ git checkout <TAB>
>>
>> ->
>>
>>     $ git checkout fatal: Not a git repository (or any of the parent directories): .git
>>     HEAD
>>
>> I agree it is ugly, but would it be an improvement for the end user,
>> who did not realize that she was not in a directory where "git checkout"
>> makes sense, not to tell her that she is not in a git repository in
>> some way?
>
> I had thought about that too, but I think--for me--it comes down to two things:
>
> 1) We're not intentionally trying to inform the user anywhere else
> that they are not in a git repo.  We simply fail to complete anything,
> which I think is an established behavior.
> 2) It mingles with the stuff already on the command line, making it
> confusing to know what you typed.  Then you end up ctrl-c'ing your way
> out of it and starting over--which is the frustrating part.

It is not that I am unsympathetic.  It's just it looks to me that
the patch is potentially adding one more failed step by hiding the
error message to further frustrate the user.

    $ git checkout <TAB>
    ... completes nothing; puzzled but decides not to be worried for now
    $ git checkout master<RET>
    fatal: not a git repository

As you noticed, however, we do not show the ugly error message by
design.  It is not done consistently, either (happens only when we
try to complete refnames).

I was just hoping that somebody (not necessarily you) could suggest
a way to do better than hide the error message only because it looks
ugly (iow, perhaps show it not in the middle of the command line,
and do so more consistently).  Yes I would imagine it would be a lot
harder, but the end user experience _might_ become so much better to
make it worthwhile.  I dunno.

I am not strongly opposed to queuing the patch.
