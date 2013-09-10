From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 8/8] update-ref: add test cases covering --stdin signature
Date: Tue, 10 Sep 2013 18:46:05 -0400
Message-ID: <CAPig+cQNrtznw1jc+dVOZhqBV7me0gC6Vx-k5siMPeyCzxmBSQ@mail.gmail.com>
References: <cover.1378732710.git.brad.king@kitware.com>
	<cover.1378773895.git.brad.king@kitware.com>
	<9083b451c8bdb7c7e04541deee1b96ae81f910b4.1378773895.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWhK-0001IQ-GU
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab3IJWqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:46:08 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:64777 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab3IJWqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:46:07 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so6724321lab.41
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XyETJq0IC25McurYJ0fcWU8BGMUH+MgYbKbzGPF/jzI=;
        b=vJTvxWWgcE9qEiANwZ19a0tqS4ZMGQTHPJ4BXw9kVrAEQehabRYqbLBt8mwVUdyyiW
         LEEciZQc8QYmhN/ROn8ue2s3MoaadjKfF3pji//l+efyiyGMbO0kVbPEILRW65JbJo23
         HBcqZocWAGTWEIVk3e45H+GQ1dF0YaXoVXcqm3EaYZBsnV15cgR0gmIhHsfAbrYiq++3
         +MX5AdjcMsGWQagxbQmZUrPFPj2Cg8w1K7MQ2c4sUToSPQKa6aG/ixGMHMr5eBoXXTd3
         qpmhW739x4n8TloZl/Ds/Q1kXrw5Ei3mA9DktLuGasPngrZqsHdKIcP/ZXJWWpW5fgVI
         9/QQ==
X-Received: by 10.112.211.136 with SMTP id nc8mr108113lbc.80.1378853165187;
 Tue, 10 Sep 2013 15:46:05 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 10 Sep 2013 15:46:05 -0700 (PDT)
In-Reply-To: <9083b451c8bdb7c7e04541deee1b96ae81f910b4.1378773895.git.brad.king@kitware.com>
X-Google-Sender-Auth: vmQvF-H1B3I-eMdWDXkeRfoEoPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234499>

On Mon, Sep 9, 2013 at 8:57 PM, Brad King <brad.king@kitware.com> wrote:
> Extend t/t1400-update-ref.sh to cover cases using the --stdin option.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  t/t1400-update-ref.sh | 639 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 639 insertions(+)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e415ee0..a510500 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -302,4 +302,643 @@ test_expect_success \
>         'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
>         'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
>
> +a=refs/heads/a
> +b=refs/heads/b
> +c=refs/heads/c
> +E='""'
> +pws='path with space'
> +
> +print_nul() {
> +       while test $# -gt 0; do
> +               printf -- "$1" &&
> +               printf -- "Q" | q_to_nul &&
> +               shift || return
> +       done
> +}

I believe that current fashion in git test scripts is to add a space
before () in the function declaration. Likewise, the 'do' should be on
the line following 'while' and aligned with 'while' (and drop the
semicolon).

The '--' option to printf is not likely portable. POSIX [1] certainly
does not mention it.

You can get printf to emit a NUL more naturally via \0, so q_to_nul is
unnecessary.

Finally, printf reuses its 'format' argument as many times as needed
to output all arguments, so the while loop is unneeded.

Thus printf provides all the functionality you require, and
print_nul() function can be dropped. So:

    printf '%s\0' foo bar baz

is equivalent to:

    print_null foo bar baz

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html
