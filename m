From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 09:30:00 -0700
Message-ID: <xmqqioce6gon.fsf@gitster.dls.corp.google.com>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
	<20150428055506.GJ24580@peff.net>
	<CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
	<20150429043947.GA10702@peff.net> <20150429045600.GA10781@peff.net>
	<xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>
	<20150429154857.GA13518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olivier ROLAND <cyrus-dev@edla.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 18:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnUsM-0000sE-FX
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 18:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966050AbbD2QaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 12:30:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966000AbbD2QaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 12:30:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E1964B5C7;
	Wed, 29 Apr 2015 12:30:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q4RIcbgyXhPBFVoq7/ZywQmHrV8=; b=o+zoFW
	LbgMAXJEBOB/WrXnPF1B/TGdBSrQYstJl8ZUzSZFlhm2/Kr+ye4POzNLe40GTV3M
	+mUTm2L8vX0ypRIxXwXwFW9sF8yY3u5Ht5CSNlt4bMEt30f6mqQUe3ISqk3e0Fpv
	FV24ReV+utjjWMSv7EDGM92+a+1KFiSifvRv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qNxrfuLIe7hVklZczCoN5KfrjFuFRXbL
	2P3h9cACpRxtnIrBkbWzGX0o0zPbxpUOZ6dwiIcF9xCDWy+fcD8KCynpsjIGUu7j
	RRMRfo7rhcuUfJcoEUHL9wmdcIITiJmMBLWM7urvMPDtsfl8t8yOZcfJOR/QHjm8
	5ss7YiJiM+s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D241D4B5C2;
	Wed, 29 Apr 2015 12:30:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B5AC4B5BE;
	Wed, 29 Apr 2015 12:30:02 -0400 (EDT)
In-Reply-To: <20150429154857.GA13518@peff.net> (Jeff King's message of "Wed,
	29 Apr 2015 11:48:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC284160-EE8C-11E4-955D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267982>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 28, 2015 at 10:39:44PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I'm not sure of a solution short of replacing the use of sed here with
>> > something else. perl would be a simple choice, but filter-branch does
>> > not otherwise depend on it. We could use a shell "read" loop, but those
>> > are quite slow (and filter-branch is slow enough as it is!).
>> 
>> You need to only skip the header part, right?
>> I would imagine that
>> 
>> (
>> 	while read x && test -n "$x"
>>         do
>>         	:;
>> 	done
>> 	cat
>> ) <../commit | eval "$filter_msg"
>> 
>> would not spin too much in shell loop, perhaps?
>
> Yeah, that is not too bad. Probably we want "read -r", just in case of
> weirdness in the header lines (and that's in POSIX, and we use it
> in other scripts, so it should be portable enough). And we can save a
> subshell if we don't mind the potential variable-name conflict.

As all we care about is "have we hit an empty line", I do not think "-r"
really matters, but it would not hurt.

As to s/()/{}/, please tell me what I am doing wrong.  I am getting
the same process IDs from all of the $$s and the only difference
seems to be variable clobbering.

-- >8 --
#!/bin/sh

cat >/var/tmp/tester <<EOF || exit
a
b

c
d
EOF


x=foo
echo "My id is $$"
(
	echo "inside paren $$"
	while read x && test -n "$x"
	do
		:;
	done
	cat
) </var/tmp/tester
echo "x=<$x>"

x=foo
{
	echo "inside brace $$"
	while read x && test -n "$x"
	do
		:;
	done
	cat
} </var/tmp/tester
echo "x=<$x>"
