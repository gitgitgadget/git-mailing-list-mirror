Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A9C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 02:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B7C613AC
	for <git@archiver.kernel.org>; Fri, 21 May 2021 02:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhEUCLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 22:11:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58487 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhEUCLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 22:11:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BCBBC292A;
        Thu, 20 May 2021 22:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AO+Yec2KWKGtlPnpqP3eQjl3O+yG1AhsTHNlPB
        eyrKI=; b=dMffiE+MBJprDOJkbpX3ihfT4ae/E9TLhynpCyiLOvFNrFd4ny/30V
        gfa8NqULFKHW6sALeVIOvBrOzwIkdXK3BOHyMYo7O9uV1MQEEM2svYSfmGcWTFnN
        Wch3hWOu4RrXnYazgMz/QNiGriUFMioUb0zSC+qPvy0TyJUgqmWsY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E845DC2929;
        Thu, 20 May 2021 22:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 644BAC2928;
        Thu, 20 May 2021 22:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] tr2: log parent process name
References: <20210520210546.4129620-1-emilyshaffer@google.com>
Date:   Fri, 21 May 2021 11:09:49 +0900
In-Reply-To: <20210520210546.4129620-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 20 May 2021 14:05:46 -0700")
Message-ID: <xmqqpmxksuqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FC27B9C-B9D9-11EB-B8E4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Unfortunately, there's no cross-platform reliable way to gather the name
> of the parent process. If procfs is present, we can use that; otherwise
> we will need to discover the name another way. However, the process ID
> should be sufficient regardless of platform.

Not a strong objection, but I wonder if seeing random integer(s) is
better than not having cmd_ancestry info at all.  The latter better
signals that the platform does not yet have the "parent process
name" feature, I would think.

> Git for Windows also gathers information about more than one parent. In
> Linux further ancestry info can be gathered with procfs, but it's
> unwieldy to do so. In the interest of later moving Git for Windows
> ancestry logging to the 'cmd_ancestry' event, and in the interest of
> later adding more ancestry to the Linux implementation - or of adding
> this functionality to other platforms which have an easier time walking
> the process tree - let's make 'cmd_ancestry' accept an array of
> parentage.

Could we rephrase "more than one parent" at the beginning to
clarify?  I initially had to wonder what "an array of parentage"
contains (father and mother, or a sole parent and its sole parent,
which is a sole grandparent).  Since there is no "multiple processes
meet and spawn a single process", I take it is the latter.  Perhaps
"more than one generation of" or something?

> +ifdef HAVE_PROCFS_LINUX
> +	BASIC_CFLAGS += -DHAVE_PROCFS_LINUX
> +	COMPAT_OBJS += compat/procinfo.o
> +endif
> +
>  ifdef HAVE_NS_GET_EXECUTABLE_PATH
>  	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
>  endif
> diff --git a/compat/procinfo.c b/compat/procinfo.c
> new file mode 100644
> index 0000000000..523600673f
> --- /dev/null
> +++ b/compat/procinfo.c
> @@ -0,0 +1,53 @@
> +#include "cache.h"
> +
> +#include "strbuf.h"
> +#include "trace2.h"
> +
> +char *get_process_name(int pid)
> +{
> +#ifdef HAVE_PROCFS_LINUX
> +	struct strbuf procfs_path = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	/* try to use procfs if it's present. */
> +	strbuf_addf(&procfs_path, "/proc/%d/comm", pid);
> +	if (!strbuf_read_file(&out, procfs_path.buf, 0))
> +	{

Place this opening brace at the end of the previous line.

> +		/* All done with file reads, clean up early */
> +		strbuf_release(&procfs_path);
> +		return strbuf_detach(&out, NULL);
> +	}
> +#endif
> +
> +	/* NEEDSWORK: add non-procfs implementations here. */
> +	return NULL;
> +}

> +void trace2_collect_process_info(enum trace2_process_info_reason reason)
> +{
> +	if (!trace2_is_enabled())
> +		return;
> +
> +	/* someday we may want to write something extra here, but not today */
> +	if (reason == TRACE2_PROCESS_INFO_EXIT)
> +		return;
> +
> +	if (reason == TRACE2_PROCESS_INFO_STARTUP)
> +	{

Ditto.

> +		/*
> +		 * NEEDSWORK: we could do the entire ptree in an array instead,
> +		 * see compat/win32/trace2_win32_process_info.c.
> +		 */
> +		char *names[2];
> +		names[0] = get_process_name(getppid());
> +		names[1] = NULL;
> +
> +		if (!names[0])
> +			return;

OK, so if there is no name given, we do not show pid as a
placeholder.

> +		trace2_cmd_ancestry((const char**)names);
> +
> +		free(names[0]);
> +	}
> +
> +	return;
> +}
> diff --git a/config.mak.uname b/config.mak.uname
> index cb443b4e02..7ad110a1d2 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -58,6 +58,7 @@ ifeq ($(uname_S),Linux)
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	BASIC_CFLAGS += -DHAVE_SYSINFO
>  	PROCFS_EXECUTABLE_PATH = /proc/self/exe
> +	HAVE_PROCFS_LINUX = YesPlease

Have all Linux instances procfs enabled and mounted?  It might be
that we need to detect this at runtime anyway?

    ... goes and thinks ...

Ah, OK, that "try reading from proc/%d/comm" is the runtime
detection, so it is only this Makefile variable is slightly
misnamed (it is not "HAVE" but "is worth checking for it").

Makes sense.

