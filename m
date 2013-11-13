From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] config: arbitrary number of matches for --unset and --replace-all
Date: Wed, 13 Nov 2013 18:22:38 -0500
Message-ID: <CAPig+cQZo0R3q=J2BygTfdJ1uuiT1HPDCjTxt8mykxOXM1uf2Q@mail.gmail.com>
References: <CAB8C745oJjw6pZ1MFy73Wy=WM-8n=aRY7VUh73u__VLB5e8mQA@mail.gmail.com>
	<06ba1524cbe4fa31b6e1a8d644882521aeaff4f4.1384337608.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 14 00:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgjm1-0005fQ-0q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 00:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab3KMXWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 18:22:43 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:64501 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab3KMXWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 18:22:41 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so971139lab.15
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B2FH2CP/R+Wch+OYGMhrkgM6t5V0ZWm766SvPRbknok=;
        b=geirgUFbDPHcFbW24AwFB6lnvZ4ar7WVlrSN0N/hmgtAYUAIa9Tg5kbpuu2XR/26QX
         FuzNkLxw9NCpDhws30hoZFaV84ywRHMt4VE8I5CtlpXXVnf/bbYkJ8nPwtIl36ylof1O
         QesCDXmlxN9lEZ63f1GOK1BSQOkqb1+yQMvmy7FEfS1KgJyKCkGoB0dbTWP9EVIhoH1F
         LckJEwOjApxFr2VVBFgNDGa4NKean4GcpOZ8hrF59du20x1UJ+s3z43lHzPMvtKT6sA9
         JDC1LKYGEugEF1ICvGU6zSVnVlPoHRS3/lAi5ddAU9pkWOtO5VkWCO2py7F+9oQSuMwg
         g59Q==
X-Received: by 10.112.157.166 with SMTP id wn6mr350998lbb.87.1384384958402;
 Wed, 13 Nov 2013 15:22:38 -0800 (PST)
Received: by 10.114.200.180 with HTTP; Wed, 13 Nov 2013 15:22:38 -0800 (PST)
In-Reply-To: <06ba1524cbe4fa31b6e1a8d644882521aeaff4f4.1384337608.git.tr@thomasrast.ch>
X-Google-Sender-Auth: rI21k_FZ8VExe6Y8aQtz0-9FETY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237807>

On Wed, Nov 13, 2013 at 5:19 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
> index 46103a1..7d55730 100755
> --- a/t/t1303-wacky-config.sh
> +++ b/t/t1303-wacky-config.sh
> @@ -47,4 +58,57 @@ test_expect_success 'do not crash on special long config line' '
>         check section.key "$LONG_VALUE"
>  '
>
> +setup_many() {
> +       setup &&
> +       # This time we want the newline so that we can tack on more
> +       # entries.
> +       echo >>.git/config &&
> +       # Semi-efficient way of concatenating 5^5 = 3125 lines. Note
> +       # that because 'setup' already put one line, this means 3126
> +       # entries for section.key in the config file.
> +       cat >5to1 <<EOF

Broken &&-chain.

> +  key = foo
> +  key = foo
> +  key = foo
> +  key = foo
> +  key = foo
> +EOF
> +       cat 5to1 5to1 5to1 5to1 5to1 >5to2 &&      # 25
> +       cat 5to2 5to2 5to2 5to2 5to2 >5to3 &&      # 125
> +       cat 5to3 5to3 5to3 5to3 5to3 >5to4 &&      # 635
> +       cat 5to4 5to4 5to4 5to4 5to4 >>.git/config # 3125
> +}
> +
> +test_expect_success 'get many entries' '
> +       setup_many &&
> +       git config --get-all section.key >actual &&
> +       test_line_count = 3126 actual
> +'
> +
> +test_expect_success 'get many entries by regex' '
> +       setup_many &&
> +       git config --get-regexp "sec.*ke." >actual &&
> +       test_line_count = 3126 actual
> +'
> +
> +test_expect_success 'add and replace one of many entries' '
> +       setup_many &&
> +       git config --add section.key bar &&
> +       check_regex section.key "b.*r" bar &&
> +       git config section.key beer "b.*r" &&
> +       check_regex section.key "b.*r" beer
> +'
> +
> +test_expect_success 'replace many entries' '
> +       setup_many &&
> +       git config --replace-all section.key bar &&
> +       check section.key bar
> +'
> +
> +test_expect_success 'unset many entries' '
> +       setup_many &&
> +       git config --unset-all section.key &&
> +       test_must_fail git config section.key
> +'
> +
>  test_done
> --
> 1.8.5.rc0.346.g150976e
