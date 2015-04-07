From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/4] t1006: add tests for git cat-file --literally
Date: Tue, 7 Apr 2015 16:49:49 -0400
Message-ID: <CAPig+cQ8SqtjRHRp=po0uXHWp3TFDXBsu5W6EUTs=ZWtR-br1A@mail.gmail.com>
References: <551F7984.5070902@gmail.com>
	<1428126289-19239-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfaRX-0002Qd-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 22:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbbDGUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 16:49:51 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33022 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbbDGUtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 16:49:51 -0400
Received: by lbbzk7 with SMTP id zk7so52187413lbb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MUY3yNUduXfmyvMgnx/Q5pKU8gEhkJvpCxHMXrDo7Hs=;
        b=b2DcdqM1lJnB0YpAKB+kYtN4NMOMcBgtQec0IOs1vgtpXbZjBpaSJsiKkWLAwQGtfv
         Mwlh/j8NXq9qg6mAGhff58mvW7s5DwjVH5Lv0qiMQ0KHtKjDnwJ2EtYoaTx5Y3ZCsNMH
         IWD12b4OEr41OXocfjP46GfpYLFb+eX1oJoNuoqdmiI3w6Jy/SH7kVrpYAqHd52axfUE
         vklPuBrDG8plkcpxL0lizFWGeiCJrEhNDgVzSlMnPd1pnZ4AqBIuC74OKcVT0qu3YMCO
         u52VPU5c/HZTVl/pYKqHprHzqI9t7+DwhunIZ2VjGPGDb2h7geiVGkCk73V1d57zWP9F
         eVUg==
X-Received: by 10.112.151.211 with SMTP id us19mr19562890lbb.120.1428439790006;
 Tue, 07 Apr 2015 13:49:50 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 7 Apr 2015 13:49:49 -0700 (PDT)
In-Reply-To: <1428126289-19239-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: qKDYxqZieMk3T9GiyFP2je_BlgU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266942>

On Sat, Apr 4, 2015 at 1:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ab36b1e..5b74044 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -47,6 +47,18 @@ $content"
>         test_cmp expect actual
>      '
>
> +    test_expect_success "Type of $type is correct using --literally" '
> +       echo $type >expect &&
> +       git cat-file -t --literally $sha1 >actual &&
> +       test_cmp expect actual
> +    '
> +
> +    test_expect_success "Size of $type is correct using --literally" '
> +       echo $size >expect &&
> +       git cat-file -s --literally $sha1 >actual &&
> +       test_cmp expect actual
> +    '
> +
>      test -z "$content" ||
>      test_expect_success "Content of $type is correct" '
>         maybe_remove_timestamp "$content" $no_ts >expect &&
> @@ -296,4 +308,19 @@ test_expect_success '%(deltabase) reports packed delta bases' '
>         }
>  '
>
> +bogus_type="bogus"
> +bogus_sha1=$(git hash-object -t $bogus_type --literally -w --stdin </dev/null)
> +
> +test_expect_success "Type of broken object is correct" '
> +       echo $bogus_type >expect &&
> +       git cat-file -t --literally $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "Size of broken object is correct" '
> +       echo "0" >expect &&

Zero is such a common fallback value when things go wrong that it may
not be the best choice for this test. Consequently, it might be better
to create the bogus object with non-zero length. Take a look at how
'hello_length' and 'hello_sha1' are computed elsewhere in this script
for inspiration.

> +       git cat-file -s --literally $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.0.rc1.249.g9f2ee54
