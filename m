From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Sat, 17 Oct 2015 19:57:57 -0400
Message-ID: <CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-4-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 18 01:58:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnbMh-0000cY-54
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 01:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbbJQX57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 19:57:59 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32820 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbJQX56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 19:57:58 -0400
Received: by vkaw128 with SMTP id w128so7582360vka.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jkuM7d1mp+xgyy3eBu+F38ixaVOxgaYraZLSRn1YSv0=;
        b=xpoS/mpQE/JWJkCgwrUF+muIB18KLt8BZlGbM2w4q32JpRk+4JfravSkjgOwLXnmw5
         izawssZNB7e9y5eKEnMwdW62yOstXe+40CgIMMw7EWQudPc+5ri+BvgPvhGU745raP/X
         h9YZvcX4WuSFc1daa9+tjpQyDzUeDvNsqFl82MZUu62kKY4EC4xjKyFcTPDrjTIDUqv8
         0+/LAzjEqve3UBt1p9lqF2v9K5v8cYwsJLf7/+yRCkJpjiwfB5PZ0vTUDwbDAV7AHLJv
         OZCSieUFO5zORhnVRDOTKj3mFfdlnnOGcxFr6stGsafVBrPBSSPVnNs4fjvlJ+sL8AVa
         a1QA==
X-Received: by 10.31.11.209 with SMTP id 200mr15591571vkl.84.1445126277972;
 Sat, 17 Oct 2015 16:57:57 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sat, 17 Oct 2015 16:57:57 -0700 (PDT)
In-Reply-To: <1445008605-16534-4-git-send-email-tklauser@distanz.ch>
X-Google-Sender-Auth: aAQ2xO3YYOAHgESBLd3wDvnVXLM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279796>

On Fri, Oct 16, 2015 at 11:16 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> Implement the --count-lines options for git stripspace [...]
>
> This will make it easier to port git-rebase--interactive.sh to C later
> on.

Is there any application beyond git-rebase--interactive where a
--count-lines options is expected to be useful? It's not obvious from
the commit message that this change is necessarily a win for later
porting of git-rebase--interactive to C since the amount of extra code
and support material added by this patch probably outweighs the amount
of code a C version of git-rebase--interactive would need to count the
lines itself.

Stated differently, are the two or three instances of piping through
'wc' in git-rebase--interactive sufficient justification for
introducing extra complexity into git-stripspace and its documentation
and tests?

More below.

> Furthermore, add the corresponding documentation and tests.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index 29e91d8..9c00cb9 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -438,4 +438,40 @@ test_expect_success 'avoid SP-HT sequence in commented line' '
>         test_cmp expect actual
>  '
>
> +test_expect_success '--count-lines with newline only' '
> +       printf "0\n" >expect &&
> +       printf "\n" | git stripspace --count-lines >actual &&
> +       test_cmp expect actual
> +'

What is the expected behavior when the input is an empty file, a file
with content but no newline, a file with one or more lines but lacking
a newline on the final line? Should these cases be tested, as well?

> +test_expect_success '--count-lines with single line' '
> +       printf "1\n" >expect &&
> +       printf "foo\n" | git stripspace --count-lines >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '--count-lines with single line preceeded by empty line' '
> +       printf "1\n" >expect &&
> +       printf "\nfoo" | git stripspace --count-lines >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '--count-lines with single line followed by empty line' '
> +       printf "1\n" >expect &&
> +       printf "foo\n\n" | git stripspace --count-lines >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '--count-lines with multiple lines and consecutive newlines' '
> +       printf "5\n" >expect &&
> +       printf "\none\n\n\nthree\nfour\nfive\n" | git stripspace --count-lines >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '--count-lines combined with --strip-comments' '
> +       printf "5\n" >expect &&
> +       printf "\n# stripped\none\n#stripped\n\nthree\nfour\nfive\n" | git stripspace -s --count-lines >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.6.1.148.g7927db1
