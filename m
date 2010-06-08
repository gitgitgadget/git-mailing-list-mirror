From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.*
	configurations ignored for known tools
Date: Tue, 8 Jun 2010 01:34:46 -0700
Message-ID: <20100608083445.GC14366@gmail.com>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr> <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Jun 08 10:35:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLuGw-0000I6-RW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 10:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0FHIex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 04:34:53 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:43458 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0FHIew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 04:34:52 -0400
Received: by pzk6 with SMTP id 6so2006390pzk.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Az3rCYz0uUc/Lmr2Qzi5t8PcKRpMPeVpaPP9kXQswQM=;
        b=pl/Nw27h2uc944S54Fz1eUWSJSn2ilSmwlLylmLUJ47I0fUxzX3lZ9nSYh3zJIoFGI
         lnAbR9C5Z34BmoQss9m5hyopXY9jCnDzDt5QtL1JRdIuPnVpbsMFhvzcmgqBIAcPOrvc
         haJMGSP3aaKQis2bC8C4JDzfSIe8jt3Xpm7XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F7DMDASb2ohsxt687K1xosjFlJ+brbDC3hJZbJkjO6qh3Zjm6I8vYSTnpImyUg7mrN
         PoE7yzEY5oVdUpfJjb+BeqkvXn2r7ZcP+25ybucCkwgS9Y/Y2wABNOghb9zyoexA4Giz
         0G//UpjMgPVrX0ACE571McXb3+fISGeHpxhP4=
Received: by 10.115.115.9 with SMTP id s9mr12752570wam.66.1275986091362;
        Tue, 08 Jun 2010 01:34:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 33sm47715042wad.20.2010.06.08.01.34.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 01:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148655>


Hi, sorry for the delay in responding to this email.

On Sat, Jun 05, 2010 at 04:31:52AM +0200, Sylvain Rabot wrote:
> At this time when you define merge.tool with a known tool,
> such as meld, p4merge, diffuse ... etc, mergetool.<tool>.*
> configurations are ignored and git mergetool will use its
> own templates.
> 
> This patch adds a detection for mergetool.<tool>.cmd configuration
> in the run_merge_tool function. If the configuration is set, it will
> try to run the tool with mergetool.<tool>.path if its set. It also
> consider the mergetool.<tool>.trustExitCode configuration.
> 
> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> ---
>  git-mergetool--lib.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 51dd0d6..2a58d88 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -84,9 +84,69 @@ get_merge_tool_cmd () {
>  
>  run_merge_tool () {
>  	merge_tool_path="$(get_merge_tool_path "$1")" || exit
> +	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
> +	merge_tool_cmd_base="$(echo $merge_tool_cmd | cut -f1 -d " ")"
>  	base_present="$2"
>  	status=0
>  
> +	# if mergetool.<tool>.cmd is set we execute it, not a template
> +	if test -n "$merge_tool_cmd"; then
> +		# mergetool.<tool>.path is empty
> +		if test -z "$merge_tool_path"; then
> +			# mergetool.<tool>.cmd not found
> +			if ! $(which "$merge_tool_cmd_base" > /dev/null 2>&1); then
> +				echo >&2 "Configuration mergetool.$1.cmd \"$merge_tool_cmd_base\" not found"
> +				exit 1
> +			else
> +				merge_cmd="$merge_tool_path/$merge_tool_cmd"
> +			fi
> +		# mergetool.<tool>.path is a path

Files and Directories are both paths...

> +		elif test -d "$merge_tool_path"; then

But...

> +			# mergetool.<tool>.cmd not found
> +			if !test -f "$merge_tool_path/$merge_tool_cmd_base"; then
> +				echo >&2 "Configuration mergetool.$1.cmd \"$(echo "$merge_tool_path/$merge_tool_cmd_base" | sed 's#//\+#/#')\" not found"
> +				exit 1
> +			# mergetool.<tool>.cmd not executable
> +			elif !test -x "$merge_tool_path/$merge_tool_cmd_base"; then
> +				echo >&2 "Configuration mergetool.$1.cmd \"$(echo "$merge_tool_path/$merge_tool_cmd_base" | sed 's#//\+#/#')\" is not executable"
> +				exit 1
> +			# tool ok
> +			else
> +				merge_cmd="$merge_tool_path/$merge_tool_cmd"
> +			fi

I don't think we ever signed up to support this configuration.
mergetool.<tool>.path has always (from my naive reading of the
documentation) been the absolute path to <tool>.

I don't think it should have a dual-role where it can be either
the tool's parent directory or the path to the tool itself.
I would prefer to keep it as simple as possible, if we can.


> +		# mergetool.<tool>.path is the same as mergetool.<tool>.cmd
> +		elif test "$merge_tool_path" = "$merge_tool_cmd_base"; then
> +			# mergetool.<tool>.cmd not found
> +			if ! $(which "$merge_tool_cmd_base" > /dev/null 2>&1); then
> +				echo >&2 "Configuration mergetool.$1.cmd \"$merge_tool_cmd_base\" not found"
> +				exit 1
> +			else
> +				merge_cmd="$merge_tool_cmd"
> +			fi
> +		# mergetool.<tool>.path is the tool itself
> +		elif $(which "$merge_tool_path" > /dev/null 2>&1); then
> +			merge_cmd="$merge_tool_path $merge_tool_cmd"
> +		# mergetool.<tool>.path invalid
> +		else
> +			echo >&2 "Configuration mergetool.$1.path \"$merge_tool_path\" is not valid path"
> +			exit 1
> +		fi
> +
> +		# trust exit code
> +		trust_exit_code="$(git config --bool mergetool."$1".trustExitCode || echo false)"
> +
> +		if test "$trust_exit_code" = "false"; then
> +			touch "$BACKUP"
> +			(eval "$merge_cmd")
> +			check_unchanged
> +			return $status
> +		else
> +			(eval "$merge_cmd")
> +			status=$?
> +			return $status
> +		fi
> +	fi

This section is getting pretty nested.
Should we break the handling for configs-that-override-builtins
into a separate function?

> +
>  	case "$1" in
>  	kdiff3)
>  		if merge_mode; then
> -- 
> 1.7.1

One last thing -- I tried to fetch from the repo you
mentioned elsewhere in this thread but it was offline.

Cheers,

-- 
		David
