Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B143C4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20C86141B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 13:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhEYNfj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 May 2021 09:35:39 -0400
Received: from elephants.elehost.com ([216.66.27.132]:55319 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhEYNfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 09:35:39 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14PDY0R4083525
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 May 2021 09:34:01 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <20210524201007.115124-1-emilyshaffer@google.com> <xmqqpmxfh3j5.fsf@gitster.g>
In-Reply-To: <xmqqpmxfh3j5.fsf@gitster.g>
Subject: RE: [PATCH v3] tr2: log parent process name
Date:   Tue, 25 May 2021 09:33:54 -0400
Message-ID: <038801d7516a$9efb1fc0$dcf15f40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJyDPZcqUUkOSfbwgArp/LyHQPVEwJGg4dBqayEmRA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 24, 2021 11:54 PM, Junio C Hamano wrote:
>Emily Shaffer <emilyshaffer@google.com> writes:
>
>> diff --git a/compat/procinfo.c b/compat/procinfo.c new file mode
>> 100644 index 0000000000..0e92fb8b7c
>> --- /dev/null
>> +++ b/compat/procinfo.c
>> @@ -0,0 +1,51 @@
>> +#include "cache.h"
>> +
>> +#include "strbuf.h"
>> +#include "trace2.h"
>> +
>> +char *get_process_name(int pid)
>> +{
>> +#ifdef HAVE_PROCFS_LINUX
>> +	struct strbuf procfs_path = STRBUF_INIT;
>> +	struct strbuf out = STRBUF_INIT;
>> +	/* try to use procfs if it's present. */
>> +	strbuf_addf(&procfs_path, "/proc/%d/comm", pid);
>> +	if (!strbuf_read_file(&out, procfs_path.buf, 0)) {
>> +		/* All done with file reads, clean up early */
>> +		strbuf_release(&procfs_path);
>> +		return strbuf_detach(&out, NULL);
>> +	}
>> +#endif
>> +
>> +	/* NEEDSWORK: add non-procfs implementations here. */
>> +	return NULL;
>> +}
>
>Is the reason why this takes "int" and not "pid_t" because we may port to non-POSIX platforms that do not have pid_t defined?
>
>    ... goes and greps ...
>
>Nah, we use pid_t everywhere (including compat/mingw.c); unless there is a reason not to, let's use that type.
>
>> +void trace2_collect_process_info(enum trace2_process_info_reason
>> +reason) {
>> +	if (!trace2_is_enabled())
>> +		return;
>> +
>> +	/* someday we may want to write something extra here, but not today */
>> +	if (reason == TRACE2_PROCESS_INFO_EXIT)
>> +		return;
>> +
>> +	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
>> +		/*
>> +		 * NEEDSWORK: we could do the entire ptree in an array instead,
>> +		 * see compat/win32/trace2_win32_process_info.c.
>> +		 */
>> +		char *names[2];
>> +		names[0] = get_process_name(getppid());
>> +		names[1] = NULL;
>
>Makes me wonder if get_process_name() is an appropriate abstraction; specifically, something like
>
>		const char **names = get_ancestry_names();
>                int cnt;
>		if (names)
>			trace2_cmd_ancestry(names);
>		for (cnt = 0; names[cnt]; cnt++)
>                	free((char *)names[cnt]);
>		free(names);
>
>would allow platforms to decide how many levels is easy for them to grab for reporting, for example (and they do not even have to have
>to assume that getting process IDs to feed get_process_name() one by one is the easiest way to show ancestry).

Passing pid_t == 1 to get_process_names is non-informative. We can't tell what is really intended inside get_process_names(). Knowing that we are getting the ancestor, however, gives us an the important glue that the parent is wanted so we can interpret 1 as a non-ancestor. NonStop has pid_t defined regardless of whether it is used or relevant, so a higher-level of abstraction makes sense. The git process always has a valid pid_t, but the ancestor may not, but we do not know this at compile time. The platform code previously shared appears to be the correct technique for us. Going with get_ancestry_names() is interesting, but I think a count (how many ancestors do you want) is important (1 - just immediate, 2 - parent, grandparent, -1 - everyone). The ancestry tree can be very large (although each lookup is only about 8us). During a trace, I really would not want to care about more than 2 ancestors, typically, not the likely 8 or 10 that I can see happening in my situation (too much 
 noise). The number of ancestors to trace probably needs to be in .git.config.


