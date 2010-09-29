From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] add test for git grep --recursive
Date: Wed, 29 Sep 2010 20:35:50 +0000
Message-ID: <AANLkTikAUe=YWHcgF33aNFHesuxHtgCTXNZmbRoV99c-@mail.gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
	<1285792134-26339-2-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 22:35:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13Ne-0004nV-ES
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab0I2Ufx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 16:35:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40538 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab0I2Ufw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 16:35:52 -0400
Received: by iwn5 with SMTP id 5so1455666iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jgm4SEriSsoJ42D1t4gHpHb3+cUOXoCR0+qqeiDn2S0=;
        b=it4G50z0Ku2+XTxrOl4Gutnh6wgjdnarVGxyjjbNzb4wgnFTiyo8Zu/Eh0opE4jtsF
         qvIpgtta0K49iMjCK4AMg6jmEYB9gF68AEU65hBEZ4HcDJPjvi/TYGE6wGc7jhSlstXm
         vDHHIkFYplOtX9RwlX0Db/+LbGjNj6vFuPb80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kLcpf7zy0TbRzjJTeLOZ3jZ8m4GFKnK0npOceQ+H6g46sC4ujiy5XYw5JL9ZBIYD9p
         KxuGXNI64g6EDyHlq8U/ZhU54fKYBw1+5a8EatmOsva9i+r36mratTkMmYl1MrOzMFX0
         Bc0PP4YdDeH1hfdT1ODP1xuEwbY1VXDjge5/0=
Received: by 10.231.157.205 with SMTP id c13mr2360867ibx.71.1285792550530;
 Wed, 29 Sep 2010 13:35:50 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 13:35:50 -0700 (PDT)
In-Reply-To: <1285792134-26339-2-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157603>

On Wed, Sep 29, 2010 at 20:28, Chris Packham <judge.packham@gmail.com> =
wrote:
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> =C2=A0t/t7820-grep-recursive.sh | =C2=A0101 +++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 101 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 t/t7820-grep-recursive.sh
>
> diff --git a/t/t7820-grep-recursive.sh b/t/t7820-grep-recursive.sh
> new file mode 100644
> index 0000000..4bbd109
> --- /dev/null
> +++ b/t/t7820-grep-recursive.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Chris Packham
> +#
> +
> +test_description=3D'git grep --recursive test
> +
> +This test checks the ability of git grep to search within submodules=
 when told
> +to do so with the --recursive option'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup - initial commit' '
> + =C2=A0 =C2=A0 =C2=A0 printf "one two three\nfour five six\n" >t &&
> + =C2=A0 =C2=A0 =C2=A0 git add t &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "initial commit"
> +'
> +submodurl=3D$TRASH_DIRECTORY
> +
> +test_expect_success 'setup submodules for test' '
> + =C2=A0 =C2=A0 =C2=A0 for mod in $(seq 1 5 | sed "s/.*/submodule&/")=
; do
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git submodule add =
"$submodurl" $mod &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git submodule init=
 $mod
> + =C2=A0 =C2=A0 =C2=A0 done
> +'
> +
> +test_expect_success 'update data in each submodule' '
> + =C2=A0 =C2=A0 =C2=A0 for n in $(seq 1 5); do

seq isn't portable to windows, so we usually write out "1 2 3 4 5"
directly.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cd submodule$n &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sed -i "s/^four.*/& #$n/" t &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git commit -a -m"update")
> + =C2=A0 =C2=A0 =C2=A0 done
> +'
> +
> +cat >expected <<EOF
> +t:four five six
> +EOF
> +test_expect_success 'non-recursive grep in base' '
> + =C2=A0 =C2=A0 =C2=A0 git grep "five" >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected actual
> +'

Put the "cat >expected <<EOF" inside the test:

    test_expect_success 'non-recursive grep in base' '
        cat >expected <<\EOF &&
        t:four five six
        EOF
  =C2=A0 =C2=A0 =C2=A0 git grep "five" >actual &&
  =C2=A0 =C2=A0 =C2=A0 test_cmp expected actual
    '

ditto for the rest.
