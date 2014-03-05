From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 05 Mar 2014 10:29:45 -0800
Message-ID: <xmqqa9d4ijmu.fsf@gitster.dls.corp.google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
	<20140226203836.GM7855@google.com>
	<CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:30:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGZs-00032o-36
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaCES3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:29:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbaCES3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:29:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A78CE6F174;
	Wed,  5 Mar 2014 13:29:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jEHouN4UuakaFka15ctOyzhj4sw=; b=DcN32V
	MOphqlWmprd+GIH4aKjri59Rh2LPyeYfxM+1u/wG4qAbbHGHyUGeREpodcNlKRLC
	DnsY14JXBZpcIaC3gsbgHCjYDy1IXO2FHPTTw6lLwmqAg/x2Ef2aMKbBPEJtl8X8
	0blTgQ9d18yjUSRv6gdOFl8va32LsrlaFnoWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAqM3Vhr0c5vd/5Mp6GogJeKMsT/xk0S
	ODYXaU3pHBjSkJ08lDAyBVOIwrhX+NHMnqDfdZLKgNHGChtu1N812RO61Fu4q9+v
	e1rkkoGk07C0COY3D9yJfCXXciflN2hx+Tvk8hyO7i/7GUzGOUVrxHYqDp7Jd5RZ
	5dP900UD5rc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 905B36F172;
	Wed,  5 Mar 2014 13:29:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF09D6F171;
	Wed,  5 Mar 2014 13:29:47 -0500 (EST)
In-Reply-To: <CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
	(Andrew Wong's message of "Wed, 5 Mar 2014 10:30:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21B06FE6-A494-11E3-A551-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243458>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On Wed, Feb 26, 2014 at 3:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Andrew Wong wrote:
>>
>>> --- a/builtin/merge.c
>>> +++ b/builtin/merge.c
>>> @@ -909,7 +909,8 @@ static int suggest_conflicts(int renormalizing)
>>>       fclose(fp);
>>>       rerere(allow_rerere_auto);
>>>       printf(_("Automatic merge failed; "
>>> -                     "fix conflicts and then commit the result.\n"));
>>> +                     "fix conflicts and then commit the result.\n"
>>> +                     "To abort the merge, use \"git merge --abort\".\n"));
>>
>> Seems reasonable, but I worry about the command growing too noisy.
>>
>> Could this be guarded by an advice.<something> setting?  (See advice.*
>> in git-config(1) for what I mean.)
>
> I was planning to use advice.resolveConflict, but as I went through
> merge.c, I noticed there could be a few other situations where we
> could print out the same message:
> 1. when prepare_to_commit() fails, due to hook error, editor error, or
> empty commit message
> 2. "git commit --no-commit"
>
> This means contexts are no longer only about "resolving conflict", so
> I was thinking of renaming advice.resolveConflict to something like
> advice.mergeHints.
>
> Any thoughts?

I have no strong opinion on the naming, other than that I doubt this
particular new "how to abort" message is worth the headache associated
with the "rename" which involves transition planning of deprecating
the old, supporting both for a while and then removing the old.

The existing message above in "suggest-conflicts" is about hinting
the user to first resolve the conflict before attempting to
continue, and that is perfectly in line with the existing use of
advice.resolveConfict in die_conflict() in git-pull that tells the
user there is an unresolved conflict.

On the other hand, the additional "how to abort" message does not
have to be limited to "you have conflicted paths in the index" case.

If the user said "git merge" while another "git merge" is still
outstanding, we would want to say "You have not concluded your
previous merge" and die, and you presumably want to add the same
"how to abort" message there.  Such a codepath is unlikely to be
covered by existing advice.resolveConflict, and it sounds more
natural, at least to me, to use a separate variable to squelch only
the new "how to abort" part.
