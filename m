From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
Date: Tue, 12 Jan 2016 10:11:31 -0800
Message-ID: <xmqq4meivfak.fsf@gitster.mtv.corp.google.com>
References: <20160111154651.GA25338@sigill.intra.peff.net>
	<20160111155239.GB22778@sigill.intra.peff.net>
	<5694873D.5000001@alum.mit.edu>
	<20160112095257.GB9855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:11:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3Px-0004uD-4J
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759521AbcALSLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:11:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753634AbcALSLf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:11:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C112D39520;
	Tue, 12 Jan 2016 13:11:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f0PLUV9whzrfQDe/K+jHBXEAQbY=; b=Nu7Nph
	oF/TYpjumoe2nktF6Dl1DWBrT7wv+hlpX06OK3dQeBXpY1wWzjhjOpRyjZCtYXFV
	jKtVGj2gDrgOfKL0ZJqSZtaBBtSegW2pN+bT9TXjxvu1ZMQkqODFv+DYgHMXGAtb
	aRJ8sAIB+wcA/zdRxsH/G97E8o4AuFyT3wxgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yRm/xKopRwo6j+wgIHRX3B1qTyEguYlB
	xDhFl2TInLYcOmPW1wNEot6ehvnplwNTj3APrmKHM1mVENVMFOYFB3LEDR+m1KDR
	J/m5401rfmNuuLg0bS0HS8FkItTcqn9XqnVqWtQemkqv6kSiw7MG9xtog2ogbq+Q
	rAYZUfQP32o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFD163951F;
	Tue, 12 Jan 2016 13:11:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 292BB3951E;
	Tue, 12 Jan 2016 13:11:33 -0500 (EST)
In-Reply-To: <20160112095257.GB9855@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jan 2016 04:52:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E948DE88-B957-11E5-B48F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283830>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 12, 2016 at 05:55:25AM +0100, Michael Haggerty wrote:
>
>> On 01/11/2016 04:52 PM, Jeff King wrote:
>> > We sometimes call lock_ref_sha1_basic both with REF_NODEREF
>> > to operate directly on a symbolic ref.
>> 
>> ^^^ This sentence seems to be missing some words.
>
> I think it has one too many. :)
>
> It was originally "both with a regular ref and with a symref", but I
> shortened it since we only care about the symref case. I think just
> getting rid of "both" is the right thing.

Thanks, I did notice this and wondered the same while reviewing, but
totally forgot about it when I queued X-<.

>> > diff --git a/refs/files-backend.c b/refs/files-backend.c
>> > index 180c837..ea67d82 100644
>> > --- a/refs/files-backend.c
>> > +++ b/refs/files-backend.c
>> > @@ -1901,6 +1901,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>> >  
>> >  	refname = resolve_ref_unsafe(refname, resolve_flags,
>> >  				     lock->old_oid.hash, &type);
>> > +	if (!refname && (flags & REF_NODEREF))
>> > +		refname = resolve_ref_unsafe(orig_refname,
>> > +					     resolve_flags | RESOLVE_REF_NO_RECURSE,
>> > +					     lock->old_oid.hash, &type);
>> > [...]
>> 
>> The main risk for this change would be that this new recovery code
>> allows the function to continue, but one of the outputs of the second
>> function invocation is not correct for the code that follows. Let me
>> think out loud:
>> 
>> * refname -- now will be equal to orig_refname. I think the main effect
>> is that it will be passed to verify_refname_available_dir(). This seems
>> to be what we want.
>> 
>> * type -- now reflects orig_refname; i.e., usually REF_ISSYMREF. This
>> also seems correct.
>> 
>> * lock->old_oid.hash -- is now ZEROS. This might get compared to the
>> caller's old_sha1 in verify_lock(), and it will also be written to the
>> reflog as the "old" value. I think this is also what we want.
>> 
>> So this change looks good to me.
>
> Thanks. I had a nagging feeling that I hadn't considered all cases, but
> the way you've framed it makes sense to me.

Sounds good.  Thanks, both.
