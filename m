From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t8001, t8002: fix "blame -L :literal" test on NetBSD
Date: Mon, 5 Aug 2013 11:33:54 -0400
Message-ID: <CAPig+cS4vzA9Kb=YKMYmFkckYwsRmg1AeY9hjAnGSS9MwzXkbQ@mail.gmail.com>
References: <51FFC2ED.3080906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6MnJ-0003wM-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab3HEPd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Aug 2013 11:33:58 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:46755 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3HEPd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Aug 2013 11:33:57 -0400
Received: by mail-la0-f48.google.com with SMTP id hi8so2138190lab.7
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DjB28OmP4Irik926F71/6RCpBu9PW1o4J2d75/1Gi8Q=;
        b=noEBjEP8Y3qA7ljLAKBvSAwe5nsR9qAcU9i7J5NrmyhdzfwzU1UEQb1lytdr7M7mLd
         8D2Wroenqk3NLCU0UfYNjoXUAY0u/Q2kAXrAdclBcDeAOJBD1F1IiOiOnzRZ0flAje+v
         AugS3iU6ZgJBd8kBKBHpKwTdOE72dfxrYRm23I45QDdWxNES49mEFiFQL3jsrwtjzZe0
         AWQUKoKihrF+b5j88P5FHhcgK/YoE+BRuOSrpoaEmHvZBxUIbyqxRZiICMfrPi2LA/RM
         SVijHO9Vb/Ej79YFiD2J5MKNfQH8uyFAqm45DESNQUlp5QlurbUrr/jV6ZT9C/ZDLh4K
         AhnA==
X-Received: by 10.152.3.201 with SMTP id e9mr2681568lae.24.1375716834496; Mon,
 05 Aug 2013 08:33:54 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 5 Aug 2013 08:33:54 -0700 (PDT)
In-Reply-To: <51FFC2ED.3080906@web.de>
X-Google-Sender-Auth: XyA53Q1xky0dZXl4U3GGH-SgNQE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231657>

On Mon, Aug 5, 2013 at 11:21 AM, Ren=E9 Scharfe <l.s.r@web.de> wrote:
> Sub-test 42 of t8001 and t8002 ("blame -L :literal") fails on NetBSD
> with the following verbose output:
>
>         git annotate  -L:main hello.c
>         Author F (expected 4, attributed 3) bad
>         Author G (expected 1, attributed 1) good
>
> This is not caused by different behaviour of git blame or annotate on
> that platform, but by different test input, in turn caused by a sed
> command that forgets to add a newline on NetBSD.  Here's the diff of =
the
> commit that adds "goodbye" to hello.c, for Linux:
>
>         @@ -1,4 +1,5 @@
>          int main(int argc, const char *argv[])
>          {
>                 puts("hello");
>         +               puts("goodbye");
>          }
>
> We see that it adds an extra TAB,

Curious. On Mac OS X, there is only a single tab.

> but that's not a problem.  Here's the
> same on NetBSD:
>
>         @@ -1,4 +1,4 @@
>          int main(int argc, const char *argv[])
>          {
>                 puts("hello");
>         -}
>         +               puts("goodbye");}
>
> It also adds an extra TAB, but it is missing the newline character
> after the semicolon.
>
> The following patch gets rid of the extra TAB at the beginning, but
> more importantly adds the missing newline at the end in a (hopefully)
> portable way, mentioned in http://sed.sourceforge.net/sedfaq4.html.

Tested on Mac OS X. Works correctly.

> The diff becomes this, on both Linux and NetBSD:
>
>         @@ -1,4 +1,5 @@
>          int main(int argc, const char *argv[])
>          {
>                 puts("hello");
>         +       puts("goodbye");
>          }
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This regression was introduced by 5a9830cb ("t8001/t8002 (blame):
> add blame -L :funcname tests").
>
>  t/annotate-tests.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 0bfee00..d4e7f47 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -245,8 +245,8 @@ test_expect_success 'setup -L :regex' '
>         git commit -m "hello" &&
>
>         mv hello.c hello.orig &&
> -       sed -e "/}/i\\
> -       Qputs(\"goodbye\");" <hello.orig | tr Q "\\t" >hello.c &&
> +       sed -e "/}/ {x; s/$/Qputs(\"goodbye\");/; G;}" <hello.orig |
> +       tr Q "\\t" >hello.c &&

Thanks.

Acked-by: Eric Sunshine <sunshine@sunshineco.com>

>         GIT_AUTHOR_NAME=3D"G" GIT_AUTHOR_EMAIL=3D"G@test.git" \
>         git commit -a -m "goodbye" &&
