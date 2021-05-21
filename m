Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D57C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 20:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B9F61004
	for <git@archiver.kernel.org>; Fri, 21 May 2021 20:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhEUUZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 16:25:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23896 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhEUUZF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 16:25:05 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14LKNYKY001803
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 May 2021 16:23:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>
Cc:     <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <20210520210546.4129620-1-emilyshaffer@google.com> <1e3bb53e-895b-f571-1c03-a6ae6499746d@jeffhostetler.com> <YKgSc5OgVOt6HQqW@google.com>
In-Reply-To: <YKgSc5OgVOt6HQqW@google.com>
Subject: RE: [PATCH v2] tr2: log parent process name
Date:   Fri, 21 May 2021 16:23:28 -0400
Message-ID: <02be01d74e7f$2c282300$84786900$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG/TiO1DChZ2CQV98iURtxeNF+BXAFB/hy0ApyWcG6q/2wQkA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<emilyshaffer@google.com>
On May 21, 2021 4:05 PM, Emily Shaffer wrote:
>On Fri, May 21, 2021 at 03:15:16PM -0400, Jeff Hostetler wrote:
>> On 5/20/21 5:05 PM, Emily Shaffer wrote:
>> > - I took a look at Jeff H's advice on using a "data_json" event to log
>> >    this and decided it would be a little more flexible to add a new event
>> >    instead. If we want, it'd be feasible to then shoehorn the GfW parent
>> >    tree stuff into this new event too. Doing it this way is definitely
>> >    easier to parse for Google's trace analysis system (which for now
>> >    completely skips "data_json" as it's polymorphic), and also - I think
>> >    - means that we can add more fields later on if we need to (thread
>> >    info, different fields than just /proc/n/comm like exec path, argv,
>> >    whatever).
>>
>> I could argue both sides of this, so I guess it is fine either way.
>>
>> In GFW I log a array of argv[0] strings in a generic "data_json" event.
>> I could also log additional "data_json" events with more structured
>> data if needed.
>>
>> On the other hand, you're proposing a "cmd_ancestry" event with a
>> single array of strings.  You would have to expand the call signature
>> of the trace2_cmd_ancestry() API to add additional data and inside
>> tr2_tgt_event.c add additional fields to the JSON being composed.
>>
>> So both are about equal.
>>
>> (I'll avoid the temptation to make a snarky comment about fixing your
>> post processing. :-) :-) :-) )
>
>;P
>
>(I don't have much to add - this is an accurate summary of what I thought about, too. Thanks for writing it out.)
>
>>
>> It really doesn't matter one way or the other.
>>
>> > - Jonathan N also pointed out to me that /proc/n/comm exists, and logs
>> >    the "command name" - excluding argv, excluding path, etc. It
>> > seems
>>
>> So you're trying to log argv[0] of the process and not the full
>> command line.  That's what I'm doing.
>
>It's close to argv[0], yeah. POSIX docs indicate it might be truncated in a way that argv[0] hasn't been, but it also doesn't
include the
>leading path (as far as I've seen). For example, a long-running helper script I use with mutt, right now (gaffing on line length in
email to
>help with argv clarity, sorry):
>
>  $ ps aux | grep mutt
>  emilysh+ 4119883  0.0  0.0   6892  3600 pts/6    S+   12:44   0:00 /bin/bash
/usr/local/google/home/emilyshaffer/dotfiles/open-vim-in-
>new-split.sh /var/tmp/mutt-podkayne-413244-1263002-7433772284891386689
>  # comm is truncated to 15ch, except apparently in the cases of some
>  # kernel worker processes I saw with much longer names?
>  $ cat /proc/4119883/comm
>  open-vim-in-new
>  # exe is a link to the executable, which means bash as this is a
>  # script
>  $ ls -lha /proc/4119883/exe
>  lrwxrwxrwx 1 emilyshaffer primarygroup 0 May 21 12:44
>  /proc/4119883/exe -> /usr/bin/bash
>  # cmdline has the whole argv, separated on NUL so it runs together in
>  # editor
>  $ cat /proc/4119883/cmdline
>  /bin/bash/usr/local/google/home/emilyshaffer/dotfiles/open-vim-in-new-split.sh/var/tmp/mutt-podkayne-413244-1263002-
>7433772284891386689
>
>Jonathan N pointed out that the process name (the thing in 'comm') can also be manually manipulated by the process itself, and 'man
>procfs'
>also talks about 'PR_SET_NAME' and 'PR_GET_NAME' operations in 'prctl()', so that tracks. (It doesn't look like we can use prctl()
to find
>out the names of processes besides the current process, though, so the procfs stuff is still needed. Dang.)
>
>>
>> >    like this is a little more safe about excluding personal information
>> >    from the traces which take the form of "myscript.sh
>> >    --password=hunter2", but would still be worrisome for something like
>> >    "mysupersecretproject.sh". I'm not sure whether that means we still
>> >    want to guard it with a config flag, though.
>>
>> You might check whether you get the name of the script or just get a
>> lot of entries with just "/usr/bin/bash".
>
>See above :)
>
>> There's lots of PII in the data stream to worry about.
>> The name of the command is just one aspect, but I digress.
>
>Yes, that's what we've noticed too, so a process name isn't worrying us that much more.
>
>>
>> > - I also added a lot to the commit message; hopefully it's not too
>> >    rambly, but I hoped to explain why just setting GIT_TRACE2_PARENT_SID
>> >    wasn't going to cut it.
>> > - As for testing, I followed the lead of GfW's parentage info - "this
>> >    isn't portable so writing tests for it will suck, just scrub it from
>> >    the tests". Maybe it makes sense to do some more
>> >    platform-specific-ness in the test suite instead? I wasn't sure.
>>
>> yeah, that's probably best.  Unless you can tokenize it properly so
>> that you can predict the results in a HEREDOC in the test source.
>>
>> For example, you might try to test tracing a command (where a
>> top-level "git foo" (SPACE form) spawns a "git-foo" (DASHED form) and
>> check the output for the child.
>
>Yeah, I had trouble with even deciding when to attempt such a check or not.
>> > +	if (reason == TRACE2_PROCESS_INFO_STARTUP)
>> > +	{
>> > +		/*
>> > +		 * NEEDSWORK: we could do the entire ptree in an array instead,
>> > +		 * see compat/win32/trace2_win32_process_info.c.
>> > +		 */
>> > +		char *names[2];
>> > +		names[0] = get_process_name(getppid());
>> > +		names[1] = NULL;
>>
>> You're only logging 1 parent.  That's fine to get started.
>>
>> I'm logging IIRC 10 parents on GFW.  That might seem overkill, but
>> there are lots of intermediate parents that hide what is happening.
>> For example, a "git push" might spawn "git remote-https"
>> which spawns "git-remote-https" which spawn "git send-pack" which
>> spawns "git pack-objects".
>>
>> And that doesn't include who called push.
>>
>> And it's not uncommon to see 2 or 3 "bash" entries in the array
>> because of the bash scripts being run.
>
>Agree. But it's expensive - I didn't find a handy library call to find "parent ID of given process ID", so I think we'd have to
manipulate
>procfs; and so far I only see parent ID in summary infos like /proc/n/status or /proc/n/stat, which contain lots of other info too
and would
>need parsing.
>
>We could reduce the cost a little bit by grabbing the process name from the status or stat as well, and therefore still only
opening one file
>per process, but I'd want to check whether the formats are expected to be stable for those things.
>
>> > +static void fn_command_ancestry_fl(const char *file, int line,
>> > +const char **parent_names) {
>> > +	const char *event_name = "cmd_ancestry";
>> > +	const char *parent_name = NULL;
>> > +	struct json_writer jw = JSON_WRITER_INIT;
>> > +
>> > +	jw_object_begin(&jw, 0);
>> > +	event_fmt_prepare(event_name, file, line, NULL, &jw);
>> > +	jw_object_inline_begin_array(&jw, "ancestry");
>> > +
>> > +	while ((parent_name = *parent_names++))
>> > +		jw_array_string(&jw, parent_name);
>>
>> You're building the array with the immediate parent in a[0] and the
>> grandparent in a[1], and etc.  This is the same as I did in GFW.
>>
>> Perhaps state this in the docs somewhere.
>
>Sure, makes sense. I think I neglected any doc work whatsoever in this patch anyways, whoops :)
>
>> > +	/* cmd_ancestry parent <- grandparent <- great-grandparent */
>> > +	strbuf_addstr(&buf_payload, "cmd_ancestry ");
>> > +	while ((parent_name = *parent_names++)) {
>> > +		strbuf_addstr(&buf_payload, parent_name);
>>
>> Did you want to quote each parent's name?
>
>I'd rather not - since they're going into an array anyway, I'd expect the array delimiters to be enough. Am I being naive? 'normal'
looks to
>me like it's supposed to be mostly human readable anyways, rather than parseable?
>
>> > +	strbuf_addstr(&buf_payload, "ancestry:[");
>> > +	/* It's not an argv but the rules are basically the same. */
>> > +	sq_append_quote_argv_pretty(&buf_payload, parent_names);
>>
>> This will have whitespace delimiters between the quoted strings rather
>> than commas.  Just checking if that's what you wanted.
>>
>> I'm not sure it matters, since this stream is intended for human
>> parsing.
>
>Yeah, it seems fine to me as is.
>
>>
>> We should update Documentation/technical/api-trace2.txt too.
>
>Yep, thanks.
>
>I appreciate the review, Jeff.

I checked the performance of my NonStop parent lookup implementation. It's fast enough that no one would notice (8 microseconds on
the oldest slowest machine I could find).

Just an FYI.
-Randall

