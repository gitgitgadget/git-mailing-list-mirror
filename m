From: Shezan Baig <shezbaig.wk@gmail.com>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Tue, 15 May 2012 12:26:29 -0400
Message-ID: <CANMpiOQPefL_FNocLJ=pZyAb1hZ7bEvLk6frU3xme6VQrSDD2A@mail.gmail.com>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
	<xmqqwr5atn89.fsf@junio.mtv.corp.google.com>
	<87lilqjstf.fsf@thomas.inf.ethz.ch>
	<xmqqmx66mamc.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 18:26:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUKa8-0000MG-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 18:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241Ab2EOQ0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 12:26:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43696 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073Ab2EOQ0a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 12:26:30 -0400
Received: by obbtb18 with SMTP id tb18so9107485obb.19
        for <git@vger.kernel.org>; Tue, 15 May 2012 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9jP22BwCoyGoTbaGBQBVb3P5uVlZ1EftpDtoXhIvStQ=;
        b=z+GBSbGIUKDGpC/ZarCCM8vXy5OYxGWsyi7eCVgLYgp639iVKPUGuabsKSeIgZy1Fu
         dewjIbaSAtEsggFTG15KIyqqkSQwCg7942KkGuLPEU02GxEX8DE2uv1Zg2kqWKOOFQ86
         4EVgKJkS7j//gVTYAO6Ccq2os3vrltp7FlRx9GzYId/sKKtipRP0vAMXIbaClXQrVPW3
         FmpYtJMJ7WIFzVe4uMBJW0nsi+IbrOye2Ny5W2m+Wdb54vOrwaQayd61BCKey0JHbAyT
         Eco8Md2pHIQXU+O0gfgB8c6Pg0lnba/Orf8EgcAlIAxqqCs46nUh3VO/CAMlaFsPycFc
         0uPg==
Received: by 10.182.5.164 with SMTP id t4mr18737599obt.1.1337099190093; Tue,
 15 May 2012 09:26:30 -0700 (PDT)
Received: by 10.182.57.138 with HTTP; Tue, 15 May 2012 09:26:29 -0700 (PDT)
In-Reply-To: <xmqqmx66mamc.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197840>

Hi there,
Just wondering if this patch is going to be available in an upcoming
version of git?
Thanks,
Shezan


On Fri, Apr 20, 2012 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Thomas Rast <trast@student.ethz.ch> writes:
>>>
>>>> I was a bit torn on whether I should abort with checkout, or witho=
ut
>>>> it. =A0The manual clearly states that rebase "will perform an auto=
matic
>>>> git checkout <branch> before doing anything else", which mandates =
at
>>>> least *trying* the checkout in the error path, hence this version.
>>>>
>>>> However, in contrived cases this can lead to strange behavior. =A0=
=46or
>>>> example, a checkout conflict with a file in the worktree may preve=
nt
>>>> the abort path from working correctly, even though going through w=
ith
>>>> the rebase itself may succeed.
>>>
>>> Given all that contortion, is it even worth doing this?
>>
>> Well, the logic isn't new; 0cb0664 already does the same. =A0It just=
 never
>> carried over to interactive rebase.
>
> OK.
>
> The discrepancy in the "abort" case may come only in the three cases:
>
> =A0- EDITOR is pointing at something funny; it is not worth introduci=
ng
> =A0 any backward incompatibility to optimize for this case, so
> =A0 abort-with-checkout is the right thing to do here. =A0One less th=
ing we
> =A0 have to worry about (but see the third point below).
>
> =A0- It turns out that everything is already contained and there is
> =A0 nothing to apply, i.e. after this sequence:
>
> =A0 =A0 =A0 =A0git checkout branch
> =A0 =A0 =A0 =A0git checkout $onto_or_merge_base_between_base_and_bran=
ch
>
> =A0 we find out that "git cherry $onto_or_merge_base branch" is empty=
=2E
>
> =A0 Because you will be one commit ahead of $onto_or_merge_base if "g=
it
> =A0 cherry" were to give one commit to be replayed, I think it is
> =A0 logically correct if you stayed at the $onto_or_merge_base withou=
t
> =A0 checking out <branch>. =A0In other words, abort-with-checkout is =
not
> =A0 ideal for this case; we would want to just abort in this case.
>
> =A0- The user told us not to do the rebase by making insn sheet empty=
=2E =A0In
> =A0 other words, this is "aborting the entire rebase", so ideally it
> =A0 should come back to the state before the user ran "git rebase"
> =A0 command (i.e. where she was before we switched to <branch>).
>
> =A0 I do not think this ideal behaviour is something neither batch or
> =A0 interactive rebase has traditionally implemented, but I can see h=
ow
> =A0 we can sell this as a bugfix to the end users.
>
