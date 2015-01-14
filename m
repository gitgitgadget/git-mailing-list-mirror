From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack.c: don't miss exporting unsolicited push certificates
Date: Wed, 14 Jan 2015 10:08:04 -0800
Message-ID: <xmqqr3ux9qwr.fsf@gitster.dls.corp.google.com>
References: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
	<1420849874-32013-1-git-send-email-sbeller@google.com>
	<xmqqmw5r9zck.fsf@gitster.dls.corp.google.com>
	<54B0A2C1.4040602@gmail.com>
	<xmqqiogb95t4.fsf@gitster.dls.corp.google.com>
	<CAGZ79kad=c1wXW163doxWBRdSvQ7Y9EkkD+ZXtOfawjtxEyeQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:08:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBSMo-00065T-NP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbbANSI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 13:08:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752676AbbANSIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 13:08:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A87B32C2A4;
	Wed, 14 Jan 2015 13:08:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+66wzeXv9DjHEWly6Hsey2hsH9o=; b=j7jG+a
	FU51isYVtMHgOJkjcG35nJu/dTzTWbGWNHJdcfy+FZxTJm3MJj53r3uOI7zpbFD9
	GDdjzenzHWuH6r0roPaSN6UY17sQ6sL89MrSBw9ZPt8ZxydSTw3ghCmnBh0dRcwq
	1iAfigBuAABF9q3lR1rHAEyiwfmdeqBE8wE9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mEoYpmQvH/9aH/efUc92G/ANVTMSkTrR
	EK8KH8RiOCyZ1U547mfwYHpm3b1fps1jsHD4VxWhMmZpdQOzUKwfv7pNBVv18uCj
	7+1iW+033dstCBOlw6RiaZSQ5j4xq6zSgh+m435fzr1ne7BnWgcJY951To6UKfZq
	hZElmnrIx4U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B0AD2C2A2;
	Wed, 14 Jan 2015 13:08:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 259C12C290;
	Wed, 14 Jan 2015 13:08:06 -0500 (EST)
In-Reply-To: <CAGZ79kad=c1wXW163doxWBRdSvQ7Y9EkkD+ZXtOfawjtxEyeQw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 13 Jan 2015 16:11:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49F34F7E-9C18-11E4-A235-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262403>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jan 12, 2015 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> yes that's what I was trying to hint at. The hook would just see
>>> it is unsolicited instead of not having the state available.
>>
>> OK.  That makes sort of sense.  So if we:
>>
>>  1) did not apply either patch (i.e. we accept unsolicited
>>     certificate, and the fact that we did not exchange "give me this
>>     nonce" "here is your nonce" is conveyed to the hooks by the lack
>>     of GIT_PUSH_CERT_NONCE environment and possible presense of
>>     unsolicited nonce in the GIT_PUSH_CERT blob); and then
>>
>>  2) applied this patch first (i.e. we still allow unsolicited
>>     certificate, and the same fact is now conveyed to the hooks also
>>     by GIT_PUSH_CERT_NONCE_STATUS=UNSOLICITED if they sent a nonce,
>>     or GIT_PUSH_CERT_NONCE_STATUS=MISSING); and then finally
>>
>>  3) applied the other patch to reject unsolicited certificate.
>>
>> then we can stop at any of these three steps and the behaviour of
>> three resulting systems make sense and the pre-receive hook can
>> reject unsolicited certificates if it wants to, even at step #1.
>
> I do not quite understand the intention of your mail. Are you saying I should
> make a patch series to solve the problems as outlined above?

Not really.  All I was saying was that a hypothetical patch series
that progressed in the order above would "make sort-of sense".

I was hoping that readers would ask themselves this question: if we
know that our endgame will be #3, then does it still make much sense
to have the state that only patch #2 is applied?

I think #3 makes #2 unnecessary, as we always ask for nonce when
advertising push-cert capability in the released versions of Git, so
we might get an unsolicited push-cert (which #3 will reject), but we
will never see an unsolicited nonce in a push-cert, as long as we
told the pusher that it is OK to send a push-cert to us.
