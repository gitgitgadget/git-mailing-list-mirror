From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v5 2/3] tests: use __gitcompadd to simplify completion
 tests
Date: Wed, 17 Oct 2012 19:50:40 +0200
Message-ID: <20121017175040.GE2156@goldbirke>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
 <1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 19:50:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOXlh-0004jZ-7I
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 19:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab2JQRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 13:50:44 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:49634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397Ab2JQRul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 13:50:41 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MErYk-1T8ZBa1QvC-00FQC4; Wed, 17 Oct 2012 19:50:40 +0200
Content-Disposition: inline
In-Reply-To: <1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:ue25/dMw4qoctnTW2JpdmrobVzbRh6tgWBmjim3/MDm
 OIodBsj5D+4pjg/1lvaOp4GzDQRjb4BM7kNBI89f6g59qmTsfy
 SjwcP/EyWi/Io4LByUUn6c87twnk+X455EChHuXLV0bjrZgSZc
 xnV/6xs6FS4LfUEh3OdyaY/ZCeC6EPvV5UHB8UygGmWcpk3At/
 F4KuOmt5ZP4CpI7m45FQHDFhhRN6JlXdbnWBfFE7HMTHAl7D2S
 VeF0MLHoZLxOGH5+e5uOyWGII87kx40Twnx780o+PyYewga2kj
 xMPgoQusbV1/t9fG2LLDnEXe+goAOnYk/H8o+Uneey/TGoon+T
 5fxmvZFzk38U1WHsq8hs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207926>

On Sun, Oct 14, 2012 at 05:52:50PM +0200, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 92d7eb4..49c6eb4 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -39,19 +39,18 @@ _get_comp_words_by_ref ()
>  	done
>  }
>  
> -print_comp ()
> +__gitcompadd ()
>  {
> -	local IFS=$'\n'
> -	echo "${COMPREPLY[*]}" > out
> +	compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}" > out
>  }

Please don't.  Running compgen is a fundamental part of the completion
script, therefore tests must run it as it is in the completion script
and not some copy of it.

>  run_completion ()
>  {
> -	local -a COMPREPLY _words
> +	local -a _words
>  	local _cword
>  	_words=( $1 )
>  	(( _cword = ${#_words[@]} - 1 ))
> -	__git_wrap__git_main && print_comp
> +	__git_wrap__git_main
>  }
>  
>  test_completion ()
> @@ -70,12 +69,10 @@ test_expect_success '__gitcomp - trailing space - options' '
>  	--reset-author Z
>  	EOF
>  	(
> -		local -a COMPREPLY &&

I'm not sure what I was thinking when I wrote this, but using the
local keyword while not within a function but in a subshell doesn't
seem to be that clever ;)  Maybe just a copy-paste from the local
variable declarations of run-completion().

>  		cur="--re" &&
>  		__gitcomp "--dry-run --reuse-message= --reedit-message=
>  				--reset-author" &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out

And here I should have used print_comp().

All these can be cleaned up without overriding __gitcompadd() and
potentialy compromising correctness.  Will send a patch in a minute.

> +		IFS="$newline"

This was only necessary for echoing the array.

>  	) &&
>  	test_cmp expected out
>  '
> @@ -88,12 +85,10 @@ test_expect_success '__gitcomp - trailing space - config keys' '
>  	browser.Z
>  	EOF
>  	(
> -		local -a COMPREPLY &&
>  		cur="br" &&
>  		__gitcomp "branch. branch.autosetupmerge
>  				branch.autosetuprebase browser." &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> +		IFS="$newline"
>  	) &&
>  	test_cmp expected out
>  '
> @@ -104,12 +99,10 @@ test_expect_success '__gitcomp - option parameter' '
>  	resolve Z
>  	EOF
>  	(
> -		local -a COMPREPLY &&
>  		cur="--strategy=re" &&
>  		__gitcomp "octopus ours recursive resolve subtree
>  			" "" "re" &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> +		IFS="$newline"
>  	) &&
>  	test_cmp expected out
>  '
> @@ -120,12 +113,10 @@ test_expect_success '__gitcomp - prefix' '
>  	branch.maint.mergeoptions Z
>  	EOF
>  	(
> -		local -a COMPREPLY &&
>  		cur="branch.me" &&
>  		__gitcomp "remote merge mergeoptions rebase
>  			" "branch.maint." "me" &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> +		IFS="$newline"
>  	) &&
>  	test_cmp expected out
>  '
> @@ -136,12 +127,10 @@ test_expect_success '__gitcomp - suffix' '
>  	branch.maint.Z
>  	EOF
>  	(
> -		local -a COMPREPLY &&
>  		cur="branch.me" &&
>  		__gitcomp "master maint next pu
>  			" "branch." "ma" "." &&
> -		IFS="$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> +		IFS="$newline"
>  	) &&
>  	test_cmp expected out
>  '
> -- 
> 1.7.12.1
> 
