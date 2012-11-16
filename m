From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 5/6] completion: refactor __gitcomp related tests
Date: Fri, 16 Nov 2012 22:02:42 +0100
Message-ID: <20121116210242.GZ12052@goldbirke>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
 <1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZT4D-0008PV-9c
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab2KPVC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 16:02:59 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:56507 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab2KPVC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 16:02:58 -0500
Received: from localhost6.localdomain6 (p5B130644.dip0.t-ipconnect.de [91.19.6.68])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LwGGE-1TDviv1s4s-017rDE; Fri, 16 Nov 2012 22:02:43 +0100
Content-Disposition: inline
In-Reply-To: <1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:kuh+UCGNw4bD6+2Xnu/pLZyOV6H9grC4VIalD6jBKCa
 5eJn9tGkg/7s87FqffEW4jQ96Zv98w/mWkgZ1fVKmJiax0HRxO
 0e/N5XBxk6HnEzwgSd9E6Py60fnjv5qWfMiB3TyHS3TWvhMIqw
 lqR1YmTmurMg0G4NPyRC5h4xopQzEKyA2HOHOPxIUWyvVSgnhy
 BaQLdeuqrCnX9yGWDhm5xS6gNBk9TUoy8HgNDAb45jQATAt9CV
 AnCWVZ3UScCKH2deV4CYswCcNCZrMSxF/jgEWmjshQ1A2DzThI
 +TEYOiQXUnH+XaVh1nOExX31kiU9ly1+PqkDEAfZGTSZOmu9Yx
 d4nrP2e+2GMzE5ZjAee3iPOwhud/0GIFPTnk8s2G1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209909>

On Sun, Nov 11, 2012 at 03:35:57PM +0100, Felipe Contreras wrote:
> Lots of duplicated code!
> 
> No functional changes.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 76 ++++++++++++++++++---------------------------------
>  1 file changed, 27 insertions(+), 49 deletions(-)

Despite the impressive numbers, these tests are more useful without
this cleanup.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 59cdbfd..66c7af6 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -71,87 +71,65 @@ test_completion ()
>  
>  newline=$'\n'
>  
> -test_expect_success '__gitcomp - trailing space - options' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> -	--reuse-message=Z
> -	--reedit-message=Z
> -	--reset-author Z
> -	EOF
> +# Test __gitcomp.
> +# Arguments are:
> +# 1: typed text so far (cur)

The first argument is not the typed text so far, but the word
currently containing the cursor position.

> +# *: arguments to pass to __gitcomp
> +test_gitcomp ()
> +{
> +	sed -e 's/Z$//' > expected &&
>  	(
>  		local -a COMPREPLY &&
> -		cur="--re" &&
> -		__gitcomp "--dry-run --reuse-message= --reedit-message=
> -				--reset-author" &&
> +		cur="$1" &&
> +		shift &&
> +		__gitcomp "$@" &&
>  		IFS="$newline" &&
>  		echo "${COMPREPLY[*]}" > out
>  	) &&
>  	test_cmp expected out
> +}
> +
> +test_expect_success '__gitcomp - trailing space - options' '
> +	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
> +		--reset-author" <<-EOF
> +	--reuse-message=Z
> +	--reedit-message=Z
> +	--reset-author Z
> +	EOF
>  '
>  
>  test_expect_success '__gitcomp - trailing space - config keys' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> +	test_gitcomp "br" "branch. branch.autosetupmerge
> +		branch.autosetuprebase browser." <<-\EOF
>  	branch.Z
>  	branch.autosetupmerge Z
>  	branch.autosetuprebase Z
>  	browser.Z
>  	EOF
> -	(
> -		local -a COMPREPLY &&
> -		cur="br" &&
> -		__gitcomp "branch. branch.autosetupmerge
> -				branch.autosetuprebase browser." &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> -	) &&
> -	test_cmp expected out
>  '
>  
>  test_expect_success '__gitcomp - option parameter' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> +	test_gitcomp "--strategy=re" "octopus ours recursive resolve subtree" \
> +		"" "re" <<-\EOF
>  	recursive Z
>  	resolve Z
>  	EOF
> -	(
> -		local -a COMPREPLY &&
> -		cur="--strategy=re" &&
> -		__gitcomp "octopus ours recursive resolve subtree
> -			" "" "re" &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> -	) &&
> -	test_cmp expected out
>  '
>  
>  test_expect_success '__gitcomp - prefix' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> +	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
> +		"branch.maint." "me" <<-\EOF
>  	branch.maint.merge Z
>  	branch.maint.mergeoptions Z
>  	EOF
> -	(
> -		local -a COMPREPLY &&
> -		cur="branch.me" &&
> -		__gitcomp "remote merge mergeoptions rebase
> -			" "branch.maint." "me" &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> -	) &&
> -	test_cmp expected out
>  '
>  
>  test_expect_success '__gitcomp - suffix' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> +	test_gitcomp "branch.me" "master maint next pu" "branch." \
> +		"ma" "." <<-\EOF
>  	branch.master.Z
>  	branch.maint.Z
>  	EOF
> -	(
> -		local -a COMPREPLY &&
> -		cur="branch.me" &&
> -		__gitcomp "master maint next pu
> -			" "branch." "ma" "." &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> -	) &&
> -	test_cmp expected out
>  '
>  
>  test_expect_success 'basic' '
> -- 
> 1.8.0
> 
