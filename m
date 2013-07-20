From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git p4 test: Check ignore files with client spec
Date: Sat, 20 Jul 2013 09:48:37 -0400
Message-ID: <20130720134837.GB18479@padd.com>
References: <1374188693-547-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 15:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0XWu-0006Ll-QC
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 15:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab3GTNsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 09:48:41 -0400
Received: from honk.padd.com ([74.3.171.149]:40462 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754072Ab3GTNsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 09:48:40 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id DB5E91E55;
	Sat, 20 Jul 2013 06:48:39 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6518A23A3E; Sat, 20 Jul 2013 09:48:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1374188693-547-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230897>

vitor.hda@gmail.com wrote on Fri, 19 Jul 2013 00:04 +0100:
> This test confirms that a file can be ignored during git p4 sync if if is
> excluded in P4 client specification.

This is a good check to have, and I'm glad it happens to work.  :)

I'd forgotten during your conversation with Matthieu that we
did indeed have tests for detect-branches with use-client-spec.
This test sure seems like it should cover that situation though.

Acked-by: Pete Wyckoff <pw@padd.com>

> ---
>  t/t9801-git-p4-branch.sh | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 9730821..2bf142d 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -469,9 +469,11 @@ test_expect_success 'use-client-spec detect-branches skips branches setup' '
>  		View: //depot/usecs/b1/... //depot/usecs/b3/...
>  		EOF
>  
> -		echo b3/b3-file3 >b3/b3-file3 &&
> -		p4 add b3/b3-file3 &&
> -		p4 submit -d "b3/b3-file3"
> +		echo b3/b3-file3_1 >b3/b3-file3_1 &&
> +		echo b3/b3-file3_2 >b3/b3-file3_2 &&
> +		p4 add b3/b3-file3_1 &&
> +		p4 add b3/b3-file3_2 &&
> +		p4 submit -d "b3/b3-file3_1 b3/b3-file3_2"
>  	)
>  '
>  
> @@ -487,6 +489,21 @@ test_expect_success 'use-client-spec detect-branches skips branches' '
>  	)
>  '
>  
> +test_expect_success 'use-client-spec detect-branches skips files in branches' '
> +	client_view "//depot/usecs/... //client/..." \
> +		    "-//depot/usecs/b3/b3-file3_1 //client/b3/b3-file3_1" &&
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		cd "$git" &&
> +		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
> +		git checkout -b master p4/usecs/b3 &&
> +		test_path_is_file b1-file1 &&
> +		test_path_is_file b3-file3_2 &&
> +		test_path_is_missing b3-file3_1
> +	)
> +'
> +
>  test_expect_success 'kill p4d' '
>  	kill_p4d
>  '
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
