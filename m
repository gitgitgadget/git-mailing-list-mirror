From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] ls-files: Add eol diagnostics
Date: Mon, 23 Nov 2015 12:27:53 -0500
Message-ID: <CAPig+cTuG-vApbJfuNYxFwbkNq5wpJig6Lmxhi47CCYpMWx2iA@mail.gmail.com>
References: <56501EFA.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0uuE-0007pB-Id
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 18:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbKWR1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 12:27:55 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33089 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbKWR1y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 12:27:54 -0500
Received: by vkfr145 with SMTP id r145so42561568vkf.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Ydgzj/TuAIhpgUmoiRqbRMQ1sHlJ1S19VgvI0Zm0Xp0=;
        b=HJJAd8iPDZihtuegHthYIRy8RPZGE9L/I1JDLAyERworZHIfsXk6Dwsz3c4WjAnh+x
         vfY3R1yb9KGL/SlxTjXv7qozK03AedT/AkCVcYHNLqOuiRatgv0jkp8mzlxRgQz7HRXD
         Da5h6fA4x50yUOOSyF3zQuRdLxptTl1uIyKAIUczn1gGx/iUCNIxf+nu4lb8izqrARg9
         djyJ5lOIJiidreuxHljvUgkJy1Xmg8VYcsrMWw8OIeaVNmuKPyKS2HVX4C4k7rWOw8oe
         ZfBXN5W1ZepzBLFGwPHF26y791FXyjjdIkHI2WgzuS65IZlDLNeMHTNh/HI8nWxnthW+
         UBmQ==
X-Received: by 10.31.52.82 with SMTP id b79mr20602861vka.84.1448299673833;
 Mon, 23 Nov 2015 09:27:53 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 23 Nov 2015 09:27:53 -0800 (PST)
In-Reply-To: <56501EFA.7050105@web.de>
X-Google-Sender-Auth: m0IFBh8T-H5XZrqcm9rr__e4SWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281588>

On Sat, Nov 21, 2015 at 2:36 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> When working in a cross-platform environment, a user wants to
> check if text files are stored normalized in the repository and if
> .gitattributes are set appropriately.
>
> Make it possible to let Git show the line endings in the index and
> in the working tree and the effective text/eol attributes

s/$/./

> [...]
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> @@ -147,6 +148,18 @@ a space) at the start of each line:
>         possible for manual inspection; the exact format may change a=
t
>         any time.
>
> +--eol::
> +       Show line endings ("eolinfo") and the text/eol attributes ("t=
exteolattr") of files.
> +       "eolinfo" is the file content identification used by Git when
> +       the "text" attribute is "auto", or core.autocrlf !=3D false.
> +
> +       "eolinfo" is either "" (when the the info is not avaiable"), =
or one of "binary",

s/avaiable/available/

> +       "text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".
> +       The "texteolattr" can be "", "-text", "text", "text=3Dauto", =
"eol=3Dlf", "eol=3Dcrlf".
> +
> +       Both the content in the index ("i/") and the content in the w=
orking tree ("w/")
> +       are shown for regular files, followed by the "exteolattr ("at=
tr/").

s/exteolattr/texteolattr/

Should the documentation mention that with --eol ls-files becomes a
much more expensive operation since it now has to read all blobs
referenced by trees? (genuine question)

> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> @@ -51,6 +53,23 @@ static void output_attr(int cnt, struct git_attr_c=
heck *check,
> +static void output_eol_attr(const char *file)
> +{
> +       struct stat st;
> +       if (lstat(file, &st) || (!S_ISREG(st.st_mode)))
> +               return;
> +       if (nul_term_line) {
> +               printf("%s:", file);
> +               if (!lstat(file, &st) && (S_ISREG(st.st_mode)))
> +                       printf(": %-13s ", get_convert_attr_ascii(fil=
e));

Why the trailing space in the format string?

> +               printf("%c", 0);

putc('\0') perhaps?

> +       } else {
> +               quote_c_style(file, NULL, stdout, 0);
> +               printf(": %-13s ", get_convert_attr_ascii(file));

Ditto regarding trailing space.

> +               printf("\n");

Is there a reason the "\n" isn't incorporated into the preceding
printf's format string?

> +       }
> +}
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> @@ -213,7 +238,18 @@ checkout_files () {
>                         git -c core.eol=3D$eol checkout $src$f.txt
>                 fi
>         done
> -
> +       test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
> +               echo i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt =
>e &&
> +               echo i/text-crlf w/$(stats_ascii $crlfname) ${src}CRL=
=46.txt >>e &&
> +               echo i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src=
}CRLF_mix_LF.txt >>e &&
> +               echo i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_=
CR.txt >>e &&
> +               echo i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nu=
l.txt >>e &&
> +               echo i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.=
txt >>e &&

I wonder if a here-doc would make this a bit more readable and maintain=
able...

    echo >e <<-EOF &&
    i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt
    i/text-crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
    i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.txt
    i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt
    i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
    i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
    EOF

> +               sort <e >exp &&
> +               git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!=
!g' -e 's/  */ /g' | sort >act &&
> +               test_cmp exp act &&
> +               rm e exp act
> +       "
> @@ -231,6 +267,35 @@ checkout_files () {
>         "
>  }
>
> +# Test control characters
> +# NUL SOH CR EOF=3D=3D^Z
> +test_expect_success 'ls-files --eol -o Text/Binary' '
> +       test_when_finished "rm e exp act TeBi_*" &&
> +       STRT=3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA &&
> +       STR=3D$STRT$STRT$STRT$STRT &&
> +       printf "${STR}BBB\001" >TeBi_127_S &&
> +       printf "${STR}BBBB\001">TeBi_128_S &&
> +       printf "${STR}BBB\032" >TeBi_127_E &&
> +       printf "\032${STR}BBB" >TeBi_E_127 &&
> +       printf "${STR}BBBB\000">TeBi_128_N &&
> +       printf "${STR}BBB\012">TeBi_128_L &&
> +       printf "${STR}BBB\015">TeBi_127_C &&
> +       printf "${STR}BB\015\012" >TeBi_126_CL &&
> +       printf "${STR}BB\015\012\015" >TeBi_126_CLC &&
> +       echo i/ w/binary TeBi_127_S >e &&
> +       echo i/ w/text-no-eol TeBi_128_S >>e &&
> +       echo i/ w/text-no-eol TeBi_127_E >>e &&
> +       echo i/ w/binary TeBi_E_127 >>e &&
> +       echo i/ w/binary TeBi_128_N >>e &&
> +       echo i/ w/text-lf TeBi_128_L >>e &&
> +       echo i/ w/binary TeBi_127_C >>e &&
> +       echo i/ w/text-crlf TeBi_126_CL >>e &&
> +       echo i/ w/binary TeBi_126_CLC >>e &&

here-doc equivalent:

    echo >e <<-\EOF &&
    i/ w/binary TeBi_127_S
    i/ w/text-no-eol TeBi_128_S
    i/ w/text-no-eol TeBi_127_E
    i/ w/binary TeBi_E_127
    i/ w/binary TeBi_128_N
    i/ w/text-lf TeBi_128_L
    i/ w/binary TeBi_127_C
    i/ w/text-crlf TeBi_126_CL
    i/ w/binary TeBi_126_CLC
    EOF

> +       sort <e >exp &&
> +       git ls-files --eol -o | egrep "TeBi_" | sed -e 's!attr/[=3Da-=
z-]*!!g' -e "s/  */ /g" | sort >act &&
> +       test_cmp exp act
> +'
> +
> @@ -480,4 +545,19 @@ checkout_files    native  true  "lf"      LF    =
CRLF  CRLF_mix_LF  LF_mix_CR
> +# Should be the last test case
> +test_expect_success 'ls-files --eol -d' "
> +       rm  crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.tx=
t crlf_false_attr__LF.txt .gitattributes &&
> +       echo i/text-lf w/ .gitattributes >e &&
> +       echo i/text-crlf w/ crlf_false_attr__CRLF.txt >>e &&
> +       echo i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt >>e &=
&
> +       echo i/text-lf w/ crlf_false_attr__LF.txt >>e &&

    echo >e <<-\EOF &&
    i/text-lf w/ .gitattributes
    i/text-crlf w/ crlf_false_attr__CRLF.txt
    i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt
    i/text-lf w/ crlf_false_attr__LF.txt
    EOF

> +       sort <e >exp &&
> +       git ls-files --eol -d | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/ =
 */ /g' | sort >act &&
> +       test_cmp exp act &&
> +       rm e exp act
> +"
> +
> +
>  test_done
> --
> 2.6.1.443.g36d7748
