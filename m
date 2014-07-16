From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 2/3] fixup for patch 2: actually check the return value
Date: Wed, 16 Jul 2014 22:25:59 +0530
Message-ID: <53C6AE9F.2030908@gmail.com>
References: <vpqha2h9tjw.fsf@anie.imag.fr> <1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr> <1405526952-25019-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: artagnon@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 18:56:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7SVL-00044c-9c
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965498AbaGPQ4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:56:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50082 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174AbaGPQ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:56:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so1639473pab.33
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1lVCxK8uObcbVpHK8Hp1mw8jPBIaGsJo2Kb99ZNMOJw=;
        b=nnhuzHXnoC68jBw7UE8ATgbjxTlqj9zqwMrTmvVLDmAtRVmhDZ/BGLeq/MLhPfSp5i
         q60uFdl9BF+ZEyqMTdJI/1aOFj6dDssRWTcZLIYt/zAswjnmCN9iP1LtD2OftkU4cA8W
         irODmM3NeIxAZAjMnyNQw5W+90ZIz6J1pSxKW1HJNQaZVD/GYuUQpZn9p5uNZjNQxtPP
         5enbrPibzCAbMMpZlH/hqo4HpQ0rQfglrOskZNox2+aqBhoDWG2sICQGG34i4U/kTimd
         X5hVMrGOgFhPX2l7ft1T/oCCk7JHVh0m90phaxTFyQnCJYBdTVbbN43F5660eOFH4eFJ
         AhMg==
X-Received: by 10.68.201.68 with SMTP id jy4mr31247071pbc.64.1405529770668;
        Wed, 16 Jul 2014 09:56:10 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.232.183])
        by mx.google.com with ESMTPSA id dn10sm23384422pdb.95.2014.07.16.09.56.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:56:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405526952-25019-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253676>

I think it would be unnecessary for the current iteration.
Currently git_configset_add_file has only two possible return values
-1 or 0. I could add specialized error values for ENOENT or ENOTDIR
or EACCES, but the logs show that we silently ignore the first two.
I can add an access warn for the third. What do you think?

Thanks,
Tanay.

On 7/16/2014 9:39 PM, Matthieu Moy wrote:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I won't fight for this, but I think it makes sense.
> 
>  t/t1308-config-set.sh |  4 ++--
>  test-config.c         | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index ea031bf..f0307b7 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -168,7 +168,7 @@ test_expect_success 'find value_list for a key from a configset' '
>  '
>  
>  test_expect_success 'proper error on non-existant files' '
> -	echo "Error reading configuration file non-existant-file." >expect &&
> +	echo "Error (-1) reading configuration file non-existant-file." >expect &&
>  	test_expect_code 2 test-config configset_get_value foo.bar non-existant-file 2>actual &&
>  	test_cmp expect actual
>  '
> @@ -176,7 +176,7 @@ test_expect_success 'proper error on non-existant files' '
>  test_expect_success 'proper error on non-accessible files' '
>  	chmod -r .git/config &&
>  	test_when_finished "chmod +r .git/config" &&
> -	echo "Error reading configuration file .git/config." >expect &&
> +	echo "Error (-1) reading configuration file .git/config." >expect &&
>  	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
>  	test_cmp expect actual
>  '
> diff --git a/test-config.c b/test-config.c
> index cad35f4..9dd1b22 100644
> --- a/test-config.c
> +++ b/test-config.c
> @@ -86,8 +86,9 @@ int main(int argc, char **argv)
>  		}
>  	} else if (!strcmp(argv[1], "configset_get_value")) {
>  		for (i = 3; i < argc; i++) {
> -			if (git_configset_add_file(&cs, argv[i])) {
> -				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
> +			int err;
> +			if ((err = git_configset_add_file(&cs, argv[i]))) {
> +				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
>  				goto exit2;
>  			}
>  		}
> @@ -103,8 +104,9 @@ int main(int argc, char **argv)
>  		}
>  	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
>  		for (i = 3; i < argc; i++) {
> -			if (git_configset_add_file(&cs, argv[i])) {
> -				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
> +			int err;
> +			if ((err = git_configset_add_file(&cs, argv[i]))) {
> +				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
>  				goto exit2;
>  			}
>  		}
> 
