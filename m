From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Mon, 17 Nov 2014 11:06:12 -0800
Message-ID: <xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 20:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqRd4-0005Ew-LF
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 20:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaKQTGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 14:06:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751836AbaKQTGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 14:06:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91BFA1F38B;
	Mon, 17 Nov 2014 14:06:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wpt8oSik4EUc1D/SLNwg+gmFjic=; b=fwcc7A
	5j2bP0/7RjYNtmC/4Ie9RWSx3mx5vbCimB65ZeZFhPWS3PUepCqbid9Fep7YCSUI
	qI2kINkqWC/i0oos8StFZJ0FAoilBfqfUTCFhXt+BPgF7Wt9lfebm3jyajvcD5gE
	1mcCU60i23i4N5ryOfgAoNE441Qj90XqRAydY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9AXRxQAY4MMyXIunDq+qBD2L15HEaAi
	sjyDaq/MFBEcfwki+8mJ7RLU0IZJ2En2eZC7dblzzI2hPkTuFMpXyo5ddWArUO9P
	bMnHtu1s957viOH5wlxXLh41ScHdZpTGKvW1VmDTyc4IdPj/CyXThUXr2ZDJGHum
	siD2KN7xJJg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 882161F38A;
	Mon, 17 Nov 2014 14:06:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D3471F389;
	Mon, 17 Nov 2014 14:06:16 -0500 (EST)
In-Reply-To: <xmqqzjbryonp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 16 Nov 2014 10:40:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEB883D2-6E8C-11E4-B982-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +post-format-patch
>> +~~~~~~~~~~~~
>> +
>> +This hook is called after format-patch created a patch and it is 
>> +invoked with the filename of the patch as the first parameter.
>
> Such an interface would not work well with --stdout mode, would it?
>
> And if this only works with output generated into the files, then
>
>     $ git format-patch $range | xargs -n1 $your_post_processing_script
>
> would do the same without any change to Git, I would imagine.
>
> So I would have to say that I am fairly negative on this change in
> the presented form.
>
> An alternative design to implement this as a post-processing filter
> to work for both "to individual files" and "to standard output
> stream" output filter may be possible, but even in that case I am
> not sure if it is worth the churn.
>
> In general I'd look at post-anything hook that works locally with a
> great suspicion, so that may partly be where my comment above is
> coming from.  I dunno.

Another reason, in addition to that this only works on the already
created output files, why I find this particular design distasteful
(I am not saying that there should be an easy way to drop cruft left
by third-party systems such as "Change-id:" line) is because the
mechanism the patch adds does not attempt to take advantage of being
inside Git, so the "xargs -n1" above is strictly an equivalent.  You
have a chance to make the life better for users, but not you are not
doing so.

The design of this feature could be made to allow the user to
specify a filter to munge _ONLY_ the log message part.  For example,
just after logmsg_reencode() returns the proposed commit log message
to msg in pretty.c::pretty_print_commit(), you can detect a request
to use some external filter program and let the program munge the
message.  With such a design:

 * The external filter your users would write does not have to worry
   about limiting its damage only to the log message part, as it
   will never see the patch text part; and

 * The same mechanism would work just as well for --stdout mode.

The former is what I mean by "to take advantage of being inside".
Incidentally, it falls into #2 of "5 valid reasons to admit a new
hook" [*1*].


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/232809/focus=71069
