From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Wed, 20 Aug 2014 12:38:31 -0700
Message-ID: <xmqqr40bt0i0.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-17-git-send-email-gitster@pobox.com>
	<1408553797.26173.3.camel@leckie>
	<CAPc5daXLBQdjPaWNxmwZqStiWu8qHRfDG6=JS=bhbzA+c5Ww5g@mail.gmail.com>
	<1408557408.1282.5.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:38:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKBia-000521-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 21:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaHTTio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 15:38:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61678 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbaHTTin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 15:38:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FB6830D80;
	Wed, 20 Aug 2014 15:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p1mnnQfLS8Z8xt/RNPsL/j/rgHo=; b=H3xmE9
	B+3gKm+V6q/7n1nHOE+rkII8j6Louj43GbDOAq+IQzvUFtw3wneeT0f3W/SDWImT
	ws/KnpUollgsIdGyJoPVmFV22SPVthFEcvJbzc2NQfBEr7FeNBd/i9dsFcmS/EfE
	BmSsNOlN0IutRPD2wIxp1aGwJkIVXF0O5enic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wiTOtYbfMZGZBkrO5F9trpDFxM18KL66
	Cm5hcYXT8miKJwgO195am6J/2sIz/axsKfUH1sXvsuE1w36+LZKC4+1Z0sl3vQSh
	uUMZ+j9xjaMoJnSn0T0Ff4aKNviK/l2vfr8Hor+rSXn5RtD2EXLp+hrVGGMCac76
	JHkpwcjgGlE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1478030D7F;
	Wed, 20 Aug 2014 15:38:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5029130D64;
	Wed, 20 Aug 2014 15:38:33 -0400 (EDT)
In-Reply-To: <1408557408.1282.5.camel@leckie> (David Turner's message of "Wed,
	20 Aug 2014 13:56:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9210E126-28A1-11E4-BED1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255582>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2014-08-20 at 10:29 -0700, Junio C Hamano wrote:
>> On Wed, Aug 20, 2014 at 9:56 AM, David Turner <dturner@twopensource.com> wrote:
>> > On Tue, 2014-08-19 at 15:06 -0700, Junio C Hamano wrote:
>> >> Reusing the GPG signature check helpers we already have, verify
>> >> the signature in receive-pack and give the results to the hooks
>> >> via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.
>> >>
>> >> Policy decisions, such as accepting or rejecting a good signature by
>> >> a key that is not fully trusted, is left to the hook and kept
>> >> outside of the core.
>> >
>> > If I understand correctly, the hook does not have enough information to
>> > make this decision, because it is missing the date from the signature.
>> 
>> The full certificate is available to the hook so anything we can do the hook
>> has enough information to do ;-)  But of course we should try to make it
>> easier for the hook to validate the request.
>
> Excellent, then motivated hooks can do the right thing.
>
>> > This might allow an old signed push to be replayed, moving the head of a
>> > branch to an older state (say, one lacking the latest security updates).
>> 
>> ... with old-sha1 recorded in the certificate?
>
> That does prevent most replays, but it does not prevent resurrection of
> a deleted branch by a replay of its initial creation (nor an undo of a
> force-push to rollback).  So I think we still need timestamps, but
> parsing them out of the cert is not terrible.

As I aleady mentioned elsewhere, a more problematic thing about the
push certificate as presented in 15/18 is that it does not say
anything about where the push is going.  If you can capture a trial
push to some random test repository I do with my signed push
certificate, you could replay it to my public repository hosted at
a more official site (say, k.org in the far distant future where it
does not rely on ssh authentication to protect their services but
uses the GPG signature on the push certificate to make sure it is I
who is pushing).

We can add a new "pushed-to <repository URL>" header line to the
certificate, next to "pushed-by <ident> <time>", and have the
receiving end verify that it matches to prevent such a replay.  I
wonder if we can further extend it to avoid replays to the same
repository.

Instead of "pushed-to", we can tweak the capability advertisement
sent from the server upon initial contact to advertise not just
"push-cert", but "push-cert=<nonce>", add a new "push-nonce <nonce>"
header to the certificate and then have the receiving end make sure
they are the same.  That way, the receiver can make sure it is not
being fed a certificate used when a different push was done to it or
somebody else and by doing so we do not even need "pushed-to
<repository URL>" header, perhaps?

I am still fuzzy how robust such a scheme be against MITM, though.
One way I can think of to attack the "nonce-only" scheme would be to
create a "you can push anything here" service, convince me to push
garbage there, and when I try to push to it, it can turn around and
act as a client to some high-value site the attacker does not even
control, grab the <nonce>, relay it back to me and advertise the
same <nonce>, have me sign the certificate to push garbage, and
relay that push session to the high-value target.

I am not sure if that is a valid threat model we would care about,
but with "pushed-to <repository URL>" the high-value target site can
notice that I am pushing garbage to the joker site and reject the
certificate.
