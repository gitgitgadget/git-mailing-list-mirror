Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B5C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF81207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cXB1LFzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgHDEbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:31:48 -0400
Received: from mout.web.de ([212.227.15.3]:37321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgHDEbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 00:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596515502;
        bh=5DZYzkUCXr3ysDzilghdks6vpoyaUgK+BgFdDuqLmfc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=cXB1LFzlRG224JAJYi8hI6LSjdOH9kWxU8lZ7wUQF1qtC0mkVga98XrqTg/7aPua4
         8XDjIOPpaKrWwJD+fDpJhd4G3OePHPIad0UNavHCUJ4vMm/0fnc8CzYJI+YgUUgjDy
         QHz+JjLAXnmU2ec3vgO9QRs3hu7MxahwdSXF/6Ko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhUQ6-1kPJa01518-00MaBb; Tue, 04
 Aug 2020 06:31:42 +0200
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Johannes Sixt <j6t@kdbg.org>, Chris Torek <chris.torek@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
 <CAPx1GveChRzsA=FayzhZRSQLPz+o1Po3-_9ZvAGLPztpH5Jg9w@mail.gmail.com>
 <1fd18b0c-8c2c-54ab-89aa-357b046eb403@kdbg.org>
 <fdf66f66-b7ed-f733-22d0-23ec17209f40@web.de>
Message-ID: <90b839cd-29e0-3d20-8661-a2a73eff9ced@web.de>
Date:   Tue, 4 Aug 2020 06:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fdf66f66-b7ed-f733-22d0-23ec17209f40@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8n8AcqeuwBhHhAcP8M9snzSdxBpNcGL0GndrBAqFjal5zRciP19
 ARCIzYzgrRIJjSXZG5E7+KbtjCjoxMDETgFg2/qT3khpVF8D3PBWBu8+a37fYaia/RPhzx5
 PTILIx/CqhyZVoPM28RdY0B6ZWIbhhz1aIZ8UvzsDi+ZlAgVokPvjRCMfgttGxzJw01gXSq
 B7/Hdg25PQezhfGhNxEOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bTgDFyivjxk=:42YzlLQdnagOjEmg21Qt2u
 P9aoDbeVIs116ZHm05XfzMamAUHwWLEz2mSsoCcTHOSOkCncC4/f8Rh+9B/08S9maQsGTLjJs
 QEUxgyNoBknkYYEGx3xb8qPaCPsD2iimAKbxeTcmM3Mt/PTxuaSBwNo2+Clp31yxrTiScKmZi
 iYJ3qsNn6aCpKCKmqrGchS88z5Hp2QCXckCSgWljYH6/o62Ek5kbwub9WSNZiE/iwe6ABU508
 dyggfadddm3vk4N3VotOWRZDfWW1WOMnWcjZva4vVvwMNH1dyShusP8IxHMdjIBcH4VbbdHVP
 KRq9HKZeDMoH+gNzQDJf1p9dRBSBJpMCV57eFak/nc6uBVjh2/fUvUWZdm7iuADD5OhTWjJYH
 qqhTQARB4XcMvXrmjZZ61SVIjOwrQZX+Estj0NZVHcKaKJLL2Z8GV7uUOC3ViY/zK0m1uzDm8
 loTyZsNwkLVM2FufQ0Q7s/5fJ20fu92V+ylhdEKQv4AsvveBJnuYqxPMOaoQ0f/cLWv49HeoL
 LIe2GpIXr4O3FYFFrSofmcsWcTrtLXSsFfU4stMdu+lScR9LPDjJuQPLzFsaUirpDChXCXnf1
 2CFw7L/dEDXGkevLx/QY338alPQwYET8s31KqfAlMIlDHHGjsUtifoZw267UJaxZnvm4ViNB6
 NxcN5hmvKWj3ZCahkU7Zn519Nym3udffohxkPexVrZ0jWKJzi4Axd+kh+p3/xvu3UlpfQB7er
 IdITVqCURW2a48hRTyMmS9DvS5LvorRXcnXRbqlHHXeLHRh9F9jcCE4LGAXqVybiIWEDD5tfW
 MbHFWjblhOCTwFNQ4wCHW9CyOYGeYrjOU5jNGSYO1/dFBeej40HpypYchDW96tjQ6S0F0qH/o
 /G1aKFottsO8f7BKkYhbCvWGdRU+2PTJTfVemVARzqbZ0Nd7Ql5f0qd/GX01YLbg8IHvm+87M
 FqAuovJY6jF6BuWO+IvZHLdDsp2XCo4Yrn3+fHAH0DEBY6EJILtdpYBR5E15gpEM73KD8RqOJ
 PXwdbKiM1KTRNWJpJP+10LAfPmAk+5ANfE8oYb3nAOCCpdsCJqJiLrmYjnNhQ8pfGPXHhAEsx
 zTQRPmpVb08iX1TiCNPxWzgiAMGffDMk+pLF35LbFCqIWZpa5Jz+loZBqJpSd6vf4cMe7eokc
 YAgjMdeqqrIO10MJXjb7hdUWTuVyEeuOOIUlf2/IdaGxnEk527do660wcWV0g/iLhMlY9z5WO
 QJ/AGOwkUGC0EAvdC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.08.20 um 00:27 schrieb Ren=C3=A9 Scharfe:
> Am 03.08.20 um 20:10 schrieb Johannes Sixt:
>> Am 02.08.20 um 18:11 schrieb Chris Torek:
>>> On Sun, Aug 2, 2020 at 7:40 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>>> @@ -1443,10 +1446,15 @@ int midx_repack(struct repository *r, const c=
har *object_dir, size_t batch_size,
>>>>                         continue;
>>>>
>>>>                 nth_midxed_object_oid(&oid, m, i);
>>>> -               xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz=
);
>>>> -               xwrite(cmd.in, "\n", 1);
>>>> +               fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
>>>> +       }
>>>> +
>>>> +       if (fclose(cmd_in)) {
>>>> +               error_errno(_("could not close stdin of pack-objects"=
));
>>>> +               result =3D 1;
>>>> +               finish_command(&cmd);
>>>> +               goto cleanup;
>>>>         }
>>>> -       close(cmd.in);
>>>>
>>>>         if (finish_command(&cmd)) {
>>>>                 error(_("could not finish pack-objects"));
>>>> --
>>>> 2.28.0

>> We need this explicit test after each fprintf anyway because SIGPIPE ma=
y
>> be ignored, and then writing fails with EPIPE. On Windows, this is
>> doubly important because we do not have SIGPIPE at all (and always see
>> EPIPE), but we see EPIPE only on the first failed write; subsequent
>> writes produce EINVAL.
>
> Why is this important?  The current code doesn't care about it, at
> least.  It does care about EINTR, though.

Ah, that's the point, right?  You want to *ignore* EPIPE, because the
failed pack-objects process at the other end will have died with a
(hopefully) useful error message already.

OK, so we also need a fprintf() wrapper that retries on EINTR, ignores
EPIPE and exits early if the error indicator is set?

Somehow staying with write(2) and its friends and just adding strbuf
based buffering looks attractive to me now. :-/

Ren=C3=A9
