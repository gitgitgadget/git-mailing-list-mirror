From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack.c: don't miss exporting unsolicited push certificates
Date: Mon, 12 Jan 2015 11:07:03 -0800
Message-ID: <xmqqiogb95t4.fsf@gitster.dls.corp.google.com>
References: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
	<1420849874-32013-1-git-send-email-sbeller@google.com>
	<xmqqmw5r9zck.fsf@gitster.dls.corp.google.com>
	<54B0A2C1.4040602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAkKY-0003tY-GD
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 20:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbbALTHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 14:07:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755486AbbALTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 14:07:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 464492F6D6;
	Mon, 12 Jan 2015 14:07:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zFKoRGEC/9Hy9aX8T/zhSzX4vsE=; b=iPUjQ8FWhqM7u0LKH5xg
	rovPVBhyjIAohp6MZsjGC2wrT/3VPLZr3hG+dcAHqIulhF4yQoRx2Nzbptjdk1Sd
	8Jg2oGWlLUOSlorplbMBcU/EMVywXgmsUkoRT6xBgsgA1BmVzqNmQp16+UgcD5rl
	MB2Yu0EiK/cHC+xwHR0lSo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eUB5DH5zr1RqiVaV+aNMFyvJTzZuIHk4qSGKhz+Wet5PuQ
	MWyo5HPE+4sHyhihyEiaC49v2u8Vf36ObRbDAxaZzxRdIy1zF9Yv2G3x+FOYxTKR
	vjrOqwmGpTQ1tuGbwKMqU+pM7XlyP601lOpeLaRTLYh922EKFtbhf6Tsp/HOs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B8B62F6D3;
	Mon, 12 Jan 2015 14:07:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB37D2F6D2;
	Mon, 12 Jan 2015 14:07:04 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 325F1DF6-9A8E-11E4-B6D0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262287>

Stefan Beller <stefanbeller@gmail.com> writes:

> I had problems with wording the commit message because I have no
> expertise with the feature. I am sorry for wasting your time there.

Heh, remember, the time spent discussing Git on this list is not a
wasted time.

>> What is not given to the hook is the push-cert-nonce-status.  While
>> it is sufficient to tell the hook that we are not getting a good
>> nonce (i.e. the hook does not see GIT_PUSH_CERT_NONCE_STATUS=G), we
>> are not showing that nonce-status is "unsolicited", even though we
>> internally compute and decide that; is that what you are trying to
>> fix?
>
> yes that's what I was trying to hint at. The hook would just see
> it is unsolicited instead of not having the state available.

OK.  That makes sort of sense.  So if we:

 1) did not apply either patch (i.e. we accept unsolicited
    certificate, and the fact that we did not exchange "give me this
    nonce" "here is your nonce" is conveyed to the hooks by the lack
    of GIT_PUSH_CERT_NONCE environment and possible presense of
    unsolicited nonce in the GIT_PUSH_CERT blob); and then

 2) applied this patch first (i.e. we still allow unsolicited
    certificate, and the same fact is now conveyed to the hooks also
    by GIT_PUSH_CERT_NONCE_STATUS=UNSOLICITED if they sent a nonce,
    or GIT_PUSH_CERT_NONCE_STATUS=MISSING); and then finally

 3) applied the other patch to reject unsolicited certificate.

then we can stop at any of these three steps and the behaviour of
three resulting systems make sense and the pre-receive hook can
reject unsolicited certificates if it wants to, even at step #1.

The second step makes it easier for the hook to make that decision
because it would make $GIT_PUSH_CERT_NONCE_STATUS the only thing it
needs to inspect, instead of checking it and also having to check
$GIT_PUSH_CERT_NONCE, which is a simplification [*1*].

And then in the third step, the hook does not even have to worry,
which makes what #2 does more or less pointless.

This patch is still a good thing to do from the "correctness" point
of view; the current code may accept certificates without nonce only
because in an earlier iteration of the protocol design, the nonce
was optional and the code the earlier patch fixes is a remnant of
that.  As we do not advertise push-cert without nonce in the final
and current protocol, there is no reason to be loose anymore.


[Footnote]

*1* A hypothetical naive hook implementation:

	case "$GIT_PUSH_CERT_NONCE_STATUS" in
        OK | SLOP)
        	: good and happy
                exit 0;;
	*)
        	: bad and unhappy
                exit 1;;
	esac

would diagnose an unsolicited certificate with or without nonce as
bad.  Though it cannot tell between unsolicited and missing cases,
it would not be so serious a defect in practice.
