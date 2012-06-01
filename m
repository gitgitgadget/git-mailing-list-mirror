From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Fri, 01 Jun 2012 10:01:58 -0700
Message-ID: <7vtxyv2cft.fsf@alter.siamese.dyndns.org>
References: <4FC7EFB7.4090704@steadfast.net>
 <20120601083537.GA32340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Stange <kevin@steadfast.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 19:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaVEn-0004WL-PD
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 19:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572Ab2FARCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 13:02:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758167Ab2FARCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 13:02:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71EA98AAC;
	Fri,  1 Jun 2012 13:02:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OZeUsSGv9rl2n2g29GZK7e6TjJU=; b=c7jci3
	HP0cAdIudBw2DGiUHOVE7pxTJ1Ny5YIjR+IKpffMZImigWCu0TLVEl2wGTzBq8S3
	suzjSRXBy/iZHQ4SRoGD/FTJQbD7Ey7z+JG7jxzt4EI8S1yVKEEZ/hbjf59GOD+3
	oKXNyMwz6NyoUFhOSvbpXTXe1q0FCufp4HhCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLfS4xcaIomv3wiLJ2lQPXCxFQ3+YL48
	iNfB1bNgoiBRt9TftY0pTZRMIWNhAI3z76pYcIN+llyz1dBQRRpnBbAVWgSUT92g
	9Cjwko1Cmwd63UD94BatBzedqKnCo3xgEJgfFGVfKduWBlTxj/qYzv0tHRXpYe3H
	8B3L8As3Vls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 694EC8AAB;
	Fri,  1 Jun 2012 13:02:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A48478AA9; Fri,  1 Jun 2012
 13:02:01 -0400 (EDT)
In-Reply-To: <20120601083537.GA32340@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Jun 2012 04:35:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 819AC970-AC0B-11E1-B7A9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199004>

Jeff King <peff@peff.net> writes:

> On Thu, May 31, 2012 at 05:24:55PM -0500, Kevin Stange wrote:
>
>> Request credentials from the user if none are already defined when a
>> HTTP 401 is received on a restricted repository.  Then, resubmit the
>> request and return the final result.
>> 
>> This allows all webdav transactions to obtain credentials without having
>> to individually handle the case in each request.  Having push working
>> with HTTP auth is needed for a use case I have where storing the
>> credentials in .netrc or using SSH keys is inappropriate.
>
> We already do this at a higher level in http_request, which in turns
> calls into finish_active_slot. So if we were going to go this route,
> wouldn't we also want to remove the 401 handling in http_request?

Wouldn't the higher levels know a lot more about the context this
request was made, though?  What problem does the patch try to solve?
Some higher level callers missing the "if we got 401, then reset and
retry" logic?  Wouldn't it be saner to fix the breakage there?

> The dumb-http push code is the only thing that does not go through
> http_request these days. So another option would be to refactor it to go
> through that central point.

It does sound like the right approach to take.

Thanks.
