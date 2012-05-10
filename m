From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] apply: fall back on three-way merge
Date: Thu, 10 May 2012 08:10:58 -0700
Message-ID: <7v4nrooyv1.fsf@alter.siamese.dyndns.org>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
 <1336629745-22436-7-git-send-email-gitster@pobox.com>
 <vpqy5p0bioh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 10 17:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSV1M-0002KP-2F
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759930Ab2EJPLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:11:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759924Ab2EJPLC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:11:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0F38D5F;
	Thu, 10 May 2012 11:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1enqNT0w/gv5D3uW1fvTyXdOcHE=; b=PLx9Go
	DeDhDfKPp4T+UZg2xIRc93A3RzTIo7fIfuRGzCnU1e6iarOfcCR9f3yGt53WGJcE
	R4kp9g1I9Ofb+rLU1Bo3lmiv0C4DZEqmm2p+Zn60+oUP4l8QZLWIz3BGDghBs6xS
	sHYk9tb0682IDJhZou+RDWAqba5OhmZLJ151Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L5gX6oy/S4v/1z7+mt0CmeCIrCI+uvjQ
	5aKy4HMiSDyMzKvn7Ps090fiBVG4IQoNAt3wA1pxuAi+/jYssosp/QW7bDQx4sJy
	0yWi0IAHi1FM9FxjzuFFQZsE75eX4InfpW5t/HH5OmIpKUJR3p/aD0Ay9TwARmir
	zlUBzj8fmv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 916358D5E;
	Thu, 10 May 2012 11:11:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BC328D5A; Thu, 10 May 2012
 11:10:59 -0400 (EDT)
In-Reply-To: <vpqy5p0bioh.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 10 May 2012 09:26:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59E21272-9AB2-11E1-80EF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197577>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +	/* Preimage the patch was prepared for */
>> +	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
>> +	    read_blob_object(&buf, pre_sha1, patch->old_mode))
>> +		return error("repository lacks necessary blobs to fall back on 3-way merge.");
>
> What happens if there are multiple objects for the same pre_sha1?

We probably would not get anythning out of get_sha1() due to ambiguity and
we would punt.

We could inroduce get_all_possible_sha1_among_ambigous_ones() to grab an
array, try to apply and use the first one, but I do not know if it is
really worth the effort. The usefulness of -3 is limited to only two cases
in practice, and neither case gives you a big chance of seeing such a
collision.  Either you are applying a patch from others that was based on
something you shared with them in the past, hence it is very likely that
you and they shared a very similar set of objects that determined the
length of the abbreviated object name shown on the "index" line, in which
case the chance of ambiguity is not that great, or you are using the diff
to apply pipeline in a workflow similar to the ones I recently described
in messages in another thread, in which case the patch is taken from your
own repository and the length of the abbreviated object name shown on the
"index" line is determined not to be ambiguous in the first place.

If we happened to grab totally unrelated pre_sha1, the patch won't apply,
and we would not cause any damage.

An interesting point that is worth noting is that if we happened to grab a
pre_sha1 that is different from what the original patch was based on, it
does not introduce a mis-apply risk, either.  We only fall back to the
merge after making sure the patch applies to the "original" (which may not
be exactly what the patch was based on), which ensures that the preimage
shown in the hunks of the patch match.  Because the application of the
patch to the "original" found will by definition only modify the part that
is shown in the hunks of the patch, any difference between the preimage
we find and the true preimage the patch was based on will cancel out in
the three-way merge step.
