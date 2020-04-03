Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2884C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 04:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9176720787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 04:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+v2WVcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgDCE6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:58:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50859 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbgDCE6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 00:58:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DC56550E3;
        Fri,  3 Apr 2020 00:58:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IdxQ89lEToL52YX7XBEw/ZylUNE=; b=H+v2WV
        ccJNdpAs3T4JZC6/CjxqQOiHnfTrRrvUm9J0k7+4aDSRNnRzOWZIc4zSPpPi4OYy
        UHTQUYE/p5uoVm0YgQKCELGest+o30+ytt4GKD1FTpf2/ilxEyqobuq4xqgrzTy0
        kJQ9pBLpytKcxhcXxv0RF8eIRSRG6eW7W8DHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OV0HLzQHQeSVCTDHa82UY2RIUftNxDma
        gB/xYp/Im+xrgSfyBqIEUDCjlTk4A7mKdHXVPUCzc34Dcv9ZU2FG71UAY++J0zSG
        JbFN88bGFfe2Nyc5Q1LFQdWJcfodoqy+9FBHIm3MVeSHrX5QUVM/eGtsaU6/FfeW
        BXLgb55sGVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6B3E550E2;
        Fri,  3 Apr 2020 00:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E150550DD;
        Fri,  3 Apr 2020 00:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/11] bisect--helper: fix `cmd_*()` function switch default return
References: <20200321161020.22817-1-mirucam@gmail.com>
        <20200321161020.22817-2-mirucam@gmail.com>
Date:   Thu, 02 Apr 2020 21:58:01 -0700
In-Reply-To: <20200321161020.22817-2-mirucam@gmail.com> (Miriam Rubio's
        message of "Sat, 21 Mar 2020 17:10:10 +0100")
Message-ID: <xmqqk12x17za.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2710CC0-7567-11EA-A5EA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> In a `cmd_*()` function, return `error()` cannot be used
> because that translates to `-1` and `cmd_*()` functions need
> to return exit codes.
>
> Let's fix switch default return.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c1c40b516d..1f81cff1d8 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -711,7 +711,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		res = bisect_start(&terms, no_checkout, argv, argc);
>  		break;
>  	default:
> -		return error("BUG: unknown subcommand '%d'", cmdmode);
> +		res = error(_("BUG: unknown subcommand."));

The return value from error() is *NOT* taken from "enum
bisect_error"; its value (-1) happens to be the same as
BISECT_FAILED, but that is by accident, and not by design.

So the above code is accident waiting to happen, while

	default:
		error(_("BUG: ..."));
		res = BISECT_FAILED;

would be a lot more correct (by design).

>  	}
>  	free_terms(&terms);

After this part, there is this code:

       if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
                       res = BISECT_OK;

        return abs(res);

This is not a problem with this patch, but the use of abs() is very
misleading, as res is always non-positive, as it is (after fixing
the patch I am responding to) taken from "enum bisect_error"
vocabulary.  "return -res;" would make the intent of the code
clearer, I think.

By the way, under what condition can the "BUG:" be reached?  Would
it only be reachable by a programming error?  If so, it would be
correct to use BUG("...") and force it die there.  If it can be
reached in some other way (e.g. an incorrect input by the user,
corruption in state files "git bisect" uses on the filesystem), then
it is *not* a "BUG".

I think "bisect--helper" is *not* called by end-user, so an unknown
command would be a BUG in the calling program, which is still part
of git, so it probably is more prudent to do something like the
following instead.

Thanks.

 builtin/bisect--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1c40b516d..0fbd924aac 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -711,7 +711,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", (int)cmdmode);
 	}
 	free_terms(&terms);
 
@@ -722,5 +722,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
 		res = BISECT_OK;
 
-	return abs(res);
+	return -res;
 }
