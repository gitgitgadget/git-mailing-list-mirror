Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE55C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7FA2072A
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="idtgTfog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCCWsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:48:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50640 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgCCWsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:48:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67A1E438A5;
        Tue,  3 Mar 2020 17:48:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJq6wwwvbPxVyt4dtWfFmGqmxrQ=; b=idtgTf
        ogWbZ94Vi5XNNw8BNVzhB4hdIO++mDGttMBvna568TKnZwbqeQwmgc77PaIU9e4S
        qhv+l6fYUdI9WEGI5q5nzHEqrRsTWL5yidpxW1cJ8EawNQ26WtZkDCbYT+N+eb3X
        RnJ+lWU4hsWHgPR8Q5tK/hnE2EszA6rCjjvfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VjJs5NaMCg9ZMtOAX8Du9er1qwxMUXMb
        x1Y55KyugcjNfog3CiK8joVd+HNIvCWtTjYDcgebYWrLvc2MTaHsGX8dhBV9cpOT
        SMLExDYZTqKTTt+pj//xDOXnqxh/m+PjKEAIsQCV8N0JCYnkywCNe7La42ectaA3
        5i48yYM2eog=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 600EC438A4;
        Tue,  3 Mar 2020 17:48:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C91DE438A3;
        Tue,  3 Mar 2020 17:48:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] remote.c: fix handling of %(push:remoteref)
References: <20200302133217.GA1176622@coredump.intra.peff.net>
        <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
        <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
        <xmqqtv358fkk.fsf@gitster-ct.c.googlers.com>
        <20200303222423.wfbjuuwp3263qesv@doriath>
Date:   Tue, 03 Mar 2020 14:48:49 -0800
In-Reply-To: <20200303222423.wfbjuuwp3263qesv@doriath> (Damien Robert's
        message of "Tue, 3 Mar 2020 23:24:23 +0100")
Message-ID: <xmqq5zfl6omm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26AFA832-5DA1-11EA-A8F0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

>> By the way, I have a bit higher-level question.  
>> 
>> All of the above logic that decides what should happen in "git push"
>> MUST have existing code we already use to implement "git push", no?
>
> Yes.
>
>> Why do we need to reinvent it here, instead of reusing the existing
>> code?  Is it because the interface into the functions that implement
>> the existing logic is very different from what this function wants?
>
> Mostly yes. The logic of git push is to massage the refspecs directly, for
> instance:
> 	case PUSH_DEFAULT_MATCHING:
> 		refspec_append(&rs, ":");
> 	case PUSH_DEFAULT_CURRENT:
> 		...
> 		strbuf_addf(&refspec, "%s:%s", branch->refname, branch->refname);
> 	case PUSH_DEFAULT_UPSTREAM:
> 		...
> 		strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);
>
> And the error messages are also not the same, and to give a good error
> message we need to parse the different cases.
>
> It may be possible to refactorize all this, but not in an obvious way and
> it would be a lot more work than this patch series.

Yeah, in light of the analysis I agree it makes sense to take the
approach of these two patches, at least for now.

Thanks.
