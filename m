Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B0C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2946423718
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392967AbhAUA0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:26:04 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:45260 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403848AbhATXTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 18:19:45 -0500
Date:   Wed, 20 Jan 2021 23:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611184662;
        bh=sarW6sRfwypjPnoS7hhKJwtwOCbduIyid3Qnxn8wDzE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UDZECVZdP3rYTFP237cpOpVbkROM6gcmK+/mEV+8vW1G1fBU3EcRqEQ209WA7PFm8
         yq81pq7Atzp8Cww3aX6aVDhihzJpdh4pFhxaheOdfR+5+PRVwedqWgiYjQmEoihrqr
         +HgAQz45Np6ky+PmVJoiiJ5KLLYoTW54Gkh0vbnk=
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [Wireshark-dev] Multiple-line parsing of packets dissected over HTTP
Message-ID: <aCtJaGp2bmtHdiu65J9Z3vSEeFMfN9OvOzv-eXNbnXUVKpH-f7q48QJpTklEWoOEaAt4ctixkpOIC8vMTmBP7er36t-y8HHFRA17vXzB-UE=@protonmail.com>
In-Reply-To: <YAd0044tbht/DOKq@google.com>
References: <s1Sx5qZaXOlypsQCtHxGBayhdqUl1j2vuywQN6cG59KarFM9HZu32n0CEtcje206DeKXAYuqBoNbDOA8bgwXZI3u_3nwPxYFme2GcqV0I3s=@protonmail.com> <CAGka-81Ze71igsW2zsfzYqqkr+sz5FE6YYo3mEpdEQUSUxZvaw@mail.gmail.com> <YAd0044tbht/DOKq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, Jonathan,

On Tuesday, January 19, 2021 6:09 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:

> Hi,
>
> Pascal Quantin wrote:
>
> > Le mar. 19 janv. 2021 =C3=A0 17:45, Joey Salazar via Wireshark-dev <
> > wireshark-dev@wireshark.org> a =C3=A9crit :
>
> > > In commit 33af2649 [1] we can keep dissecting the contents of the req=
,
> > > adv, and res packets by setting
> > > while (plen > 0) { }
> > > either in `dissect_git_pdu()` or in `dissect_one_pkt_line()`, but for=
 now
> > > in `dissect_git_pdu()` it'd be a bit messy, so wanted to ask for your
> > > feedback for getting `dissect_one_pkt_line()` to work properly first.
> > > As you can see in pcap 169 [2], it correctly parses the length of the
> > > first line as 0x0014 (20 bytes) until `0x0a`, then it's supposed to g=
et the
> > > length of the next line by the first 4 hex bytes in that line, but in=
stead
> > > of reading the length as 0x0018 (24 bytes) it's reading it as 0x0010 =
(16
> > > bytes), and anyways, this particular line's length actually is 59 byt=
es.
>
> Interesting. Let me summarize your question: getting the information
> in one place here, the relevant code at line 114 looks like
>
> | + while (plen > 0) {
> | + proto_tree_add_uint(git_tree, hf_git_packet_len, tvb, offset, 4, plen=
);
> | + offset +=3D 4;
> | + plen -=3D 4;
> | +
> | + proto_tree_add_item(git_tree, hf_git_packet_data, tvb, offset, plen, =
ENC_NA);
> | + offset +=3D plen;
> | + // To-do: add lines for parsing of terminator packet 0000
> | + }
>
> The relevant part of the pcap is shown in an image; transcribing
> imperfectly, I see
>
> | 0014command=3Dls-refs\n
> | 0018agent=3Dgit/2.29.0.rc2
> | 0016object-format=3Dsha1
> | 0001
> [etc]
>
> where \n denotes a newline byte and there are no newlines between
> these pkt-lines.
>
> That first pkt-line has 4 bytes for the length, followed by 12 bytes
> for "command=3Dls-refs\n", including newline. So why does this parse as
>
> packet-length: 0x0014
> packet data: "command=3Dls-refs\n"
> packet-length: 0x0010
> packet data: "agent=3D[etc]"
>
> ?
>
> [...]
>
> > So what is the code leading to this dissection? It does not seem to be
> > https://gitlab.com/joeysal/wireshark/-/commit/33af2649927cb5660d4aeb64b=
9a9e9a58a1823aa
> > as dissect_one_pkt_line() seem to read only one line (BTW using a while
> > loop in this commit is useless as you are incrementing offset by plen, =
and
> > the code you shared considers that plen includes the 4 bytes of the pac=
ket
> > length field while your screenshot does not assume that).
>
> This reply is a bit dense, but it contains the hints to move forward:
>
> First, there's the matter of the contract of the dissect_one_pkt_line()
> function. The name suggests it would dissect a single pkt-line, but
> it has this loop in it. What does it actually do? And what do we
> want it to do?
>
> That second question is easy to answer: this code will be much easier
> to read if dissect_one_pktline dissects a single pkt-line! For
> example, if we imagine a contract like
>
> /** Dissects a single pkt-line.
> *
> * @param[in] tvb Buffer containing a pkt-line.
> * @param offset Offset at which to start reading.
> * @param[out] tree Tree to attach the dissected pkt-line to.
> * @return Number of bytes dissected, or -1 on error.
> */
> static int dissect_one_pkt_line(tvbuff_t *tvb, int offset, proto_tree *tr=
ee)
>
> then we could call this in a loop, like:
>
> int offset =3D 0;
>
> while (offset < total length)
> offset +=3D dissect_one_pkt_line(tvb, offset, tree);
>
> Obtaining the total length and including some error handling left as
> an exercise to the reader.
>
> As for the first question: what does the current code do? The loop at
> l114 doesn't modify plen except by subtracting 4 from it. So instead
> of reading the pkt-length from the next pkt-line, it assumes it is 4
> bytes less. 0x14 - 4 is 0x10, hence the 0x10 as pkt length
> assumption.

This was most helpful, thank you, in some cases I couldn't understand why `=
pkt-length` was being parsed the one it was.
Apologies to all for my poor explanation of what I wanted the code to do!

I've updated the commit and it now is 9342d7fb [1], it is now reading the s=
ize of each pkt-line before checking for `0000` Flush Packet (checking for =
`0001` delimiter could be added in line 131) and jumping to the next pkt-li=
ne.

However, I understand now that `while (plen > 0)` in line 119 should not be=
 doing that since that `plen` is for the first pkt-line only, making this a=
n unsuitable approach.

I'll start working on the approach suggested above by Jonathan. All your fe=
edback and observations most welcome.

Thank you all for the input and time invested so far,
Joey

[1] gitlab.com/joeysal/wireshark/-/commit/9342d7fbc15fad4ec7765bbbb0f167231=
9dc705a
