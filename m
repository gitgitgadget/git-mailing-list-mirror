Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76DC433E6
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE80A64E0F
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhA2WFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:05:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55786 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhA2WFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:05:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B525104C75;
        Fri, 29 Jan 2021 17:04:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CSqXqzC4miqpyXL6GlQIpmLkfEw=; b=sMIyNw
        TZOSDXfpGhmWsvAEWmYuKrj3m70Y2KNFPVkjHyaN+Cq+6+HugcNtuM5FTStkPxXu
        SbxD2gl5N50gm4b8GyfiD9brTDGo6Mwyb3ZN0RW3vnQ42YEKco8K1su9sFcoB72X
        LO1sys/nicioXRc4Foukg6UW42SfdV3F+jKAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GA3LYXVK+2PBDsHwUyAaIC7KMBDvNT0K
        uMY/4aVJWIwEPvJoeqdP2Tv93J9Ngj9VmFegMipQ0w+UpuRyaVGeaOJfoQsg/wEM
        PQpuPYDcOlOIeSK8v95PAoOHy13C55pdlJuF867uP1jQYGqfONQ79X5zRSNGjsly
        dgPPJA+6rLs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33FB8104C74;
        Fri, 29 Jan 2021 17:04:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C3E0104C73;
        Fri, 29 Jan 2021 17:04:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
References: <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
        <20210129202306.723272-1-jonathantanmy@google.com>
Date:   Fri, 29 Jan 2021 14:04:18 -0800
In-Reply-To: <20210129202306.723272-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 29 Jan 2021 12:23:06 -0800")
Message-ID: <xmqqtuqzs8m5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F032BFE6-627D-11EB-9082-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I think the use of &&-cascade is iffy here.  Even when we are *not*
>> accepting request for unborn, we should still parse it as such.
>> This does not matter in today's code, but it is a basic courtesy for
>> future developers who may add more "else if" after it.
>> 
>> IOW
>> 
>> 		else if (!strcmp("unborn", arg)) {
>> 			if (!data.allow_unborn)
>> 				; /* we are not accepting the request */
>> 			else
>> 				data.unborn = 1;
>> 		}
>> 
>> I wrote the above in longhand only for documentation purposes; in
>> practice, 
>> 
>> 		else if (!strcmp("unborn", arg))
>>                 	data.unborn = data.allow_unborn;
>> 
>> may suffice.
>
> My thinking was (and is) that falling through in the case of a
> disallowed argument (as opposed to a completely unrecognized argument)
> makes it more straightforward later if we ever decide to tighten
> validation of the ls-refs request - we would only have to put some code
> at the end that reports back to the user.

Sorry, I do not quite follow.  If "unborn" is conditionally allowed,
you can extend what I suggested above like so:

	if (we see we got an unborn request) {
-		if (allowed)
+		if (partially allowed)
+			record that we got unborn request and will
+			partially respond to it
+		else if (allowed)
			record that we got unborn request;
+		else
+			report that we don't accept unborn request;
	}

This will matter even more if you write more else-if.  The
downstream of else-if clauses are forced to interpret (and fail)
"unborn" request they are not interested in.

>> >  	if (request->status != PACKET_READ_FLUSH)
>> >  		die(_("expected flush after ls-refs arguments"));
>> >  
>> > -	head_ref_namespaced(send_ref, &data);
>> > +	send_possibly_unborn_head(&data);
>> >  	for_each_namespaced_ref(send_ref, &data);
>> 
>> And here is another caller of send_ref().  Are we sure that
>> send_ref()'s expectation is satisfied by this caller when the
>> iteration encounters a broken ref (e.g. refs/heads/broken not a
>> symref but names an object that does not exist and get_sha1()
>> yielding 0{40}), or a dangling symref (e.g. refs/remotes/origin/HEAD
>> pointing at something that does not exist)?
>
> I assume that by "this caller" you mean for_each_namespaced_ref(), since
> you mention an iteration. I believe so - send_ref has been changed to
> tolerate a NULL (as in (void*)0, not 0{40}) oid, and that is the only
> change, so if it worked previously, it should still work now.

So a dangling symref, e.g. "refs/remotes/origin/HEAD -> trunk" when
no "refs/remotes/origin/trunk" exists, is not reported to send_ref()
in the same way as an unborn "HEAD"?  I would have expected that we'd
report where it points at, and for that to work, you'd have to use
not just the vanilla send_ref() as the callback, but something that
knows how to do "are we expected to send unborn symrefs" logic, like
send_possibly_unborn_head does.

That "changed to tolerate ... should work" worries me.

If "for_each_namespaced_ref(send_ref, &data)" will never call send_ref()
with NULL (as in (void *)0) oid, then that would be OK, but if it
ends up calling with NULL somehow, it is responsible to ensure that
data->symrefs is true and flag has REF_ISSYMREF set, or send_ref()
would misbehave, (see the first part of your message, which I am
responding to), no?
