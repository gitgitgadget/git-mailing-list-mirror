From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 12:31:00 -0800
Message-ID: <xmqq61csswvv.fsf@gitster.dls.corp.google.com>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63Rf-0007am-1c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbaL3UbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:31:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486AbaL3UbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:31:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 871762A77E;
	Tue, 30 Dec 2014 15:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fDjrNvvrbCvnihBRf4u7si/TiOc=; b=SsD/zZ
	irl7NY3zY9kapVYZq9Wor5hpVyIiXHY43buIr9AcM/xc59HI0IRmAIgpthGcQsUB
	hWtUc3L/OW8yJmlb3mxJObOB4A8pS/YJEh5zHnF2sjkyQmQ3VezRkcGi+w66e0zf
	2XRgOZSzHlkwA5sQoPuNK+7YFdlm16kpLHkCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E597Sbd6MJgjT8cqDgAngTiFaBdvGdMP
	OMtCr29a0FkXN8kmjMaXp8T6eiNuesX0F+33PFkJsMSqBrGDizrBWaOFQcURNlnU
	b2v1wohEMnbly9JUFSdJJ9Nc8pSGsxoxDVlUAXRXgq3CpiIj1xZvMaePY3PUUiqO
	tncrnLWBz1g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E0D02A77D;
	Tue, 30 Dec 2014 15:31:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F0EA2A76E;
	Tue, 30 Dec 2014 15:31:01 -0500 (EST)
In-Reply-To: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
	(Robert Dailey's message of "Tue, 30 Dec 2014 14:12:15 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C505C0D2-9062-11E4-A796-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261940>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I was surprised to find today that the following didn't work as expected:
>
> $ git show master@{"1 year ago"}:Path/To/File.h
>
> It gave me the following warning which did not make the problem obvious at all:
> warning: Log for 'master' only goes back to Mon, 8 Sep 2014 12:08:44 -0500.
>
> What it is trying to tell me (and I only found this out after a lot of
> poking and prodding around Google) is that I can't refer to a commit
> by date if it extends beyond the range of the reflog.
>
> I don't understand why this requirement is in place. Each commit has a
> time stamp, so in theory it should be possible to calculate an
> absolute date from the duration specified in the refspec and grab the
> commit from `git log` from that.

The reason is because the dates on the commit object itself do not
have anything to do with the question you are asking with the
"@{date}" notation.  master@{at-this-time} notation specifies the
commit that was at the tip of your master branch at the specified
time, and that information can _only_ come from your own reflogs.

If you did this in your copy of git.git repository today:

    $ git checkout -b test e83c5163316f89bfbd
    $ sleep 3600
    $ git reset --hard master
    $ git show test@{20.minutes.ago}

you will see e83c516, even though that commit is almost 10 years
old.  Now what was at the tip of your "test" branch on April 7th,
2005?  The answer is "nothing", as most likely your 'test' branch
did not exist back then.

And that is why "git show test@{2005/04/07}" will not (and should
not) look at the timestamps in commit objects.
