Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FE520705
	for <e@80x24.org>; Thu,  7 Jul 2016 22:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbcGGWUB (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 18:20:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751926AbcGGWUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 18:20:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87BE92A0F0;
	Thu,  7 Jul 2016 18:19:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fUkmPfsMOiXP6EzfCbLs8xqrZuU=; b=qhsfAU
	Bbv0g+nZxevsfVc+H/v6beAGSOmRA1zH1viwy9YZqE+hZaGsXokVwMJyi72b+tVe
	fU6WrNId/Ej95FenYom7wyeWIn5emuXppVfriOAXP6V+ohazkp7vh0r39rh7v3RK
	qnhbtG6ynraiOISnmYhhA228Diev4A4MkJGOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B3YB0r9CLY0YnEq05HgCkPQOrh632IOV
	hjwdn3MhhfQ3IWGR9Vd12ovhiqkV0YrgeNqhLtPiOXDPwHRCzwZt295sISLB8CPf
	FJIjI3A9XdmRVvHACeYpNJaULRdmrD6KBVYPqB09w6RTUvH6xHrvRHIAloNMARmU
	cMtFBv2XGtc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 800562A0EF;
	Thu,  7 Jul 2016 18:19:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1854D2A0EE;
	Thu,  7 Jul 2016 18:19:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
	<xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 07 Jul 2016 15:19:56 -0700
In-Reply-To: <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Jul 2016 11:43:31 -0700")
Message-ID: <xmqqd1mpnl9v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F06E156A-4490-11E6-8310-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am however not convinced passing the full SHA-1 is a good
> solution.  The make_cache_entry() function may be creating a cache
> entry to stuff in a non-default index (i.e. not "the_index"), but
> its caller does not have a way to tell it which index the resulting
> cache entry will go, and calls refresh_cache_entry(), which always
> assumes that the caller is interested in "the_index", so what
> add_cacheinfo() does by calling make_cache_entry() feels wrong in
> the first place.  Also, the call from update_file_flags() knows that
> the working tree is in sync with the resulting cache entry.
>
> Perhaps update_file_flags() should not even call add_cacheinfo()
> there in the first place?  I wonder if it should just call
> add_file_to_index()---after all, even though the current code
> already knows that 99b633 _is_ the result it wants in the index, it
> still goes to the filesystem and rehashes.
>
> I dunno.  I really do not like that extra sha1 argument added all
> over the callchain by this patch.

While the above still stands (i.e. I really want to see us find a
solution without the extra argument all over), I do not think
add_file_to_index() would work well here, as the stage #2 of the
index is contaminated with CRLF in this case, and getting rid of it
is the whole point of renormalization, I would think.  Of course,
you will get a normalized result if you merged in the other
direction, as your stage #2 would have normalized 99b633 when you
cleanly merge the CRLF version from the other side with
renormalization, and "git add" of the cleanly merged result would
keep the normalized version.

Perhaps that is an acceptable downside.  If your side is not
normalized, and if the merge result is the same as what you already
have, perhaps you deserve to keep that unnormalized result, and
you'd be better off normalizing your tree before doing a merge, if
you do not like the fact that your indexed blobs have CRLF.

> Or did you mean other calls to add_cacheinfo()?
