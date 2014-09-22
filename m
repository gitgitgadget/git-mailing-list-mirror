From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] unblock and unignore SIGPIPE
Date: Mon, 22 Sep 2014 10:30:38 -0700
Message-ID: <xmqqwq8vlg01.fsf@gitster.dls.corp.google.com>
References: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
	<541D3E0C.4030400@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Reynolds <patrick.reynolds@github.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW7Ry-0006vf-3d
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 19:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbaIVRaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 13:30:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53928 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbaIVRau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 13:30:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47F593C05C;
	Mon, 22 Sep 2014 13:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=clPQ4r36ia3UGSJmD6NkUe2iVsQ=; b=SqVzoy
	71JwUHidaFmOhKzIp02abnMHUq7UvJ4Wxd4EqtOvW0OtiKGKvNx734iI3em+OKqI
	ELs0X9zep5rQg5GFGU2AvEVi1RFU5jU1maRV+eUu8Rb4ZeV7sfJQ+zLbiwGsQKq+
	pwSxeBXRiU7atOKJ/QrIXYG5+bSFqePIzFB88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L8UD1+OEw5jP9KbUZAcVTGoOtzQ9dHtn
	b6TVryHuWxc6HkLuhdfToLXwwkElVZQ3ovNZKDxBzQFdagiikhKTnA13xoclpXQn
	XduBYjt0VZsc2TsI59GRL37JtjjNq4fdmT/EsdMfIt07ClEx8MTct5CitZxlLarF
	XKMGXdPoYaE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D6E93C05B;
	Mon, 22 Sep 2014 13:30:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8326C3C05A;
	Mon, 22 Sep 2014 13:30:41 -0400 (EDT)
In-Reply-To: <541D3E0C.4030400@kdbg.org> (Johannes Sixt's message of "Sat, 20
	Sep 2014 10:42:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D8CD5F6-427E-11E4-ADCF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257368>

Johannes Sixt <j6t@kdbg.org> writes:

>> +static void restore_sigpipe_to_default(void)
>> +{
>> +	sigset_t unblock;
>> +
>> +	sigemptyset(&unblock);
>> +	sigaddset(&unblock, SIGPIPE);
>> +	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
>> +	signal(SIGPIPE, SIG_DFL);
>> +}
>
> This does not build on MinGW due to missing sigaddset() and
> sigprocmask(). I've a patch that adds dummies for them (but I ran out of
> time to complete it for submission). But then the test cases ...
>
>> +test_expect_success 'a constipated git dies with SIGPIPE' '
>> +	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 )
>> +	test "$OUT" -eq 141
>> +'
>> +
>> +test_expect_success 'a constipated git dies with SIGPIPE even if parent ignores it' '
>> +	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 )
>> +	test "$OUT" -eq 141
>> +'
>
> ... fail always because we neither get SIGPIPE (we don't have it on
> Windows) nor do we see a write error (e.g. EPIPE) when writing to the
> pipe. Should I protect these tests with !MINGW or would it be an option
> to drop these tests alltogether?

Let's do !MINGW for now, unless somebody can think of a reason why
this change and tests are a bad idea (e.g. "we are not in the
business of preventing users from shooting themselves; have the
users bug those who wrote the software that spawns us with SIGPIPE
ignored", to which I am sympathetic to some degree but not very much
because I am also a practical person).

Thanks.
