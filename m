From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Wed, 14 Dec 2011 09:54:33 -0800
Message-ID: <7vhb13qbs6.fsf@alter.siamese.dyndns.org>
References: <4EDBF4D5.6030908@pcharlan.com>
 <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EE8782A.9040507@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 18:54:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rat2Q-0003Y0-US
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 18:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab1LNRyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 12:54:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466Ab1LNRyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 12:54:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9809045A5;
	Wed, 14 Dec 2011 12:54:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tdQhsdKXQkRFv3ZJsWL2kMIn/mw=; b=Y1ep/q
	wP0+v/gReuqwk4BEATEwbBoI9leLBCAZymn+mY3bReG8FXgqZPhd4qY3DokCSLCz
	IL9rJkcjioy7zCR4nylMYccmViuml1+9t/WTRLZm6iq1rPkeIHRUWjecoh06tPWL
	094V2hmFHdvmFpNkFr1blmOH3sjOQOF0h/t9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qo9FwghLN70WJgORqVW46EoVHEQXbrPa
	OPz6zp0YGk5rDGJ15QeDGn4Yxw6pufJBJDQYcCQuCTkgIc/R6LkooDTpKGR3O8o0
	TgV6O8ZEEtaEEDN7ncTOEVCUnpA2jbOc4y2iSdRFjaUAejgt8ie5a633Rtgb8/Cn
	23Gw3gUUqOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EE1E45A4;
	Wed, 14 Dec 2011 12:54:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C2E845A2; Wed, 14 Dec 2011
 12:54:34 -0500 (EST)
In-Reply-To: <4EE8782A.9040507@elegosoft.com> (Michael Schubert's message of
 "Wed, 14 Dec 2011 11:19:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEF043CE-267C-11E1-8F85-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187157>

Michael Schubert <mschub@elegosoft.com> writes:

>> ...
>> +	memset(threeway, 0, sizeof(threeway));
>> +	while (pos < active_nr) {
>> +		int stage;
>> +		stage = ce_stage(ce);
>> +		if (!stage || strcmp(path, ce->name))
>> +			break;
>> +		hashcpy(threeway[stage - 1], ce->sha1);
>> +		if (stage == 2)
>> +			mode = create_ce_mode(ce->ce_mode);
>> +		pos++;
>> +		ce = active_cache[pos];
>> +	}
>> +	if (is_null_sha1(threeway[1]) || is_null_sha1(threeway[2]))
>> +		return error(_("path '%s' does not have necessary versions"), path);
>> ...
>> +	ce = make_cache_entry(mode, sha1, path, 2, 0);
>>  	if (!ce)
>>  		die(_("make_cache_entry failed for path '%s'"), path);
>>  	status = checkout_entry(ce, state, NULL);
>
> gcc 4.6.2:
>
> builtin/checkout.c: In function ‘cmd_checkout’:
> builtin/checkout.c:210:5: warning: ‘mode’ may be used uninitialized in this function [-Wuninitialized]
> builtin/checkout.c:160:11: note: ‘mode’ was declared here

Isn't this just your gcc being overly cautious (aka "silly")?

The variable "mode" is assigned to when we see an stage #2 entry in the
loop, and we should have updated threeway[1] immediately before doing so.
If threeway[1] is not updated, we would have already returned before using
the variable in make_cache_entry().
