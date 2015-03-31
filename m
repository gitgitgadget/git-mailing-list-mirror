From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] sha1_name: implement @{push} shorthand
Date: Tue, 31 Mar 2015 15:57:53 -0700
Message-ID: <xmqqmw2sojv2.fsf@gitster.dls.corp.google.com>
References: <20150331173339.GA17732@peff.net>
	<20150331173834.GF18912@peff.net>
	<xmqqk2xwq25m.fsf@gitster.dls.corp.google.com>
	<20150331223200.GC31948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd56f-00008o-05
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbCaW54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:57:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750903AbbCaW5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 031DF452E2;
	Tue, 31 Mar 2015 18:57:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+qTeh3GnsvDlSGGHEEKtclQAbQ=; b=QgVL7X
	JQhn0aQccPjovw3Qh2moJ2ExJL4pNaPJ7Rb25Yj1Bf2QwS9xyz5V1yc+p/89dh5j
	6KYXNOjloj6cmgvgVgQ5/7bPt5dw0FfyT+4I2ClRXEAtY9hatraHNxKD7CK++mWB
	ZRArS5Pdj2+B2w+siasAKBlAsXyxQ+gv5zurw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OD19rxu+OIfCBknqX+EkLSxf5+GUHMNe
	H9BBOHi+FSzOyG8g6RKiEt+ym0r6VNjVdZOxX6aFXhFTmjJg1a4ZdWAyxuTcGK7b
	HIw7hMnxuBSmIJcno5EN3KQlOdtcF5QEeFk7l9JjZvk1luZY8oPgtZ7PG6TS7Fm5
	WyDKjOXccWw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F06C4452E1;
	Tue, 31 Mar 2015 18:57:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A2FD452DD;
	Tue, 31 Mar 2015 18:57:54 -0400 (EDT)
In-Reply-To: <20150331223200.GC31948@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 18:32:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D9971DA-D7F9-11E4-8AE0-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266576>

Jeff King <peff@peff.net> writes:

>> > +static char *tracking_ref_for(struct remote *remote, const char *refname)
>> > +{
>> > +	char *ret;
>> > +
>> > +	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
>> > +	if (!ret)
>> > +		die(_("@{push} has no local tracking branch for remote '%s'"),
>> > +		    refname);
>> 
>> I would imagine that it would be very plausible that anybody with a
>> specific remote and the name of the ref that appears on that remote
>> would want to learn the local name of the remote-tracking ref we use
>> to track it.
>
> I am not sure I understand. We do _not_ have a local name we use to
> track it. That is the error. I can print "remote %s does not have branch
> %s", if that is what you mean.

No, I am not saying we should not detect an error.

>> But the error message limits the callers only to those who are
>> involved in @{push} codepath.  Shouldn't the error check be done in
>> the caller instead, anticipating the day this useful function ceases
>> to be static?
>
> Is it really a useful general function?

I often interact with this remote called 'ko'.  Do I have remote-tracking
branch to keep track of its 'master' branch, and if so, what is it?

Isn't that the question that the apply_refspecs() is answering?

> If you remove the die() message,
> it is literally a one-liner.

Yes, I thought I said that here...

>> I would suspect that such a change would make it just a one-liner,
>> but I think this helper that takes remote and their refname is much
>> easier to read than four inlined calls to apply_refspecs() that have
>> to spell out remote->fetch, remote->fetch_refspec_nr separately.

>> Perhaps we would want 
>> 
>> 	struct refspecs {
>>         	int nr, alloc;
>>                 const char **refspec;
>> 	} fetch_refspec;
>> 
>> in "struct remote", instead of these two separate fields, and then
>> make apply_refspecs() take "struct refspecs *"?  I haven't checked
>> and thought enough to decide if we want "struct refspec *" also in
>> that new struct, though.
>
> I think it is more complicated, as there are actually two arrays indexed
> by each {fetch,push}_refspec_nr. We have "fetch_respec", which contains
> the text (I assume), and then the "struct refspec".

Yeah, I thought I said that, too ;-)

> So ideally those
> would be stored together in a single list, but of course many helper
> functions want just the "struct refspec" list. So you still end up with
> two lists, but just pushed down into a single struct. I guess that's
> better, but I was trying to find a bound to my refactoring rather than
> touching all of the code. :-/

OK.
