From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Fri, 19 Feb 2016 14:29:04 -0800
Message-ID: <xmqqbn7cbahb.fsf@gitster.mtv.corp.google.com>
References: <1455908253-1136-1-git-send-email-sbeller@google.com>
	<xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOQTGEY6akKgz695nPdG4cG4SsYKLcJkKr1im+RQjK5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Dave Borowitz <dborowitz@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:29:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWtY1-0005ne-HG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 23:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428517AbcBSW3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 17:29:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1428470AbcBSW3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 17:29:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 177DE440CC;
	Fri, 19 Feb 2016 17:29:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nrIq+JN9jLUQqdk7Zmm9L8p6kks=; b=mSGiNr
	i1VwxeeYHRL3N816ULYtj8Fk6SC8x2L21MdmwQLtqWRl+Ff5fq6TwrGyKxoGq5ck
	gmC/yrMCa4Cct6msNod+B1At09gTn/unvH/XN/1dHACIb75eiIhAjyzxw2H8XLbK
	1irvqQdHY31wn7gx+c3y3AEjFk6OZsmVhGIys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2mrj7QlFCPCwzauMBQV+1xSZsZ6IiSH
	MnxFkQ/7+D06kP2tWsdXerLy1xrqT7tJPGeHeuaoTy8dPOyK24MNuXEAgTVvzRse
	m2yPWbhTWyLLkS1vAlvM46UTxt2pAuKPfVZqDQvO8nMe1J2hX2bpNNa7qq7fcfKx
	NUgzvC4EzIQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F2B5440CB;
	Fri, 19 Feb 2016 17:29:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7EA58440CA;
	Fri, 19 Feb 2016 17:29:05 -0500 (EST)
In-Reply-To: <CAGZ79kaOQTGEY6akKgz695nPdG4cG4SsYKLcJkKr1im+RQjK5A@mail.gmail.com>
	(Stefan Beller's message of "Fri, 19 Feb 2016 14:10:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F4D00E4-D758-11E5-8AD1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286755>

Stefan Beller <sbeller@google.com> writes:

> Doing a 'git fetch' only and not the fetch for the specific sha1 would be
> incorrect?

I thought that was what you are attempting to address.

> ('git fetch' with no args finishes successfully, so no fallback is
> triggered. But we are not sure if we obtained the sha1, so we need to
> check if we have the sha1 by doing a local check and then try to get the sha1
> again if we don't have it locally.

Yes, that is what I meant in the "In the opposite fallback order"
suggestion.
>>>                               (clear_local_git_env; cd "$sm_path" &&
>>> +                                     remote_name=$(get_default_remote)
>>>                                       ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>>> -                                      test -z "$rev") || git-fetch)) ||
>>> +                                      test -z "$rev") || git-fetch $remote_name $rev
>>
>> Regardless of the "fallback order" issue, I do not think $rev is a
>> correct thing to fetch here.  The superproject binds $sha1 to its
>> tree, and you would be checking that out, so shouldn't you be
>> fetching that commit?
>
> Both $sha1 and $rev are in the submodule (because
> 'git submodule--helper list' puts out the sha1 as the
> submodule sha1). $rev is either empty or equal to $sha1
> in my understanding of "rev-list $sha1 --not --all".

Not quite.  The rev-list command expects [*1*] one of three outcomes
in the original construct:

 * The repository does not know anything about $sha1; the command
   fails, rev is left empty, but thanks to &&, git-fetch runs.

 * The repository has $sha1 but the history behind it is not
   complete.  While digging from $sha1 following the parent chain,
   it would hit a missing object and fails, rev may or may not be
   empty, but thanks to &&, git-fetch runs.

 * The repository has $sha1 and its history is all connected.  The
   command succeeds.  If $sha1 is not connected to any of the refs,
   however, that commit may be shown and stored in $rev.  In this
   case, "$rev" happens to be the same as "$sha1".

As this "fetch" is run in order to make sure that the history behind
$sha1 is complete in the submodule repository, so that detaching the
HEAD at that commit will give the user a useful repository and its
working tree, the check the code is doing in the original is already
flawed.  If $sha1 and its ancestry is complete in the repository,
rev-list would succeed, and if $sha1 is ahead of any of the refs,
the original code still runs "git fetch", which is not necessary for
the purpose of detaching the head at $sha1.  On the other hand, by
using "-n 1", it can cause rev-list stop before discovering a gap in
history behind $sha1, allowing "git fetch" to be skipped when it
should be run to fill the gap in the history.

To be complete, the rev-list command line should also run with
"--objects"; after all, a commit walker fetch may have downloaded
commit chain completely but haven't fetched necessary trees and
blobs when it was killed, and "rev-list $sha1 --not --all" would not
catch such a breakage without "--objects".

> Oh! Looking at that I suspect the
> "test -z $(git rev-list -n 1 $sha1 --not --all 2>/dev/null)"
> and "git cat-file -e" are serving the same purpose here and should just
> indicate if the given sha1 is present or not.

That is the simplest explanation why the original "rev-list"
invocation is already wrong.  It should do an equivalent of
builtin/fetch.c::quickfetch() to ensure that $sha1 is something that
is complete, i.e. could be anchored with a ref if we wanted to,
before deciding to avoid running "git fetch".
