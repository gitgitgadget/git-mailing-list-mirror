Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E1F1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 22:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeA1W6P (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 17:58:15 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:44610 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeA1W6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 17:58:12 -0500
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id F07C019DC07;
        Sun, 28 Jan 2018 23:58:06 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1517180287;
        bh=Uh814iEuWDZ46e4xkS/GOvOtAB9y7IpZ+119WM0dKiI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Reply-To:
         Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version;
        b=CtBsCxsaVi7uj4qAHFcX3BoWvXLucBeVvyLAUyIfulTpTFUFljf53dpiMeh5mN+ZA
         sm2Zz/EhQoNf+vEMKDs7/03t8zw8WWSO9J/AWfDaY9rAcB7iOIh/N+QBuymGMcXRgI
         uVO39cxDeOiy8Gz8RdtdFO+CqEPMIi1lPSxWLJbQ=
Subject: Re: [PATCH v2] daemon: add --send-log-to=(stderr|syslog|none)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com>
 <20180127183132.19724-1-mail@lucaswerkmeister.de>
 <CAPig+cTetjQ9LSH68Fe5OTcj9TwQ9GSbGzdrjzHOhTAVFvrPxw@mail.gmail.com>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <1d98ac06-7cfd-c006-d3c5-9dcb385a17d8@lucaswerkmeister.de>
Date:   Sun, 28 Jan 2018 23:58:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAPig+cTetjQ9LSH68Fe5OTcj9TwQ9GSbGzdrjzHOhTAVFvrPxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.01.2018 07:40, Eric Sunshine wrote:
> On Sat, Jan 27, 2018 at 1:31 PM, Lucas Werkmeister
> <mail@lucaswerkmeister.de> wrote:
>> This makes it possible to use --inetd while still logging to standard
>> error. --syslog is retained as an alias for --send-log-to=syslog. A mode
>> to disable logging explicitly is also provided.
>>
>> The combination of --inetd with --send-log-to=stderr is useful, for
>> instance, when running `git daemon` as an instanced systemd service
>> (with associated socket unit). In this case, log messages sent via
>> syslog are received by the journal daemon, but run the risk of being
>> processed at a time when the `git daemon` process has already exited
>> (especially if the process was very short-lived, e.g. due to client
>> error), so that the journal daemon can no longer read its cgroup and
>> attach the message to the correct systemd unit (see systemd/systemd#2913
>> [1]). Logging to stderr instead can solve this problem, because systemd
>> can connect stderr directly to the journal daemon, which then already
>> knows which unit is associated with this stream.
> 
> The purpose of this patch would be easier to fathom if the problem was
> presented first (systemd race condition), followed by the solution
> (ability to log to stderr even when using --inetd), followed finally
> by incidental notes ("--syslog is retained as an alias..." and ability
> to disable logging).
> 
> Not sure, though, if it's worth a re-roll.

I didn’t want to sound like I was just scratching my own itch ;) I hope
this option is useful for other use-cases as well?

> 
>> Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
>> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>> Notes:
>>     This was originally “daemon: add --no-syslog to undo implicit
>>     --syslog”, but Junio pointed out that combining --no-syslog with
>>     --detach isn’t especially useful and suggested --send-log-to=
>>     instead. Is Helped-by: the right credit for this or should it be
>>     something else?
> 
> Helped-by: is fine, though typically your Signed-off-by: would be last.
> 
> I understand that Junio suggested the name --send-log-to=, but I
> wonder if the more concise --log= would be an possibility.

--log sounds to me like it could also indicate *what* to log (e. g. “log
verbosely” or “don’t log client IPs”). But perhaps --log-to= ?

> 
> More below...
> 
>> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
>> @@ -110,8 +111,26 @@ OPTIONS
>> +--send-log-to=<destination>::
>> +       Send log messages to the specified destination.
>> +       Note that this option does not imply --verbose,
>> +       thus by default only error conditions will be logged.
>> +       The <destination> defaults to `stderr`, and must be one of:
> 
> Perhaps also update the documentation of --inetd to mention that its
> implied --syslog can be overridden by --send-log-to=.

Very good idea!

> 
>> diff --git a/daemon.c b/daemon.c
>> @@ -74,11 +79,14 @@ static const char *get_ip_address(struct hostinfo *hi)
>>
>>  static void logreport(int priority, const char *err, va_list params)
>>  {
>> -       if (log_syslog) {
>> +       switch (log_destination) {
>> +       case LOG_TO_SYSLOG: {
>>                 char buf[1024];
>>                 vsnprintf(buf, sizeof(buf), err, params);
>>                 syslog(priority, "%s", buf);
>> -       } else {
>> +               break;
>> +       }
>> +       case LOG_TO_STDERR: {
> 
> There aren't many instances of:
> 
>     case FOO: {
> 
> in the code-base, but those that exist don't use braces around cases
> which don't need it, so perhaps drop it from the STDERR and NONE
> cases. (Probably not worth a re-roll, though.)

Good point, forgot that part of the coding guidelines. Only the syslog
case needs it because the buf declaration can’t be labeled directly.

> 
>>                 /*
>>                  * Since stderr is set to buffered mode, the
>>                  * logging of different processes will not overlap
>> @@ -88,6 +96,11 @@ static void logreport(int priority, const char *err, va_list params)
>>                 vfprintf(stderr, err, params);
>>                 fputc('\n', stderr);
>>                 fflush(stderr);
>> +               break;
>> +       }
>> +       case LOG_TO_NONE: {
>> +               break;
>> +       }
>>         }
> 
> Consecutive lines with braces at the same indentation level is rather
> odd (but see previous comment).
> 
>>  }
>>
>> @@ -1289,7 +1302,7 @@ int cmd_main(int argc, const char **argv)
>>                 }
>>                 if (!strcmp(arg, "--inetd")) {
>>                         inetd_mode = 1;
>> -                       log_syslog = 1;
>> +                       log_destination = LOG_TO_SYSLOG;
> 
> Hmm, so an invocation "--inetd --send-log-to=stderr" works as
> expected, but "--send-log-to=stderr --inetd" doesn't; output goes to
> syslog despite the explicit request for stderr. Counterintuitive. This
> should probably distinguish between 'log_destination' being unset and
> set explicitly; if unset, then, and only then, have --inetd imply
> syslog. Perhaps something like this:
> 
>     static enum log_destination {
>         LOG_TO_UNSET = -1
>         LOG_TO_NONE,
>         LOG_TO_STDERR,
>         LOG_TO_SYSLOG,
>     } log_destination = LOG_TO_UNSET;
> 
>     if (!strcmp(arg, "--inetd")) {
>         inetd_mode = 1;
>         if (log_destination == LOG_TO_UNSET)
>             log_destination = LOG_TO_SYSLOG;
>         ...
>     }
>     ...
>     if (log_destination == LOG_TO_UNSET)
>         log_destination = LOG_TO_STDERR
> 

I’m not sure if that’s worth the extra complication… some existing
options behave the same way already, e. g. in `git rebase --stat
--quiet`, the `--stat` is ignored.

>>                         continue;
>>                 }
>> @@ -1297,9 +1310,25 @@ int cmd_main(int argc, const char **argv)
>> +               if (skip_prefix(arg, "--send-log-to=", &v)) {
>> +                       if (!strcmp(v, "syslog")) {
>> +                               log_destination = LOG_TO_SYSLOG;
>> +                               continue;
>> +                       }
>> +                       else if (!strcmp(v, "stderr")) {
> 
> Style: cuddle 'else' with the braces: } else if (...) {
>

Is that a general rule? I couldn’t find anything about it in
CodingGuidelines and daemon.c seemed to use both styles about evenly, so
I wasn’t sure what to use.

>> +                               log_destination = LOG_TO_STDERR;
>> +                               continue;
>> +                       }
>> +                       else if (!strcmp(v, "none")) {
>> +                               log_destination = LOG_TO_NONE;
>> +                               continue;
>> +                       }
>> +                       else
>> +                               die("Unknown log destination %s", v);
> 
> Even though there is a mix of capitalized and lowercase-only error
> messages in daemon.c, newly written code avoids capitalization so
> perhaps downcase "unknown".
> 

Okay, thanks!

I’ll prepare a new version of the patch, but will wait a bit before
sending it in case there’s more feedback. But thanks for your reply :)
