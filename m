From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore SIGPIPE when running a filter driver
Date: Tue, 21 Feb 2012 12:58:53 -0800
Message-ID: <7vlinvgaya.fsf@alter.siamese.dyndns.org>
References: <1329771217-9088-1-git-send-email-jehan@orb.com>
 <20120221030150.GA31737@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jehan Bing <jehan@orb.com>, git@vger.kernel.org, gitster@pobox.com,
	j.sixt@viscovery.net, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 21:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzwnr-0003xc-5G
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 21:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab2BUU64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 15:58:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab2BUU6z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 15:58:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1C76605;
	Tue, 21 Feb 2012 15:58:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y4YfIxy1VK9PoYtBUM3jqYaN8VA=; b=Kv5Us7
	28tdacE18tpjtx4VZWI7JiviorevfZQnOWg4hOYvJiZejILwUdW/hZkKsUWUHShq
	EE8TFA0Zvrd3ulsEv4Wn1RRtcGSPZR9zIyMX9nBniujL0E+Aewf357C68QL3Z524
	0EERP1u+rhMKZ97vWHAnLtOrxe4Ek4Bnk1+k4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YX2rdsFD2MrJtIBA3hCSlLyRxLdSvNtl
	EnUB4p623M5pWSHzdpUcpK6iLQ6sWAL8MplrLGYtp4WTBrYHn+8XAhfIuXrpRHCQ
	QF9JW1U2YZnNoTH4UBWwiQeoDfYCmzAMQfccWtxh9AZWFDCfl7GBQEiCvDeARmCC
	gfB28hBHY0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51B866604;
	Tue, 21 Feb 2012 15:58:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D388B6603; Tue, 21 Feb 2012
 15:58:54 -0500 (EST)
In-Reply-To: <20120221030150.GA31737@burratino> (Jonathan Nieder's message of
 "Mon, 20 Feb 2012 21:01:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD9F2B8A-5CCE-11E1-A108-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191184>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> If a filter is not defined or if it fails, git behaves as if the filter
>> is a no-op passthru. However, if the filter exits before reading all
>> the content, and depending on the timing git, could be kill with
>> SIGPIPE instead.
>>
>> Ignore SIGPIPE while processing the filter to detect when it exits
>> early and fallback to using the unfiltered content.
>>
>> Signed-off-by: Jehan Bing <jehan@orb.com>
>
> For the benefit of the uninitiated ("how would ignoring an error help
> me detect an error?"): setting the SIGPIPE handler to SIG_IGN does not
> actually ignore the broken pipe condition but causes it to be reported
> as an I/O error, errno == EPIPE.  That means instead of being killed
> by SIGPIPE, git gets to fall back to passthrough and report the
> filter's mistake.

Yes.  

You could rephrase  bit better to further clarify it, perhaps like this:

    Ignore SIGPIPE when running a filter driver
    
    If a filter is not defined or if it fails, git should behave as if the
    filter is a no-op passthru.
    
    However, if the filter exits before reading all the content, depending on
    the timing, git could be killed with SIGPIPE when it tries to write to the
    pipe connected to the filter.
    
    Ignore SIGPIPE while processing the filter to give us a chance to check
    the return value from a failed write, in order to detect and act on this
    mode of failure in a more controlled way.
    
    Signed-off-by: Jehan Bing <jehan@orb.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

although I think Jehan's original was already clear enough.

> So at least on POSIX-y platforms, this patch looks good to me.  Thanks
> for writing it.

Thank you and Johannes for eyeballing and sanity checking.

Will queue.
