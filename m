From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand option
Date: Mon, 12 Dec 2011 18:50:34 -0500
Message-ID: <CABURp0qkKXCW-U=78OpnejdtdpphhJtOoDubz77m7Gt3o5sC=Q@mail.gmail.com>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-3-git-send-email-iveqy@iveqy.com> <7vmxemls8z.fsf@alter.siamese.dyndns.org>
 <20111017190749.GA3126@sandbox-rc> <7vr52bjljd.fsf@alter.siamese.dyndns.org>
 <4E9DE883.9050105@web.de> <CABURp0okOmsk4JV9Ku5pHJb5vT-kr_fmweNNBKZ_OoRyfZan=Q@mail.gmail.com>
 <4EE6805D.7020708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:51:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFeR-0007tR-JR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab1LLXvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 18:51:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38199 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab1LLXu4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 18:50:56 -0500
Received: by wgbdr13 with SMTP id dr13so12328394wgb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jDAdYjFlMEy/0sd9VEnvaishBcVgNfjPSR8e4pRoe0c=;
        b=CCpAvi5RzOcAlCYMkdPp56azhRC5YracBhcWC+wIuZD6lm9t4UyAfcX69Nnd+kvkGe
         2BGRrMG2vcr98iCn6un2W/gc55U1dBd5BqJWZr8P41ImTNbFU/a0sXEXtg8U0PISt07T
         BvPH3s8BhP0253lLsAF7jbRURrGdnOY1mjCXE=
Received: by 10.227.205.130 with SMTP id fq2mr18645756wbb.17.1323733855207;
 Mon, 12 Dec 2011 15:50:55 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Mon, 12 Dec 2011 15:50:34 -0800 (PST)
In-Reply-To: <4EE6805D.7020708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186977>

On Mon, Dec 12, 2011 at 5:29 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 12.12.2011 22:16, schrieb Phil Hord:
>> On Tue, Oct 18, 2011 at 4:58 PM, Jens Lehmann <Jens.Lehmann@web.de> =
wrote:
>>> Am 18.10.2011 00:33, schrieb Junio C Hamano:
>>>> We could even declare that the gitlink for such a
>>>> submodule should record 0{40} SHA-1 in the superproject, but I do =
not
>>>> think that is necessary.
>>>
>>> Me neither, e.g. the SHA-1 which was the submodules HEAD when it wa=
s added
>>> should do nicely. And that would avoid referencing a non-existing c=
ommit
>>> in case you later want to turn a floating submodule into an exact o=
ne.
>>
>>
>> I'm sorry I missed this comment before.
>>
>> I hope we can allow storing the actual gitlink in the superproject f=
or
>> each commit even when we're using floating submodules.
>
> I think you misread my statement, I was just talking about the initia=
l
> commit containing the newly added submodule, not any subsequent ones.
> Floating makes differences between the original SHA-1 and the current
> tip of the branch invisible, so there is nothing to commit.
>
>> =A0I thought-experimented with this a bit last year and came to the
>> conclusion that I should be able to 'float' to tips (developer
>> convenience) and also to store the SHA-1 of each gitlink through
>> history (automated maybe; as-needed).
>
> Which means that after "git submodule update" floated a submodule bra=
nch
> further, you would have to commit that in the superproject.

Sadly, yes.  Currently I have my CI-server do this for me after it
verifies each new submodule commit is able to build successfully.

>> The problem with "float-only" is that it loses history so, for
>> example, git-bisect doesn't work.
>
> Yep. And different developers can have the same superproject commit
> checked out but their submodules can be quite different.

>> The problem with "float + gitlinks", of course, is that it looks lik=
e
>> "not floating" to the developers (git-status is dirty unless
>> overridden, etc.)
>
> Yeah. But what if each "git submodule update" would update the tip of
> the submodule branch and add that to the superproject? You could foll=
ow
> a tip but still produce reproducible trees.

Yes, and that's what I want.

Not what it sounded like was being suggested before, which (to my
eyes) implied that the submodule gitlinks were useless noise.

Phil
