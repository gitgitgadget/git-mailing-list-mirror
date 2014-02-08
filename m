From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Sun, 9 Feb 2014 06:48:18 +0700
Message-ID: <CACsJy8C_Lc+mcJxGc7S5AB47YKDrhmWPwZp2oxJ9Z1tONVT0kQ@mail.gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com> <20140208164548.GA24600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 09 00:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCHdm-00051x-Uy
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 00:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbaBHXsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 18:48:50 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:56322 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaBHXst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 18:48:49 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so7566838qae.35
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OOR+1NbiPxqQgq6cvT6/JdM5R0FsJ0d6Y59Xt2vMnOg=;
        b=s0e5CDZsZqVmKgvA+nguPmBBSpSk/Z1RWqtYHrbzRVuVZrQtps4XXQUV4HAGaRlN3Q
         6MBSnyEHWKK+wCbqdWi3XisMmY0izcM4mQrub8sSqY5gulTlmOlATBaGjXo8ZgTKcklC
         PYiNbfJUBgM2zkaa6lzUTdp50e2Bp3Sixgs9U4Db8gkne/BFkPZPo+eOe4hI1l57EfZC
         OnOSHhb8cH0K0lo4h6wCDLdNSooMM9JecVJYOyyEZc8eNMiCW1MiXKyZzjyiG5EUloim
         gDlrizivjmF3/EOmcWGkTO4tBRb3CiU7Ot5fU7ssYXOE9NYY4gwCdIkbc9WbWsjdi1Ps
         aaag==
X-Received: by 10.224.36.129 with SMTP id t1mr32518290qad.8.1391903328768;
 Sat, 08 Feb 2014 15:48:48 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 8 Feb 2014 15:48:18 -0800 (PST)
In-Reply-To: <20140208164548.GA24600@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241866>

On Sat, Feb 8, 2014 at 11:45 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 08, 2014 at 03:10:02PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> Trailing spaces are invisible in most standard editors (*). "git dif=
f"
>> does show trailing spaces by default. But that does not help newly
>> written .gitignore files. And trailing spaces are the source of
>> frustration when writing .gitignore.
>
> I guess leading spaces are not as frustrating, but I wonder if it wou=
ld
> be more consistent to say that we soak up all whitespace. That is als=
o a
> regression, but I agree that these are exceptional cases, and as long=
 as
> we provide an "out" for people to cover them via quoting, ignoring th=
e
> whitespace seems like a sane default.

Hm...

>
>> People can still quote trailing spaces, which will not be ignored (a=
nd
>> much more visible). Quoting comes with a cost of doing fnmatch(). Bu=
t
>> I won't optimize it until I see someone shows me they have a use cas=
e
>> for it.
>
> I naively expected that:
>
>   echo 'trailing\ \ ' >.gitignore
>
> would count as quoting, but your patch doesn't handle that. It _does_
> seem to work currently (that is, the backslashes go away and we treat=
 it
> literally), but I am not sure if that is planned, or simply happens t=
o
> work.

No that's what I had in mind. But yeah my patches are flawed.

>
> I guess by quoting you meant:
>
>   echo '"trailing  "' >.gitignore

This makes " special. If we follow shell convention then things
between ".." should be literal (e.g. "*" is no longer a wildcard). We
don't support it yet. So I rather go with backslash as it adds less
code.

>
> Anyway, here are some tests I wrote up while playing with this. They =
do
> not pass with your current patch for the reasons above, but maybe the=
y
> will be useful to squash in (either after tweaking the tests, or
> tweaking the patch).
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index b4d98e6..4dde314 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -775,4 +775,33 @@ test_expect_success PIPE 'streaming support for =
--stdin' '
>         echo "$response" | grep "^::    two"
>  '
>
> +####################################################################=
########
> +#
> +# test whitespace handling
> +
> +test_expect_success 'leading/trailing whitespace is ignored' '
> +       mkdir whitespace &&
> +       >whitespace/leading &&
> +       >whitespace/trailing &&
> +       >whitespace/untracked &&
> +       {
> +               echo "    whitespace/leading" &&
> +               echo "whitespace/trailing   "
> +       } >ignore &&
> +       echo whitespace/untracked >expect &&
> +       git ls-files -o -X ignore whitespace >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'quoting allows trailing whitespace' '
> +       rm -rf whitespace &&
> +       mkdir whitespace &&
> +       >"whitespace/trailing  " &&
> +       >whitespace/untracked &&
> +       echo "whitespace/trailing\\ \\ " >ignore &&
> +       echo whitespace/untracked >expect &&
> +       git ls-files -o -X ignore whitespace >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done



--=20
Duy
