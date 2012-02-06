From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/4] completion: work around zsh option propagation bug
Date: Tue, 7 Feb 2012 00:59:34 +0200
Message-ID: <CAMP44s3SruBpM74BjWuTLfS=_66p7r6rkjJ+ObLr4bLq0nERNA@mail.gmail.com>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
	<1328214625-3576-2-git-send-email-felipe.contreras@gmail.com>
	<7v1uqbpsyh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuXXS-0008TF-N9
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab2BFW7i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 17:59:38 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:55378 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756454Ab2BFW7g convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 17:59:36 -0500
Received: by lbom4 with SMTP id m4so1283013lbo.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 14:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fsTRbG+43ydrWnozyWfTY8BbGXttB2wqUoFiiD+TVOo=;
        b=YE5f1zbCxj23jv1/Lp1w7YujO703akn4B3/fi6WiRhJvMvm1YSptyA3pfSHKUp/5/H
         ThHHL3hGx2K0VR2RdT+ijC8x9OUI6fyeU1J59ZmJI9AV1ZsImThUkzpbYCNJtT/zFGZb
         9hlM5VmXx0tBBAoWwhvQ/QEiIF1Hq/TKKxae8=
Received: by 10.112.28.169 with SMTP id c9mr5419499lbh.42.1328569174057; Mon,
 06 Feb 2012 14:59:34 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 14:59:34 -0800 (PST)
In-Reply-To: <7v1uqbpsyh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190117>

On Fri, Feb 3, 2012 at 10:23 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Right now when listing commands in zsh (git <TAB><TAB>), all of them
>> will show up, instead of only porcelain ones.
>
> Jonathan's rewrite goes straight to the root cause instead, which is
> another way to describe the problem.
>
> Explaining user-visible symptoms at the beginning like you did is a g=
ood
> strategy that I would want to see more contributors follow, though.
>
>> Basically, in zsh, this:
>>
>> =C2=A0for i in $__git_all_commands
>>
>> Should be:
>>
>> =C2=A0for i in ${=3D__git_all_commands}
>>
>> Otherwise there's no word-splitting expansion (unless SH_WORD_SPLIT =
is
>> set). sh emulation should take care of that, but the subshell is mes=
sing
>> up with that. So __git_list_porcelain_commands does not do any
>> filtering.
>
> Let me step back a bit and see if we are on the same page wrt the roo=
t
> cause of the problem and for whom we are explaining the change.
>
> The adaptation of the bash completion script to zsh is done by asking=
 zsh
> to obey POSIXy word splitting rules to honor $IFS that is in effect w=
hen
> the words are split. =C2=A0However zsh does not do a good job at it i=
n some
> cases, and your patch works it around by avoiding a construct known t=
o be
> troublesome to zsh.

Troublesome to zsh emulation, yeah.

> Am I correct so far? =C2=A0If so, especially if the first sentence of=
 the above
> paragraph is correct, then how would it help others to teach "this is=
 the
> right way to do a word-split if we were writing in native zsh" when w=
e are
> not?

Because without that explanation it's quite difficult to know what
part of the code would behave differently in zsh, and how. Most people
are not familiar with shell features, and would have no idea what
"word splitting" means in a practical context.

> While it probably is a good description to have in a bug report given=
 to
> zsh folks, it is useless for people who read the history of Git.

Of course it's not. It tells you that there is indeed an issue in zsh,
and not in the way we are using it, as it has been acknowledged by zsh
developers.

> The readers need to read the solution described in order to understan=
d why
> the updated construct is written in an unnatural (to people who write=
 to
> POSIXy shells) way, or to avoid reintroducing a similar problem elsew=
here
> in the future.

Doesn't this explain that?

---
sh emulation should take care of that, but the subshell is messing
up with that.
---

Granted, for people not familiar with shell features "subshell" should
be accompanied with $(foo).

> I find that what Jonathan gave you helps them much better:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fn () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var=3D'one two=
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s\n' =
$var
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0x=3D$(fn)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: ${y=3D$(fn)}
>
> =C2=A0 =C2=A0printing "$x" results in two lines as expected, but prin=
ting "$y" results
> =C2=A0 =C2=A0in a single line because $var is expanded as a single wo=
rd when evaluating
> =C2=A0 =C2=A0fn to compute y.
>
> =C2=A0 =C2=A0So avoid the construct, and use an explicit 'test -n "$f=
oo" || foo=3D$(bar)'
> =C2=A0 =C2=A0instead.
>
> So I'll take the first two lines of the message (good bits), and simp=
lify
> the "This fixes a bug tht caused..." from the last paragraph (or perh=
aps
> even drop it).

I'm not sure about it, because this relies on knowledge of how printf
works, and it's not used that often; an example with 'for' would be
much more clear IMO.

Cheers.

--=20
=46elipe Contreras
