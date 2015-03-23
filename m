From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: Don't copy memory around
Date: Mon, 23 Mar 2015 10:11:08 -0700
Message-ID: <xmqq1tkfbpw3.fsf@gitster.dls.corp.google.com>
References: <xmqqwq2baui7.fsf@gitster.dls.corp.google.com>
	<1427129620-13380-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, karsten.blees@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 18:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya5sj-0005AL-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 18:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbbCWRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 13:11:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752215AbbCWRLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 13:11:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0099D3E865;
	Mon, 23 Mar 2015 13:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pT92/P16eU1YPpbtcU3uhZEDt4A=; b=aw3VC0
	/iGA9P83DUQ7UkdOiFpVNTlZBQ08slE9PNBwcxaj+WilHPo1ZK1DpM1ELygBhf+8
	2e1d64mbPmzI8RVpHpIbVDpuUo9WRRxEf0RsZIh9+8/aOb8QeZ5L2xIdrPp08qJf
	PayDBeJVKUz07H/XOoVlWzcwndi/83xn8npHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lu7VN+0/jlXi70HkGVBaiBYfXpktWTfI
	fnK637KRdhf0Wsl22E6wnwQeuqfUJmzKJ2e4KrdoR3c46UBKZdXTBEu8jy3ZTw8v
	2ONSCG95doKAOSBjPYyiM2uMAfI4A8CWuBGzDZkNl6R+GfScwJn99TlPh3/oS0qP
	O4pWm1YZ7y0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4DA73E864;
	Mon, 23 Mar 2015 13:11:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5096D3E863;
	Mon, 23 Mar 2015 13:11:10 -0400 (EDT)
In-Reply-To: <1427129620-13380-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 23 Mar 2015 09:53:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A0BA514-D17F-11E4-A004-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266149>

Stefan Beller <sbeller@google.com> writes:

> ... though I do not understand
> why. This passes the test suite, so I wonder if this patch would be a subtle bug
> now.

I recall the last time I traced the code I noticed that the ce can
get passed to a codepath that causes its removal from update_one(),
and then the pathname itself (which used to be ce->name but remember
that ce is invalid already at that point!) is still used after ce is
removed, which was the reason why you would introduce a bug if you
stop copying the path. You may have to follow the code again a bit
closer to make sure but I am reasonably sure that was the reason.
