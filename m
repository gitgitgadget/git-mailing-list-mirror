Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50220C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7A12068D
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgFHTlf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 8 Jun 2020 15:41:35 -0400
Received: from elephants.elehost.com ([216.66.27.132]:46352 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgFHTle (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 15:41:34 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 058JfK0S063743
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Jun 2020 15:41:20 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Brandon Casey'" <drafnel@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'git'" <git@vger.kernel.org>, "'Kyle Evans'" <kevans@freebsd.org>,
        "'Jeff King'" <peff@peff.net>
References: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com> <xmqqd06an6wf.fsf@gitster.c.googlers.com> <CACNAnaHBPeg1SMMGUdErKnn12bGo8t3O7LU6Yktw40B7bKfBGA@mail.gmail.com> <xmqqlfkxlbn4.fsf@gitster.c.googlers.com> <CA+sFfMcQ+HQPk3SMsBhWjfLiVLzfhHSv9OpzPHAJt5b50TEPeQ@mail.gmail.com>
In-Reply-To: <CA+sFfMcQ+HQPk3SMsBhWjfLiVLzfhHSv9OpzPHAJt5b50TEPeQ@mail.gmail.com>
Subject: RE: fread reading directories
Date:   Mon, 8 Jun 2020 15:41:10 -0400
Message-ID: <013101d63dcc$c5fc5740$51f505c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHV2Ey5NwX6D3scTu6T+7xb+9sm9AD6SddXAeTfzA4Chr/KtQIFiH/ZqJSMxKA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 8, 2020 3:08 PM, Brandon Casey wrote:
> To: Junio C Hamano <gitster@pobox.com>
> Cc: git <git@vger.kernel.org>; Kyle Evans <kevans@freebsd.org>; Jeff King
> <peff@peff.net>
> Subject: Re: fread reading directories
> 
> On Mon, Jun 8, 2020 at 10:18 AM Junio C Hamano <gitster@pobox.com>
> wrote:
> >
> > It may make sense to do one of the two things:
> >
> >  - The lighter weight one is to rename the macro to the reflect the
> >    trait we are trying to capture more faithfully: "fopen opens
> >    directories" and leave the code and performance characteristics
> >    as-is.
> >
> >  - Heavier weight one is to audit callers of fopen() and only let
> >    those that know they do not have a directory directly call
> >    fopen().  The other callers would call our wrapper under a
> >    different name.  This way, the former won't have to pay the
> >    overhead of checking for "you gave me a directory but I only take
> >    a file" error twice.  This is what Brandon proposed in the
> >    thread.
> >
> > Doing neither would leave this seed of confusion for later readers,
> > which is not ideal.  I am tempted to say that we for now should do an
> > even lighter variant of the former, which is to give a comment.
> >
> > Thoughts?
> 
> I'd suggest a medium weight approach which would be to introduce a new
> function with an appropriate name (fopen_file_only()?) that behaves the way
> we want it to, and replace every existing fopen() call with this new function.
> We could introduce a new macro, which I think would only be used on
> Windows, to say "fopen already fails to open directories"
> (FOPEN_FAILS_ON_DIRECTORIES?) so that fopen_file_only could be
> simplified to just a bare fopen there. That way it's clear to the reader, at the
> callsite, that the call does not have the standard behavior of fopen.
> 
> Then, FREAD_READS_DIRECTORIES could be removed from all but the 1 or 2
> platforms that it was originally set for. I'd imagine that we'd basically just
> promote the git_fopen() function from compat to become the
> implementation of the first tier fopen_file_only() function.  On the
> FREAD_READS_DIRECTORIES platforms, a bare fopen would also become
> fopen_file_only(). The call to fopen() within fopen_file_only() would
> obviously need to take this into account to ensure that it calls the real
> fopen().
> 
> I think this would put the pieces in place for someone to audit all of the
> existing uses of fopen_file_only() and potentially replace them with a straight
> fopen() if appropriate. And it would allow future code to explicitly make the
> choice between fopen_file_only() or just fopen().
> 
> None of this would produce any functional change on any of our platforms,
> but I think it would make things more clear.

Please keep me on the loop on this one. The NonStop platforms have FREAD_READS_DIRECTORIES UnfortunatelyYes. We will want to move to the new structure as soon as we can, so compat makes me comfortable.

Thanks,
Randall

