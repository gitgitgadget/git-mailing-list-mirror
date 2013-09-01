From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 8/8] update-ref: add test cases covering --stdin signature
Date: Sat, 31 Aug 2013 23:41:45 -0400
Message-ID: <CAPig+cQhH+t6unkea=0O2neJm8gOFaiKzPdSnuBaRy=Sdruu=g@mail.gmail.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<cover.1377885441.git.brad.king@kitware.com>
	<944b2af0ff064577734fd13cf40039fa4ebc10ec.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 05:42:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFyY7-0008KU-76
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 05:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab3IADls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 23:41:48 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:44199 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab3IADlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 23:41:47 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so2923856lbh.23
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nHBvdI2KoM0LslNOreM8D+Q4iYnNNTLd2HkSUjz5/Jk=;
        b=yJlxfxHIZ5aWhv37tVKqa+eGvteE6blSo3uqv7KRdpAmj/+/M5mH94KCIp4hkjCfpE
         bLvgNid6FuQetvuBTxlbU/PlYcbeUOQX2J7MgoqSdE/73GycCQnnxaN6xSAC0idco8zR
         6hHbtM6eQtmH9rWcyzxS+x2WgnPPpSQ5wOxKrUomB9ToI7c/eSU2zGwEoK8E68GNnONX
         OXT49RnwsghPMmciDYuXtWHn6eCLfPzGCpiJbO7wWcWynvKcnlQGzaNP/5Qxh9EsKi84
         u7VX4hi7Igs9g7nUErgr0yvB+KoiMBnViuFVFv3jhXfcH12MFevaoQEft+sasMyg43WM
         HcIg==
X-Received: by 10.112.154.70 with SMTP id vm6mr14495539lbb.1.1378006905728;
 Sat, 31 Aug 2013 20:41:45 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sat, 31 Aug 2013 20:41:45 -0700 (PDT)
In-Reply-To: <944b2af0ff064577734fd13cf40039fa4ebc10ec.1377885441.git.brad.king@kitware.com>
X-Google-Sender-Auth: 6w7-J46Lc813VlYUcFuBH3aKMt4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233560>

On Fri, Aug 30, 2013 at 2:12 PM, Brad King <brad.king@kitware.com> wrote:
> Extend t/t1400-update-ref.sh to cover cases using the --stdin option.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  t/t1400-update-ref.sh |  206 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 206 insertions(+)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e415ee0..9fd03fc 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -302,4 +302,210 @@ test_expect_success \
>         'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
>         'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
>
> +a=refs/heads/a
> +b=refs/heads/b
> +c=refs/heads/c
> +z=0000000000000000000000000000000000000000
> +e="''"
> +
> +test_expect_success 'stdin works with no input' '
> +       rm -f stdin &&
> +       touch stdin &&

Unless the timestamp of 'stdin' has particular significance, modern
git tests avoid 'touch' in favor of creating the empty file like this

    >stdin &&

> +       git update-ref --stdin < stdin &&

Style: Git test scripts omit whitespace following <, >, <<, and >>.

> +       git rev-parse --verify -q $m
> +'
> +
> +test_expect_success 'stdin fails with bad line lines' '
> +       echo " " > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: no ref on line:  " err &&
> +       echo "--" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: no ref on line: --" err &&
> +       echo "--bad-option" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: unknown option --bad-option" err &&
> +       echo "-\'"'"' $a $m" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: unknown option -'"'"'" err &&
> +       echo "~a $m" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: invalid ref format on line: ~a $m" err &&
> +       echo "$a '"'"'master" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: unterminated single-quote: '"'"'master" err &&
> +       echo "$a \master" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: unquoted backslash not escaping single-quote: \\\\master" err &&
> +       echo "$a $m $m $m" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: too many arguments on line: $a $m $m $m" err &&
> +       echo "$a" > stdin &&
> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: missing new value on line: $a" err
> +'

Despite the semantic relationship between all these cases, if there is
a regression in one case, the person reading the verbose output has to
study it carefully to determine the offending case. If you decompose
this monolith so that each case is in its own test_expect_success,
then the regressed case becomes immediately obvious.

> +test_expect_success 'stdin fails with duplicate refs' '
> +       echo "$a $m" > stdin &&
> +       echo "$b $m" >> stdin &&
> +       echo "$a $m" >> stdin &&

These multi-line preparations of 'stdin' might be more readable with a heredoc:

    cat >stdin <<-EOF &&
    $a $m
    $b $m
    $a $m
    EOF

> +       test_must_fail git update-ref --stdin < stdin 2> err &&
> +       grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
> +'
