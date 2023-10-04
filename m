Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD29E7C4F0
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjJDUFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjJDUFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 16:05:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C9AB
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 13:05:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 350BA349EF;
        Wed,  4 Oct 2023 16:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5HMnMuT6QsTR
        09ATeslIbZO4isLxd4DOO/gd7bsXluo=; b=Pnjk/ZLXIZfyUdpwdidjN4RhZivp
        FKnzEZbgeqt05OirXg5FXS4TjkRsIJWBiohw+9phRloecAA5fhucCbdv0fEZ53B5
        RXy8wCV4b63g7tVGBpbDDlRfWhvdZFqwdZW4Wu3uj2asnQhjBXmjkptq+dPNXL2m
        JnTDGAHb1z7Pw80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D02B349E0;
        Wed,  4 Oct 2023 16:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8B8F349DE;
        Wed,  4 Oct 2023 16:05:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] pkt-line: do not chomp newlines for sideband
 messages
In-Reply-To: <CANYiYbHp-3YuSPHnR8gjS40UJLrJV5FPzqd_BtjyR8TAALhfRQ@mail.gmail.com>
        (Jiang Xin's message of "Wed, 4 Oct 2023 21:02:25 +0800")
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
        <20230925154144.15213-3-worldhello.net@gmail.com>
        <xmqqa5t9rkft.fsf@gitster.g> <ZRKax7Me5uIHKHoC@ugly>
        <CANYiYbHp-3YuSPHnR8gjS40UJLrJV5FPzqd_BtjyR8TAALhfRQ@mail.gmail.com>
Date:   Wed, 04 Oct 2023 13:05:33 -0700
Message-ID: <xmqqa5syp302.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 60EB700E-62F1-11EE-940E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> On Tue, Sep 26, 2023 at 4:48=E2=80=AFPM Oswald Buddenhagen
> <oswald.buddenhagen@gmx.de> wrote:
>>
>> >Jiang Xin <worldhello.net@gmail.com> writes:
>> >
>> >> +++ b/pkt-line.c
>> >> @@ -462,8 +462,33 @@ enum packet_read_status packet_read_with_statu=
s(int fd, char **src_buffer,
>> >>      }
>> >> +                    case 2:
>> >> +                            /* fallthrough */
>> >> +                    case 3:
>> >
>> while not entirely unprecedented, it's unnecessary and even
>> counter-productive to annotate directly adjacent cases with fallthroug=
h.
>
> I see in "blame.c" there are directly adjacent cases like below. I
> will remove the fallthrough statement.
>
>         case 'A':
>         case 'T':
>                 /* Did not exist in parent, or type changed */
>                 break;

Yeah, it is far clearer to understand if it is written without the
"fallthru" comment between the cases and instead a comment that
explains both cases after them (exactly like the example you found
in "blame.c").  When we want "fallthru" comment is if we had some
processing specific to the earlier case ('A' or '2') that is not
done in the later case ('T' or '3'), in which case we may want to
explicitly say we did not forget to "break" by adding the "fallthru"
comment.  But it does not apply here.

Thanks.

