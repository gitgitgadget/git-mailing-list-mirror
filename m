From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Sun, 16 Nov 2014 10:11:04 -0800
Message-ID: <xmqq4mtz10ef.fsf@gitster.dls.corp.google.com>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
	<xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
	<CAHYJk3Q9tcS+o0hDnDz24ysSKkL6m16OmhyHuj=W88VQjTximw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>, git <git@vger.kernel.org>,
	Adri Farr <14farresa@gmail.com>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 19:11:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq4IE-0007mf-Le
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 19:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbaKPSLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 13:11:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751632AbaKPSLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 13:11:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 464DF19FE0;
	Sun, 16 Nov 2014 13:11:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vO3mNmkp0Evuqr33JaEnTMr9Wk8=; b=KGNa7F
	IuHIMMtmBW7D3jYMKrRUwUZq+l6OHugRuIYPS9IUk8SLUm2hwrR8IxUtNzc0oZ9s
	AcqSz3bNMkaOwA9Fkqbtr6EvQ5GbLA913mkQ59d5B5zFyNBaG30JqhrngOFMoUV0
	raC9s/+ukjqZqRXkjiJIksug2IXYxVvlNjTK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W7xn2r2DkH5wXzLU/ICBby4O+TdDMA5K
	IttOoJ3jMA/CxEeM4ZWZv5SEWegQDKLCKJ2dC7kbaa+joCfwDL2FdX4ePh6zd+V9
	CYNRxvnPEubMXX5sgGgyC2QeZxe3D4s6FAcLJolDcPXwTLF9qe+AzbS6lKFNqzUp
	xS8/hqvOq9U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E88B19FDF;
	Sun, 16 Nov 2014 13:11:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9659C19FDE;
	Sun, 16 Nov 2014 13:11:07 -0500 (EST)
In-Reply-To: <CAHYJk3Q9tcS+o0hDnDz24ysSKkL6m16OmhyHuj=W88VQjTximw@mail.gmail.com>
	(Mikael Magnusson's message of "Sun, 16 Nov 2014 02:51:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFBB406E-6DBB-11E4-9B61-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mikael Magnusson <mikachu@gmail.com> writes:

>>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>>> index a40d3df..2b66351 100644
>>> --- a/git-mergetool--lib.sh
>>> +++ b/git-mergetool--lib.sh
>>> @@ -221,6 +221,7 @@ run_merge_tool () {
>>>       else
>>>               run_diff_cmd "$1"
>>>       fi
>>> +     status=$?
>>>       return $status
>>>  }
>>
>> Thanks for a quick turn-around.  As a hot-fix for what is already in
>> -rc I am fine with this fix but the patch makes me wonder if $status
>> as a global shell variable has any significance.
>
> $status is an alias for $? in zsh, and so cannot be assigned to. But
> other than that I don't think it holds any meaning and should be fine
> in a .sh script.

That is not what I meant by "global ... significance".

The question was if the codepath in the caller depends on this
setting the global variable here, or nobody looks at and depends on
the global variable we are setting here after this function returns.

It does not have any significance that a random shell implementation
is not POSIX compliant.  That would merely mean that such a shell
cannot be used to run POSIX shell scripts like our Porcelain.  I
would suspect that zsh has more "posixly correct" mode, with which
it _can_ run POSIX shell scripts, and I would imagine that this
"$status is an alias $?" business is disabled in that mode?

My quick glance across the codepaths in the callers of this funciton
indicated that it should be safe not using this global variable, so
my answer to my original question was "no there is no significance".
I think we can safely remove any mention of status from this shell
function, i.e. if we remove initial assignment to 0, remove this new
assignment and then remove the "return $status" at the end, the
caller would still be happy.
