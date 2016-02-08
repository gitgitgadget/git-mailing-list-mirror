From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 08 Feb 2016 11:43:19 -0800
Message-ID: <xmqqlh6v7zu0.fsf@gitster.mtv.corp.google.com>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
	<20160208135013.GA27054@sigill.intra.peff.net>
	<CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
	<20160208163700.GA22929@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602082027550.2964@virtualbox>
	<20160208193509.GA30554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:43:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSriY-0000yz-B8
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbcBHTnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:43:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753573AbcBHTnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:43:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 359274175A;
	Mon,  8 Feb 2016 14:43:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V0OisJ5Cwps+D0phREIf96MdGvo=; b=cvx3RM
	b6cW/lHi0cl9H10LNDikTxrHUJpGICA7Ky1+UQboouHwZeuBpAQnxfyLv8AM2QaT
	UI7Y3YMWJzJVddOcdLvboNrLczqkGXuUu0dQBnrqrIbTdyP463L4ik/nnChHlk1r
	C5wCvAtc7D4NORDCI7lABfFKoeFXTJxcBTI6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+UvVniOdHnOaya5AL6Qe7kXEb8PIL5F
	Ke2BiS86UJdAUY2xWg7CREc9pg2rCCDeOsch5Lh8oTO3h8rXHSvf8hQFyMZn4wkj
	8KP8nPbu+6+IlkZJQCc2aT+lhKHiMxxy5NFS7JGJ674Z9hy/CLr06omFfKhNJX3/
	QFlLfwMgRNM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BD5B41758;
	Mon,  8 Feb 2016 14:43:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E63041755;
	Mon,  8 Feb 2016 14:43:20 -0500 (EST)
In-Reply-To: <20160208193509.GA30554@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 14:35:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3526BC18-CE9C-11E5-8BA9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285794>

Jeff King <peff@peff.net> writes:

> I'm confused why it matters. write_script() unconditionally calls "chmod
> +x", doesn't it?

Yeah, that was exactly my thought, too.  Sorry for not noticing that
this depended the "interpreter" exactly be /bin/sh, though (it is
not even executed).

> I just double-checked its definition in test-lib-function.sh; am I
> missing some Windows-specific magic that kicks in?
>
>> So why not just prefix it with `SHELL_PATH=/bin/sh`?
>
> But then what is write_script buying us?

The correct way to write a script for a specific interpreter is to
give a second parameter to write_script, i.e.

		write_script exec.sh /bin/sh </dev/null &&

and the answer to the question is "it will save us one line".

The version in 'master' that does

                echo "#!/bin/sh" >exec.sh &&
                chmod +x exec.sh &&

should be equivalent, so dropping that hunk from the patch is the
right resolution perhaps?
