From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/33] t3210: test for spurious error messages for
 dangling packed refs
Date: Tue, 16 Apr 2013 21:42:53 -0700
Message-ID: <7v38upix82.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-17-git-send-email-mhagger@alum.mit.edu>
 <7vobdfvglf.fsf@alter.siamese.dyndns.org> <516D5CC6.10505@alum.mit.edu>
 <7vip3mhxhq.fsf@alter.siamese.dyndns.org>
 <20130416235712.GA20585@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 06:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKD7-00047R-DM
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 06:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab3DQEm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 00:42:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab3DQEm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 00:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B2DD1149A;
	Wed, 17 Apr 2013 04:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L/rrzD8GcygqyVaeCMmcDfJMubM=; b=RLM/eH
	nHgQIPLxA1MhVxf8aSyqqABZfTlU1iyQw6MLbj5XyDJ/obmUBncAYPxh+8sxuPLc
	8gPdykRgSG6cIwX/oVyMQMTHvH4JkB0D0hQkTfKscOxFoypCgV9wiWe28bvsGGuT
	0JyBxW/VssbSL4xje8mc1p6F2H+nNTVY2QU9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NRVgR1jHbhUVy82YNxPQ3oqBi8XQOU6k
	zoJDAWhujla1XaD0UxfRW2wuhIX+gBPtQxFsHqvSrALf475HgOH7AGGLRiaZYK/K
	z5KxYfftnzDnjID2jUATxJ0PLkhtGeI/tfcEAmUNPgWw6/CTcUOmPiYp358x5SFF
	MgAi/7IIY1k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711FD11499;
	Wed, 17 Apr 2013 04:42:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E92CA11498; Wed, 17 Apr
 2013 04:42:54 +0000 (UTC)
In-Reply-To: <20130416235712.GA20585@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Apr 2013 19:57:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4516503C-A719-11E2-8B6D-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221502>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 16, 2013 at 04:22:25PM -0700, Junio C Hamano wrote:
>
>> +static void parse_expire_value(const char *value, unsigned long *expire)
>> +{
>> +	if (!strcmp(value, "never") || !strcmp(value, "false"))
>> +		*expire = 0;
>> +	else if (!strcmp(value, "all") || !strcmp(value, "now"))
>> +		/*
>> +		 * We take over "now" here, which usually translates
>> +		 * to the current timestamp, because the user really
>> +		 * means everything she has done in the past, and by
>> +		 * definition reflogs are the record of the past,
>> +		 * there is nothing from the future to be kept.
>> +		 */
>> +		*expire = ULONG_MAX;
>> +	else
>> +		*expire = approxidate(value);
>> +}
>
> Do we want to use approxidate_careful here to catch other junk?

We can catch a misspelt argument or configuration value that way.
That would be a good idea.
