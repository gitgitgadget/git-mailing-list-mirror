From: "Dave Rodgman" <dav1dr@eml.cc>
Subject: Re: [PATCH] git-rebase-interactive: avoid breaking when
 GREP_OPTIONS="-H"
Date: Mon, 07 Sep 2009 14:25:24 +0100
Message-ID: <1252329924.15286.1333585269@webmail.messagingengine.com>
References: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Carlo Marcelo Arenas Belon" <carenas@sajinet.com.pe>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 15:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkeDt-0006Wb-Cj
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 15:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZIGNZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 09:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZIGNZX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 09:25:23 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40979 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751800AbZIGNZW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 09:25:22 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0637569213;
	Mon,  7 Sep 2009 09:25:25 -0400 (EDT)
Received: from web6.messagingengine.com ([10.202.2.215])
  by compute2.internal (MEProxy); Mon, 07 Sep 2009 09:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=+7tMZD2dGv6+TF9prQVHy28q09U=; b=e5HPMZr+IsxqythLMig+kX03tNzIYOyR1RkZ2GSiWpOiKILfdgfnXXo7zboTESJeB7zJhAmADdTtopfvTOWxjwtMWtKs5bhPromYibhLalXMK5UBVaNUomkS2ul6BIS2EBF2qLX605uYPsS84HznCjpnVdQsTDnijOOXUumsWwA=
Received: by web6.messagingengine.com (Postfix, from userid 99)
	id CAAAF50D73; Mon,  7 Sep 2009 09:25:24 -0400 (EDT)
X-Sasl-Enc: m2ph/m0MNBaJ/nUpNy2Td8wzl8p5mwyBTyVQaXX64TjC 1252329924
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127929>



On Mon, 07 Sep 2009 05:56 -0700, "Carlo Marcelo Arenas Belon"
<carenas@sajinet.com.pe> wrote:
> if GREP_OPTIONS is set and includes -H, using `grep -c` will fail
> to generate a numeric count and result in the following error :
> 
>   /usr/libexec/git-core/git-rebase--interactive: line 110: (standard
>   input):1+(standard input):0: missing `)' (error token is
>   "input):1+(standard input):0")

I think in my case, grep is being confused by colours being enabled - I
have this wrapper script
for grep:

#!/bin/bash
echo $@
`which -a grep|/bin/grep -v $0|head -n 1` --color=auto $@

your patch fixes it though.

thanks

Dave

> 
> instead of grep counting use `wc -l` to return the line count.
> 
> Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
> ---
>  git-rebase--interactive.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23ded48..c12d980 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -106,8 +106,8 @@ mark_action_done () {
>  	sed -e 1q < "$TODO" >> "$DONE"
>  	sed -e 1d < "$TODO" >> "$TODO".new
>  	mv -f "$TODO".new "$TODO"
> -       count=$(grep -c '^[^#]' < "$DONE")
> -       total=$(($count+$(grep -c '^[^#]' < "$TODO")))
> +       count=$(grep '^[^#]' < "$DONE" | wc -l)
> +       total=$(($count+$(grep '^[^#]' < "$TODO" | wc -l)))
>  	if test "$last_count" != "$count"
>  	then
>  		last_count=$count
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
