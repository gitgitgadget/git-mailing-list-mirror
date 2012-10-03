From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Thu, 4 Oct 2012 01:47:00 +0200
Message-ID: <CACBZZX764OOH82CiLYPr+_qNU65U4Zxuod_7G5ef8yAtHApXog@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <CACBZZX4Fb0OCkh5kwKvLC+_0xb7q-UB7LH2_WY=dFN5SYUeezQ@mail.gmail.com>
 <20121003232115.GB11618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:07:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtM3-0001DP-QF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907Ab2JCXrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 19:47:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59517 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788Ab2JCXrV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 19:47:21 -0400
Received: by obbuo13 with SMTP id uo13so7916566obb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0KXOHyezXQUdq4aEbyQ2HEzEU4ewyfgckf9WR1qDW+g=;
        b=G1Eg8p84lRRP3YVpvLPq+AgwT31E06goNgzmV+WoMrt9jWNDvXT4fHaYRhwvvzFexr
         Qj1L36vBXCs8C+OmpaGOQMX+B+++Vm6Rxx08c/sr0f3rPrbAtW6wAMl5v6giaYjnIa4u
         O5FHlBIzYriEl6sXKyLaH7+wYsxScX1PglsX2KrgzNJqRWR0erz2pYkXFteLradChs+C
         q+RC9pl4MhGfDiYqsNzp5gS4hRvoMC6G7774orscpbHuUbnlScQtDAr1IrhjQ/Jrn4/7
         E3dxvyeM2k1lxqjpFP7wiiksXukGbm0+XxcUdWY4nXrGFzKczfHH0OM/ZOZ0qm4OOwuk
         pclA==
Received: by 10.60.24.69 with SMTP id s5mr2951093oef.45.1349308040937; Wed, 03
 Oct 2012 16:47:20 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 3 Oct 2012 16:47:00 -0700 (PDT)
In-Reply-To: <20121003232115.GB11618@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206966>

On Thu, Oct 4, 2012 at 1:21 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 04, 2012 at 12:32:35AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Wed, Oct 3, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
>> > What version of git are you using?  In the past year or so, I've m=
ade
>> > several tweaks to speed up large numbers of refs, including:
>> >
>> >   - cff38a5 (receive-pack: eliminate duplicate .have refs, v1.7.6)=
; note
>> >     that this only helps if they are being pulled in by an alterna=
tes
>> >     repo. And even then, it only helps if they are mostly duplicat=
es;
>> >     distinct ones are still O(n^2).
>> >
>> >   - 7db8d53 (fetch-pack: avoid quadratic behavior in remove_duplic=
ates)
>> >     a0de288 (fetch-pack: avoid quadratic loop in filter_refs)
>> >     Both in v1.7.11. I think there is still a potential quadratic =
loop
>> >     in mark_complete()
>> >
>> >   - 90108a2 (upload-pack: avoid parsing tag destinations)
>> >     926f1dd (upload-pack: avoid parsing objects during ref adverti=
sement)
>> >     Both in v1.7.10. Note that tag objects are more expensive to
>> >     advertise than commits, because we have to load and peel them.
>> >
>> > Even with those patches, though, I found that it was something lik=
e ~2s
>> > to advertise 100,000 refs.
>>
>> FWIW I bisected between 1.7.9 and 1.7.10 and found that the point at
>> which it went from 1.5/s to 2.5/s upload-pack runs on the pathologic=
al
>> git.git repository was none of those, but:
>>
>>     ccdc6037fe - parse_object: try internal cache before reading obj=
ect db
>
> Ah, yeah, I forgot about that one. That implies that you have a lot o=
f
> refs pointing to the same objects (since the benefit of that commit i=
s
> to avoid reading from disk when we have already seen it).
>
> Out of curiosity, what does your repo contain? I saw a lot of speedup
> with that commit because my repos are big object stores, where we hav=
e
> the same duplicated tag refs for every fork of the repo.

Things are much faster with your monkeypatch, got up to around 10
runs/s.

The repository mainly contains a lot of git-deploy[1] generated tags
which are added for every rollout to several subsystems.

Of the ~50k references in the repo 75% point to a commit that no other
reference points to. Around 98% of the references are annotated tags,
the rest are branches.

1. https://github.com/git-deploy/git-deploy
