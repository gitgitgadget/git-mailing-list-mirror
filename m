Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65750C43464
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B20206B7
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIQUWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:22:01 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:17068 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIQUWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 16:22:01 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 16:22:00 EDT
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4BspKL2xv0z5tl9;
        Thu, 17 Sep 2020 22:21:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E3EB92100;
        Thu, 17 Sep 2020 22:21:57 +0200 (CEST)
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     tytso@mit.edu, Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <64358b70-4fff-5dc8-6e63-2fc916bea6af@kdbg.org>
Date:   Thu, 17 Sep 2020 22:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917112830.26606-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.09.20 um 13:28 schrieb Ævar Arnfjörð Bjarmason:
> Change the behavior of core.fsyncObjectFiles to also sync the
> directory entry. I don't have a case where this broke, just going by
> paranoia and the fsync(2) manual page's guarantees about its behavior.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  sha1-file.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/sha1-file.c b/sha1-file.c
> index dd65bd5c68..d286346921 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1784,10 +1784,14 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
>  }
>  
>  /* Finalize a file on disk, and close it. */
> -static void close_loose_object(int fd)
> +static void close_loose_object(int fd, const struct strbuf *dirname)
>  {
> -	if (fsync_object_files)
> +	int dirfd;
> +	if (fsync_object_files) {
>  		fsync_or_die(fd, "loose object file");
> +		dirfd = xopen(dirname->buf, O_RDONLY);
> +		fsync_or_die(dirfd, "loose object directory");

Did you have the opportunity to verify that this works on Windows?
Opening a directory with open(2), I mean: It's disallowed according to
the docs:
https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/open-wopen?view=vs-2019#return-value

> +	}
>  	if (close(fd) != 0)
>  		die_errno(_("error when closing loose object file"));
>  }

-- Hannes
