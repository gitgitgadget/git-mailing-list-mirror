From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Thu, 19 Sep 2013 11:02:17 -0700
Message-ID: <xmqqbo3ou1ue.fsf@gitster.dls.corp.google.com>
References: <20130917190659.GA15588@pengutronix.de>
	<xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
	<20130917201259.GB16860@sigill.intra.peff.net>
	<xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
	<20130917202917.GA20020@sigill.intra.peff.net>
	<xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
	<20130917212106.GB20178@sigill.intra.peff.net>
	<xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
	<20130917220345.GA22914@sigill.intra.peff.net>
	<xmqqd2o7w0xc.fsf@gitster.dls.corp.google.com>
	<20130919074616.GA29773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 19 20:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMiYc-00080S-Af
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 20:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab3ISSCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 14:02:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120Ab3ISSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 14:02:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA8E343600;
	Thu, 19 Sep 2013 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xZ+Bh6ilu+1xEe0AwE7fsMwYRas=; b=japdnd
	zz3ix2WcAQokJQAEi7aMQ7SkK2/oEDCYJ8x+Xihw88P6royxm+mL0VShWzEbucX8
	uXskEA48HQ1X2u8+gYSYM2SWphkk6TzHeEYfOEv9BgX8Sgvb93wpNRvSlCecPV+Q
	BTU3MYY73ati1bUhoHfY4PQNhVmgfIN2cqwh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BPo7c3B+p0tr7qet3jwReAP2PcK64U/A
	LczQelmeUtBqyQu9W3mxYRFGKupDZCgL2YH6DWBwgy0I1ESy973tkDilpW6DWkbp
	FigtGjqoZktHeImbXdYKJGFzbNsKIYt98Qf3Jd2SDS32mVg1EQa07VMWmGr6OiCu
	NwKO+fF6gdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7C14435FF;
	Thu, 19 Sep 2013 18:02:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AAF0435F3;
	Thu, 19 Sep 2013 18:02:20 +0000 (UTC)
In-Reply-To: <20130919074616.GA29773@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Sep 2013 03:46:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0A7297E-2155-11E3-8FA5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235023>

Jeff King <peff@peff.net> writes:

> An alternative would be to write the new entries to a temporary index
> in memory. And then you can throw away the entries in the current index
> that match the pathspec, and add in the entries from the temporary
> index. I was just hoping that unpack-trees would do all of that for me.
> :)

Isn't a "go there" one-way merge with pathspecs very similar to what
happens in "reset -- pathspec" except for the working tree part?  I
suspect that it may be sufficient to mimic the read_from_tree() and
adapt update_index_from_diff() callback in builtin/reset.c to also
update the working tree (and we can do so unconditionally without
checking if we have any local modification in this case, which
simplifies things a lot), but I may be missing something.
