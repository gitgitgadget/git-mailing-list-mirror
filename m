From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] wt-status: fix possible use of uninitialized
 variable
Date: Thu, 21 Mar 2013 12:55:12 -0700
Message-ID: <7vip4ka5pb.fsf@alter.siamese.dyndns.org>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321110527.GA18819@sigill.intra.peff.net>
 <20130321194949.GG29311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 20:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIlai-0001Yr-9L
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 20:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab3CUTzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 15:55:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab3CUTzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 15:55:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35EBFB64B;
	Thu, 21 Mar 2013 15:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S6nunw9ia6a8F48bfuMdLje2F4A=; b=ExmBRW
	BQ24uQ8+stCbpxX5paYDUQ4njwtRCbT9AQ5eiHaF8pZ7gtLamIV4elnq8EOIXTwP
	HA4AWsoDLsy2/zkGkqNn6cPLTCom9spatv/raJFvS5Wbcq4ssJxg2NPQ9qeSxevV
	MVrcfLUfY2YvT2hTFtMFArHrXDiSC3dy51MA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tm00sWfBSkwSLcTkQAtygjlRPAhnXoXx
	6PAAEaio1O4lpkXocWoNv8w7uG50ni3G1LsDHtqIHxT8qwLRM9m4wkoXAIefMEhF
	MhKAV1aU/Oh/tOPINvfNvR8N1japoRlvYBBQx787/T8meN4cKMNcXo1a86FpogZt
	jEuzlUdEvWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2934BB64A;
	Thu, 21 Mar 2013 15:55:14 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AA3BB649; Thu, 21 Mar 2013
 15:55:13 -0400 (EDT)
In-Reply-To: <20130321194949.GG29311@google.com> (Jonathan Nieder's message
 of "Thu, 21 Mar 2013 12:49:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EBA3F22-9261-11E2-BD81-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218751>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Instead of using the "x = x" hack, let's handle the default
>> case in the switch() statement with a die("BUG"). That tells
>> the compiler and any readers of the code exactly what the
>> function's input assumptions are.
>
> Sounds reasonable.
>
>> We could also convert the flag to an enum, which would
>> provide a compile-time check on the function input.
>
> Unfortunately C permits out-of-bounds values for enums.
>
> [...]
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -264,7 +264,7 @@ static void wt_status_print_change_data(struct wt_status *s,
>>  {
>>  	struct wt_status_change_data *d = it->util;
>>  	const char *c = color(change_type, s);
>> -	int status = status;
>> +	int status;
>>  	char *one_name;
>>  	char *two_name;
>>  	const char *one, *two;
>> @@ -292,6 +292,9 @@ static void wt_status_print_change_data(struct wt_status *s,
>>  		}
>>  		status = d->worktree_status;
>>  		break;
>> +	default:
>> +		die("BUG: unhandled change_type %d in wt_status_print_change_data",
>> +		    change_type);
>
> Micronit: s/unhandled/invalid/.

I actually think "unhandled" is more correct for this one; we may
add new change_type later in the caller, and we do not want to
forget to add a new case arm that handles the new value.
