From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 1/2] git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
Date: Sun, 3 Apr 2011 17:25:13 +0200
Message-ID: <BANLkTikf0s=tyGSnmgf1zmRAe3WnzB4JUA@mail.gmail.com>
References: <1299019777-19033-1-git-send-email-avarab@gmail.com>
	<1299019777-19033-2-git-send-email-avarab@gmail.com>
	<7vpqq99i11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 17:25:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6PB6-0007qA-DM
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 17:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1DCPZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 11:25:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab1DCPZP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 11:25:15 -0400
Received: by fxm17 with SMTP id 17so3451836fxm.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c8Cs7RzNtCE+/17dhk8KJReknQTyOEAl9PVz5GjTCJ0=;
        b=hZ0yS5h2lz175dY3NOPS6ofnMw1gkxuH9uymNOYRX12o7Jc8MghzM4w74uoV2PRpYd
         RSOMTuMWT5cJGWzBkm9mibxxnCKhky0VJ1YoH79wPXUeTqTPHIHmPmGTchNOx4hXQ6do
         zeO7P41QB6HS9SeIcEFlfkoK+TOpCosNZvIxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tZcELIqqR1PSw1+BP4CaE4MGFLAerrUe6eckeAwFwUwNUhQHO1cjFP6mWpw57JbT4g
         9q95kUZ1QvIDspaI/mK1yyTUCQ/6XlkEUd/BZaB0GcN2aaQ6K2qUUbt4wn88BbReNoKD
         qRwTy9ZJkO2vf03CxgvgSxeMHJ9gK6T4dy7+o=
Received: by 10.223.6.11 with SMTP id 11mr3202410fax.103.1301844314042; Sun,
 03 Apr 2011 08:25:14 -0700 (PDT)
Received: by 10.223.93.196 with HTTP; Sun, 3 Apr 2011 08:25:13 -0700 (PDT)
In-Reply-To: <7vpqq99i11.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170698>

On Thu, Mar 3, 2011 at 01:14, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> In a previous incarnation of the gettext series I implemented the
>> eval_gettext() fallback like this:
>>
>> =C2=A0 =C2=A0 eval_gettext() {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext_out=3D$(gettext "$1")
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettext_eval=3D"printf '%s' \"$gettext_o=
ut\""
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf "%s" "`eval \"$gettext_eval\"`"
>> =C2=A0 =C2=A0 }
>>
>> This was clever, but would incorrectly handle cases where the variab=
le
>> being interpolated contained spaces. E.g.:
>>
>> =C2=A0 =C2=A0 cmd=3D"git foo"; eval_gettext "command: \$cmd"
>>
>> Would emit "command: gitfoo", instead of the correct "command: git
>> foo".
>
> Hmm, are you sure you got your quoting right?
>
> =C2=A0 =C2=A0$ cat >1.sh <<\EOF
> =C2=A0 =C2=A0#!/bin/sh
> =C2=A0 =C2=A0gettext () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$1" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'command: $cmd') echo 'dcomm=
an: $cmd' ;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*) echo "GETTEXT POISON" ;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0eval_gettext() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext_out=3D$(gettext "$1"=
) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext_eval=3D"printf '%s' =
\"$gettext_out\"" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext_cmd=3D$(eval "$gette=
xt_eval") &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf "%s" "$gettext_cmd"
> =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0cmd=3D"git foo"
> =C2=A0 =C2=A0eval_gettext "command: \$cmd"
> =C2=A0 =C2=A0EOF
> =C2=A0 =C2=A0$ sh -x 1.sh
> =C2=A0 =C2=A0+ cmd=3D'git foo'
> =C2=A0 =C2=A0+ eval_gettext 'command: $cmd'
> =C2=A0 =C2=A0++ gettext 'command: $cmd'
> =C2=A0 =C2=A0++ case "$1" in
> =C2=A0 =C2=A0++ echo 'dcomman: $cmd'
> =C2=A0 =C2=A0+ gettext_out=3D'dcomman: $cmd'
> =C2=A0 =C2=A0+ gettext_eval=3D'printf '\''%s'\'' "dcomman: $cmd"'
> =C2=A0 =C2=A0++ eval 'printf '\''%s'\'' "dcomman: $cmd"'
> =C2=A0 =C2=A0+++ printf %s 'dcomman: git foo'
> =C2=A0 =C2=A0+ gettext_cmd=3D'dcomman: git foo'
> =C2=A0 =C2=A0+ printf %s 'dcomman: git foo'
> =C2=A0 =C2=A0dcomman: git foo
>
> Am I grossly missing something from what you are trying to do here?

(CC-ing the list again, so there's a record of this in the mail
archive).

Your eval_gettext() is better, but it still fails in cases where the
string contains "'s. E.g.:

    test_expect_success C_LOCALE_OUTPUT 'eval_gettext: our
eval_gettext() fallback can interpolate variables with spaces in them'
'
        cmdline=3D"git am" &&
        export cmdline;
        printf "When you have resolved this problem run \"git am
--resolved\"." >expect &&
        eval_gettext "When you have resolved this problem run
\"\$cmdline --resolved\"." >actual
        test_cmp expect actual
    '

If this were just:

    test_expect_success C_LOCALE_OUTPUT 'eval_gettext: our
eval_gettext() fallback can interpolate variables with spaces in them'
'
        cmdline=3D"git am" &&
        export cmdline;
        printf "When you have resolved this problem run git am
--resolved." >expect &&
        eval_gettext "When you have resolved this problem run
\$cmdline --resolved." >actual
        test_cmp expect actual
    '

Your version would work.

Maybe there's some portable version of doing this that works with
variables with spaces mixed with quotes. But unless someone can point
it out I'll submit a series with git-sh-i18n--envsubst and tests
demonstrating why it's needed soon.q
