From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Sun, 15 Mar 2015 20:50:41 -0700
Message-ID: <xmqqr3spsir2.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<vpq1tkq5fsw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yurii Shevtsov <ungetch@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 16 04:52:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXM5K-0007L8-MH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 04:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbbCPDwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 23:52:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750937AbbCPDwx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 23:52:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E513A41479;
	Sun, 15 Mar 2015 23:50:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97ytjyC2J5wLY2dxsVmEpzAQY40=; b=arnYc1
	ehdMt+qqrOysM876kVrrvvMI7nIHsiBDcrKpDEfPLnM1FnVJY35a0eg2mNLF+kuP
	9foNvqR9g6tgiPbl4egnWXfBQQhChAKFJgPgS3+KTuzSyUO7zlZvLE+bkUw5nUdL
	b5iM3+wQ1ibeVzYRi/i5IMwDCp+A+FI5K12/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljAcPxRsDNctajNoOP3tFs4RmtvFYF9O
	UJ0uoDdDIXT4rxaOTZkd/RohoEjVKJYbf8d2JvVsqjgcZEpWLmndFUifBm88tA6z
	uPwdTQbNvMxKLg76bAyJ8t8v2B1vGsniY9R37AL4pyrEI3fSS4+gJ6NQzisv3oph
	wE9yomQw7Qk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE79A41478;
	Sun, 15 Mar 2015 23:50:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6969C41476;
	Sun, 15 Mar 2015 23:50:42 -0400 (EDT)
In-Reply-To: <vpq1tkq5fsw.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	15 Mar 2015 18:30:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E4B5DD6-CB8F-11E4-8BBD-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265543>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
>>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>>                 return -1;
>>
>> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
>> -               return error("file/directory conflict: %s, %s", name1, name2);
>
> I'm surprised to see this error message totally go away. The idea of the
> microproject was to DWIM (do what I mean) better, but the dwim should
> apply only when $directory/$file actually exists. Otherwise, the error
> message should actually be raised.

I actually think this check, when we really fixed "diff --no-index"
to work sensibly, should go away and be replaced with something
sensible.  As it stands now, even before we think about dwimming
"diff D/ F" into "diff D/F F", a simple formulation like this will
error out.

    $ mkdir -p a/sub b
    $ touch a/file b/file b/sub a/sub/file
    $ git diff --no-index a b
    error: file/directory conflict: a/sub, b/sub

Admittedly, that is how ordinary "diff -r" works, but I am not sure
if we want to emulate that aspect of GNU diff.  If the old tree a
has a directory 'sub' with 'file' under it (i.e. a/sub/file) where
the new tree has a file at 'sub', then the recursive diff can show
the removal of sub/file and creation of sub, no?  That is what we
show for normal "git diff".

But I _think_ fixing that is way outside the scope of GSoC Micro.

And patching this function, because it is recursively called from
within it, to "dwim" is simply wrong.  When we see a/sub that is a
directory and b/sub that is a file, we do *NOT* want to rewrite the
comparison to comparison between a/sub/sub and b/sub.

What needs to be fixed for the Micro is the top-level call to
queue_diff() that is made blindly between paths[0] and paths[1]
without checking what kind of things these are.



    
