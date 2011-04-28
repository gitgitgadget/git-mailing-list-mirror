From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
Date: Thu, 28 Apr 2011 23:24:05 +0300
Message-ID: <BANLkTikt=Em6kP93aZfuZ3DEXdXN+7sAzg@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<20110428160115.GA19003@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:24:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFXkz-0001tq-6r
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933493Ab1D1UYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 16:24:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61040 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1D1UYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 16:24:06 -0400
Received: by fxm17 with SMTP id 17so2073602fxm.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2oAmXdWNMmkl1ffCaxOOGj98FooA6fUKd2fudyzbXJs=;
        b=xrG8zFdNRPTA5DaJrqMcWNSKqLEojPupn9p2gY9jknp8yjL0M1RxHMtsojJP0yYtEj
         PRKzAi8kvd47har6bmtf/mR28drUWxVJQQ7melgJh60brCTH2q5wr879iN5h7eNRvAWu
         70APGx9siRTX5anSLtHeOZXyN+A66xJIusVUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vQ5Xig/NBw00/tLK3h8CEjgngcGopvXWN86HttoJ3BtSX7dG0IzApQhcXlZbnOU/Ah
         iGcFiKoazUBgWSJWq9TeS8s6IIzMkZlYFx1Vdx/ArSr9YR6mt8l5P5imLVzBBWvu5T+q
         ZFY2lmlFNE/f+eCfW9K5xtpxyqltQ9VRaUfos=
Received: by 10.223.87.16 with SMTP id u16mr4407435fal.13.1304022245299; Thu,
 28 Apr 2011 13:24:05 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Thu, 28 Apr 2011 13:24:05 -0700 (PDT)
In-Reply-To: <20110428160115.GA19003@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172402>

2011/4/28 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Wed, Apr 27, 2011 at 01:40:34AM -0500, Jonathan Nieder wrote:
>> The "_get_comp_words_by_ref -n :=3D words" command from the
>> bash_completion library reassembles a modified version of COMP_WORDS
>> with ':' and '=3D' no longer treated as word separators and stores i=
t in
>> the ${words[@]} array. =C2=A0Git's programmable tab completion scrip=
t uses
>> this to abstract away the difference between bash v3's and bash v4's
>> definitions of COMP_WORDS (bash v3 used shell words, while bash v4
>> breaks at separator characters); see v1.7.4-rc0~11^2~2 (bash: get
>> --pretty=3Dm<tab> completion to work with bash v4, 2010-12-02).
>>
>> zsh has (or rather its completion functions have) another idea about
>> what ${words[@]} should contain: the array is prepopulated with the
>> words from the command it is completing. =C2=A0For reasons that are =
not
>> well understood, when git-completion.bash reserves its own "words"
>> variable with "local words", the variable becomes empty and cannot b=
e
>> changed from then on. =C2=A0So the completion script neglects the ar=
guments
>> it has seen, and words complete like git subcommand names. =C2=A0For
>> example, typing "git log origi<TAB>" gives no completions because
>> there are no "git origi..." commands.
>>
>> Work around this by using a different variable (comp_words) that is
>> not special to zsh. =C2=A0So now commands that completed correctly b=
efore
>> v1.7.4-rc0~11^2~2 on zsh should be able to complete correctly again.
>
> Thanks for this explanation. =C2=A0I tried to fix this some time ago,=
 but
> got only as far as to indentify that something is amiss with returnin=
g
> $words from _get_comp_words_by_ref(), and during tracing I saw so muc=
h
> weird and (for me) unexplicable zsh behavior that I simply gave up.
>
> But this patch heavily conflicted with one of my long-forgotten
> cleanup patch series, and that series together with the above
> explanation gave me alternative ideas for fixing this issue with zsh.
>
> So, here it is. =C2=A0The first two patches are independent cleanups,=
 but
> they make the actual fix in the third patch so short.
>
> It works well as far as I tested it with both bash and zsh, but I
> would really appreciate a few extra sets of eyeballs for the cleanups
> and sanity-checking and testing of the bugfix.
>
>
> SZEDER G=C3=A1bor (3):
> =C2=A0bash: don't modify the $cur variable in completion functions
> =C2=A0bash: remove unnecessary _get_comp_words_by_ref() invocations
> =C2=A0bash: don't declare 'local words' to make zsh happy
>
> =C2=A0contrib/completion/git-completion.bash | =C2=A0225 +++++++++---=
--------------------
> =C2=A01 files changed, 64 insertions(+), 161 deletions(-)

Nice! Much better approach.

I also noticed that behavior when not defining 'words' as local, but
though modifying all those instances was overkill.

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

--=20
=46elipe Contreras
