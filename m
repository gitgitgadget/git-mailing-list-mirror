From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: Read gpg settings for signed commit verification
Date: Wed, 27 Mar 2013 10:02:49 -0700
Message-ID: <7vwqssn5c6.fsf@alter.siamese.dyndns.org>
References: <8C726954D36902459248B0627BF2E66F45D70C3E4E@AUSP01VMBX10.collaborationhost.net> <7vip4com2p.fsf@alter.siamese.dyndns.org> <20130327162232.GB22386@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hans Brigman <hbrigman@openspan.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Sarvis <jsarvis@openspan.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:03:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtl2-0003So-0g
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab3C0RCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:02:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab3C0RCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:02:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44CF6A878;
	Wed, 27 Mar 2013 13:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WdGzMu0KfcHmTfCqmN2ibKPI8PY=; b=fzQxcO
	xRCXucs1PVgya4pjUv7a7ZWxFrqvCfE0EBC5eENqxjz3056jTwQLfEZmprjSZEo+
	NdgoRHUYWi7QRQ4h9nN591Y2dWV1Lzt3D7ytP8m896P6gebQytn0skD2AJYjPh9T
	dVCYiXxR/EZAScXdCun1DNT6pKAzfQxmZpYlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M5hPtp35EIYCSQrKUSS/R47BeJaeJoId
	D2KRUYCb96QB8BJo+WrU2VNrZuBvkce6G5pcVUaeCfgCrvLubMRw12R9DON6gN4h
	/LQu2FRNRfC4BGjmkXXoAzaUj96NaK+Oj6PUJD3BxHM6z8+RrRm1R/5yG1SS+uOu
	ioBWXH5sZWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3983BA876;
	Wed, 27 Mar 2013 13:02:51 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3623A875; Wed, 27 Mar 2013
 13:02:50 -0400 (EDT)
In-Reply-To: <20130327162232.GB22386@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Mar 2013 12:22:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 285BBAA0-9700-11E2-8B0E-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219277>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 27, 2013 at 09:15:58AM -0700, Junio C Hamano wrote:
>
>> >  	}
>> > -
>> > +	if (git_gpg_config(var, value, cb) < 0)
>> > +		return -1;
>> >  	if (grep_config(var, value, cb) < 0)
>> >  		return -1;
>> 
>> Hmph.  I do not particularly like the way the call to grep_config()
>> loses information by not ignoring its return value and always
>> returning -1, but I'll let it pass for this patch.
>
> That's my fault for suggesting he follow the same style as grep here.
> But I wonder if it is worth the effort. We have never cared about
> anything beyond "was there an error" in our config callbacks, and the
> value returned from the callbacks is lost in git_parse_file (i.e., we do
> not propagate the actual return value, but only check that
> "callback(var, value, data) < 0", and die if so).
>
> Existing callbacks pass data out by writing into a struct pointed to by
> the data pointer, which is more flexible, anyway.
>
> So unless you want to overhaul the whole config system to propagate
> return codes back to the caller, I do not think there is any point in
> worrying about it.

Yeah, that is where my conclusion in the message you are responding
comes from ;-)
