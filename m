From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/7] cat-file: add --batch-all-objects option
Date: Fri, 26 Jun 2015 02:56:58 -0400
Message-ID: <CAPig+cT-VC7eQgLec+ATux76GHdRBVwG9BqcR9QiqXntf+s4eg@mail.gmail.com>
References: <20150622103321.GB12584@peff.net>
	<20150622104559.GG14475@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 08:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8NZS-0004TT-6K
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 08:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbFZG5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 02:57:01 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36303 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbbFZG47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 02:56:59 -0400
Received: by ykdr198 with SMTP id r198so52352409ykd.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gM4pjqJsoh1TlN/ER8ItgHYZYTTNz2xEfUrey5WjWzk=;
        b=gC7SE6U3oVetDFGncPc+HeRlQy3sgqP4RyOTTg951mbW0kdZ1gKHimDP5b98XgYK24
         3lD/X7YGtDDfeTohjUOhTEM7mTw5r/1sDjifHscFpv0ucHodde596DtNxMFwbCrSjrw1
         qITVR8Sym/YWxintN1CHSogiaGWQmkp75IaB4vCxn1b4Uy5MUdzmydRmR5nTm7BzEbbO
         1dls+PECVQPfVusu3Go+AFHRufkZdjOQ+0PV3i2mquMlRYz3KF0r9jmNcZmOvxNH+EIx
         0Q4iPiruHN9LXK75m9nvFzCqiBZNgwFxVAy09GbmYb1o6ieB9i+Gz78BpS8AX9GlYQbX
         kfSQ==
X-Received: by 10.13.204.207 with SMTP id o198mr105054ywd.163.1435301818901;
 Thu, 25 Jun 2015 23:56:58 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Thu, 25 Jun 2015 23:56:58 -0700 (PDT)
In-Reply-To: <20150622104559.GG14475@peff.net>
X-Google-Sender-Auth: 3166x9OpeDX92VRYgxaeilyipsc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272761>

On Mon, Jun 22, 2015 at 6:45 AM, Jeff King <peff@peff.net> wrote:
> [...] This patch adds an option to
> "cat-file --batch-check" to operate on all available
> objects (rather than reading names from stdin).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 93a4794..2b4220a 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -547,4 +547,31 @@ test_expect_success 'git cat-file --batch --follow-symlink returns correct sha a
>         test_cmp expect actual
>  '
>
> +test_expect_success 'cat-file --batch-all-objects shows all objects' '
> +       # make new repos so we now the full set of objects; we will

s/now/know/

> +       # also make sure that there are some packed and some loose
> +       # objects, some referenced and some not, and that there are
> +       # some available only via alternates.
> +       git init all-one &&
> +       (
> +               cd all-one &&
> +               echo content >file &&
> +               git add file &&
> +               git commit -qm base &&
> +               git rev-parse HEAD HEAD^{tree} HEAD:file &&
> +               git repack -ad &&
> +               echo not-cloned | git hash-object -w --stdin
> +       ) >expect.unsorted &&
> +       git clone -s all-one all-two &&
> +       (
> +               cd all-two &&
> +               echo local-unref | git hash-object -w --stdin
> +       ) >>expect.unsorted &&
> +       sort <expect.unsorted >expect &&
> +       git -C all-two cat-file --batch-all-objects \
> +                               --batch-check="%(objectname)" >actual.unsorted &&
> +       sort <actual.unsorted >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.4.719.g3984bc6
