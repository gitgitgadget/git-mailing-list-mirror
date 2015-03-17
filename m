From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Tue, 17 Mar 2015 15:16:38 -0700
Message-ID: <xmqqpp87mfqx.fsf@gitster.dls.corp.google.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
	<1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
	<xmqqlhiwredj.fsf@gitster.dls.corp.google.com>
	<xmqq8uewp183.fsf@gitster.dls.corp.google.com>
	<87egons4du.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:16:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXzn4-00058F-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 23:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbbCQWQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 18:16:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750958AbbCQWQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 18:16:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEFD23EBB6;
	Tue, 17 Mar 2015 18:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L6mi/lNeVLMFU3XCQ1wueE9gb/U=; b=Np5R1P
	vX4gyeJ4gMhWz2o2S+0QMMP1dC4cp++P9laHaqHWyokZ64uVCWeLxT6wXJ40AfHg
	WHaB/H9TIgAWOmOw7cRhc2gwab72uti5YEZDZJVQ5tOEOWs4vk/1nO4g7Z7XWbZ7
	ZoOWDV2Rgnn/WK+/kvnsxDMC5DKPJ7uTflt/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bIrpyFJd2wNEwiunh4wLr9ZkP61Pjjkg
	Dqp3hCS+p/M5xf1h5TYsEZDehnEvjuGjW9dJUcaZbbR35ptRxSenXq7Tuxl96j+q
	tMZKSl/B8BfulAkSVmqr75xubEby82yE8FWzIHhi8hxEVf37TaipS8ztytW1Ozgb
	+f8rr2O+7Oo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C72353EBB5;
	Tue, 17 Mar 2015 18:16:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 148E43EBB4;
	Tue, 17 Mar 2015 18:16:40 -0400 (EDT)
In-Reply-To: <87egons4du.fsf@gmail.com> (Kenny Lee Sin Cheong's message of
	"Tue, 17 Mar 2015 17:25:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48F30AC2-CCF3-11E4-803D-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265672>

Kenny Lee Sin Cheong <kenny.lee28@gmail.com> writes:

> On Tue, Mar 17 2015 at 02:49:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> 	if (try to see if it is a revision or regvision range) {
>>         	/* if failed ... */
>> 		if (starts with '-') {
>>                 	do the option thing;
>>                         continue;
>> 		}
>> 		/* args must be pathspecs from here on */
>>                 check the  '--' disambiguation;
>>                 add pathspec to prune-data;
>> 	} else {
>> 		got_rev_arg = 1;
>> 	}
>>
>> but I didn't trace the logic myself to see if that would work.
>
> You're right. I was actually going to try and check all possible
> suffixes of "-" but your solution saves us from doing that, and it
> didn't break any tests.

"It didn't break any tests" does not tell us much, though.

I also notice that handle_revision_arg() would die() by calling it
directly or indirectly via verify_non_filename(), etc., but the
caller actually is expecting it to silently return non-zero when it
finds an argument that cannot be interpreted as a revision or as a
revision range.  

If we feed the function a string that has ".." in it, with
cant_be_filename unset, and if that string _can_ be parsed as a
valid range (e.g. "master..next"), we would check if a file whose
name is that string and die, e.g.

    $ >master..next ; git log master..next
    fatal: ambigous argument 'master..next': both revision and filename

If we swap the order to do the "revision" first before "option",
however, we would end up getting the same for a name that begins
with "-" and has ".." in it.  I see no guarantee that future
possible option name cannot be misinterpreted as a range to trigger
this check.

But "git cmd -$option" for any value of $option does not have to be
disambiguated when there is a file whose name is "-$option".  The
existing die()'s in the handle_revision_arg() function _will_ break
that promise.  Currently, because we check the options first,
handle_revision_arg() does not cause us any problem, but swapping
the order will have fallouts.

If we want to really do the swapping (and I think that is the only
sensible way if we wanted to allow "-" and any extended SHA-1 that
begins with "-" as "the previous branch"), I think the "OK, it looks
like a revision (or revision range); as we didn't see dashdash, it
must not be a filename" check has to be moved to the caller, perhaps
like this:

	if (try to see if it is a revision or a revision range) {
        	/* failed */
                ...
	} else {
        	/* it can be read as a revision or a revision range */
                if (!seen_dashdash)
			verify_non_filename(arg);
		got_rev_arg = 1;
	}

The "missing" cases should also silently return failure and have the
caller deal with that.

> On a similar note, would it be relevant to add similar changes to
> rev-parse?

If the goal is "to allow '-' everywhere '@{-1}' is allowed, and used
as such", then yes, of course, such an update is needed.

But I am not sure if that is a worthwhile goal to aim for in the
first place, though.  You would need to accept -@{two.days.ago} as a
"short-hand" for @{-1}@{two.days.ago}, etc., which does not look
very readable way in the first place.
