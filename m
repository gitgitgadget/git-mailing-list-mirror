From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Sun, 14 Sep 2014 18:20:57 +0200
Message-ID: <5415C069.9000702@gmail.com>
References: <1410683442-74523-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 18:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTCY0-00073U-8W
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 18:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbaINQVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 12:21:03 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45240 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbaINQVB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 12:21:01 -0400
Received: by mail-lb0-f175.google.com with SMTP id v6so3288732lbi.34
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vvD/zf4zQRDI0xoJbwYulxHM8e68K0KNDNWXa58jpnc=;
        b=BxzsTqKEMwb3zkt30wV/qq0KW14QIVaoJmvcUnzZGtcjv3yngOUK094/bwc+B/2uEf
         FH21GPxHjsKiKgM1Qg9KiXbi1cGlqPEAWSKkvgkKEzo+NzMyW6EAJReEwgU0s+ZO4oTV
         xor4WooWJxilCQ0DAQj/7yznO0FSV4fP/D7AzfGA+UUakXCM7IMwjvMOlm1mu1ILFB/t
         hUsJgcMDX5MPHedNNVgIY9HpvwwXcZW0+lLpsa/K0jVFGp9YwOrC9IPFvqQ3uBUV68/S
         ZUhsbPbYlCnDjFxATEDq8ZoxGpDM9oPM9FSvKcjRMHLfh6m8BG9Oa/EImoUtx7CnSFwc
         Gzsg==
X-Received: by 10.152.22.137 with SMTP id d9mr22688846laf.29.1410711660177;
        Sun, 14 Sep 2014 09:21:00 -0700 (PDT)
Received: from client.googlemail.com (dhcp-183168.eduroam.chalmers.se. [129.16.183.168])
        by mx.google.com with ESMTPSA id dw2sm3393342lbc.38.2014.09.14.09.20.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 09:20:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1410683442-74523-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257018>

Hi David,

On 09/14/2014 10:30 AM, David Aguilar wrote:
> Ensure that rev-parse --verify --quiet is silent when asked
> about deleted reflog entries.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This verifies and depends on "refs: make rev-parse --quiet actually quiet".
> 
>  t/t1503-rev-parse-verify.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> index 813cc1b..731c21c 100755
> --- a/t/t1503-rev-parse-verify.sh
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -83,6 +83,15 @@ test_expect_success 'fails silently when using -q' '
>  	test -z "$(cat error)"
>  '
>  
> +test_expect_success 'fails silently when using -q with deleted reflogs' '
> +	ref=$(git rev-parse HEAD) &&
> +	: >.git/logs/refs/test &&
> +	git update-ref -m test refs/test "$ref" &&

I'm just curious, why not simply

   git branch test

?

> +	git reflog delete --updateref --rewrite refs/test@{0} &&
> +	test_must_fail git rev-parse --verify --quiet refs/test@{0} 2>error &&

Is it a shortcoming of the specification that it doesn't consider
whatever might be written to stdout? Is it acceptable that if the
git-rev-parse command succeeds, the error message from test_must_fail
will be written to the file "error" and, therefore, somewhat hidden from
the user running the tests?

> +	test -z "$(cat error)"

test(1) comes with an option (-s) to perform such tests and test-lib.sh
defines test_must_be_empty which additionally outputs the given file's
contents if its not empty.

> +'
> +
>  test_expect_success 'no stdout output on error' '
>  	test -z "$(git rev-parse --verify)" &&
>  	test -z "$(git rev-parse --verify foo)" &&
> 

Kind regards,
   Fabian
