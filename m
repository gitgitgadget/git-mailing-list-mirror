Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D37C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C5120756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LgrcGOdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgHKQIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:08:35 -0400
Received: from mout.web.de ([212.227.17.12]:51765 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgHKQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 12:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597162109;
        bh=0n/j15b6DSqKwdvx5H44U7XbgA9gbWhUDD5EUPGL10w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LgrcGOdqDU9Xfkrs0uwnRXMSxWY4DccqOUuy/FAaRoV3ke0IbH+66jBZMflEgcE1P
         kTtV41NP9403GhhBg13XXR6JELlhV0zJKHQaGt92w/wjbADA/2jLMF5XCPldJcy3Cd
         qte1WuBt9lpW2IcEqp7fdnMxLgrzcoMTYgMsp158=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEiK-1juaaD21DU-00FTTa; Tue, 11
 Aug 2020 18:08:29 +0200
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
To:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
 <90541678-f412-89a1-2ee0-4cae30e26551@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3655b3c8-9b60-daec-c3a2-6e3703ec5b3f@web.de>
Date:   Tue, 11 Aug 2020 18:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <90541678-f412-89a1-2ee0-4cae30e26551@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f9KsSrhw63NE0YCpyKgxB1z88T2Wa7rCpqNaiSUP+rLo9BX+KJC
 rIhdXbZgqt8TGV04AZBYSei2/2lwNgSjxDh/avuNTRiApPiywReF1Y+9NINUAyZKz+IW+P1
 S+wnGZkDzPv7KgOnIwhB9/fzPiM2KADQdVCvMpk2ay4be3UMzc/Yzwd2p2j/gOqEhXdWTml
 FIC5TrD+bgdr0Qh0f8OBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ooToIeEDus4=:5xe+l7kIq3McdZ60QH3p+r
 RoKWF4KiULrDyWg9Rdp8yc9dV7P99rVHKC5Ty86N5kIi3StQ0O/NtNMEgMs1FhTtEEd67r+W3
 caJqVmsCtY9j4AgwJ/Z1M37AO3NThVO304OltkJeClKcGWEFLMBP7ZrtAjiaymAZErqsCpo30
 3hSXsbk1TAb2SHwH/2gYB2Ic1O8cxyYY7pkxjYzMkJMtBdQypaUqNL/xIh/oVvEndtKUT9Tu8
 EoPzucvQHX81b3od8ivd5Dqk2t4N0luXxuVlNphvykTvIWJmtAmqoxb5TDX7UWXAJvSLer92M
 4Qx+P2sUQNikJrvEIdZEDNhitThvH/cMXOp1rIap2/JAe1ad/y6r71hhh3YpALewHVorR1FHW
 YTxrmxMCh7NkaPRFt4a9VEvICuZG18qnYRDm/CyvUVIJM3+/4YRV1UTWtBur7eYSqu1iyTZze
 /C6p/FiXO8do8Pp6UhiXdyFVs4sXAYxWTbOPJpfO7NZTAkIPhK9WHqob2oZCHqTHBUq8rdld2
 kR9eCqkOjyvOwiIoQO1bibAuSCKRFBmQCk/XFooupKhuTlXxeihc+J+bwMoEeH38wZYvemjNo
 kwcEPc0Mx6NQCRTQb/rihE8i6e3PSAr1ArXKQSk76uoQGlco3UCT15nQxGbPbzHiR773SfiLP
 zsPCgR4ZnLWdtroxK+7NZ7DH5o6aku/3iMIhDYKZ5akv1RCfVx+B0M1jESgtP694U4oojTKFE
 zQ0gEE5j74fBl1O3YCmqgnx1T2vBAln9YUHe+E5lN+rdo0KWJBu0Z8yZ8CgEOVQxuYYpTMrfO
 jNbl46UYAaHIcQj6ruEzaJlmUB4jwpitNNlW+2hyIvzsYJwzPsd2o9j+Hr38oN3Z+n9G8pt05
 ztfHnlZH68fQYALKbGRSdz07uv9viOqBQmITea4GbFhsJirkGOneKqLhyaEE9DIoK2rmdcNK2
 dlM50ECGhzi53gRtSlniw5BX2XIbhCCG0ng9PVA3hLa1kNEIYm8eKMVdlAjoR1Evb/oWPw2rs
 /wWvkUVlU7tL7ACLJSU30mKIA08hZMl8FvkTf3ILf9qWAOnYSxrho9TrUbfN2BSRuhOYTdOOf
 xm42onJrxQHmVCjekt+oSDF8rp48kJY5iESeS2rP2UB8/minfFvDuv27qGZY3EFzAYl7F1nis
 sxynAETnA6BcmOlZRlzIvYG2aH6wJHJpjKrywtPu8gaiDjd/M/XmhCHCGYO6mlTPhtVN8dcHy
 i1YH0vAp9vcH63Y39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.08.20 um 14:39 schrieb Derrick Stolee:
> On 8/2/2020 10:38 AM, Ren=C3=A9 Scharfe wrote:
>> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
>> 2016-06-08), significantly reduce the number of system calls and
>> simplify the code for sending object IDs to pack-objects by using
>> stdio's buffering and handling errors after the loop.
>
> Good find. Thanks for doing this important cleanup.
>
> Outside of Chris's other feedback, this looks like an obviously
> correct transformation.

I spent a surprising amount of time trying to find a solution that is
easy to use and allows precise error handling.  But now I get second
thoughts.  The main selling point of buffering is better performance,
which is achieved by reducing the number of system calls.  How much
better actually?

So I get this in my Git repo clone without this patch:

  $ strace --summary-only --trace=3Dwrite git multi-pack-index repack --no=
-progress
  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
  100.00    2.237478           2    921650           write
  ------ ----------- ----------- --------- --------- ----------------
  100.00    2.237478                921650           total

And here's the same with the patch:

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
  100.00    0.013293           2      4613           write
  ------ ----------- ----------- --------- --------- ----------------
  100.00    0.013293                  4613           total

Awesome, right?  write(2) calls are down by a factor of almost 200 and
the time spent on them is reduced significantly, as advertised.  Let's
ask hyperfine for a second opinion though.  Without this patch:

  Benchmark #1: git multi-pack-index repack --no-progress
    Time (mean =C2=B1 =CF=83):      1.652 s =C2=B1  0.206 s    [User: 1.38=
3 s, System: 0.317 s]
    Range (min =E2=80=A6 max):    1.426 s =E2=80=A6  1.890 s    10 runs

And the same with this patch applied:

    Time (mean =C2=B1 =CF=83):      1.635 s =C2=B1  0.199 s    [User: 1.36=
3 s, System: 0.204 s]
    Range (min =E2=80=A6 max):    1.430 s =E2=80=A6  1.871 s    10 runs

OK, so system time is down by ca. 50%, but the total duration is
basically unchanged.  It seems strace added quite some overhead to our
measurement above.

Anyway, now I wonder if adding our own buffer on top if the
OS-internal pipe buffer is actually worth it.  The numbers above are
from Debian testing , by the way.  Perhaps buffering still pays off on
operating systems with slower pipes..

Ren=C3=A9
