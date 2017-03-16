Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD0920323
	for <e@80x24.org>; Thu, 16 Mar 2017 16:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdCPQJJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 12:09:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54377 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752698AbdCPQJI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 12:09:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BA51839A7;
        Thu, 16 Mar 2017 12:09:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z9fOVxHDbMOXpWGn6J9j0W+JfD0=; b=VleW/L
        rCieJ2qijIvqCCRkd04OYAu874qO4BjyMMUzF9gbSbCr54lDKuwQkR1Sl3L3Zi4t
        DQmmWmE3bF+O3omvVfDf5HEvsdXwowjPoB8JfcROsI0ZNuyQCOv3h0Mj778p5gwh
        H8SNR5FQZjdag5M8K4eS7NPFr0rXXlyYjkSz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QYFy0dZnWnNOLPwZmRhKfm3w7bz81RJU
        SZ5oWajP4ZY0PMxqCBrkkjD2v7OamdnOWNz9ff6zjY4yj2CnMpoXdk8yxJacv8gc
        O8+O+IxNWcA0+6YpAj/9oJQSYE/hrvBZ9iBTTGQl+WvAUiBGbYhnIKBDnbpBFcQT
        Oi7WhuqjrfY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24A33839A6;
        Thu, 16 Mar 2017 12:09:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95285839A3;
        Thu, 16 Mar 2017 12:09:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4 2/4] dir: add directory_exists
References: <20170314003246.71586-4-lehmacdj@gmail.com>
        <20170316051827.97198-1-lehmacdj@gmail.com>
        <20170316051827.97198-3-lehmacdj@gmail.com>
Date:   Thu, 16 Mar 2017 09:09:05 -0700
In-Reply-To: <20170316051827.97198-3-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Thu, 16 Mar 2017 01:18:25 -0400")
Message-ID: <xmqqlgs5cify.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E19B7D32-0A62-11E7-8D4E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> +int directory_exists(const char *path)
> +{
> +	struct stat sb;
> +	int ret = lstat(path, &sb);
> +	return ret == 0 && S_ISDIR(sb.st_mode);
> +}

I am not a great fan of using file_exists() [*1*] on anything other
than paths in the working tree (i.e. in preparation for checking
things out of or into the index), as paths inside .git/ and paths
outside have different requirements.  One of the difference is if it
makes sense to use stat(2) or lstat(2) for a check like this
function does.  For working tree entities, which file_exists() and
friends are designed for, we absolutely should use lstat(2).  The
"RelNotes" symbolic link at the top level of the project must be
known as a symbolic link and a question "is this a directory?" on it
must be answered "no", for example.

But there is no fundamental reason ~/.git-credential-cache (or
anything outside the working tree) must be S_ISDIR().  If the user
wanted to have the real directory elsewhere and point at it with
a symbolic link ~/.git-credential-cache, we should allow it.

If we need a helper function to see if a path in the working tree is
a directory, adding this new helper function to dir.c (which is
about the paths in the working tree) and use lstat(2) in it is the
right thing to do.  But I do not think it should be used to check if
~/.git-credential-cache directory, which is not a filesystem entity
in a working tree, exists.

IOW, I do not think this patch helps the topic of this series.  Drop
this patch from the series and have a similar code (but use stat(2)
instead of lstat(2)) directly inside get_socket_path()'s in the next
patch, perhaps?


[Footnote]

*1* ... and friends, like safe_create_leading_directories().

