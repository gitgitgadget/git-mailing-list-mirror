Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C1F20899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbdHHWau (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:30:50 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36189 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdHHWat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:30:49 -0400
Received: by mail-vk0-f50.google.com with SMTP id u133so19464292vke.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W2oLzaKUENjHMmlQJt3euy7e3waUnhqgDTkQkL9N6z4=;
        b=CZNokSCNoDVWsdoLX5oK4kkvss0jADRJ9syMysraAaTcHKzap+vjDAqLX3H/MVcksd
         I0pV6XuDXrainqwgVIsXkAB/QjygrNDMVjNZMeBlMiup8ISVBUh4gQHGCxr+6qRrFtSS
         +XQCOE/05aadx44PeexcjoozoQEtumdnwenSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W2oLzaKUENjHMmlQJt3euy7e3waUnhqgDTkQkL9N6z4=;
        b=idIdwIEACATpci3rSdX09VjzF5eQcmSJxArdhRw0OkKkh9in3gV41sDh3ctZu1Qb8O
         bgStdQ+BG84Q544f98Ow4NO7lGQQ76rfP+sP3haLSwPsB/EUaI9IYxEzdPRJBnB9m+C0
         fgs3qMrasFdxfu+4uiFYzapgAMQCBSqxbIp+h82bH8cm5caKdA7BGby7UYs4pA402ZXv
         GDR3A54LvfErIAOLEspXhM1fz8mz/FwT8sJ+HJyTw+GRAc/u+3ITMIDzOWhHhah3a0Kr
         k99TdT35thbjPX6SSXVSQgKYoeE6cHndhGzMmfgNDVImTMfM8MrA0JIFcEtNrJcVdwKZ
         JNAg==
X-Gm-Message-State: AHYfb5gpDw7wIclQIzVTgdk8Ubz9OrZ3gWWyr0gMoXgnL5w2Z1d9xRzI
        BK3T8G8GLRrinnJYhDA732HsXZr/DxE3
X-Received: by 10.31.128.141 with SMTP id b135mr4196701vkd.22.1502231448992;
 Tue, 08 Aug 2017 15:30:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 8 Aug 2017 15:30:28 -0700 (PDT)
In-Reply-To: <xmqqpoc5c15v.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
 <xmqqpoc5c15v.fsf@gitster.mtv.corp.google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 8 Aug 2017 15:30:28 -0700
Message-ID: <CAJo=hJusmthiWG6sQ27_anZ7DVbEKGNHyOCUigWP6Naj4ThDvg@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> For `log_type = 0x4..0x7` the `log_chained` section is used instead to
>> compress information that already appeared in a prior log record.  The
>> `log_chained` always includes `old_id` for this record, as `new_id` is
>> implied by the prior (by file order, more recent) record's `old_id`.
>>
>> The `not_same_committer` block appears if `log_type & 0x1` is true,
>> `not_same_message` block appears if `log_type & 0x2` is true.  When
>> one of these blocks is missing, its values are implied by the prior
>> (more recent) log record.
>
> Two comments.
>
>  * not-same-committer would be what I would use when I switch
>    timezones, even if I stay to be me, right?

Correct. This is based on the theory that the timezone in a reflog is
actually the system timezone, not your timezone. If you push to a
remote system, that system's reflog will be using that system's
timezone, not your timezone. So you aren't really that different, and
we can compress the timezone part away. Also, if you do move
timezones, you are likely to remain in that timezone for some period
of time, and such we can compress many log records again with the same
timezone+name+email.

Its ancient history from my research with "pack v4", but people don't
really change timezones very often in the Git committer data. I
suspect its even more true with reflog data.

>  I am just wondering
>    if it is clear to everybody that "committer" in that phrase is a
>    short-hand for "committer information other than the timestamp".

Maybe not. I will try to come up with another shorthand name for this.

>  * Should the set of entries that are allowed to use of "chained"
>    log be related to the set of entries that appear in the restart
>    table in any way?  For a reader that scans starting at a restart
>    point, it would be very cumbersome if the entry were chained from
>    the previous entry, as it would force it to backtrack entries to
>    find the first non-chained log entry.  A simple "log_chained must
>    not be used for an entry that appear in the restart table" rule
>    would solve that, but I didn't see it in the document.

Good catch!  This is implemented as you described in JGit (for the
reasons you described), but not documented. I'll fix it.
