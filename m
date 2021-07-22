Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C6DC4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2815360EB1
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhGVUWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:22:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56456 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhGVUWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:22:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 745D3E786B;
        Thu, 22 Jul 2021 17:02:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jIfdhGMV0mFaPDr5WX71npsKY+bQUxa9BcZlZF
        t2Wj8=; b=X2TjGQXQk8zJ0fcGNWwClYkjkS2GxXyNLHoVSUsOnP+amNL+EZ8OqQ
        JjAiElVWR5GjVJkOA5BxBNk179jS0KSEP0Am9OKGsMpdtp0jrPxCK09rc06b52ww
        QlshlgqoW8azJEGxNIp8+QwLNQ7w99RaRp4Fs8Gu1cqIVWWgFVRp0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C67DE786A;
        Thu, 22 Jul 2021 17:02:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5E60E7869;
        Thu, 22 Jul 2021 17:02:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
References: <20210722012707.205776-1-emilyshaffer@google.com>
        <20210722012707.205776-3-emilyshaffer@google.com>
Date:   Thu, 22 Jul 2021 14:02:38 -0700
In-Reply-To: <20210722012707.205776-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 21 Jul 2021 18:27:07 -0700")
Message-ID: <xmqqwnpi83kh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25C53C34-EB30-11EB-A469-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Unfortunately, there's no cross-platform reliable way to gather the name
> of the parent process. If procfs is present, we can use that; otherwise
> we will need to discover the name another way. However, the process ID
> should be sufficient to look up the process name on most platforms, so
> that code may be shareable.

Is the sentence that begin with "However" still relevant?  The
latest get_ancestry_names() does not add anything when the result
read from the procfs is unusable, but the sentence gives a false
impression that it may somehow fall back to show the PID.

> Git for Windows also gathers information about more than one generation
> of parent. In Linux further ancestry info can be gathered with procfs,
> but it's unwieldy to do so. In the interest of later moving Git for
> Windows ancestry logging to the 'cmd_ancestry' event, and in the
> interest of later adding more ancestry to the Linux implementation - or
> of adding this functionality to other platforms which have an easier
> time walking the process tree - let's make 'cmd_ancestry' accept an
> array of parentage.

Clearly written.  Nice.

> +`"cmd_ancestry"`::
> +	This event contains the text command name for the parent (and earlier
> +	generations of parents) of the current process, in an array ordered from
> +	nearest parent to furthest great-grandparent. It may not be implemented
> +	on all platforms.
> ++
> +------------
> +{
> +	"event":"cmd_ancestry",
> +	...
> +	"ancestry":["bash","tmux: server","systemd"]
> +}
> +------------

OK.

> diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
> new file mode 100644
> index 0000000000..578fed4cd3
> --- /dev/null
> +++ b/compat/linux/procinfo.c
> @@ -0,0 +1,55 @@
> +#include "cache.h"
> +
> +#include "strbuf.h"
> +#include "strvec.h"
> +#include "trace2.h"
> +
> +static void get_ancestry_names(struct strvec *names)
> +{
> +	/*
> +	 * NEEDSWORK: We could gather the entire pstree into an array to match
> +	 * functionality with compat/win32/trace2_win32_process_info.c.
> +	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
> +	 * gather the immediate parent name which is readily accessible from
> +	 * /proc/$(getppid())/comm.
> +	 */
> +	struct strbuf procfs_path = STRBUF_INIT;
> +	struct strbuf name = STRBUF_INIT;
> +
> +	/* try to use procfs if it's present. */
> +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> +		strbuf_release(&procfs_path);
> +		strbuf_trim_trailing_newline(&name);
> +		strvec_push(names, strbuf_detach(&name, NULL));

At this point, we successfully read from /proc/$(ppid)/comm
and pushed the result into names strvec.  I think you would want to
have an explicit "return;" here.

Alternatively, you could put the rest of the function in the
corresponding "else" clause, but I think an early return after each
method successfully collects the result would make a lot more sense.

> +	}
> +
> +	return;
> +	/* NEEDSWORK: add non-procfs-linux implementations here */

This looks the other way around.  A future non-procfs-linux
implementation written here will be unreachable code ;-)

Just lose "return;" from here, have one in the if(){} body, and keep
the "here is where you add more/other implementations" comment and
we'd be OK, I think.

> +void trace2_collect_process_info(enum trace2_process_info_reason reason)
> +{
> +	if (!trace2_is_enabled())
> +		return;
> +
> +	/* someday we may want to write something extra here, but not today */
> +	if (reason == TRACE2_PROCESS_INFO_EXIT)
> +		return;
> +
> +	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
> +		/*
> +		 * NEEDSWORK: we could do the entire ptree in an array instead,
> +		 * see compat/win32/trace2_win32_process_info.c.
> +		 */
> +		struct strvec names = STRVEC_INIT;
> +
> +		get_ancestry_names(&names);
> +
> +		if (names.nr)
> +			trace2_cmd_ancestry(names.v);
> +		strvec_clear(&names);
> +	}
> +
> +	return;
> +}

Good.

Thanks.
