From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please document git-http-backend/Apache timeout interactions
Date: Sun, 21 Feb 2016 15:29:56 -0800
Message-ID: <xmqqwppx8wwb.fsf@gitster.mtv.corp.google.com>
References: <20160221221744.GA38068@sesse.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:30:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdS4-0002qV-0J
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbcBUXaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:30:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752434AbcBUXaB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:30:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 213B345568;
	Sun, 21 Feb 2016 18:30:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gO3BN51Rb03b0lxd0E21V7+Lscg=; b=x37tBl
	hWTViTVI761guht3/dGfxSp0o6nmdSB3GSHQiKamvhsRCwUASi6irjoPeahxA+Kh
	ZCpByBe23KhwssnGTCeB2XlsYU1/YUMUtFHJB327AbG78xNfVGXPucs4oCAQImzI
	t+EzjevkgwbYHeEV8Lpn0Z7NQpGHsi7Mny1rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SxfDprKuWARy6MvIjhYx4SaHClO9bJSp
	K5V77PbvlLlbwcoldmRePhBkWjizvynnFMQduhvoctOIXSyJxfXeJjGdY8A4lnWy
	j5lVey5P4w5A1HiAhpZxBkYZ97DxclOt9LRK4XMNjSMKxTVCvKatBt3ThXwlaUEq
	74CVRX4+mOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15A1E45567;
	Sun, 21 Feb 2016 18:30:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCAAF45565;
	Sun, 21 Feb 2016 18:29:57 -0500 (EST)
In-Reply-To: <20160221221744.GA38068@sesse.net> (Steinar H. Gunderson's
	message of "Sun, 21 Feb 2016 23:17:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05147874-D8F3-11E5-9F1E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286843>

"Steinar H. Gunderson" <sgunderson@bigfoot.com> writes:

> I am running git-http-backend behind Apache as suggested in
> git-http-backend(1). However, what it fails to mention is that
> git-fetch-pack seemingly can be very slow in sending its request.
> Consequently, mod_reqtimeout (on by default, as I understand it)
> kicks in as an anti-DoS measure, and the user sees a 408 (timeout)
> error.
>
> Seemingly the simplest fix is to turn off mod_reqtimeout in the vhost
> serving git (potentially with some <IfModule> around it):
>
>    RequestReadTimeout header=0 body=0
>
> Would you consider adding this to the documentation?

This feels 70% like "how to configure your Apache server when you
run site that is contacted by a client that is slow to talk?", that
is not necessarily specific to Git.

Also while it may make sense to tweak the timeout on the server
side, recommending to disable it altogether, instead of adjusting to
the typical requirement for a sane client, feels just wrong.

Also, are all requests from one client slow to start, or are only
some phases in the protocol exchange slow but not others?  If the
server side can tell which ones could be normally slow, selectively
loosening timeouts only for them might be more palatable, but I am
sensing that you are not suggesting such an approach.

For these reasons, I am on the fence.
