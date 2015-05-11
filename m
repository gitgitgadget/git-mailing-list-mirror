From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] Fix atomicity and avoid fd exhaustion in ref transactions
Date: Mon, 11 May 2015 10:32:32 -0700
Message-ID: <CAGZ79kZFESzovGGq=igMtJDUMO9E_XQ4QPw=20WVLQRPz68MdQ@mail.gmail.com>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 19:32:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrrZG-0001Ei-UC
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbbEKRce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:32:34 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35849 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbEKRcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:32:33 -0400
Received: by iecmd7 with SMTP id md7so36363427iec.3
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1s7wQu9kdAekgmsB0qSAX++09jrV2O+VpluDFxALVTw=;
        b=JWb6pgu5kc2iGdjRHwjpUWvqpf6jEGzYya8DuyxjTv+7lkJr4/OCpj8M+12KhUZa4Z
         ufCWhdu429aeKBAgBEuA6wftAVzYp/2IKTIIhWrJ9cizvh7ZPxVv5V+9FX8sDvMBi7kw
         DWqyBihPl+G1J2zde590qvkCYJXqE2/i7MbJ52y6Wr2kWFYBADHTYpjddMuG5+dabOUh
         4gr3Pzb04KDHiJ/fDVuCA01njKNKcc+APXHQUpw5qnykqa+z4/xOIF1FGXPei7UAdoQy
         FVi+sFLpsE4dkq88+5ki37EdD+SZpvu/5vyD3jemhSQWugVSbr4wX0M0Xf1UgLx2DppO
         MZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1s7wQu9kdAekgmsB0qSAX++09jrV2O+VpluDFxALVTw=;
        b=cTDuji0BeKrYTl4k+9aZGVr2H5ii+lA439E+Lghxz+nHHS95dMdqguTVqPYzf70f+v
         FqC83SJefSK63hfONYDuUbC3tgkh6TOkGT1PiXfjcI5YtprXJZxjvtvO/AkviPAkW04I
         5wdA6u8vfxNfc5fsuYqZWY4gO1Pxq10D2JRqWZwiLmqmFACjN93kQEu9ipl53zj0jBaU
         bTvxEOhUZwC5UrnH5s3p8k1ZE9CP6Vt9GmbYd8HKxJm10u2j/czojNtmIbKQ0B7N1QST
         rQqq5fupuJ1jZgrVtQIPkYF/oexL+rwNaEeNpehCY5gVP0efQzEYFuTQVCoPUkz2shO1
         mZ7A==
X-Gm-Message-State: ALoCoQlcQMrn4cvvzYL52mlr23M/DOFaoJJzqrohSmlMY7+1iZr08VDQVb8WL8ENFxKczdetCH08
X-Received: by 10.42.20.14 with SMTP id e14mr12372069icb.76.1431365552917;
 Mon, 11 May 2015 10:32:32 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 10:32:32 -0700 (PDT)
In-Reply-To: <xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268801>

On Sun, May 10, 2015 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> The following other branches, also from my GitHub repo, might be
>> useful:
>>
>> * 'write-refs-sooner-2.3' -- suggested merge of the change to 'maint'.
>>
>> * 'write-refs-sooner-master' -- suggested merge of the change to
>>   'master'.
>>
>> * 'write-refs-sooner-rebased-2.3' and
>>   'write-refs-sooner-rebased-master' -- rebases of 'write-refs-sooner'
>>   onto 'maint' and 'master' respectively, in case anybody is
>>   interested to see how the individual patches would look if
>>   implemented natively on these branches.
>
> Thanks, that indeed is very helpful and instructive.
>
> A mechanical merge of sooner-2.2 to maint trivially gave sooner-2.3,
> so I am happy with that one.
>
> Even though I manually resolved it and the resulting tree pretty
> much matched with your suggested merge, I am hesitant to record the
> change of sooner-2.3 as a single large merge to master.  I am
> tempted to record this as somewhat a wicked merge, e.g.
>
>  - apply posted patches on maint-2.2, which is your sooner-2.2;
>
>  - branch sooner-2.3 from maint, merge sooner-2.2;
>
>  - branch sooner-master from v2.4.0, apply the patches in your
>    sooner-rebased-master on top, and then merge sooner-2.3, possibly
>    with "-s ours"
>
> And then sooner-master would record both "if built naturally on 2.4"
> progression, which would explain what was done much better than a
> huge merge of sooner-2.3 into 'master', and "what is to be done on
> older codebase".
>
> I dunno.
>
> Anyway, these patches looked good both on 2.2 and on 2.4.  Thanks.

The patches from Michael all look good. The one he picked up from me has a
weird commit message, though.

Thanks,
Stefan
