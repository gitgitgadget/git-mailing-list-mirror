From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] bash: add helper function to get config variables
 for completion
Date: Thu, 14 Oct 2010 12:15:07 -0500
Message-ID: <20101014171507.GA17550@burratino>
References: <20101014085538.GB838@neumann>
 <1287046727-22509-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 14 19:18:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6RRx-0003Ug-Rv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 19:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab0JNRSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 13:18:36 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38689 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab0JNRSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 13:18:35 -0400
Received: by qyk5 with SMTP id 5so261980qyk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Tm/dJLF2ygYLeEqZWhzsL+QTCmRxsDvNw5uby5eAy5k=;
        b=tw85kP8kjpQACurqw/0R+Jh7ftKc/vOmK4IK0bDaQvoWcSvVtN4iyjCkCzsPhO7bBN
         GpyewvbTpzCxEr0e0/UTnXxXYsSjyXFFRotYPBHwoZdBhQlQ7UBhkqh9ebC+QMHJmHpP
         dAA1I6Zc4+IThNig62H1KcTwst7CBea2zoDcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oV6xHn51dMhHp1fGNu5l4YrhjyxdVSCVPoY1Vq/L+0nEQ++tIQFbRdiJSh7SolBYkM
         FCXpTO7M9h0kPlE5f5wZwV4e6OySLZ4cQgLwbyLcuzN1JjNoIzL+LhujM2SdF2Bic7Cm
         R2gb7IfYKXfrkhdr0twOuUCHuxjowu+PJDd8c=
Received: by 10.229.98.209 with SMTP id r17mr6054720qcn.241.1287076714292;
        Thu, 14 Oct 2010 10:18:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s28sm4559896qcp.9.2010.10.14.10.18.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 10:18:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287046727-22509-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159058>

SZEDER G=C3=A1bor wrote:

> Currently there are three completion functions that perform similar
> queries to 'git config' to get config variable names.

Good point.

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -451,10 +451,7 @@ __git_remotes ()
>  		echo ${i#$d/remotes/}
>  	done
>  	[ "$ngoff" ] && shopt -u nullglob
> -	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.ur=
l' 2>/dev/null); do
> -		i=3D"${i#remote.}"
> -		echo "${i/.url*/}"
> -	done
> +	__git_get_config_variables "remote" "url"
>  }

Ok, so __git_get_config_variables $category $var means something like

	git config --get-regexp '$category[.].*[.]$var' |
	cut -d. -f2

> @@ -750,14 +747,16 @@ __git_compute_porcelain_commands ()
>  	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
>  }
> =20
> -__git_aliases ()
> +# returns all config variables within a given section with an option=
al
> +# suffix, with both the section name and the suffix removed
> +__git_get_config_variables ()
>  {
> -	local i IFS=3D$'\n'
> -	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "alias=
\..*" 2>/dev/null); do
> +	local section=3D"$1" suffix=3D"${2-}" i IFS=3D$'\n'
> +	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "$sect=
ion\..*${suffix:+\.$suffix}" 2>/dev/null); do

Would it be possible to shorten this line?  e.g.

	for i in $(
		git --git-dir=3D"$(__gitdir)" ...
	); do

or

	while read -r setting
	do
		...
	done < <(
		git --git-dir=3D"$(__gitdir)" ...
	)

or

	local ... IFS=3D$'\n'
	set -- $(git ... )
	for i do
		...
	done
