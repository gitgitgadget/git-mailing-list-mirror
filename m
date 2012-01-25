From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Wed, 25 Jan 2012 14:16:53 +0200
Message-ID: <CAMP44s16L0GJUh4JcQgjBXUf4ftT7yQFgPy0p6zCNMnZjZGQww@mail.gmail.com>
References: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
	<vpqwr8g8c03.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 25 13:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq1me-0004fP-BI
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 13:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab2AYMQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 07:16:55 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55023 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab2AYMQz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 07:16:55 -0500
Received: by lagu2 with SMTP id u2so665129lag.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 04:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vKpmVzqliyD3iMTtHpgymGkyxT3AgY6yhsN8BYGfuQY=;
        b=QRkV+6fydhN5cPi4/TZTZ9F0W6AyikLQ/fm5OzxxOYEHzjiS7iHb9NoUPehfxgJL6E
         d6oRYxlUYi05CSMqrn+xTX5HEoDFR5KKYo+Ocfh9PuvPIKFKZs2X+pc9MejHbmO3k7Ju
         lRPOP+qqonBfSHe3T1Z1o6ss1pHt+eD8FeYRw=
Received: by 10.152.112.132 with SMTP id iq4mr6334910lab.28.1327493813140;
 Wed, 25 Jan 2012 04:16:53 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Wed, 25 Jan 2012 04:16:53 -0800 (PST)
In-Reply-To: <vpqwr8g8c03.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189109>

On Wed, Jan 25, 2012 at 9:41 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The simplest and most generic solution is to hide all the changes we=
 do
>> to IFS, so that "foo \nbar " is recognized by zsh as "foo bar". This
>> works on versions of git before and after the introduction of
>> __gitcomp_nl (a31e626), and versions of zsh before and after 4.3.12.
> [...]
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # another workaround for=
 zsh because it would quote spaces in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the COMPREPLY array if=
 IFS doesn't contain spaces
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>
> No time to test right now, but is this not going to
>
> 1) leave IFS as hidden even outside the completion script, possibly
> affecting unrelated scripts that would need to set IFS as local and k=
eep
> its special effect?

What special effect?

Unrelated scripts can still set IFS as local.

You can test this:

---
#!/bin/sh

if [[ -n ${ZSH_VERSION-} ]]; then
    autoload -U +X bashcompinit && bashcompinit
fi

_foo()
{
    typeset -h IFS
    local cur=3D"${COMP_WORDS[COMP_CWORD]}"
    local IFS=3D$'\n'
    w[0]=3D'first '
    w[1]=3D'second and space '
    w[2]=3D'third\\ quoted\\ space '
    ./test1 >> /tmp/t1.txt
    COMPREPLY=3D( $(compgen -W "${w[*]}" -- $cur) )
}
complete -o nospace -F _foo foo
---

test1:
---
#!/bin/sh

test1() {
	local IFS=3D$'\n'
	w=3D( $(echo -e "foo \nbar"))
	echo "test1: 0:'${w[0]}' 1:'${w[1]}'"
}

test1

w=3D( $(echo -e "foo \nbar"))
echo "test2: 0:'${w[0]}' 1:'${w[1]}'"
---

The result in /tmp/t1.txt would be:
test1: 0:'foo ' 1:'bar'
test2: 0:'foo' 1:'bar'

Regardless of whether you use typeset -h or not.

> 2) break cases where strings are to be split on \n only (e.g. see
> "foo bar\nboz" as three possible completions "foo", "bar", "boz" inst=
ead
> of "foo bar" and "boz"?

Those cases are already broken, which is what I reported to the zsh
mailing list. You would get "foo\ bar" and "boz", and that's after
4.3.12; before, compgen -W would still break the completions in 3,
because they did 'results+=3D( $words )', instead of 'results+=3D(
"$words" )'.

Cheers.

--=20
=46elipe Contreras
