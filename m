From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add format-patch options to send-email
Date: Tue, 16 Oct 2012 00:48:57 +0200
Message-ID: <20121015224857.GA2156@goldbirke>
References: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 00:49:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNtTJ-0008T2-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 00:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab2JOWtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 18:49:03 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:62539 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab2JOWtC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 18:49:02 -0400
Received: from localhost6.localdomain6 (p5B1307B3.dip0.t-ipconnect.de [91.19.7.179])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MTgXI-1Sxb9l3BLs-00QPcS; Tue, 16 Oct 2012 00:48:58 +0200
Content-Disposition: inline
In-Reply-To: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:+WsijoYiAG7MRPO+Z1HUrTtWyweQM5C9lTdba3TZw9O
 bRn4TMQzLbLKOyX7dIji4ARiI1K8r6gvYQ09P7pcp105FoPKrK
 4VyRDdEBs0tXpKxYMSkP57KbfxLkdW+rlwbn/RLaywbLTFyzif
 OqqXE+eHw9xW/86QDXJVl7L6dN5MMSAU5QcvkLoav7UEc/FSPq
 8m0i2o8SqkXXlwcBb/jyNhf/osSym3vxE9HDXvQvp0cvxqYpgC
 11nqdQyu/eNo3PY63Gi4TaZFExXdqEUxnLXrC/FhKftG37C0Ge
 ihBM7sh6hleqpZuZ11m3gMYmDQlMbz7/brtA7g6RPTc3+Zhe/0
 J6kJWnVyTBeP725ydVMY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207784>

Hi,

On Sun, Oct 14, 2012 at 06:14:03PM +0200, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 35 +++++++++++++++++-----------------
>  t/t9902-completion.sh                  | 21 ++++++++++++++++++++
>  2 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d743e56..2a83504 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash

This patch doesn't apply on current master.

> @@ -1559,11 +1559,12 @@ _git_send_email ()
>  			--signed-off-by-cc --smtp-pass --smtp-server
>  			--smtp-server-port --smtp-encryption= --smtp-user
>  			--subject --suppress-cc= --suppress-from --thread --to
> -			--validate --no-validate"
> +			--validate --no-validate
> +			$__git_format_patch_options"
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__git_complete_revlist_file

While send-email accepts a rev-list, it doesn't accept
'HEAD:Documentation', does it?  So __git_complete_revlist() would be
better here, because that makes the intent clear.

>  }
>  
>  _git_stage ()
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 92d7eb4..c4b6c13 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -146,6 +146,22 @@ test_expect_success '__gitcomp - suffix' '
>  	test_cmp expected out
>  '
>  
> +setup_repository ()
> +{
> +	mkdir "$1" && (
> +	cd "$1" &&
> +	git init &&
> +	test_tick &&
> +	git commit --allow-empty -m "Initial"
> +	)
> +}
> +
> +test_expect_success 'prepare' '
> +	setup_repository one &&
> +	git clone one test &&

Why are these new repositories needed?

> +	cd test

This 'cd' makes all subsequent tests to be executed in a different
repository than previously, which breaks 'checkout completes ref
names'.

> +'
> +
>  test_expect_success 'basic' '
>  	run_completion "git \"\"" &&
>  	# built-in
> @@ -228,4 +244,9 @@ test_expect_success 'general options plus command' '
>  	test_completion "git --no-replace-objects check" "checkout "
>  '
>  
> +test_expect_success 'send-email' '
> +	test_completion "git send-email --cov" "--cover-letter " &&
> +	test_completion "git send-email ma" "master "
> +'
> +
>  test_done
> -- 
> 1.7.12.1
> 
