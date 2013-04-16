From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/33] refs: extract a function peel_entry()
Date: Tue, 16 Apr 2013 10:55:16 -0700
Message-ID: <7vhaj6mkcb.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-15-git-send-email-mhagger@alum.mit.edu>
 <7v38urwv6o.fsf@alter.siamese.dyndns.org> <516D4D1F.5010207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USA6G-0002XM-MH
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079Ab3DPRzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:55:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935536Ab3DPRzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9C0616B62;
	Tue, 16 Apr 2013 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aZJJL1HavzA67CPlpcyrGcPUBC8=; b=EFTvJj
	ujHt7xJxOfiynun4zDwcZTu8b3ghehG4J2L6ufS28VyRIW4JuoCu2LfhX2oYGcCe
	w4OAIciIV47xJ5nsj4IP9RaQwqZlzS0sQsaGioPpMXH42Gim2hUEDt/N6sWZ4eA4
	LGSIm0HnrKGk6/CVCtyZg2sRHSlwXNsXznOdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=riO2yPpct851kG5RNJlVd2TmatNmNBXF
	z/TwuFPvr5YCT1cuJJe30+ncDFMzhLvGlg/4K5Bp591g5ipRfX5merL2azjJhUgP
	Hip58s6uCC2vN3ThfxpzSaejwi+h//VNDBMEFOgS+CzwSHIxbstoLsuuTp6JVNU8
	ZJIQHzmHGx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C10D916B61;
	Tue, 16 Apr 2013 17:55:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8F1116B60; Tue, 16 Apr
 2013 17:55:17 +0000 (UTC)
In-Reply-To: <516D4D1F.5010207@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 16 Apr 2013 15:07:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC827240-A6BE-11E2-A23A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221437>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/15/2013 07:38 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>>  	if (read_ref_full(refname, base, 1, &flag))
>>>  		return -1;
>>>  
>>> -	if ((flag & REF_ISPACKED)) {
>>> +	/*
>>> +	 * If the reference is packed, read its ref_entry from the
>>> +	 * cache in the hope that we already know its peeled value.
>>> +	 * We only try this optimization on packed references because
>>> +	 * (a) forcing the filling of the loose reference cache could
>>> +	 * be expensive and (b) loose references anyway usually do not
>>> +	 * have REF_KNOWS_PEELED.
>>> +	 */
>>> +	if (flag & REF_ISPACKED) {
>>>  		struct ref_entry *r = get_packed_ref(refname);
>> 
>> This code makes the reader wonder what happens when a new loose ref
>> masks a stale packed ref, but the worry is unfounded because the
>> read_ref_full() wouldn't have gave us REF_ISPACKED in the flag in
>> such a case.
>> 
>> But somehow the calling sequence looks like such a mistake waiting
>> to happen.  It would be much more clear if a function that returns a
>> "struct ref_entry *" is used instead of read_ref_full() above, and
>> we checked (r->flag & REF_ISPACKED) in the conditional, without a
>> separate get_packed_ref(refname).
>
> As I'm sure you realize, I didn't change the code that you are referring
> to; I just added a comment.

Yes.

> But yes, I sympathize with your complaint.  Additionally, the code has
> the drawback that get_packed_ref() is called twice: once in
> read_ref_full() and again in the if block here.  Unfortunately, this
> isn't so easy to fix because read_ref_full() doesn't use the loose
> reference cache, so the reference that it returns might not even have a
> ref_entry associated with it (specifically, unless the returned flag
> value has REF_ISPACKED set).  So there are a couple options:
>
> * Always read loose references through the cache; that way there would
> always be a ref_entry in which the return value could be presented.
> This would not be a good idea at the moment because the loose reference
> cache is populated one directory at a time, and reading a whole
> directory of loose references could be expensive.  So before
> implementing this, it would be advisable to change the code to populate
> the loose reference cache more selectively when single loose references
> are needed.  -> This approach would be well beyond the scope of this
> patch series.
>
> * Implement a function like read_ref_full() with an additional (struct
> ref_entry **entry) argument that is written to *in the case* that the
> reference that was returned has a ref_entry associated with it, and NULL
> otherwise.  This would have to be an internal function because we don't
> want to expose the ref_entry structure outside of refs.c.
> read_ref_full() would be implemented on top of the new function.

Isn't there another?

Instead of using read_ref_full() at this callsite, can it call a
function, given a refname, returns a pointer to "struct ref_entry",
using the proper "a loose ref covers the packed ref with the same
name" semantics?

I guess that may need the same machinery for your first option to
implement it efficiently; right now read_ref_full() goes directly to
the single file that would hold the named ref without scanning and
populating sibling refs in the in-core loose ref hierarchy, and
without doing so you cannot return a struct ref_entry.  Hmm...
