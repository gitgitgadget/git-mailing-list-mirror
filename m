From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] wrapper.c: add a new function unlink_or_msg
Date: Tue, 22 Jul 2014 10:56:16 -0700
Message-ID: <xmqq4my9gtvj.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-3-git-send-email-sahlberg@google.com>
	<xmqqha2el2x5.fsf@gitster.dls.corp.google.com>
	<CAPc5daW_6bVg4B4GHA-HCRL7bzmLAdVOF2xOYa9aOOjze-zTdA@mail.gmail.com>
	<CAL=YDWmHcy+Kf+gJLHyFK7bVjnD+bk7rX22jqHVFmTXoHDCEhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:56:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9eIg-0005EY-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 19:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbaGVR40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 13:56:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51052 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756253AbaGVR4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 13:56:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B89BB29D7D;
	Tue, 22 Jul 2014 13:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0MMjgF0fKN5iQlVJzEmLMWVY0Pg=; b=lARl4k
	uKyhXu3nEM1JhiBGVyC54Nb43pPzsd6uwhFaulKm9b5PIpPIouNkRDDj8JStGV8E
	vo+2HkPoVn3Ngsd5NBKERs5knpxMD20ZhMkTWAbOHICi2P+AOYYektWEmw6o7jS+
	2vbf0PEfZfMWPdrrhDmwDKiv5obhii6FZ/73s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UNeJZtCdVTBzuWdWiwqMlYR/KQEUQ+E+
	bM6UnGFVSAAs5JUnSuA/ts7HV6YFZxAmb6J51SXH0WETbEObXnX4VkOmAxFbyTCw
	DtKA2X4dFJ3mxQTL4c5c/Qql5znGIGJctLycneNsvBl36gOXTGFUl3SgxQzmmnKE
	HEyCZbLnPU8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF4FA29D7C;
	Tue, 22 Jul 2014 13:56:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB1A329D70;
	Tue, 22 Jul 2014 13:56:18 -0400 (EDT)
In-Reply-To: <CAL=YDWmHcy+Kf+gJLHyFK7bVjnD+bk7rX22jqHVFmTXoHDCEhQ@mail.gmail.com>
	(Ronnie Sahlberg's message of "Tue, 22 Jul 2014 10:42:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7BA43FBC-11C9-11E4-85A1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254026>

Ronnie Sahlberg <sahlberg@google.com> writes:

> One reason for the former could be if there are problems with multiple
> refs in a single transaction.
> It would be very annoying to have to do
> $ git <some command>
>    error: ref foo has a problem
>
> $ <run command to fix the problem>
> $ git <some sommand>     (try again)
>    error: ref bar has a problem
> ...
>
> And it might be more userfriendly if that instead would be
> $ git <some command>
>    error: ref foo has a problem
>    error: ref bar has a problem
>    ...
>
> And get all the failures in one go instead of having to iterate.
> ...
> I personally do not know yet which approach is the best but would like
> to keep the door open for the "try all and fail at the end".

Yes, and often it is useful (e.g. we allow to push multiple and then
show the result for individual refs).  But that still does not show
a need for accumulating the error messages to strbuf, does it?
