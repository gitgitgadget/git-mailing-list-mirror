From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t7300: add tests to document behavior of clean and
 nested git
Date: Mon, 6 Apr 2015 18:06:50 -0400
Message-ID: <CAPig+cTHp3rc_o+cpgguXkPj_aUU6-Hw-Kv6RXyGv8Yt06conQ@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 00:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfFAY-0001cc-NK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 00:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbbDFWGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 18:06:54 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35694 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbbDFWGw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 18:06:52 -0400
Received: by lbbuc2 with SMTP id uc2so25870952lbb.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=KnOtkH3WIkq9MTFyXGPiMbeIZjD4EHJHz/d7FtUYXYs=;
        b=ZORsVWFpd36aWGPJCgHGWL7GubWS+vvyxKH5wScL8sMCWlKk4g6RczTZ5v3MbwKZMV
         Ox5ZZsrSZ4CIW0koSK7fdc7XHeQMjTtKTfAXq2CQmGG+7BpfMFg8QmozlXEDkRCxg5Lm
         TjHtc6u6BA5j4fBpYXYyc8IZ/3j7iv1XmdqPBE8Y3ItqJyGVKU/vD5DQKMjBiNhkTsfo
         tVAIDxJ9zgHz0vbA+FarThO8yGfAkm99EMtuxiOkTwjgDK23W0mcei3WyQC7CMnNjEob
         nwYB9LJMfhg7+qN6ugoBUb+/kB3IWgbm3pCEV57zGTDWz3A5fS9aUdqMH1pHJVZ4NqHe
         VaHA==
X-Received: by 10.152.170.136 with SMTP id am8mr10407797lac.102.1428358010516;
 Mon, 06 Apr 2015 15:06:50 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 15:06:50 -0700 (PDT)
In-Reply-To: <1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com>
X-Google-Sender-Auth: JUq_LL1NT-JxBwNsEihxz4aIbbs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266890>

On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gmail=
=2Ecom> wrote:
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 99be5d9..cfdf6d4 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -455,6 +455,88 @@ test_expect_success 'nested git work tree' '
>         ! test -d bar
>  '
>
> +test_expect_failure 'nested git (only init) should be kept' '
> +       rm -fr foo bar &&
> +       mkdir foo bar &&
> +       (
> +               cd foo &&
> +               git init
> +       ) &&
> +       (
> +               cd bar &&
> +               >goodbye.people
> +       ) &&

(minor; ignore if desired) The above could be simplified to:

    rm -fr foo bar &&
    git init foo &&
    mkdir bar &&
    >bar/goodbye.people &&

> +       git clean -f -d &&
> +       test -f foo/.git/HEAD &&
> +       ! test -d bar

Here and elsewhere, you could instead use test_path_is_file() and
test_path_is_missing(), respectively.

> +'
> +
> +test_expect_failure 'nested git (bare) should be kept' '
> +       rm -fr foo bar &&
> +       mkdir foo bar &&
> +       (
> +               cd foo &&
> +               git init --bare
> +       ) &&
> +       (
> +               cd bar &&
> +               >goodbye.people
> +       ) &&

Simplified:

    rm -fr foo bar &&
    git init --bare foo &&
    mkdir bar &&
    >bar/goodbye.people &&

> +       git clean -f -d &&
> +       test -f foo/HEAD &&
> +       ! test -d bar
> +'
> +
> +test_expect_success 'giving path in nested git work tree will remove=
 it' '
> +       rm -fr foo &&
> +       mkdir foo &&
> +       (
> +               cd foo &&
> +               git init &&
> +               mkdir -p bar/baz &&
> +               cd bar/baz &&
> +               >hello.world
> +               git add . &&
> +               git commit -a -m nested
> +       ) &&
> +       git clean -f -d foo/bar/baz &&
> +       test -f foo/.git/HEAD &&
> +       test -d foo/bar/ &&

Alternative, here and elsewhere: test_path_is_dir()

> +       ! test -d foo/bar/baz
> +'
> +
> +test_expect_success 'giving path to nested .git will not remove it' =
'
> +       rm -fr foo &&
> +       mkdir foo bar &&
> +       (
> +               cd foo &&
> +               git init &&
> +               >hello.world
> +               git add . &&
> +               git commit -a -m nested
> +       ) &&
> +       git clean -f -d foo/.git &&
> +       test -f foo/.git/HEAD &&
> +       test -d foo/.git/refs &&
> +       test -d foo/.git/objects &&
> +       test -d bar/
> +'
> +
> +test_expect_success 'giving path to nested .git/ will remove content=
s' '
> +       rm -fr foo bar &&
> +       mkdir foo bar &&
> +       (
> +               cd foo &&
> +               git init &&
> +               >hello.world
> +               git add . &&
> +               git commit -a -m nested
> +       ) &&
> +       git clean -f -d foo/.git/ &&
> +       test 0 =3D $(ls -A foo/.git | wc -l) &&

Although in the latest POSIX, -A may not be portable.

Alternative: test_dir_is_empty()

> +       test -d foo/.git
> +'
> +
>  test_expect_success 'force removal of nested git work tree' '
>         rm -fr foo bar baz &&
>         mkdir -p foo bar baz/boo &&
> --
> 2.4.0.rc0.37.ga3b75b3
