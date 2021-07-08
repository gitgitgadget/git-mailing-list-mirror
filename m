Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15475C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEA56141E
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhGHPWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:22:23 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:35306 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231876AbhGHPWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:22:22 -0400
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id D8FA9285902;
        Thu,  8 Jul 2021 23:19:36 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id NgCx-47mbPSH; Thu,  8 Jul 2021 23:19:24 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Thu,  8 Jul 2021 23:19:24 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id CF068600DC525;
        Thu,  8 Jul 2021 23:19:23 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, congdanhqx@gmail.com, felipe.contreras@gmail.com
Subject: Re: [PATCH] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Thu,  8 Jul 2021 23:19:11 +0800
Message-Id: <20210708151911.2524122-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> char *hint_cleanup_all =
> _("Please enter the ... , and an empty message aborts the commit.\n");
> char *hint_cleanup_space =
> _("Please enter the ... if you want to.\n"
>       "An empty message aborts the commit.\n");
>
> if (allow_empty_message) {
>         hint_cleanup_all = _("...");
>         hint_cleanup_space = _("...");
> }
>
> ... the if/elseif cascade in which calls to status_printf() are made
> ... using these variables

Would it be better this way or just using the ternary operator in-line
instead? If the latter, should it still be separated into another
variable or just embedded in the status_printf call? Using the ternary
operator does require to separate checks of allow_empty_message, but
might as well save us an `if` construct to reassign the variable.

In other words, which of the following 3 is the most acceptable?

1. As Junio suggested, quoted above.

2.
status_printf(s, GIT_COLOR_NORMAL, allow_empty_message ?
                                   _("...") :
				   _("...."), comment_line_char);

3.
const char *hint_foo = allow_empty_message ?
                       _("...") :
		       _("....");
......
status_printf(s, GIT_COLOR_NORMAL, hint_foo, comment_line_char);

--------------------------------------------------------------------

Felipe Contreras wrote:
> In git the style is to avoid braces if the content of the condition is a
> single line.

Đoàn Trần Công Danh wrote:
> In Git project, it's enforced to have -Wdeclaration-after-statement,
> IOW, move all declaration before statement.

Noted with thanks!

> After changing those texts, the tests should be updated, too.
> It's a customary service for the next developer, who needs to bisect
> this project to have all test-cases pass on each changes.
> 
> With this change, t7500.50 and t7502.37 runs into failures.
> Please fix them here, instead of next change.

I did change test cases accordingly in the second patch (excerpt below), and
both tests did pass afterwards. Was there something wrong with it?

> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 7d02f79c0d..812ca45043 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -497,8 +497,8 @@ test_expect_success 'invalid message options when using --fixup' '
> 
>  cat >expected-template <<EOF
> 
> -# Please enter the commit message for your changes. Lines starting
> -# with '#' will be ignored, and an empty message aborts the commit.
> +# Please enter the commit message for your changes.
> +# Lines starting with '#' will be ignored.
>  #
>  # Author:    A U Thor <author@example.com>
>  #
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 38a532d81c..a5217872ca 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -608,8 +608,8 @@ test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
> 
>  echo "sample
> 
> -# Please enter the commit message for your changes. Lines starting
> -# with '#' will be ignored, and an empty message aborts the commit." >expect
> +# Please enter the commit message for your changes.
> +# Lines starting with '#' will be ignored." >expect
> 
>  test_expect_success 'cleanup commit messages (strip option,-F,-e): output' '
>  	test_cmp expect actual

--------------------------------------------------------------------

And some perhaps rather noob questions below, as an (overly) curious
newcomer,

- Why is the "lego" style breakdown of translation strings unrecommended?
  I suppose it might be in consideration of possibly different linguistic
  sequences across languages but I'm not so sure.

- What is the rationale behind prohibiting braces around single line
  constructs? It seems somewhat error-prone since somebody else could
  later be adding statements into the body without putting the curly
  braces.

- When replying to multiple comments in multiple emails (like in this very
  email), would it be better to send multiple emails as replies to individual
  comments or do it in one email? If the latter, which previous message should
  the single reply be In-Reply-To?

Thanks in advance,
Hu Jialun
