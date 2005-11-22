From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 22:26:19 -0800 (PST)
Message-ID: <20051122062619.97432.qmail@web31810.mail.mud.yahoo.com>
References: <7vhda5ssxb.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 22 08:13:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeRbu-0005Oi-Dp
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 07:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVKVG0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 01:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVKVG0V
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 01:26:21 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:44637 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750918AbVKVG0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 01:26:20 -0500
Received: (qmail 97434 invoked by uid 60001); 22 Nov 2005 06:26:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QbgwiSTqGY4y3TctbCsPI/qXGI3aOeA4tIUpHbisdidp2GDnoFmvT0SreF/2Tucm4dyBSCsaA3g7EwuViRWwRRvn4zDgnBP5BgGnqh1BLLCAIwdoh4mHf8LAzcopPJPnI9Ky8Wu3yTny568+J2GUiGPh1jJLpAMrHzqm4URaiEQ=  ;
Received: from [68.221.119.157] by web31810.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 22:26:19 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhda5ssxb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12531>

--- Junio C Hamano <junkio@cox.net> wrote:

> 
> The case statement that follows that comment is not quite right,
> BTW.  "format-patch foo bar..baz" should mean sequence of "foo"
> and then "bar..baz", but it incorrectly translates to a
> malformed "foo..bar..baz".
> 
> Modulo that bug, what the current code does is to special case
> one or two arguments case and rewrite them in that case
> statement, and then iterate over the resulting "$@".  We barf if
> each 'revpair' is not in rev1..rev2 format.
> 
> But it might make sense to (still keeping the above three
> backward compatibility syntax exceptions) interpret "rev" to
> mean "rev^1..rev", like this:

Ok, I don't understand the patch below.  I tried
to get from "rev" to a "rev^1..rev" or the identical
"rev^1 rev", but could never do it with git-format-patch.
So for now I just use the "rev^1..rev".

BTW, here is the analogy:
  git-diff-tree --pretty=raw -p <commit-id>
does what I want, except that it is not in patch format
as expected.  So it is quite possible to just add a
command line parameter to git-diff-tree to indicate
"formatted patch output", and we're done.

    Luben

> 
> ---
> 
> diff --git a/git-format-patch.sh b/git-format-patch.sh
> index 7ee5d32..351790c 100755
> --- a/git-format-patch.sh
> +++ b/git-format-patch.sh
> @@ -99,7 +99,7 @@ filelist=$tmp-files
>  # Also, "rev1.." should mean "rev1..HEAD"; git-diff users are
>  # familiar with that syntax.
>  
> -case "$#,$1" in
> +case "$#,$1$2" in
>  1,?*..?*)
>  	# single "rev1..rev2"
>  	;;
> @@ -131,7 +131,8 @@ do
>  		rev2=`expr "$revpair" : '.*\.\.\(.*\)'`
>  		;;
>  	*)
> -		usage
> +		rev1="$revpair^"
> +		rev2="$revpair"
>  		;;
>  	esac
>  	git-rev-parse --verify "$rev1^0" >/dev/null 2>&1 ||
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
