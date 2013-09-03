From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 8/8] update-ref: add test cases covering --stdin signature
Date: Tue, 3 Sep 2013 04:16:46 -0400
Message-ID: <CAPig+cRZFAaa1WVUa9V3jC9Oiy+ucSvyRAc0jdgwQASmhZm6eA@mail.gmail.com>
References: <cover.1377885441.git.brad.king@kitware.com>
	<cover.1378142795.git.brad.king@kitware.com>
	<9457f5c046a0fb420f4fd730c7b02c2a75ee7e0d.1378142796.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 10:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlnC-0005dL-Dn
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 10:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495Ab3ICIQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 04:16:49 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:40375 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab3ICIQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 04:16:47 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so4782007lbh.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=swe0kTPKFpV9I8tM3XR+BzJSXMIZBjBboA5RxpzXSN0=;
        b=g1dGN5NDunwzosmvotNgEWHQZE7/Xn4pTPKAjtPNBpyZKINQVIrqlRJ/+asROQx9BG
         wWJxaM5RmjO1O6CwEVoGRGintn0AbfKS9m5nz1M+r+z6HapZ85D/QxxZbB5h71nwGSRv
         Wihjto9+uWAjzvYG3uMdEzzF3GNoZ+no2agDIZ5u3pgff4n33nfDPx4AbEi8AFsBnkXg
         pOqFmqwH+b1Xrp8ngdyFEJnWz9KDg1dEHxYqICUJcp81eLLARjrylKKsUZtf+rFoviq6
         0f8N6cH57yr/9sGewoY1ThirUsa7vGna0YB8T5/69oJKy+va7CsZ6hc8tgD/EjX/rUXm
         kW0A==
X-Received: by 10.152.2.74 with SMTP id 10mr820451las.36.1378196206676; Tue,
 03 Sep 2013 01:16:46 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 3 Sep 2013 01:16:46 -0700 (PDT)
In-Reply-To: <9457f5c046a0fb420f4fd730c7b02c2a75ee7e0d.1378142796.git.brad.king@kitware.com>
X-Google-Sender-Auth: 3cVVK_wmgnUuf9JrFAh-tnxoXCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233708>

On Mon, Sep 2, 2013 at 1:48 PM, Brad King <brad.king@kitware.com> wrote:
> Extend t/t1400-update-ref.sh to cover cases using the --stdin option.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  t/t1400-update-ref.sh |  256 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 256 insertions(+)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e415ee0..b6d7dfa 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -302,4 +302,260 @@ test_expect_success \
>         'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
>         'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
>
> +a=refs/heads/a
> +b=refs/heads/b
> +c=refs/heads/c
> +z=0000000000000000000000000000000000000000
> +e='""'
> +pws='path with space'
> +
> +test_expect_success 'stdin fails on bad input line with only whitespace' '
> +       echo " " >stdin &&
> +       test_must_fail git update-ref --stdin <stdin 2>err &&
> +       grep "fatal: no ref on line:  " err
> +'
> +
> +test_expect_success 'stdin fails on bad input line with only --' '
> +       echo "--" >stdin &&
> +       test_must_fail git update-ref --stdin <stdin 2>err &&
> +       grep "fatal: no ref on line: --" err
> +'
> +
> +test_expect_success 'stdin fails on bad input line with only --bad-option' '
> +       echo "--bad-option" >stdin &&
> +       test_must_fail git update-ref --stdin <stdin 2>err &&
> +       grep "fatal: unknown option --bad-option" err
> +'

When you decomposed the monolithic test from v1 into individual tests,
you dropped a couple cases ("fatal: unknown option'" and "fatal:
unterminated single-quote"). Was this intentional?

> +test_expect_success 'stdin fails with duplicate refs' '
> +       cat >stdin <<-EOF &&
> +$a $m
> +$b $m
> +$a $m
> +EOF
> +       test_must_fail git update-ref --stdin <stdin 2>err &&
> +       grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
> +'

The leading '-' on '-EOF' allows you to indent the content of the
heredoc and the terminating EOF, which makes the test read nicely:

    test_expect_success 'stdin fails with duplicate refs' '
        cat >stdin <<-EOF &&
        $a $m
        $b $m
        $a $m
        EOF
        test_must_fail git update-ref ...
    '

> +
> +test_expect_success 'stdin create ref works with no old value' '
> +       echo "$a $m" >stdin &&
> +       git update-ref --stdin <stdin &&
> +       git rev-parse $m >expect &&
> +       git rev-parse $a >actual &&
> +       test_cmp expect actual
> +'
