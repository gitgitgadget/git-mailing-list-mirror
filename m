From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't tried Negotiate
Date: Fri, 05 Feb 2016 13:02:58 -0800
Message-ID: <xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	<20160205204648.GA7403@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:03:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnX0-0004B2-JA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbcBEVDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:03:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751482AbcBEVDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:03:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC38241DE5;
	Fri,  5 Feb 2016 16:02:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NU8k7v6E1DjK2t20urDvptq/u0Y=; b=HWY7TS
	qKy6g4oq0Tsgv7Oqs0GBcWxHcKd7qtqtNePMJP1xxa4naX9DQ3LILCExwU5R9n4m
	Ioe7ulX0KzMZl3rOHuK+5B4fJsd+XMHFz3I68MnKdHa+JOI5IRsvOvmyXwqlykd8
	ANC/D/6Sq1ZkQuaQ5Vijs4t9TRDzhSYwcju5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tZS/+qWnpQ2xXjhXWHAeD31EvHiC4SAZ
	VTb5l7WuckoxMxP7ZcuEWU09+6uVDqZH0EixCqlPUDnA3ZrjvwQNM/fzeelpO+KZ
	jjsVpWs9WkZGUMBfBFNGc17l8vPxqxmNqUfa6Tf+sfhYQGgf2ped8Q/+oeZBAg3p
	YU9XjVRC9K8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3B1F41DE2;
	Fri,  5 Feb 2016 16:02:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2988C41DDB;
	Fri,  5 Feb 2016 16:02:59 -0500 (EST)
In-Reply-To: <20160205204648.GA7403@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 5 Feb 2016 20:46:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6221D36-CC4B-11E5-9928-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285631>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Feb 05, 2016 at 12:18:22PM +0300, Dmitry Vilkov wrote:
>> You are right, we are using a bare URL (without a username component).
>> With username encoded in URL everything works just fine. But it's
>> generally wrong to pass creds in URL (in my opinion) and security
>> policy of my employer prohibits doing such thing.
>> Anyway, as you said libcurl needs valid (not NULL) username/password
>> to do GSS-Negotiate, so there is nothing wrong if I set empty
>> username/password combination when git prompts for creds. Even more,
>> there is no other way to let libcurl to use GSS-Negotiate without
>> username in URL.
>
> You can literally do https://:@git.crustytoothpaste.net/git/repo.git as
> the URL, and that will work.  GSS-Negotiate using Kerberos passes the
> ticket, which contains the principal name in it, so an actual username
> and password is not needed at all.  libcurl just needs something to tell
> it to do authentication.

Hmph, so documenting that <emptyname>:<emptypassword>@<repository>
as a supported way might be an ugly-looking solution to the original
problem.  A less ugly-looking solution might be a boolean that can
be set per URL (we already have urlmatch-config infrastructure to
help us do so) to tell us to pass the empty credential to lubCurl,
bypassing the step to ask the user for password that we do not use.

The end-result of either of these solution would strictly be better
than the patch we discussed in that the end user will not have to
interact with the prompt at all, right?
