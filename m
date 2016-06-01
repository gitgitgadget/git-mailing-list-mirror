From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule operations: tighten pathspec errors
Date: Wed, 01 Jun 2016 14:14:32 -0700
Message-ID: <xmqqy46owr0n.fsf@gitster.mtv.corp.google.com>
References: <1463793689-19496-1-git-send-email-sbeller@google.com>
	<xmqqd1o8vbc4.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbdfEJ1iSpOJ=HfHP=EvVxB9Sv+5Zk+goLSOJphh8ZZ+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 23:14:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DTN-0000O9-59
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 23:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbcFAVOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 17:14:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbcFAVOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 17:14:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92FBD207E6;
	Wed,  1 Jun 2016 17:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KGM9yj04rl5Jpc/6wUdDEPhxIGY=; b=fsa0i9
	yITp9CzN4ndOyNZO4VWaLHse+HNz5wq7DFWMWdU2FKKICq9LET/elKGB85TBamOd
	IPoUa4cgbB3DFL1UnXeyM88/X2L0moBo3ZuLFVtrJr8IfNIo4HxKxNNY4C2Hdw9D
	27KzYFv/zmzNgxVubEUiFdkFKjpIMNFhT0PW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OsOD3ZRBPmGE9Et7WOnMrO9jHr7op6Xd
	3QRHwFvjcZZOziprfjIIMoafZHGLy3UH7v3xI/jH55h+oQiHsihiy3tUpz2UC6gs
	AUYHHvPflUiUgfYlKWv/nJJRXm39ME3EkkEDspr42mI7n4qRNhzuLnx+OnpAy8M8
	b7GrOMyDiBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B619207E5;
	Wed,  1 Jun 2016 17:14:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B8C5207E4;
	Wed,  1 Jun 2016 17:14:33 -0400 (EDT)
In-Reply-To: <CAGZ79kbdfEJ1iSpOJ=HfHP=EvVxB9Sv+5Zk+goLSOJphh8ZZ+w@mail.gmail.com>
	(Stefan Beller's message of "Wed, 1 Jun 2016 13:55:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6A4792C-283D-11E6-A12F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296167>

Stefan Beller <sbeller@google.com> writes:

> On Thu, May 26, 2016 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> @@ -36,10 +37,9 @@ static int module_list_compute(int argc, const char **argv,
>>>
>>>       for (i = 0; i < active_nr; i++) {
>>>               const struct cache_entry *ce = active_cache[i];
>>> -
>>> -             if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>>> -                                 0, ps_matched, 1) ||
>>> -                 !S_ISGITLINK(ce->ce_mode))
>>> +             if (!S_ISGITLINK(ce->ce_mode) ||
>>> +                 !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>>> +                                 0, ps_matched, 1))
>>>                       continue;
>>
>> OK, this is the crucial bit in this patch. pathspec matches are now
>> done only against gitlinks, so any unmatch is "pattern or path
>> given, but there was no such submodule".
>
> right.

That changes the semantics, and its user visible effect may deserve
to be in the documentation, no?

It used to be that "git submodule--helper list COPYING" did not
complain, but with this change, it would.  Which may be a good
change, but "git submodule--helper list sub*" where most but not all
of glob expansion done by the shell are submodule directories may be
a common thing people may do, and it may be irritating to see the
unmatch complaints.  I dunno.

When we know we are not going to complain (i.e. --unmatch-ok option
is given from the command line), I think it is perfectly fine (and
it is even preferrable) to swap the order of the check.  The mode
check done with S_ISGITLINK() is much cheaper and it is likely to
yield true much less often, which in turn would allow us to make
fewer calls to more expensive match_pathspec().

But when we want to diagnose typo (i.e. --unmatch-ok was not given),
we may want to preserve the current order, so that the "sub*"
example in a few paragraphs ago would not irritate the users.

>> It is tempting to update report_path_error() return "OK" when its
>> first parameter is NULL.
>
> such that we can do a
>
>     if (report_path_error(unmatch_ok ? NULL : ps_matched, pathspec, prefix)))
>         result = -1;

I actually was thinking about setting ps_matched to NULL so that
both match_pathspec() and report_path_error() would get NULL.
match_pathspec() has to do _more_ work when ps_matched[] aka seen[]
is given.

>>> @@ -407,7 +410,7 @@ cmd_foreach()
>>>       # command in the subshell (and a recursive call to this function)
>>>       exec 3<&0
>>>
>>> -     git submodule--helper list --prefix "$wt_prefix"|
>>> +     git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix"|
>>
>> For this to work, somebody must ensure that the variable unmatch is
>> either unset or set to empty unless the user gave --error-unmatch to
>> us.  There is a block of empty assignments hear the beginning of
>> this file for that very purpose, i.e. resetting a stray environment
>> variable that could be in user's environment.
>>
>> The patch itself does not look too bad.  I do not have an opinion on
>> which one should be the default, and I certainly would understand if
>> you want to keep the default loose (i.e. not complaining) with an
>> optional error checking, but whichever default you choose, the
>> option and variable names need to be clarified to avoid confusion.
>
> Ok I'll fix the variable names; I think for consistency with e.g.
> ls-files --error-unmatch
> we would want to be loose by default and strict on that option.

I do not think the "typo-prevention" safety measure should suddenly
be turned into opt-in; I'd suggest "--unmatch-ok" instead.
