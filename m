Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3737C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 19:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7433C20789
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 19:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iEZoSLpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgITTL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 15:11:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56315 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgITTL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 15:11:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF85C7BABA;
        Sun, 20 Sep 2020 15:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GsgHWYBovUp56IAtVqnN5fjyCMw=; b=iEZoSL
        ptY3LyaZjKq4BFO0hF9VGLt5udaGJ9K1xeVsJtdeexWiLPepitWTeOyowmaptufu
        3reIDBoonurVB4wBZNa5K+EAECotlJRjgjYCbeSxmjYx/wDKXeNGqRcewg2maiE9
        JcT1wpDOj7UMtSL3AfXniBykz7NqPGSoR+7P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q9xXMG3neNCLlb9K2k6f7aHfOQTaVIHV
        L4NWw4Uk0Bgq7eYtSR+R034+RI4lIjBi8Iug1zrlIvqraQ7AtHVKhaUKzl5zs025
        xBpmS4n2QHscjqpZRooZKnDb+cReV5Sk34OuGN4h9VFw6DwdUGLXtiIaP6dcgpjk
        n7gYzxUZC/o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7DE37BAB9;
        Sun, 20 Sep 2020 15:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4261E7BAB7;
        Sun, 20 Sep 2020 15:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca, peff@peff.net
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
References: <20200918113256.8699-2-tguyot@gmail.com>
        <20200920130945.26399-1-tguyot@gmail.com>
        <20200920153915.GB2726066@nand.local>
Date:   Sun, 20 Sep 2020 12:11:20 -0700
In-Reply-To: <20200920153915.GB2726066@nand.local> (Taylor Blau's message of
        "Sun, 20 Sep 2020 11:39:15 -0400")
Message-ID: <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11946916-FB75-11EA-947D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sun, Sep 20, 2020 at 09:09:46AM -0400, Thomas Guyot-Sionnest wrote:
>> In builtin_diffstat(), when both files are coming from "stdin" (which
>> could be better described as the file's content being written directly
>> into the file object), oideq() compares two null hashes and ignores the
>> actual differences for the statistics.
>>
>> This patch checks if is_stdin flag is set on both sides and compare
>> contents directly.
>>
>> Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
>> ---
>> Range-diff:
>> 1:  479c2835fc ! 1:  1f25713d44 diff: Fix modified lines stats with --stat and --numstat
>>     @@ -20,8 +20,12 @@
>>       	}
>>
>>      -	same_contents = oideq(&one->oid, &two->oid);
>>     ++	/* What is_stdin really means is that the file's content is only
>>     ++	 * in the filespec's buffer and its oid is zero. We can't compare
>>     ++	 * oid's if both are null and we can just diff the buffers */
>>      +	if (one->is_stdin && two->is_stdin)
>>     -+		same_contents = !strcmp(one->data, two->data);
>>     ++		same_contents = (one->size == two->size ?
>>     ++			!memcmp(one->data, two->data, one->size) : 0);
>>      +	else
>>      +		same_contents = oideq(&one->oid, &two->oid);
>
> After reading your explanation in [1], this version makes more sense to
> me.

These oid fields are prepared by calling diff_fill_oid_info(), and
even for paths that are dirty (hence no "free" oid available from
index or tree entry), an appropriate oid is computed.

But there are paths for which oid cannot be computed without
destroying their contents.  Such paths are marked by the function
with null_oid.

It happens to be that stdin is the only class of paths that are
treated that way _right_ _now_, but future code may support
different kind of paths that share the same trait.

When we want to know "is comparing the oid sufficient?", we
shouldn't inspect the is_stdin flag ourselves in a caller of
diff_fill_oid_info(), because the helper _is_ responsible for
knowing what kind of paths are special, and signals that "assume
this would not be equal to anything else" by giving null_oid back.

The caller should use the info left by diff_fill_oid_info(), namely,
"even if the oid on both sides are the same, if it is null_oid, then
we know diff_fill_oid_info() didn't actually compute the oid, and we
need to compare the blob ourselves".

And there is no point in doing memcmp() here, I think.  

The same_contents() check is done as an optimization to avoid xdl.
Even if the two sides were thought to be different at the oid level,
xdl comparison may find that there is no difference after all
(e.g. think of whitespace ignoring comparison), so we should assume
and rely on that the downstream code MUST BE prepared to handle
false negatives (i.e. same_contents says they are different, but
they actually produce no diffstat).  Running memcmp() over contents
in potentially a large buffer to find that they are different, and
then have xdl process that large buffer again, would be a waste.

Summarizing the above, I think the second best fix is this (which
means that the posted patch is the third best):

	/*
	 * diff_fill_oid_info() marked one/two->oid with null_oid
	 * for a path whose oid is not available.  Disable early
	 * return optimization for them.
	 */
	if (oideq(&one->oid, &null_oid) || oideq(&two->oid, &null_oid))
		same_contents = 0; /* could be different */
	else if (oideq(&one->oid, &two->oid))
		same_contents = 1; /* definitely the same */
	else
		same_contents = 0; /* definitely different */

But I suspect that the best fix is to teach diff_fill_oid_info() to
hash the in-memory data to compute the oid, instead of punting and
filling the oid field with null_oid.  If function builtin_diffstat()
is allowed to look at the contents and run memcmp() here, the 'data'
field should have been filled and valid when diff_fill_oid_info()
looked at it already.

The "best" fix will have wider consequences, so we may not want to
jump to it right away without careful consideration.

For example, the "best" fix will fix another bug.  The 'index'
header shows a NULL object name in normal "diff --patch" output for
these paths in the current code, which means they cannot be used
with "apply --3way".  That way, this codepath does not have to know
anything about the "null means we don't know" convention.  

Try:

    $ (cat COPYING; echo) >RENAMING
    $ git diff --no-index COPYING - <RENAMING | grep '^index '
    index 536e55524d..0000000000 100644

and notice that the stdin side has a null object name in the current
code.  I think we will show the right object name if we fix the
diff_fill_oid_info().

Thanks.


