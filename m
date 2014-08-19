From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Push the NATIVE_CRLF Makefile variable to C and added a
 test for native.
Date: Tue, 19 Aug 2014 00:44:58 -0400
Message-ID: <CAPig+cT4PidGPBE3aQKWme+eXcY3a1LEQNt+5eWQNzZ1jCqz6A@mail.gmail.com>
References: <53F25488.8000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 19 06:45:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJbI9-0000oc-04
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 06:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbaHSEo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2014 00:44:59 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:40779 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaHSEo7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2014 00:44:59 -0400
Received: by mail-yh0-f48.google.com with SMTP id i57so5302056yha.35
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 21:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qEcspfIlc72gYBfPvBz35s4x+8tBzCXcHU64PZe7Vg8=;
        b=NxaWH+Vj0rAF7hbZHfU2gksVW7tYXKDhr+TNg6PBHJv5vcKO2Z2bSFGYSFPz8RCoh8
         e0I49qeNCcjaeyhI8r108twUNuTEVGamxwBAtl9Kro0lQkgR6dHxN0Ai2uMvc50y+QCP
         bS3J67PDzN+VvBlbNt384MPJVdCCb+ySgQQhZsRESw3x5aYz/imxDf6x5rQYGY90hv3E
         8nbIvPgUm+UhadbsSyilGffrIFOaEQXqyIANL+Q8rPO7Tz0uvB4o+wTte49Dd+LnJAPx
         wZOXr6huGnFzaXt6NGPj8kYo0ei0bc0PIqgjPcgC3Nyu7A1ivPRNx0ZLdpJgxJuQsNhl
         o4Jg==
X-Received: by 10.236.91.171 with SMTP id h31mr435456yhf.144.1408423498558;
 Mon, 18 Aug 2014 21:44:58 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Mon, 18 Aug 2014 21:44:58 -0700 (PDT)
In-Reply-To: <53F25488.8000103@web.de>
X-Google-Sender-Auth: 64EMiZ-MP_07uUC-qOX0EInWLkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255440>

On Mon, Aug 18, 2014 at 3:31 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
> incorrectly set on Mingw git. However, the Makefile variable is not
> propagated to the C preprocessor and results in no change. This patch
> pushes the definition to the C code and adds a test to validate that
> when core.eol as native is crlf, we actually normalize text files to =
this
> line ending convention when core.autocrlf is false.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> (This is from MINGW, and some part of my brain thougth that this was =
send
> upstream, but it wasn't. Only 95f31e9a is in git.git)
>
>  Makefile              |  3 +++
>  t/t0026-eol-config.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 63a210d..13311d2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1481,6 +1481,9 @@ ifdef NO_REGEX
>         COMPAT_CFLAGS +=3D -Icompat/regex
>         COMPAT_OBJS +=3D compat/regex/regex.o
>  endif
> +ifdef NATIVE_CRLF
> +       BASIC_CFLAGS +=3D -DNATIVE_CRLF
> +endif
>
>  ifdef USE_NED_ALLOCATOR
>         COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
> index 4807b0f..43a580a 100755
> --- a/t/t0026-eol-config.sh
> +++ b/t/t0026-eol-config.sh
> @@ -80,4 +80,22 @@ test_expect_success 'autocrlf=3Dtrue overrides uns=
et eol' '
>         test -z "$onediff" && test -z "$twodiff"
>  '
>
> +test_expect_success NATIVE_CRLF 'eol native is crlf' '
> +
> +       rm -rf native_eol && mkdir native_eol &&
> +       ( cd native_eol &&
> +       printf "*.txt text\n" > .gitattributes
> +       printf "one\r\ntwo\r\nthree\r\n" > filedos.txt
> +       printf "one\ntwo\nthree\n" > fileunix.txt

Broken &&-chain (3 lines).

> +       git init &&
> +       git config core.autocrlf false &&
> +       git config core.eol native &&
> +       git add filedos.txt fileunix.txt &&
> +       git commit -m "first" &&
> +       rm file*.txt &&
> +       git reset --hard HEAD &&
> +       has_cr filedos.txt && has_cr fileunix.txt
> +       )
> +'
> +
>  test_done
> --
> 2.1.0.rc2.210.g636bceb
