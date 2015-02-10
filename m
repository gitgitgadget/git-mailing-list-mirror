From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: avoid running end_packfile recursively
Date: Tue, 10 Feb 2015 10:45:20 -0800
Message-ID: <xmqqa90lwqpr.fsf@gitster.dls.corp.google.com>
References: <20150210010719.GA31823@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:45:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLFoO-0007kt-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 19:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbbBJSpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 13:45:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753090AbbBJSpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 13:45:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5783A37FAC;
	Tue, 10 Feb 2015 13:45:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gWBZvqwsGT92vv1Uzu2amlzLmKA=; b=l9oJz4
	IfVmb750ewUE01CDPIfiinsKhLS9xmJq4R6mLFI/JOw0Qf33IYtDkoVsX0mxBpKN
	fHM/Ws9ZflXIBl5WylcEsgKvQREd1EF/GVCkqQ6q9pbcMGyNj3hAnnbE8GN7pSbD
	rXuymm9fya/nkIDCW73awRiC4H1GkFAJwlXDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YzzqvUOD1VnDOxrWR4EaurTwTZ24NQrN
	pZQfoWNu7dkUGp/AixgfG9bCYcRwdiOXaVeUJkYKCdUnBbTGmgceeyVzYiBSdo8e
	QOy9FkpuFlz3Nz0GYYzTy3EqaBwPd/gDCrpiAmNBGaI30FYH1xGjw81p+w7Jqpis
	5wOyxpVzUJ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E17037FAA;
	Tue, 10 Feb 2015 13:45:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C590A37FA9;
	Tue, 10 Feb 2015 13:45:21 -0500 (EST)
In-Reply-To: <20150210010719.GA31823@peff.net> (Jeff King's message of "Mon, 9
	Feb 2015 20:07:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7A67C76-B154-11E4-AABF-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263640>

Jeff King <peff@peff.net> writes:

> When an import has finished, we run end_packfile() to
> finalize the data and move the packfile into place. If this
> process fails, we call die() and end up in our die_nicely()
> handler.  Which unfortunately includes running end_packfile
> to save any progress we made. We enter the function again,
> and start operating on the pack_data struct while it is in
> an inconsistent state, leading to a segfault.
> ... This new problem is
> quite similar, except that we are worried about calling
> die() _during_ end_packfile, not right after. Ideally we
> would simply set pack_data to NULL as soon as we enter the
> function, and operate on a copy of the pointer.

Nicely analyzed and well done.

> Unfortunately, it is not so easy. pack_data is a global, and
> end_packfile calls into other functions which operate on the
> global directly. We would have to teach each of these to
> take an argument, and there is no guarantee that we would
> catch all of the spots.

Well, you can rename the global to something else to make sure ;-)
But I think that the approach with a simple flag is better.

If we were planning to do the global-to-parameter surgery for other
reasons (perhaps need to make things reentrant?) then the equation
might become different, but I do not think we are doing that right
now, so...

Thanks.
