From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 03/11] ref-filter: add option to pad atoms to the right
Date: Thu, 30 Jul 2015 13:56:46 -0400
Message-ID: <CAPig+cR709U7zy3+F4eoiyUBhA=c2ZCxPc9uUoDQLOuooFxvzQ@mail.gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
	<1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
	<1438271332-10615-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 19:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKs4a-0005e1-OC
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 19:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbbG3R4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 13:56:48 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34761 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbbG3R4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 13:56:47 -0400
Received: by ykax123 with SMTP id x123so40315582yka.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JcVRig4QZPjGMEwIz1+nuRIlW2sNA72aEf4wUFIsOac=;
        b=nlFpfUum7cd9xm8fIPjGOcTH48g6/c8TIcUkhLYA14u1YWM6mVA1Kpv6Y3w8kh4wH2
         I1loyvNNE2p4e+rsuPtoK83Dg06/GNhDXwrHYK0B5tcqnzpE0Rd4nJ8RmgxPEOuQ222y
         MHLGlgq1jvnZugQGEOQ6H0mF4CfqiiseFy2h9cIU5NImYK+9il4eJ/C/pSf/nBlwwQBH
         P1Rs/e7ypHqB7oumggHdkTOjA9aurDI7HvUUK3c9YvpKkcBuIUEu+PW4IqYRqJ6bJ4nR
         PGc/NWpBL7sOghVwkXzvtedgKRR5ZW7O+DQSfyP1+nD7DKl9AaT9tGMospHxfbzv6wy/
         NDmw==
X-Received: by 10.13.192.132 with SMTP id b126mr52569319ywd.163.1438279007011;
 Thu, 30 Jul 2015 10:56:47 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 30 Jul 2015 10:56:46 -0700 (PDT)
In-Reply-To: <1438271332-10615-3-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: HH0XdLZ_t5uzfJK2X5kxIOtawdE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275022>

On Thu, Jul 30, 2015 at 11:48 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a new atom "padright" and support %(padright:X) where X is a
> number.  This will align the succeeding atom or string to the left
> followed by spaces for a total length of X characters. If X is less
> than the atom or string length then no padding is done.
>
> Add tests and documentation for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..48caac9 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,36 @@ test_expect_success 'filtering with --contains' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'padding to the right using `padright`' '
> +       cat >expect <<-\EOF &&
> +       master|    master    |
> +       side|    side      |
> +       odd/spot|    odd/spot  |
> +       double-tag|    double-tag|
> +       four|    four      |
> +       one|    one       |
> +       signed-tag|    signed-tag|
> +       three|    three     |
> +       two|    two       |
> +       EOF
> +       git for-each-ref --format="%(refname:short)%(padright:5)|%(padright:10)%(refname:short)|" >actual &&
> +       test_cmp expect actual
> +'

In an earlier review, Matthieu pointed out that this test failed to
ensure that the 'padright' value did not leak into the next atom. In a
subsequent version, you fixed the test to check that condition, but
now you've somewhat lost it again, at least visually. That is, because
whitespace is "invisible" and because 'padright' now also affects
literal strings, someone reading this test can't tell if those
trailing |'s in the expected output are padded or not. You could use a
different format string to prove that the 'padright' value doesn't
leak. For instance:

    %(padright:10)%(refname:short)|%(padright:5)|%(refname:short)

This way, as long as the two |'s are side-by-side, then you've proved
that the first one wasn't affected by the preceding 'padright:10'. You
could also add back the %(refname:short) at the front of the pattern,
as you currently have it, if you want to prove that padding is not
enabled at the start of format.

> +test_expect_success 'no padding when `padright` length is smaller than atom length' '
> +       cat >expect <<-\EOF &&
> +       refs/heads/master|
> +       refs/heads/side|
> +       refs/odd/spot|
> +       refs/tags/double-tag|
> +       refs/tags/four|
> +       refs/tags/one|
> +       refs/tags/signed-tag|
> +       refs/tags/three|
> +       refs/tags/two|
> +       EOF
> +       git for-each-ref --format="%(padright:5)%(refname)|" >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.6
