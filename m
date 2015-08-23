From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Sun, 23 Aug 2015 01:54:22 -0400
Message-ID: <CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
References: <20150811104056.16465.58131@localhost>
	<55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost>
	<55D8C824.6000704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schauer <josch@debian.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 07:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTOEe-0002KU-J1
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 07:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbbHWFyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 01:54:24 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33495 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbHWFyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2015 01:54:23 -0400
Received: by ykll84 with SMTP id l84so107014970ykl.0
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SEXpQmbHk9Rt2VcH1TLetUP3ZiYOthrgNn88ToDSr0c=;
        b=d1dnKbXKCB0k8xiPWR33tX7rEAN8+XRxe8PgjCSetAhYbYhoOVqmH06IAV5DMwmfW3
         V9kCVn1mNlIEq8WjfCwzrcNy/YDFthuERDJIGmLCj+TNSX0FTLfIBC/9Jj+Bxhd/ElL6
         q/iL6l5wLljmje4Kr4OhasnBEcXpye/yEmVJXDRcTWIDdmXtcq7uTa7NDJlicgU0O+R8
         UbetyjoTrEpB5GaGK88LwBGnrsYif5shVNXCeIMC4GqDASP4M2y8YqrxJWybZk4fTotT
         xk9vgNoa6pKL8CrKNWYdvb3Q2RKM8e8/7xlWQxEucjyrdITN/i0bb2S/e5KAye0Ly7x0
         wThw==
X-Received: by 10.13.220.193 with SMTP id f184mr21476213ywe.39.1440309262355;
 Sat, 22 Aug 2015 22:54:22 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sat, 22 Aug 2015 22:54:22 -0700 (PDT)
In-Reply-To: <55D8C824.6000704@web.de>
X-Google-Sender-Auth: LgmwcLZ8cnX15Hf0MJbrYKoF0gM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276401>

On Sat, Aug 22, 2015 at 3:06 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> A ZIP file directory has a 16-bit field for the number of entries it
> contains.  There are 64-bit extensions to deal with that.  Demonstrat=
e
> that git archive --format=3Dzip currently doesn't use them and instea=
d
> overflows the field.
>
> InfoZIP's unzip doesn't care about this field and extracts all files
> anyway.  Software that uses the directory for presenting a filesystem
> like view quickly -- notably Windows -- depends on it, but doesn't
> lend itself to an automatic test case easily.  Use InfoZIP's zipinfo,
> which probably isn't available everywhere but at least can provides
> *some* way to check this field.
>
> To speed things up a bit create and commit only a subset of the files
> and build a fake tree out of duplicates and pass that to git archive.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner=
-cases.sh
> index 654adda..c6bd729 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -115,4 +115,44 @@ test_expect_success 'archive empty subtree by di=
rect pathspec' '
>         check_dir extract sub
>  '
>
> +ZIPINFO=3Dzipinfo
> +
> +test_lazy_prereq ZIPINFO '
> +       n=3D$("$ZIPINFO" "$TEST_DIRECTORY"/t5004/empty.zip | sed -n "=
2s/.* //p")
> +       test "x$n" =3D "x0"
> +'

Unfortunately, this sed expression isn't portable due to dissimilar
output of various zipinfo implementations. On Linux, the output of
zipinfo is:

    $ zipinfo t/t5004/empty.zip
    Archive:  t/t5004/empty.zip
    Zip file size: 62 bytes, number of entries: 0
    Empty zipfile.
    $

however, on Mac OS X:

    $ zipinfo t/t5004/empty.zip
    Archive:  t/t5004/empty.zip   62 bytes   0 files
    Empty zipfile.
    $

and on FreeBSD, the zipinfo command seems to have been removed
altogether in favor of "unzip -Z" (emulate zipinfo).

One might hope that "unzip -Z" would be a reasonable replacement for
zipinfo, however, it is apparently only partially implemented on
=46reeBSD, and requires that -1 be passed, as well. Even with "unzip -Z
-1", there are issues. The output on Linux and Mac OS X is:

    $ unzip -Z -1 t/t5004/empty.zip
    Empty zipfile.
    $

but FreeBSD differs:

    $ unzip -Z -1 t/t5004/empty.zip
    $

With a non-empty zip file, the output is identical on all platforms:

    $ unzip -Z -1 twofiles.zip
    file1
    file2
    $

So, if you combine that with "wc -l" or test_line_count, you may have
a portable and reliable entry counter.

More below...

> +test_expect_failure ZIPINFO 'zip archive with many entries' '
> +       # add a directory with 256 files
> +       mkdir 00 &&
> +       for a in 0 1 2 3 4 5 6 7 8 9 a b c d e f
> +       do
> +               for b in 0 1 2 3 4 5 6 7 8 9 a b c d e f
> +               do
> +                       : >00/$a$b
> +               done
> +       done &&
> +       git add 00 &&
> +       git commit -m "256 files in 1 directory" &&
> +
> +       # duplicate it to get 65536 files in 256 directories
> +       subtree=3D$(git write-tree --prefix=3D00/) &&
> +       for c in 0 1 2 3 4 5 6 7 8 9 a b c d e f
> +       do
> +               for d in 0 1 2 3 4 5 6 7 8 9 a b c d e f
> +               do
> +                       echo "040000 tree $subtree      $c$d"
> +               done
> +       done >tree &&
> +       tree=3D$(git mktree <tree) &&
> +
> +       # zip them
> +       git archive -o many.zip $tree &&
> +
> +       # check the number of entries in the ZIP file directory
> +       expr 65536 + 256 >expect &&
> +       "$ZIPINFO" many.zip | head -2 | sed -n "2s/.* //p" >actual &&

With these three patches applied, Mac OS X has trouble with 'many.zip':

    $ unzip -Z -1 many.zip
    warning [many.zip]:  76 extra bytes at beginning or within zipfile
      (attempting to process anyway)
    error [many.zip]:  reported length of central directory is
      -76 bytes too long (Atari STZip zipfile?  J.H.Holm ZIPSPLIT 1.1
      zipfile?).  Compensating...
    00/
    00/00
    ...
    ff/ff
    error: expected central file header signature not found (file
      #65793). (please check that you have transferred or created the
      zipfile in the appropriate BINARY mode and that you have compiled
      UnZip properly)

And FreeBSD doesn't like it either:

    $ unzip -Z -1 many.zip
    unzip: Invalid central directory signature
    $

> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.5.0
