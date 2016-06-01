From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 2/2] completion: add git status
Date: Wed, 01 Jun 2016 14:15:10 +0200
Message-ID: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
References: <20160601040542.GA18978@sigill.intra.peff.net>
 <6e722a5fb64b73373ac6450ec9600e98745df29d.1464769152.git.thomas.braun@virtuell-zuhause.de>
 <1464773857.4315.1.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 14:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b853T-0007vx-EE
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 14:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbcFAMPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 08:15:18 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34599 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716AbcFAMPR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 08:15:17 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b853K-0003Jk-6h; Wed, 01 Jun 2016 14:15:14 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b853G-00060o-MK; Wed, 01 Jun 2016 14:15:10 +0200
Received: from x590c39c4.dyn.telefonica.de (x590c39c4.dyn.telefonica.de
 [89.12.57.196]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 01 Jun 2016 14:15:10 +0200
In-Reply-To: <1464773857.4315.1.camel@virtuell-zuhause.de>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1464783314.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296081>


Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash  
> b/contrib/completion/git-completion.bash
> index addea89..77343da 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1782,6 +1782,35 @@ _git_stage ()
>  	_git_add
>  }
>
> +_git_status ()
> +{
> +	case "$cur" in
> +	--ignore-submodules=*)
> +		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
> +		return
> +		;;
> +	--untracked-files=*)
> +		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
> +		return
> +		;;
> +	--column=*)
> +		__gitcomp "
> +			always never auto column row plain dense nodense
> +			" "" "${cur##--column=}"
> +		return
> +		;;
> +	--*)
> +		__gitcomp "
> +			--short --branch --porcelain --long --verbose
> +			--untracked-files= --ignore-submodules= --ignored
> +			--column= --no-column
> +			"
> +		return
> +		;;
> +	esac
> +	__git_complete_file

__git_complete_file()'s job is to complete the '<rev>:<path>' notation,
e.g. 'master:Mak<TAB>',  which is not what we want here, because this
notation doesn't make sense for 'git status' and because 'git status
<TAB>' would then offer refs instead of files.

I think there are two choices what to do instead:

   - Don't do anything :)  Bash will then fall back to filename
     completion, which is quite close to what we want here (and in this
     case the return statements from the other case arms can go away as
     well).  The drawback is that all ignored files in the current
     working directory will show up after 'git status <TAB>'.

   - use __git_complete_index_file() with appropriate options, perhaps
     '--cached --others', but I didn't think this through.  For bonus
     points pass additional options when certain 'git status' options are
     already present on the command line, e.g. pass '--ignored', too, if
     it is present.

> +}
> +
>  __git_config_get_set_variables ()
>  {
>  	local prevword word config_file= c=$cword
