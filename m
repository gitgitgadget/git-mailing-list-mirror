Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B0C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CA061C37
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFVak convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 6 Jul 2021 17:30:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:59962 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFVak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:30:40 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 166LRu2Y053701
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Jul 2021 17:27:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Alex Henrie'" <alexhenrie24@gmail.com>,
        "'Richard Hansen'" <rhansen@rhansen.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com> <20210705123209.1808663-2-felipe.contreras@gmail.com> <87bl7f5ho1.fsf@evledraar.gmail.com> <60e4bf9a6a628_1c4281208b@natae.notmuch> <04de01d772a8$540c6690$fc2533b0$@nexbridge.com> <60e4c71099ef_1c4281208ad@natae.notmuch>
In-Reply-To: <60e4c71099ef_1c4281208ad@natae.notmuch>
Subject: RE: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Date:   Tue, 6 Jul 2021 17:27:51 -0400
Message-ID: <04df01d772ad$c9ac7430$5d055c90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEjwC2BG0r8Ti4tiVL2ONsdEMpHYQJC7SfhAdO76CQCFHAokgHyNSSTA0AC0f2sQvAUQA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 6, 2021 5:12 PM, Felipe Contreras wrote:
>Randall S. Becker wrote:
>> On July 6, 2021 4:40 PM, Felipe Contreras wrote:
>> >Subject: Re: [RFC PATCH 01/35] merge: improve fatal fast-forward
>> >message
>> >
>> >Ævar Arnfjörð Bjarmason wrote:
>> >>
>> >> On Mon, Jul 05 2021, Felipe Contreras wrote:
>> >>
>> >> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> > ---
>> >> >  builtin/merge.c | 2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/builtin/merge.c b/builtin/merge.c index
>> >> > a8a843b1f5..05e631229d 100644
>> >> > --- a/builtin/merge.c
>> >> > +++ b/builtin/merge.c
>> >> > @@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>> >> >  	}
>> >> >
>> >> >  	if (fast_forward == FF_ONLY)
>> >> > -		die(_("Not possible to fast-forward, aborting."));
>> >> > +		die(_("unable to fast-forward"));
>> >>
>> >> I read the existing message a bit more like "this makes no sense
>> >> anymore" (correct) and the latter more like "we encountered an error".
>> >
>> >I mean, this is the documentation of --ff-only:
>> >
>> >  With `--ff-only`, resolve the merge as a fast-forward when possible.
>> >  When not possible, refuse to merge and exit with a non-zero status.
>> >
>> >So if you do `git merge --ff-only` you are telling git: "I want you to exit with an error when the fast-forward is not possible".
>> >
>> >If you do:
>> >
>> >  % git merge --ff-only
>> >  fatal: Not possible to fast-forward, aborting.
>> >
>> >That "aborting" part is redundant; we know `git merge` should abort if the fast-forward is not possible, we explicitely told git to do that.
>>
>> `git merge` is a special operation where errors (conflicts, for one)
>> may leave the repository in a merge pending state where you
>> subsequently may have to use `git merge --abort` to reset the
>> situation or `git add` to continue. The `aborting` output makes it
>> clear that you do not have to do the `--abort` and *cannot* do the
>> `add` because there was an implicit `--abort` done resulting from the
>> failure.
>
>But this is not a `git merge`, this is a `git merge --ff-only`; they are different operations. There *never* is a need for `--abort` with `git
>merge --ff-only`.

Well, you know that and I know that, but having to explain this to every new git user who will operationally use git merge --ff-only within hours or days of their first clone is a different matter.

>Anyway, the error message is meant for `git fast-forward` which definitely doesn't need any `--abort`.
>
>Initially I created a new variable to have a different error message for `git merge --ff-only` and `git fast-forward`, precisely to avoid
>changing the current error message of `git merge --ff-only` and thus avoid any inertial comments like this one. But then I thought there
>was no need to complicate the series when both can be improved at once.
>Apparently that's not the case.
>
>I guess I'll add it back.

Thanks. I understand the purpose here.

-Randall

