From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] completion: cleanup __gitcomp*
Date: Mon, 30 Jan 2012 11:50:04 -0600
Message-ID: <20120130175004.GG10618@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-4-git-send-email-felipec@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipec@infradead.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 18:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvMy-0001xW-2d
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab2A3RuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:50:14 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58749 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab2A3RuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:50:13 -0500
Received: by yenm6 with SMTP id m6so1905242yen.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=n1xGvl/VAsKeBzcFMpszMG6kYuTB/O7N3BMUsjyaSfk=;
        b=WSwJKxx+DtQdh7rRowny4AQzlirTMvcCCdrEgjs28m9srwPMzHJmUSH6kBbNTiOGXX
         EJf0vwzgw0SE19P113NB7vYFnyIAcHTjZByQ+mpwr+QH11xNdLVW6+PVXzYZgit3BCAy
         2p4S0R+pLbSpEmM29xMqdmAfkony/NcZGypM0=
Received: by 10.236.184.131 with SMTP id s3mr10706534yhm.32.1327945813011;
        Mon, 30 Jan 2012 09:50:13 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h29sm48027745ann.16.2012.01.30.09.50.10
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 09:50:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327944197-6379-4-git-send-email-felipec@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189382>

Felipe Contreras wrote:

> I don't know why there's so much code; these functions don't seem to be
> doing much:

Unless you mean "This patch has had inadequate review and I don't
understand the code I'm patching, so do not trust it", please drop
this commentary or place it after the three dashes.

>  * no need to check $#, ${3:-$cur} is much easier
>  * __gitcomp_nl doesn't seem to using the initial IFS
>
> This makes the code much simpler.
>
> Eventually it would be nice to wrap everything that touches compgen and
> COMPREPLY in one function for the zsh wrapper.
>
> Comments by Jonathan Nieder.

I don't want this acknowledgement.  Who should care that I commented
on something?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   20 +++-----------------
>  1 files changed, 3 insertions(+), 17 deletions(-)

This diffstat tells me more of what I wanted to know about the patch
than the description did.

I imagine it would have been enough to say something along the lines of
"The __gitcomp and __gitcomp_nl functions are unnecessarily verbose.
__gitcomp_nl sets IFS to " \t\n" unnecessarily before setting it to "\n"
by mistake.  Both functions use 'if' statements to read parameters
with defaults, where the ${parameter:-default} idiom would be just as
clear.  By fixing these, we can make each function almost a one-liner."

By the way, the subject ("clean up __gitcomp*") tells me almost as
little as something like "fix __gitcomp*".  A person reading the
shortlog would like to know _how_ you are fixing it, or what the
impact of the change will be --- e.g., something like "simplify
__gitcomp and __gitcomp_nl" would be clearer.

[...]
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
[...]
> @@ -524,18 +520,8 @@ __gitcomp ()
>  #    appended.
>  __gitcomp_nl ()
>  {
> -	local s=$'\n' IFS=' '$'\t'$'\n'
> -	local cur_="$cur" suffix=" "
> -
> -	if [ $# -gt 2 ]; then
> -		cur_="$3"
> -		if [ $# -gt 3 ]; then
> -			suffix="$4"
> -		fi
> -	fi
> -
> -	IFS=$s
> -	COMPREPLY=($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
> +	local IFS=$'\n'
> +	COMPREPLY=($(compgen -P "${2-}" -S "${4:- }" -W "$1" -- "${3:-$cur}"))

This loses the nice name $suffix for the -S argument.  Not a problem,
just noticing.
