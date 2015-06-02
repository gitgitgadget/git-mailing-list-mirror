From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Tue, 02 Jun 2015 13:11:33 -0700
Message-ID: <xmqq7frl3m6i.fsf@gitster.dls.corp.google.com>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
	<1433260647-18181-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzsXF-000370-BN
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbbFBULh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:11:37 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34713 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbFBULf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:11:35 -0400
Received: by igbhj9 with SMTP id hj9so95508830igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yu6uPAhQP95vtCsUi6tD/SLhXgn5PTt3egOyTd4iorA=;
        b=LMup6o2AcsXs6ATgjvzBl9Ne2e18bPQXlbBT9TYMcuttJfQfIQjs0E0+8MhgHFTOlB
         Zh8jeMn+JXXU3YPiGPnGDfm2vGqIzChANhzPXMSRyJnXucgY0Pf4BYkz/kgXIWdirVmT
         Vwq4XocVcgbj2lFlM3qCO4EkcQrdfdFtX2JDlg82XkSM1NxYu6p4jEFDvBrZKtWlq/bi
         PaSWlx77Y3VI0V/W+LSt4OwWR4EO5XvPsoA+Yt/aZlfeBbWmKbv9529MtsTj1zFSPRfn
         rb6Uvu02fxp4OSQ5ejwBxw6hPBhHAzqhU/uy7rPErmKE0TUE1Um8/6e2G6yxs4VVJNGr
         Y9vw==
X-Received: by 10.50.97.33 with SMTP id dx1mr22152461igb.1.1433275895134;
        Tue, 02 Jun 2015 13:11:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id e10sm4783755igy.11.2015.06.02.13.11.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 13:11:34 -0700 (PDT)
In-Reply-To: <1433260647-18181-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 2 Jun 2015 17:57:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270591>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> NULL_SHA1 is never a valid value for a reference. If a loose reference
> has that value, mark it as broken.
>
> Why check NULL_SHA1 and not the nearly 2^160 other SHA-1s that are
> also invalid in a given repository? Because (a) it is cheap to test
> for NULL_SHA1, and (b) NULL_SHA1 is often used as a "SHA-1 is invalid"
> value inside of Git client source code (not only ours!), and
> accidentally writing it to a loose reference file would be an easy
> mistake to make.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c                         | 7 +++++++
>  t/t6301-for-each-ref-errors.sh | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 47e4e53..c28fde1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1321,6 +1321,13 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>  				hashclr(sha1);
>  				flag |= REF_ISBROKEN;
>  			}
> +
> +			if (!(flag & REF_ISBROKEN) && is_null_sha1(sha1)) {
> +				/* NULL_SHA1 is never a valid reference value. */
> +				hashclr(sha1);

Do you need to clear after checking with is_null_sha1()?

> +				flag |= REF_ISBROKEN;
> +			}
> +
>  			if (check_refname_format(refname.buf,
>  						 REFNAME_ALLOW_ONELEVEL)) {
>  				hashclr(sha1);
> diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
> index 72d2397..cdb67a0 100755
> --- a/t/t6301-for-each-ref-errors.sh
> +++ b/t/t6301-for-each-ref-errors.sh
> @@ -24,7 +24,7 @@ test_expect_success 'Broken refs are reported correctly' '
>  	test_cmp broken-err err
>  '
>  
> -test_expect_failure 'NULL_SHA1 refs are reported correctly' '
> +test_expect_success 'NULL_SHA1 refs are reported correctly' '
>  	r=refs/heads/zeros &&
>  	echo $ZEROS >.git/$r &&
>  	test_when_finished "rm -f .git/$r" &&
