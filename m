Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7541C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 09:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhLUJpb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Dec 2021 04:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbhLUJpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 04:45:31 -0500
Received: from mx.mickler.org (mx.mickler.org [IPv6:2a01:4f8:c2c:3e1e::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50FC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 01:45:30 -0800 (PST)
Received: from dynamic-2a01-0c23-c0f1-c300-99b6-808b-59c9-f3d7.c23.pool.telefonica.de ([2a01:c23:c0f1:c300:99b6:808b:59c9:f3d7])
        by mx.mickler.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <florian@mickler.org>)
        id 1mzbi1-000Iei-OC; Tue, 21 Dec 2021 10:45:25 +0100
Date:   Tue, 21 Dec 2021 10:45:23 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <nycvar.QRO.7.76.6.2112202223300.347@tvgsbejvaqbjf.bet>
References: <20211218010621.2fdc2b3c@monster.mickler.org> <xmqq7dc2zplg.fsf@gitster.g> <nycvar.QRO.7.76.6.2112202223300.347@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: passing CURLOPT_CERTTYPE to libcurl
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org, jqassar@gmail.com
From:   Florian Mickler <florian@mickler.org>
Message-ID: <4B51B2CA-3BED-4046-8544-219DA737E7CD@mickler.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the summary!
I am currently looking into it. Got into a conversation with dwmw2 also about fixing libcurl or even openssl after i found some issues he opened about this weird interface. Which really sounds like it would be the real fix. (Although probably slower to trickle to end users and more complex)


For this patch i guess I will skip the engine variable, because it is not needed for my use case and my lib version. (Although I am still experimenting with the whole pkcs11 stuff)

That makes the error handling easier (none needed, imo).
The git libcurl min version is also raised above the introduction of those curlopts, so no libcurl-version-bracing needed.

I was looking into the testing framework, it might be possible to configure the https to require client auth on a different port and then testing that with pem and der file.

Adding pkcs11 infrastructure to the test harness might be a bit over the top though :-)

Best regards,
Flo



Am 20. Dezember 2021 23:21:28 MEZ schrieb Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>Hi Junio & Florian,
>
>On Fri, 17 Dec 2021, Junio C Hamano wrote:
>
>> Florian Mickler <florian@mickler.org> writes:
>>
>> > Is there a specific reason, that patch wasn't merged? It would
>allow
>> > for non-pem ssl certificates to be loaded also (without pkcs11 at
>all).
>> >
>> > I realize, that the underlying systems could and should set up
>> > everything automagically as soon as i point them to the certificate
>that
>> > i want to use. But not opening up these CURL Settings from git
>seems
>> > kind of silly given that today's systems still seem kinda borked
>and do
>> > not do that.  What harm comes from these two tuning knobs being
>exposed?
>> >
>> > Best regards,
>> > Flo
>> >
>> >
>> > [1] https://marc.info/?l=git&m=136675822032549&w=2
>
>This corresponds to
>https://lore.kernel.org/git/1366758207-7724-1-git-send-email-jqassar@gmail.com/
>(for those who prefer lore.kernel.org over marc.info, and for those who
>want to look for the Message-ID directly).
>
>My summary of that thread:
>
>- The patch implements something Git wants to support.
>
>- A couple of improvements need to be made, such as:
>
>  * Error-checking needed to be improved
>
> * Adding a hint to the documentation of `http.sslKeyType` being set to
>    `ENG` causing `http.sslKey` being interpreted differently.
>
>  * Adding regression tests, if possible
>
>  * Maybe a more complete commit message?
>
>- Testing the smart card support was considered hard, especially given
>that the contributor still wanted to contribute patches to cURL without
>  which it wouldn't work.
>
>  The patch seems to have been contributed via
>  https://curl.se/mail/lib-2013-04/0340.html, been reviewed and changes
>  were requested, but there was no other patch submission that I could
>  find.
>
>However, over five years later, what looks like an equivalent fix to me
>  was applied:
>https://github.com/curl/curl/commit/4939f3652473c1519d2b604068efb87ef7531874
>
>- The contributor, Jerry Qassar, gave all the signs of working on a
>  next iteration ("reroll", as Junio likes to call it). But that never
>  materialized, either:
>
>  https://lore.kernel.org/git/?q=f%3Ajqassar
>
> Based on this, the lack of a cURL contribution, and a quick web search
>  for the name "Jerry Qassar" I somehow doubt that Cc:ing them might
>  raise their attention.
>
>> Almost always, when some patch aims to achieve a worthy goal, and in
>> the initial discussion on the thread more experienced project
>> members agree it is a worthwhile thing to do, the only reason why
>> the feature proposed does not materialize in later versions of Git
>> is because the developer with the original itch did not follow it
>> through after getting review comments and saying something that
>> makes reviewers to expect an updated version of the patch.
>>
>> I didn't follow your marc.info URL, but I am reasonably sure, if I
>> were involved in the discussion, that would be the likely reason.
>
>Yes, you were involved in the discussion, and indeed, there was no
>follow-up.
>
>After more than 8 years, I do believe that the patch is fair game to be
>picked up by any other interested contributor who might want to
>contribute
>v2 (hint, hint, Florian... all it would take is to study the mail
>thread
>from way back when and adapt the patch accordingly, of course after
>rebasing it to a recent Git revision).
>
>Ciao,
>Dscho

---
Signature
