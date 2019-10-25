Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E681F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 03:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbfJYDyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 23:54:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391314AbfJYDyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 23:54:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7854CA0D7E;
        Thu, 24 Oct 2019 23:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZV6QZ050s/lDHA9+HXECeBlhOzk=; b=jP7FWA
        wskuDXa1VaB2SEBXwp2wGXIGuTX1RqH0geN7Hr+QYH5bVcwX581t8Tq+7wjdzQyD
        W2ujgm4e3cZ5sdnYOzSX9XcTa5Am/cNUfr1SOfhzH6vcl9O5w4YHODCFb7c6ElpR
        O4qJsRWRFx5zSOblkeH+RKwx8B+Zxql3j4nAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GFs3lvqjg2VuiH32C9+z9/20gAgSITsA
        7k7/IIs/Gl28pRj3g/VnhqtRCeHQWhQP2x1frSstPT9fxSrxy3O2k6aNEdT7Tuf2
        76gGVeof8iL/lX5XSX8D3OVjOQjc7mSE3ysJvhDQ/WWS8qE41cQQdPepED94FsQl
        +k5yMK7AvAc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70F64A0D7D;
        Thu, 24 Oct 2019 23:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0163A0D7A;
        Thu, 24 Oct 2019 23:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] git-gui: remove unused global declarations
References: <20191025013255.7367-1-me@yadavpratyush.com>
        <20191025013255.7367-2-me@yadavpratyush.com>
Date:   Fri, 25 Oct 2019 12:54:26 +0900
In-Reply-To: <20191025013255.7367-2-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Fri, 25 Oct 2019 07:02:55 +0530")
Message-ID: <xmqq1rv1eaz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24C5AEC2-F6DB-11E9-9199-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

>  proc next_diff {{after {}}} {
> -	global next_diff_p next_diff_w next_diff_i
> +	global next_diff_p next_diff_w
>  	show_diff $next_diff_p $next_diff_w {} {} $after
>  }

Not in particular about next_diff_i, but seeing a hunk like this
makes me wonder if you want to go the other way around.  If a future
fix needs to (re)introduce the use of next_diff_i global variable in
this proc (it seems that there are two procs that declare the
variable as global, one of which is this one, and the other one
assigns to it), the code change must resurrect this declaration;
otherwise the code would only confuse itself by potentially having
two variables (one global, one local) with the same name, no?

For next_diff_i in particular, I think the right solution would be
to remove both global decl and the assignment, as the assignment is
made to otherwise unused variable.  But the primary point in such a
change is not "remove unused global decl"; it is "remove unused
variable".

