From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Wed, 29 Apr 2015 18:35:09 -0700
Message-ID: <xmqq383i4cvm.fsf@gitster.dls.corp.google.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
	<CAGZ79kY95mxKWwTPSB0S5c0eux1ButhuvGz91GQUz8WXt1w18w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:35:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndNl-0000VB-J5
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbbD3BfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:35:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750996AbbD3BfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:35:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 384534DBC8;
	Wed, 29 Apr 2015 21:35:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sTKr4kvoBCzVAqTOjaRFhXPH5w4=; b=IYdy/I
	kAKhyT1JscNHHxnC8C6W1gEn7B1qJ1atCEZiziszcvGJ8X22krp6ZhmwNqOVALOX
	ODyxGXM2SZ2Y6c9v0rBB4bPhjcqKe88FZeTfBXoE7H/kPSHB79tFAr9SIausNRl7
	kf2B13c9mLp48aBA2WOrRJQGzZKe8ZHaa8Gk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lvfz9oFBWVa31B+UqN62kNWu+mLpP4LJ
	BcFEYQKQHB4Fm+dNNBWIf4tDRCruI5Ve124m0N0GiDmH8YhDhqXQ+HtC12LS8F82
	KYoFjAJ7eIOKTEp6sBSLi2xzOf5y7RLanb+w1dLSAXFugyUCscmD2IKQBsAZzI5O
	1Dqd+VQjrH8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DE754DBC6;
	Wed, 29 Apr 2015 21:35:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1ADA4DBC1;
	Wed, 29 Apr 2015 21:35:10 -0400 (EDT)
In-Reply-To: <CAGZ79kY95mxKWwTPSB0S5c0eux1ButhuvGz91GQUz8WXt1w18w@mail.gmail.com>
	(Stefan Beller's message of "Wed, 29 Apr 2015 16:47:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23F87862-EED9-11E4-A1AD-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268045>

Stefan Beller <sbeller@google.com> writes:

[administrivia: cull the parts of the original from your quote if
you are not addressing them]

>>         fd = open(path, O_RDONLY);
>> -       if (fd < 0)
>> -               die_errno("Error opening '%s'", path);
>> +       if (fd < 0) {
>> +               error_code = READ_GITFILE_ERR_OPEN_FAILED;
>> +               goto cleanup_return;
>> +       }
>>         buf = xmalloc(st.st_size + 1);
>>         len = read_in_full(fd, buf, st.st_size);
>>         close(fd);
>> -       if (len != st.st_size)
>> -               die("Error reading %s", path);
>> +       if (len != st.st_size) {
>> +               error_code = READ_GITFILE_ERR_READ_FAILED;
>> +               goto cleanup_return;
>
> Sorry for the late review.
>
> So when you jump from here to the cleanup, there is no close(fd) involved?
> I think there are code paths now, which leak fd.

This one comes _after_ close(fd), so there is no issue.

A later step does introduce an issue; see $gmane/267975.

Thanks.
