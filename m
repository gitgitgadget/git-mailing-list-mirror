Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C6E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjJBCgr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 1 Oct 2023 22:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjJBCgq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:36:46 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C16C9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:36:43 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-65af75a0209so71647976d6.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214202; x=1696819002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80TqUISKuKYB07hrqc7MfSAWX563oyqAwbGa3UK1Cjc=;
        b=wSU/cQG52AemS5MICNOAvLV12G55aJmHkTXZ0iB2ABtcQeqQVhFrgoyEeFU/iX5AML
         vEK6nLfEOViyqNRGrgjxG4ltTi23NUnRwMlVgMlpLBcE8QzZaIfQzMpDiQOBZuVu5S0U
         uZnurN4/IolWoaNRqfwHhH6MPk/UPpaiZMe7Vr9udEV+MnVbyNKlIC7duYDWb6Ue1Nb7
         yulwiKtywM4FZCl+LjYIwz+BuPvmzpcsYQqa2BLmJnJSqnweJ9V6jGqTukbQ4N6pJTVe
         YfEWsVL945dT+TQrVy5pF5nlPzDuZUSh1oQ/amlyWa4JgBlIxZREgs/AdyNsfZAjipeY
         qIGw==
X-Gm-Message-State: AOJu0YxcJ42CCtyoHzlV6GcZHcqS+2KZ5TkmFmw7xlSwt40hEcHz6KWu
        MhfgyBbJHWiaXHHo1cauYZH1HgellOA/rrW5mmI=
X-Google-Smtp-Source: AGHT+IFQl1cOU/rHEh2QTXN+ErQsWHU3OikfD7a3OZQ1vrkOLZ6wMzx66C5jmKuDicgAYiEIAtxYqxbS6uhiRRMJvlA=
X-Received: by 2002:a0c:e44d:0:b0:65b:771:f2d5 with SMTP id
 d13-20020a0ce44d000000b0065b0771f2d5mr8863126qvm.61.1696214202412; Sun, 01
 Oct 2023 19:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
 <20230927195537.1682-5-ebiederm@gmail.com> <CAPig+cS02ushqgw+u39Tmnoy3rgp8BzqT4T9D=-01m5fsLxC6Q@mail.gmail.com>
 <87v8bp93j5.fsf@gmail.froward.int.ebiederm.org>
In-Reply-To: <87v8bp93j5.fsf@gmail.froward.int.ebiederm.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 1 Oct 2023 22:36:31 -0400
Message-ID: <CAPig+cS2TVZJQmfQNQud5dRcROFN3kTeu-OBTmCW=7aNjoJGxw@mail.gmail.com>
Subject: Re: [PATCH 05/30] loose: add a mapping between SHA-1 and SHA-256 for
 loose objects
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2023 at 10:11 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Wed, Sep 27, 2023 at 3:56 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> >> +       for (; iter != kh_end(map); iter++) {
> >> +               if (kh_exist(map, iter)) {
> >> +                       if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
> >> +                           oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
> >> +                               continue;
> >> +                       strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
> >> +                       if (write_in_full(fd, buf.buf, buf.len) < 0)
> >> +                               goto errout;
> >> +                       strbuf_reset(&buf);
> >> +               }
> >> +       }
> >
> > Nit: If you call strbuf_reset() immediately before strbuf_addf(), then
> > you save the reader of the code the effort of having to scan backward
> > through the function to verify that `buf` is empty the first time
> > through the loop.
>
> I am actually perplexed why the code works this way.
>
> My gut says we should create the entire buffer in memory and then
> write it to disk all in a single system call, and not perform
> this line buffering.

I think I had a similar question/thought while reading the patch but...

> Doing that would remove the need for the strbuf_reset entirely,
> and would just require the buffer to be primed with the
> loose_object_header.
>
> But what is there works and I will leave it for now.

... came to this same conclusion.

> It isn't a bug, and it can be improved with a follow up patch.

Exactly.

I haven't thought through the consequences, but perhaps brian was
worried about the memory footprint of buffering the whole thing before
writing to disk.
