From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule--helper: initial clone learns retry logic
Date: Thu, 09 Jun 2016 12:19:31 -0700
Message-ID: <xmqqy46egofw.fsf@gitster.mtv.corp.google.com>
References: <20160609190637.21177-1-sbeller@google.com>
	<20160609190637.21177-2-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:19:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5UT-0002AD-QL
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbcFITTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:19:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750772AbcFITTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:19:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B21722DAE;
	Thu,  9 Jun 2016 15:19:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PZy39UB0LOytivjIHB08zUI1cO0=; b=NGQkog
	U4kz1AQDvS3/W6zp45gvnA2yn7WoIhrwrv3YMQBGldJYoaBQ4mYMJSs8o7864ebm
	RBpdUgXuKM6vIuO4x2OzbWNWax6woddoWhqRTe3PjqM4GzLDgprBMKJpPx7HVI30
	HlRCuktZnHY5v5ifW0PvS7lkhRAYfKNLhTviY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHyXRMY56wQJihDq2BkdByhHj5CryOW1
	LLCxP8Tx32+phWRXvDSkQPw1sQk/rvqkwCuZGEtWShDwZjEyEEcl+LsOUmxcMagO
	6NgmN+4TAcMiBOdKSdeoOvE23kfKgOnI+zNKmEm6R/WxhcNDHws+mcNljmFZGdrb
	LlewHmwrkCA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5398922DAD;
	Thu,  9 Jun 2016 15:19:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C978B22DAB;
	Thu,  9 Jun 2016 15:19:32 -0400 (EDT)
In-Reply-To: <20160609190637.21177-2-sbeller@google.com> (Stefan Beller's
	message of "Thu, 9 Jun 2016 12:06:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 187FB930-2E77-11E6-B7CA-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296918>

Stefan Beller <sbeller@google.com> writes:

> +static int compare_ce(const void *one, const void *two, void *cb_data)
> +{
> +	const struct cache_entry *ce_one = one, *ce_two = two;
> +	return ce_two - ce_one;
> +}

This would work in practice, but I suspect that this is not ANSI-C
kosher; as address comparison for ordering (not equality) is
undefined if two pointers are not pointing into the same array or
into the same struct's fields.

I think we have one or two other instances of such fishy pointer
comparison already in the codebase, so it is not a show-stopper, but
it would be better if this can be avoided and be replaced with
something that I do not have to raise eyebrows at ;-)
