From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary backquotes
Date: Fri, 08 Jan 2016 10:12:37 -0800
Message-ID: <xmqq7fjk2b56.fsf@gitster.mtv.corp.google.com>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
	<1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
	<vpqa8ogdsyr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:12:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHbWs-0004zh-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 19:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbcAHSMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 13:12:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbcAHSMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 13:12:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5627F392FF;
	Fri,  8 Jan 2016 13:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=06hEZKrjYdTivAXPQ+LuouO+iZg=; b=d35JIp
	X8h6arcpb/sY88CLshzqhXFtCZIpws6r5PvYZePHsOxvnFgPDUkuUvks1R/P7mha
	SLgIZ4tXUprjn2z5TPtIU9fhH2v48V1w4kMWgt2lstdhZuGvN/4WqzRCjJ5I8b9Y
	wvzy9SL2o9uxROlqX3Ac45aBGJo4BJcROBba8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w0ixB1tXszXEUeH4xMLvlfAPfvwveqT+
	CrFgCs09E804tBfUOmURewXbo8vc9DybREv/necOga1C3UFxwtf3Ur4EwzFjVRbv
	429TuJNeIC9RPqxrdnmn823HWohkTU+79m97eefNMnZIVqngiI2pDqZzAW5BZ0ib
	XudjV26BBHk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DE1B392FE;
	Fri,  8 Jan 2016 13:12:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BAD22392FC;
	Fri,  8 Jan 2016 13:12:38 -0500 (EST)
In-Reply-To: <vpqa8ogdsyr.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	08 Jan 2016 15:52:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66BB18AE-B633-11E5-91B9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283571>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Instead of making the shell expand 00* and invoke 'echo' with it,
>> and then capturing its output as command substitution, just use
>> the result of expanding 00* directly.
>
> This is not actually how it happens. cover=`echo *` expands the * before
> the assignment to $cover, while cover="*" assigns a litteral * to
> $cover.
>
> Then, when you use $cover, the variable is expanded to * and then it is
> expanded to filenames here:
>
>>  	mv $cover cover-to-edit.patch &&
>
> On the other hand, this instance of $cover is quoted, hence the
> *-expansion won't happen:
>
>>  	perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&
>
> So, I believe this patch is not correct.

I think this tried to mimick 6ffd3ec8 but the context covered by
that commit is different from the right hand side of an assignment.

You are right that [10/10] changes where the expansion happens and
is not a faithful conversion.  The result may be the same, though ;-)

If anything, I think

        -	mv $cover cover-to-edit.patch &&
        +	mv "$cover" cover-to-edit.patch &&

is a prudent thing to do, but that is orthogonal to what 10/10
tried to do.

>
> OTOH, patches 1 to 9 look good to me.
