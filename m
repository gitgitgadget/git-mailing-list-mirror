From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] ls-files: Add eol diagnostics
Date: Mon, 7 Dec 2015 15:21:20 -0500
Message-ID: <CAPig+cQayKit8JzYtYJrLE1EFiNAOqpnC+GDm7MpiSO8zHJySw@mail.gmail.com>
References: <5665BD39.1040403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62Hl-00007p-S2
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbbLGUVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 15:21:22 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33327 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbbLGUVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 15:21:21 -0500
Received: by vkca188 with SMTP id a188so110758924vkc.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3fa/4ke/xr7MTEHzrrk0ECjsEipTqbCWtcFJ2ROclCE=;
        b=mQnR2ZMaFM0Q16DxvosGhTkgbIK9vK0CCI4jkwEru8qFvFZcwCQVkovJh82+4jxFJS
         L8oHVK9GE+KxXa5etkEKPIqeJPgyic2vUzKazkrl2nAT7aw0uLR+szSR6OmSntHc32Yu
         smw9jeRVgsNcyHeM4Qa/4BrYktPvy1+Y/vSen18cO+E0K3mYQ2MglEXt0Ty0QQuzgnpz
         cI+pfUFlXg4mm3CZNebKBdV/ZXEMyWA9Jd7AEbc8U4wfyJXVkSi5MonS6W1G9dnytnDD
         HzeqM+XDSA+bQqCjzLDZXKY1gZHgz9M0DEpxg0UvwLKDd6TfhiXK2I+iS59HMUgN1K+d
         BQCw==
X-Received: by 10.31.56.18 with SMTP id f18mr19788379vka.19.1449519680312;
 Mon, 07 Dec 2015 12:21:20 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 7 Dec 2015 12:21:20 -0800 (PST)
In-Reply-To: <5665BD39.1040403@web.de>
X-Google-Sender-Auth: zIa3w2qsM1KlrvLDl8mGsDpT3Ko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282115>

On Monday, December 7, 2015, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> When working in a cross-platform environment, a user wants to
> check if text files are stored normalized in the repository and if
> .gitattributes are set appropriately.[...]

A few style comments this time around...

> Helped-By: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> @@ -47,6 +48,21 @@ static const char *tag_modified =3D "";
> +static void write_eolinfo(const struct cache_entry *ce, const char *=
path)
> +{
> +       struct stat st;
> +       const char *i_txt =3D "";
> +       const char *w_txt =3D "";
> +       if (!show_eol)
> +               return;
> +       if (ce && S_ISREG(ce->ce_mode))
> +               i_txt =3D get_cached_convert_stats_ascii(ce->name);
> +       if (!lstat(path, &st) && (S_ISREG(st.st_mode)))

Style: unnecessary parentheses around S_ISREG(), which is inconsistent
with S_ISREG() two lines above.

> +               w_txt =3D get_wt_convert_stats_ascii(path);
> +       printf("i/%-13s w/%-13s attr/%-9s ", i_txt, w_txt,
> +                                get_convert_attr_ascii(path));
> +}
> diff --git a/convert.c b/convert.c
> @@ -95,6 +100,62 @@ static int is_binary(unsigned long size, struct t=
ext_stat *stats)
> +static unsigned int gather_convert_stats(const char *data, unsigned =
long size)
> +{
> +       struct text_stat stats;
> +       if (!data || !size)
> +               return 0;
> +       gather_stats(data, size, &stats);
> +       if (is_binary(size, &stats) || stats.cr !=3D stats.crlf)
> +               return CONVERT_STAT_BITS_BIN;
> +       else if (stats.crlf && (stats.crlf =3D=3D stats.lf))

Style: unnecessary parentheses around 'foo =3D=3D bar'

> +               return CONVERT_STAT_BITS_TXT_CRLF;
> +       else if (stats.crlf && stats.lf)
> +               return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS=
_TXT_LF;
> +       else if (stats.lf)
> +               return CONVERT_STAT_BITS_TXT_LF;
> +       else
> +               return 0;
> +}
> +
> +static const char *gather_convert_stats_ascii(const char *data, unsi=
gned long size)
> +{
> +       unsigned int convert_stats =3D gather_convert_stats(data, siz=
e);
> +
> +       if (convert_stats & CONVERT_STAT_BITS_BIN)
> +               return "binary";
> +       switch (convert_stats) {
> +               case CONVERT_STAT_BITS_TXT_LF:
> +                       return("text-lf");

Style: space after "return".

Also, can we lose the unnecessary noisy parentheses? (I recall
mentioning this in my first review.)

Same for "return" statements below.

> +               case CONVERT_STAT_BITS_TXT_CRLF:
> +                       return("text-crlf");
> +               case CONVERT_STAT_BITS_TXT_LF | CONVERT_STAT_BITS_TXT=
_CRLF:
> +                       return("text-crlf-lf");
> +               default:
> +                       return ("text-no-eol");
> +       }
> +}
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> @@ -214,6 +239,20 @@ checkout_files () {
>                 fi
>         done
>
> +       test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
> +         test_when_finished 'rm e expect actual' &&

Style: test_when_finished is incorrectly indented with tab+spaces
rather than only tabs

> +               cat >e <<-EOF &&
> +               i/text-crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
> +               i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src}CRLF=
_mix_LF.txt
> +               i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt
> +               i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.tx=
t
> +               i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
> +               i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
> +               EOF
> +               sort <e >expect &&
> +               git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!=
!g' -e 's/  */ /g' | sort >actual &&
> +               test_cmp expect actual
> +       "
> @@ -480,4 +550,20 @@ checkout_files    native  true  "lf"      LF    =
CRLF  CRLF_mix_LF  LF_mix_CR
>  checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>
> +

Style: unnecessary blank line

> +# Should be the last test case: remove some files from the worktree
> +# run 'git ls-files -d'

This seems kind of fragile. Might it be possible to either recreate
those files when this test finishes or instead provide a function
which creates them on-demand for tests which need them? My concern is
that there is a good chance that someone later adding tests will
overlook this comment, especially since most people just plop new
tests at the bottom of the file.

> +test_expect_success 'ls-files --eol -d' "
> +       rm  crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.tx=
t crlf_false_attr__LF.txt .gitattributes &&

Style: too many spaces following 'rm'

Same issue raised in my previous review: If one or more of these files
did not get created,  for instance, because some earlier test failed,
then this 'rm' will fail, thus causing this entire test to fail
unnecessarily. Therefore, 'rm -f' would make more sense.

> +       cat >expect <<-\EOF &&
> +       i/text-crlf w/ crlf_false_attr__CRLF.txt
> +       i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt
> +       i/text-lf w/ .gitattributes
> +       i/text-lf w/ crlf_false_attr__LF.txt
> +       EOF
> +       git ls-files --eol -d | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/ =
 */ /g' | sort >actual &&
> +       test_cmp expect actual &&
> +       rm expect actual

Also, from the previous review: test_when_finished() would be a more
reliable way to clean up these files if they really ought to be
cleaned up.

> +"
> +
>  test_done
> --
> 2.6.2.403.gd7a84e3
