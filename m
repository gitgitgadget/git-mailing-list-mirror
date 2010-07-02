From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Fri, 02 Jul 2010 10:25:18 -0700
Message-ID: <7vmxu923up.fsf@alter.siamese.dyndns.org>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
 <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net>
 <7v1vbn417d.fsf@alter.siamese.dyndns.org> <4C2D7DF7.8030408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 02 19:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUjze-00038T-BK
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 19:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380Ab0GBRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 13:25:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401Ab0GBRZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 13:25:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF329C061C;
	Fri,  2 Jul 2010 13:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sSvgX8vD6xB9x3SUjltbVGDzPZI=; b=UF4cSA
	LTJGoBL2uLfpZkPirW2l4YZt0wN3Lr/6X2FHeKkfHnN9NCXQhZjWnTA/J8UUEm8m
	7NVxMqLecUm0955atdehAxTOgaE2QY7iKS3I8mE0rzOA3rTVXKDftCGYOx2wjLZ+
	b2Qqv8cterj+KU6FI6+pTbCM3izbl/QAF8cYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JzT2NuCHhLb3oI20nxHOEaeectYU4PSz
	0wS3lMtmj0DOVJB3ugFdEmcroqQsBnWv06u/gEcC3kLE77NBVfhdRplNTue5RkXX
	/mS9TEqhXuyB5Plaie5cGR5mg7zatPdZz6+wiWHT453FAb3wjPh3FhPagtO+0TSG
	l0DAqCqMRxs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C731C0618;
	Fri,  2 Jul 2010 13:25:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADCB5C0616; Fri,  2 Jul
 2010 13:25:20 -0400 (EDT)
In-Reply-To: <4C2D7DF7.8030408@viscovery.net> (Johannes Sixt's message of
 "Fri\, 02 Jul 2010 07\:49\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC9305BC-85FE-11DF-B947-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150142>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/1/2010 18:27, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Would it be possible to update the timestamp of preimage every time it is
>>> used (e.g., in rerere.c:merge()), and check for that?
>> 
>> It would be _possible_, but we are _not_ modifying the file at that point,
>> so somehow that solution feels very wrong, no?
>
> rr-cache is basically a static database. The fact that we have a file
> named 'thisimage' is just an abuse - to put a temporary file somewhere.
> Therefore, depending on lockfile infrastructure to change timestamps for
> us while manipulating 'thisimage' should feel no less wrong, don't you
> think so?

Not really.  

"This" in "thisimage" stands for "image involved in conflict we are
looking at _this moment_", and using the per-conflict-id directory to
house that file was a conscious design decision.  Because you are trying
to record a new data item (namely "the last time we saw this conflict")
somewhere in the rr-cache database, using the timestamp of that directory
to tell when was the last time that _this moment_ was makes sense, at
least to me.

If anything, "preimage" that has newer timestamp than "postimage" feels
wrong, as you would record pre, think for a while how the corresponding
post should look like, and then record post.

If we for whatever reason trust placing an extra timestamp on a regular
file more than using directory timestamp (which I think may be a valid
concern from portability point of view), I'd rather see "preimage"
timestamp to keep track of the time when we _first_ encountered the
particular conflict, and "postimage" used for recording the time when we
saw the conflict most recently.
