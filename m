From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/5] bisect: introduce support for --no-checkout=<ref> option.
Date: Sat, 30 Jul 2011 15:49:36 +0200
Message-ID: <201107301549.36999.chriscool@tuxfamily.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com> <1312014511-7157-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 15:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn9vM-0007eB-Gb
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 15:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab1G3Nts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 09:49:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33447 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab1G3Ntr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 09:49:47 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8EE63A623B;
	Sat, 30 Jul 2011 15:49:39 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312014511-7157-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178196>

On Saturday 30 July 2011 10:28:28 Jon Seymour wrote:
> diff --git a/bisect.c b/bisect.c
> index dd7e8ed..e6c99a0 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -24,6 +24,8 @@ struct argv_array {
> 
>  static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
>  static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
> +static const char *argv_update_ref[] = {"update-ref", "--no-deref",
>                                                           NULL, NULL, NULL};
> +static const char *cursor_ref = 0;

Please use "NULL" instead of "0" above.
And is this global really needed? I would prefer if you passed one more 
argument to some functions.

>  /* bits #0-15 in revision.h */
> 
> @@ -714,9 +716,19 @@ static int bisect_checkout(char *bisect_rev_hex)
>  	mark_expected_rev(bisect_rev_hex);
> 
>  	argv_checkout[2] = bisect_rev_hex;
> -	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
> -	if (res)
> -		exit(res);
> +	if (!cursor_ref) {
> +	  res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
> +	  if (res) {
> +	    exit(res);
> +	  }

Style nit: braces are superfluous, please use:

if (res)
        exit(res); 

> +	} else {
> +	    argv_update_ref[2] = cursor_ref;
> +	    argv_update_ref[3] = bisect_rev_hex;
> +	    res = run_command_v_opt(argv_update_ref, RUN_GIT_CMD);
> +	    if (res) {
> +	      die("update-ref --no-deref %s failed on %s", cursor_ref,
> bisect_rev_hex);
> +	    }

Style nit: braces are superfluous.

> +	}

Thanks,
Christian.
