Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9E22095B
	for <e@80x24.org>; Tue, 21 Mar 2017 21:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756924AbdCUVwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 17:52:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755793AbdCUVwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 17:52:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A02656A5E2;
        Tue, 21 Mar 2017 17:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O7uzZ4L5TH6Ymb8ka/ISI22AnTE=; b=wakjVZ
        DTlf2D95phmTjrMBXkLPIA8/Qb9vCd1fmG+qi8Xv1b6CGoESgck59pUYzmjXWdWE
        Dhof16Sxq1vQTchG2UQHl6bfbOWrxFexD9JpEtjBKQcL9pDxY3ILgAXxNgwYNCSv
        37pHZ4NSPPGHerDOa3yQPhJQB504qxgyvmdew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AuTow3PM5U8srKoNuv+BRZlMFDvyixUQ
        +4tI7TmyhMwDY61Xj2hReJ5NnOyJt2RQKg0H2Sj+D40vmL7ihxc3my0rZoXHdwdg
        gzOLknACNojY9Iwy7nKBJoWOnt84t6aI1U18x0DyLqUJZv0hA+FySUZgZZPXlulK
        3Xe4brSgUpQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 981056A5E1;
        Tue, 21 Mar 2017 17:51:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06F1F6A5E0;
        Tue, 21 Mar 2017 17:51:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, mfick@codeaurora.org
Subject: Re: [PATCH] builtin/describe: introduce --broken flag
References: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com>
        <20170321185139.8300-1-sbeller@google.com>
Date:   Tue, 21 Mar 2017 14:51:57 -0700
In-Reply-To: <20170321185139.8300-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 21 Mar 2017 11:51:39 -0700")
Message-ID: <xmqq7f3invr6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BCA2B38-0E80-11E7-B24F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This patch helps to fix the root cause in [1], which tries to work around
> this situation.

I do not necessarily think it is reasonable to give $version-dirty
and proceed when a repository corruption is detected; if there is a
breakage in the repository, "git describe" is correct to die when a
populated submodule is broken.  IOW, I do not agree that [1] below
is working with a sensible expectation.

This is a tangent, but how does the Gerrit repository get corrupted
in the way described in [1] in the first place?  That might be what
needs to be corrected, perhaps?

>  Documentation/git-describe.txt |  7 +++++
>  builtin/describe.c             | 59 ++++++++++++++++++++++++++++++------------
>  t/t6120-describe.sh            | 20 ++++++++++++++
>  3 files changed, 70 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index 8755f3af7b..b71fa7a4ad 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -34,6 +34,13 @@ OPTIONS
>  	It means describe HEAD and appends <mark> (`-dirty` by
>  	default) if the working tree is dirty.
>  
> +--broken[=<mark>]::
> +	Describe the working tree.
> +	It means describe HEAD and appends <mark> (`-broken` by
> +	default) if the working tree cannot be examined for dirtiness.
> +	This implies `--dirty`, which is the fallback behavior when
> +	the working tree examination works.

The wording for the "--dirty" is already awkward, but this one is
even more so ("Describe the working tree. It means" conveys no
useful information).  I however cannot come up with something much
better.  This is the best I could come up with:

	Describe the state of the working tree.  When the working
	tree matches HEAD, the output is the same as "git describe
	HEAD" and "-dirty" is appended to it if the working tree has
	local modification.  When a repository is corrupt and Git
	cannot determine if there is local modification, instead of
	dying, append "-broken" instead.

The last sentence can be tweaked to replace the description for
"--dirty".

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 76c18059bf..37a83520c9 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -9,6 +9,7 @@
>  #include "diff.h"
>  #include "hashmap.h"
>  #include "argv-array.h"
> +#include "run-command.h"
>  
>  #define SEEN		(1u << 0)
>  #define MAX_TAGS	(FLAG_BITS - 1)
> @@ -31,12 +32,7 @@ static int have_util;
>  static struct string_list patterns = STRING_LIST_INIT_NODUP;
>  static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
>  static int always;
> -static const char *dirty;
> -
> -/* diff-index command arguments to check if working tree is dirty. */
> -static const char *diff_index_args[] = {
> -	"diff-index", "--quiet", "HEAD", "--", NULL
> -};
> +static const char *append, *dirty, *broken;

Perhaps call it "suffix" or something?

> +		if (broken) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			argv_array_pushl(&cp.args, "diff-index", "--quiet", "HEAD", "--", NULL);
> ...
> +			}
> +		} else if (dirty) {
> +			struct argv_array args = ARGV_ARRAY_INIT;
>  			static struct lock_file index_lock;
>  			int fd;
>  
> +			argv_array_pushl(&args, "diff-index", "--quiet", "HEAD", "--", NULL);


Somehow it looks like the patch is making the code a lot worse by
losing diff_index_args[] and duplicating the same command line twice
in the code.  Wouldn't argv_array_pushv() into these two different args
array from the same template work better?
