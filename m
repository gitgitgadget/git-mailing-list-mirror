From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 10:22:42 -0700
Message-ID: <xmqqa8klr21p.fsf@gitster.mtv.corp.google.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<20160422044258.GA31619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:22:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aten4-0003No-KF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbcDVRWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:22:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754330AbcDVRWp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:22:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 643C9155B8;
	Fri, 22 Apr 2016 13:22:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkFLCiy3PeCfJPLFNr9k35vZUwc=; b=IS4MnA
	0YpMm3iw/JDzWSMFzQa4GuQMN9N9jF+Oc1oknGPEn+WTX/iBEKuwuzq79dv2QkJr
	2n/FWDcIKqmi4r+qpjjz4VNdmIDpFQYeMhNIdy3vN7a+z6fM5cSdfFXWosqBr6GF
	nFA8S4iEwfdu9Eq1GgVj0h+hD0KCSsKeEnNCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWrrYqndjzuaDAn6OaekPyZwjJCciOfw
	2QnAB4kQ7JwkGEr2ceKazQ1LK2E869akOGT+Z0JnuCE0DWsMHWHfLHbTizLG+9T+
	xdTmrbmZCf44oJ+CJs6ELKbKPBByD/YARrJqp6+gg8Dw9AqV+fbsTqM0v3Ka+uqi
	PV3Mq/6hAf8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C8C6155B7;
	Fri, 22 Apr 2016 13:22:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2906155B6;
	Fri, 22 Apr 2016 13:22:43 -0400 (EDT)
In-Reply-To: <20160422044258.GA31619@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Apr 2016 00:42:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2E2E732-08AE-11E6-9D78-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292230>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 21, 2016 at 03:20:39PM -0700, Junio C Hamano wrote:
>
>> * jk/push-client-deadlock-fix (2016-04-20) 5 commits
>>  - t5504: drop sigpipe=ok from push tests
>>  - fetch-pack: isolate sigpipe in demuxer thread
>>  - send-pack: isolate sigpipe in demuxer thread
>>  - run-command: teach async threads to ignore SIGPIPE
>>  - send-pack: close demux pipe before finishing async process
>> 
>>  "git push" from a corrupt repository that attempts to push a large
>>  number of refs deadlocked waiting for a rejection from the
>>  receiving end that will never come.
>> 
>>  Will merge to 'next'.
>
> Minor nit, but the deadlock is the other way around: the rejection
> showed up and our demuxer is blocked writing to a reader who does not
> care about it.
>
> Might be worth fixing since this text goes into the topic merge commit
> (though I really hope nobody ever has to debug it enough ever again for
> that distinction to matter :) ).

Thanks.  Something like this, perhaps?

  "git push" from a corrupt repository that attempts to push a large
  number of refs deadlocked; the thread to relay rejection notices
  for these ref updates blocked on writing them to the main thread,
  after the main thread at the receiving end notices that the push
  failed and decides not to read these notices and return a failure.


>> * da/user-useconfigonly (2016-04-01) 2 commits
>>  - ident: give "please tell me" message upon useConfigOnly error
>>  - ident: check for useConfigOnly before auto-detection of name/email
>> 
>>  The "user.useConfigOnly" configuration variable makes it an error
>>  if users do not explicitly set user.name and user.email.  However,
>>  its check was not done early enough and allowed another error to
>>  trigger, reporting that the default value we guessed from the
>>  system setting was unusable.  This was a suboptimal end-user
>>  experience as we want the users to set user.name/user.email without
>>  relying on the auto-detection at all.
>> 
>>  Waiting for Acks.
>>  ($gmane/290340)
>
> I think you are waiting for the Ack from the original author on your
> tweaks. But FWIW, what you have queued looks good to me.

What often happens is that I start waiting, and then when
necessary actions to move things forward is never taken, and there
are many other topics that need my attention to move forward, I stop
caring, especially when the topic is not something other people care
about (if the original author does not care deeply enough, why
should we?).

Let me read it over again as it has been a while and then move it
forward with your Reviewed-by's.

>> * dk/gc-more-wo-pack (2016-01-13) 4 commits
>>  - gc: clean garbage .bitmap files from pack dir
>>  - t5304: ensure non-garbage files are not deleted
>>  - t5304: test .bitmap garbage files
>>  - prepare_packed_git(): find more garbage
>> 
>>  Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
>>  .bitmap and .keep files.
>> 
>>  Waiting for a reroll.
>>  ($gmane/284368).
>
> This one's getting pretty stale, but as I recall was pretty close to
> done.  I'll try to give it a look in the next couple of days.

Thanks.
