Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8501F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfBOR5p (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:57:45 -0500
Received: from siwi.pair.com ([209.68.5.199]:33954 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfBOR5p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:57:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E5A903F4024;
        Fri, 15 Feb 2019 12:57:44 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BB1BC3F4022;
        Fri, 15 Feb 2019 12:57:44 -0500 (EST)
Subject: Re: [PATCH v6 02/15] trace2: create new combined trace facility
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
 <pull.108.v6.git.gitgitgadget@gmail.com>
 <6bad326bbd27426845734d08428e6987a75d9ad9.1549473350.git.gitgitgadget@gmail.com>
 <87y36hnit9.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e7be277a-169d-f759-dc14-4ea0e7768c89@jeffhostetler.com>
Date:   Fri, 15 Feb 2019 12:57:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <87y36hnit9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/15/2019 11:00 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:
> 
>> +	sa.sun_family = AF_UNIX;
>> +	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
>> +	if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1 ||
>> +	    connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
>> +		if (tr2_dst_want_warning())
>> +			warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
>> +				path, dst->env_var_name, strerror(errno));
>> +
>> +		tr2_dst_trace_disable(dst);
>> +		return 0;
>> +	}
> 
> Just curious, what do you use af_unix:* for? Is this provided by some
> Windows emulation ?

On the Mac, I want to send data to a server that only handles
stream data.  I thought about making the prefix something like
     "af_unix:stream:<path>"
and then we could have the correpsonding dgram version too, but
I didn't add that.

I think I'll add this in the next re-roll.



> On Linux with systemd, this does not work for logging to systemd's
> /dev/log. You're opening the socket with SOCK_STREAM, but it needs
> SOCK_DGRAM. I.e.:
> 
>      # fail
>      echo '{"yay": "testing"}' | nc -U /dev/log
>      # works
>      echo '{"yay": "testing"}' | nc -uU /dev/log
> 
> So that gives something that'll "work" for "jounalctl -f", but on my
> system ends up being munged to the invalid JSON:
> 
>      '{"yay"[PID]: "testing"}'.
> 
> I found, and this may be specific to the systemd/rsyslog setup on RedHat
> I'm working with, that what /dev/log is expecting is a payload in the
> syslog format: https://tools.ietf.org/html/rfc5424
> 
> So related to my question in
> https://public-inbox.org/git/87a7iyk0r8.fsf@evledraar.gmail.com/ I
> wonder what we should do about this. It seems the bare minimal thing
> that's needed it some way to open a socket with SOCK_DGRAM, maybe we
> should just do that unconditionally if the connect() fails with
> EPROTOTYPE?
> 
> But it seems that for that to be useful for systemd we'd need to support
> the syslog.h interface (so different from af_unix:*), or learn how to
> write a standard syslog packet to an af_unix:* SOCK_DGRAM socket.
> 
> I guess we can start with just supporting that by hardcoding the ident &
> LOG_* values to something sensible, e.g.:
> 
>    openlog("git", LOG_PID | (tr2_dst_want_warning() ? LOG_CONS : 0), LOG_USER);
>    syslog(LOG_USER|LOG_DEBUG, message_or_json);
>    closelog();
> 
> I can write the patches for this. As in the earlier message I'm just
> looking for some context, whether this is stuff you have WIP already,
> and whether you have any other/related ideas. Thanks.
> 

When I created the "af_unix:" prefix for Unix domain sockets, I thought
we could later do other types of sockets if we wanted to.  The common
theme being they just need an "fd".

For syslog(), rather than changing the af_unix socket code, you could
create a new Trace2 target.  For example, copy one of the existing
targets:
    trace2/tr2_tgt_normal.c that defines GIT_TR2
    trace2/tr2_tgt_event.c that defines GIT_TR2_EVENT
    trace2/tr2_tgt_perf.c that defines GIT_TR2_PERF
and create:
    trace2/tr2_tgt_syslog.c that defines GIT_TR2_SYSLOG.

Then in tr2_tgt_syslog.c you have complete control of the formatting
of the data you send to syslog().  You can omit fields as necessary.
Or you can printf format it rather than JSON encode it.

Then in trace2/tr2_dst.c add a parser for "syslog:<whatever>".
All it has to do is set a bit so that tr2_dst_trace_want()
returns true if you were able to openlog().

Hope that helps,
Jeff


