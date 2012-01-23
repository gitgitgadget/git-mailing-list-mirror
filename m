From: Albert Yale <surfingalbert@gmail.com>
Subject: Re: [PATCH] grep: fix -l/-L interaction with decoration lines
Date: Mon, 23 Jan 2012 13:28:32 -0500
Message-ID: <CALEc4zH3+gW412xtPE2qPnHjDzrOzL=8sn9vb31tjQoKJf7wZQ@mail.gmail.com>
References: <CALEc4zGV6Oo-WR0vPE6=oEmm=fo4dd=nyBWFuK1oU7rmF9K41A@mail.gmail.com>
 <74777e0e8633d980fee9a1a680a63535be042fdc.1327340917.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 23 19:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpOdt-0001FM-Ca
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 19:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab2AWS3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 13:29:16 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55615 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab2AWS3O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 13:29:14 -0500
Received: by wics10 with SMTP id s10so2359547wic.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UD+zoi8BU4bOs0iklUB7NKtCQlcvpyV38n/eIZ+ZJYY=;
        b=jsdVnSvyu4+zFrcO6DmVMwfrSVIBZ3IYJzgaL0aoFIxmjRf+yYQNqYJhGM1p6bQW4T
         0NrrvtIsSsAHF6UH6AC7UUTLJHHhi90dXHN0c/24EdZXeByiDrCiRoPpsoDZsJaDlys3
         xo8TbPnmjuDWrPjdbX1hZpA1EdvEnXNSQpQbA=
Received: by 10.180.86.105 with SMTP id o9mr8601900wiz.4.1327343353233; Mon,
 23 Jan 2012 10:29:13 -0800 (PST)
Received: by 10.223.86.144 with HTTP; Mon, 23 Jan 2012 10:28:32 -0800 (PST)
In-Reply-To: <74777e0e8633d980fee9a1a680a63535be042fdc.1327340917.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189005>

Your patch is clearly better than mine. I'll let you take over this bug=
=2E

Thanks for taking a deeper look into this,

Albert Yale

On Mon, Jan 23, 2012 at 12:52 PM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> From: Albert Yale <surfingalbert@gmail.com>
>
> In threaded mode, git-grep emits file breaks (enabled with context, -=
W
> and --break) into the accumulation buffers even if they are not
> required. =A0The output collection thread then uses skip_first_line t=
o
> skip the first such line in the output, which would otherwise be at
> the very top.
>
> This is wrong when the user also specified -l/-L/-c, in which case
> every line is relevant. =A0While arguably giving these options togeth=
er
> doesn't make any sense, git-grep has always quietly accepted it. =A0S=
o
> do not skip anything in these cases.
>
> Signed-off-by: Albert Yale <surfingalbert@gmail.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
>> Reviewed-by: Thomas Rast <trast@student.ethz.ch>
>
> Please don't. =A0I didn't actually read the patch or look at the code=
,
> or say so, and you're claiming I did. =A0I was working purely from th=
e
> commit message.
>
>> As for creating a test, I'm unfamiliar with the testing procedure fo=
r
>> git-core. A "how to" in the "Documentation" folder would be very
>> useful in that regard.
>
> Well, there's t/README.
>
>
> Here's a patch that also does -c and has tests. =A0Placing them was m=
ore
> finicky than I hoped; the list of files in the repo varies wildly
> across the test set. =A0It also exploits knowledge that git-ls-files
> order is the same as 'git grep -l' order, which might not be
> appropriate.
>
>
> =A0builtin/grep.c =A0| =A0 =A06 ++++--
> =A0t/t7810-grep.sh | =A0 22 ++++++++++++++++++++++
> =A02 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9ce064a..1120b9f 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1034,8 +1034,10 @@ int cmd_grep(int argc, const char **argv, cons=
t char *prefix)
>
> =A0#ifndef NO_PTHREADS
> =A0 =A0 =A0 =A0if (use_threads) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (opt.pre_context || opt.post_context=
 || opt.file_break ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opt.funcbody)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(opt.name_only || opt.unmatch_name=
_only ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opt.count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (opt.pre_context || opt.post=
_context ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opt.file_break || opt.f=
uncbody))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skip_first_line =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_threads(&opt);
> =A0 =A0 =A0 =A0}
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 7ba5b16..75f4716 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -246,6 +246,28 @@ do
> =A0done
>
> =A0cat >expected <<EOF
> +file
> +EOF
> +test_expect_success 'grep -l -C' '
> + =A0 =A0 =A0 git grep -l -C1 foo >actual &&
> + =A0 =A0 =A0 test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +file:5
> +EOF
> +test_expect_success 'grep -l -C' '
> + =A0 =A0 =A0 git grep -c -C1 foo >actual &&
> + =A0 =A0 =A0 test_cmp expected actual
> +'
> +
> +test_expect_success 'grep -L -C' '
> + =A0 =A0 =A0 git ls-files >expected &&
> + =A0 =A0 =A0 git grep -L -C1 nonexistent_string >actual &&
> + =A0 =A0 =A0 test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> =A0file:foo mmap bar_mmap
> =A0EOF
>
> --
> 1.7.9.rc2.215.gd9e83
>
