From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set API
Date: Mon, 04 Aug 2014 13:52:36 -0700
Message-ID: <xmqqiom8q8ob.fsf@gitster.dls.corp.google.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-6-git-send-email-tanayabh@gmail.com>
	<xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
	<53DFD729.8090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEPFW-0001pd-5G
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaHDUwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:52:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59442 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbaHDUwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:52:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67F382FCAC;
	Mon,  4 Aug 2014 16:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OhiiAP04YiEb2SZ8OI2cfPaJQe0=; b=ciLtiY
	N3X6PZRil5vldRfkqoQyxUhnNlCbzNOFQ8yIobp5iMmbB0PbRnYsoZZ4+KATSwj3
	3PYwuwgWnE5aMrorzfqbcIIFdfDXJfHPvEVJjUIugRb7T50Ro79/6gvFAhrXsp6M
	jPylBI4BCfafhzWDmZtEjTuMU9NbhGq5KpGyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WwLkXjwMYoD6ac0zK4w4tFCmjKtVxyw9
	jVbQRwgOjH9R8DhKS71GKZlUItmT+dXhPQYQqIUkn3cQmfOLAOwPmzOcVqpfm+LX
	U2n3+HO517buBVID9H1rlTxJNdbuwu3XbuFN5Fx8cgc5JwrdqhrQjJTTpPtKc3YW
	PocifTIaYSU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AAE92FCAB;
	Mon,  4 Aug 2014 16:52:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 033ED2FC89;
	Mon,  4 Aug 2014 16:52:37 -0400 (EDT)
In-Reply-To: <53DFD729.8090307@gmail.com> (Tanay Abhra's message of "Tue, 05
	Aug 2014 00:25:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44B2B7FE-1C19-11E4-A271-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254781>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 8/4/2014 11:37 PM, Junio C Hamano wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> Add `git_die_config` that dies printing the line number and the file name
>>> of the highest priority value for the configuration variable `key`.
>>>
>>> It has usage in non-callback based config value retrieval where we can
>>> raise an error and die if there is a semantic error.
>>> For example,
>>>
>>> 	if (!git_config_get_value(key, &value)) {
>>> 		/* NULL values not allowed */
>>> 		if (!value)
>>> 			git_config_die(key);
>>> 		else
>>> 			/* do work */
>>> 	}
>> 
>> It feels a bit unnatural at the API level that this does not take
>> 'value'; I do understand that it is not a big deal in the error code
>> path to locate again the value from the configuration using the key,
>> but still.
>>
>
> But, we don't have a use for "value" as it is not denoted in the error
> string, that is why I left it out.

That is my point.  Why doesn't the error message talk about what
value the caller found was offensive, and in what way?

>>> +	else
>>> +		die(_("bad config variable '%s' at file line %d in %s"),
>> 
>> At least, quote the last '%s'.
>>
>
> Noted. Thanks.

Actually, "at file line" sounded very strange, at least to me, hence
the suggested reword in the part you did not quote.
