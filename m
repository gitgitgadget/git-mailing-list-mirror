Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F01C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 03:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BC461417
	for <git@archiver.kernel.org>; Tue, 25 May 2021 03:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEYDzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 23:55:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53569 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEYDzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 23:55:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16ACD1352B5;
        Mon, 24 May 2021 23:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pYWPNqG9ET39G22HhXyjLc1Ei/xsZjuKNxYw+j
        rZH5I=; b=kLuh+yX6euaE5zYOC0QgyIdyX64eanw3bccwY2ya8ktYHe9c8jDo6t
        SekfK6noFY1fzCveNE6miR/l74d3HKs1idK/GgDIp2Qm6Fz3nV+AlsQn+f6Wdyx0
        AHVtsA7I/62YjEyphM7Z1QCADa3QbdDphyN3aCLMvv0ht1/1f+YVU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E4031352B4;
        Mon, 24 May 2021 23:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 578EA1352B3;
        Mon, 24 May 2021 23:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3] tr2: log parent process name
References: <20210524201007.115124-1-emilyshaffer@google.com>
Date:   Tue, 25 May 2021 12:54:06 +0900
In-Reply-To: <20210524201007.115124-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 24 May 2021 13:10:07 -0700")
Message-ID: <xmqqpmxfh3j5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB70DA40-BD0C-11EB-A9F1-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/compat/procinfo.c b/compat/procinfo.c
> new file mode 100644
> index 0000000000..0e92fb8b7c
> --- /dev/null
> +++ b/compat/procinfo.c
> @@ -0,0 +1,51 @@
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
> +	if (!strbuf_read_file(&out, procfs_path.buf, 0)) {
> +		/* All done with file reads, clean up early */
> +		strbuf_release(&procfs_path);
> +		return strbuf_detach(&out, NULL);
> +	}
> +#endif
> +
> +	/* NEEDSWORK: add non-procfs implementations here. */
> +	return NULL;
> +}

Is the reason why this takes "int" and not "pid_t" because we may
port to non-POSIX platforms that do not have pid_t defined?

    ... goes and greps ...

Nah, we use pid_t everywhere (including compat/mingw.c); unless
there is a reason not to, let's use that type.

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
> +		char *names[2];
> +		names[0] = get_process_name(getppid());
> +		names[1] = NULL;

Makes me wonder if get_process_name() is an appropriate
abstraction; specifically, something like

		const char **names = get_ancestry_names();
                int cnt;
		if (names)
			trace2_cmd_ancestry(names);
		for (cnt = 0; names[cnt]; cnt++)
                	free((char *)names[cnt]);
		free(names);

would allow platforms to decide how many levels is easy for them to
grab for reporting, for example (and they do not even have to have
to assume that getting process IDs to feed get_process_name() one by
one is the easiest way to show ancestry).

