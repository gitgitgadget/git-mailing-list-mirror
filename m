Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6791F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbcHXRFR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:05:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753808AbcHXRFR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FD2836881;
        Wed, 24 Aug 2016 13:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lai2D09C8d59DJoGkIzg3am9kO8=; b=xIYGrB
        d6Wcz9GfZysaZJGshongeBQBugtwHuvLV8lD1dr/ANL3hxp+AqP2k1/PW1MiW/2b
        i+eCcDigMUEEf5iaEKDxU0bT5gwMmkUSKJLVDCEMsEpZkbKPW1HyftSVSrUHU3YI
        QLvPC2gDlhI10HRcsiSN2zonYKIxdorjpat8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m481EFfN11zeJ0TQadhB9ddiDbYUaKcI
        MoG8NZbXzTjKy1EvRF1QJrC+1ZC6xhlDjzWRVaqsoN0iQiQpfgkEj0sOwNPCxX7N
        sxV1RhKv4jFrcTvR9ACSWoD8o58W2UBjqxkMTELktdc96cE0K3/eBI/aTiySK3dY
        9c7UCQeubs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D9E636880;
        Wed, 24 Aug 2016 13:02:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B729D3687E;
        Wed, 24 Aug 2016 13:02:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree version
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <xmqqk2f6rvx9.fsf@gitster.mtv.corp.google.com>
        <20160824161939.d2h4qlaxhhi6limm@sigill.intra.peff.net>
Date:   Wed, 24 Aug 2016 10:02:39 -0700
In-Reply-To: <20160824161939.d2h4qlaxhhi6limm@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 24 Aug 2016 12:19:40 -0400")
Message-ID: <xmqqr39eqevk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91B5F3D8-6A1C-11E6-9A65-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 24, 2016 at 09:09:06AM -0700, Junio C Hamano wrote:
>
>> >  +	if (!path)
>> >  +		path = obj_context.path;
>> >  +	else if (obj_context.mode == S_IFINVALID)
>> >  +		obj_context.mode = 0100644;
>> >  +
>> >   	buf = NULL;
>> >   	switch (opt) {
>> >   	case 't':
>> 
>> The above two hunks make all the difference in the ease of reading
>> the remainder of the function.  Very good.
>
> Yeah, I agree. Though it took me a moment to figure out why we were
> setting obj_context.mode but not obj_context.path; the reason is that
> "mode" is convenient to use as local storage, but "path" is not, because
> it is not a pointer but an array.

Wait a minute.  Why is it a cascaded if/elseif, not two independent
if statements that gives a default value?  In other words, wouldn't
these two independent and orthogonal decisions?

 * When forced to use some path, we ignore obj_context.path

 * Whether we are forced to use a path or not, if we do not know the
   mode from the lookup context, we want to use the regular blob
   mode.

So that part of the patch is wrong after all, I would have to say.

	if (!path)
        	path = obj_context.path;
	if (obj_context.mode == S_IFINVALID)
        	obj_context.mode = 0100644;

or something like that, perhaps.

> So it would have been a little clearer to me as:
>
>   const char *path;
>   unsigned mode;
>   ...
>   if (!force_path) {
> 	/* use file info from sha1 lookup */
> 	path = obj_context.path;
> 	mode = obj_context.mode;
>   } else {
> 	/* use path requested by user, and assume it is a regular file */
> 	path = force_path;
> 	mode = 0100644;
>   }

Hmph, if you read it that way, then if/elseif makes some sense, but
we need to assume that the obj_context.mode can be garbage and have
a fallback for it.

Just like

	git cat-file --filters --path=git.c HEAD:t

would error out because HEAD:t is not even a blob, I would expect

	git cat-file --filters --path=git.c :RelNotes

to error out, because the object itself _is_ known to be a
blob that is not a regular file.

And that kind of type checking will not be possible with "if the
user gave us a path, assume it is a regular file".
