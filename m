X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [StGIT PATCH] Bash snippet to show branch and patch in bash prompt
Date: Mon, 30 Oct 2006 11:57:03 +0200
Message-ID: <4545CC6F.90001@tromer.org>
References: <20061029233745.24899.1470.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 09:58:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <20061029233745.24899.1470.stgit@lathund.dewire.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30490>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeTtz-00060K-J1 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 10:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161201AbWJ3J5w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 04:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJ3J5w
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 04:57:52 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:60907 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S1161201AbWJ3J5v (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 04:57:51 -0500
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id k9U9vNCh020874; Mon, 30 Oct 2006 11:57:28
 +0200
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

On 2006-10-30 01:37, Robin Rosenberg wrote:
> +# include this in your bashrc or copy to /etc/bash_completions.d
> +
> +if [ "$PS1" ]; then
> +    # trap 'PS1="\u@\h [$(stg top)] \w]\$ "' DEBUG
> +    function stgtag
> +    {
> +	br=$(stg branch 2>/dev/null)
> +	top=$(stg top 2>/dev/null)
> +	if [[ -n "$br$top" ]];then
> +	    echo "[$top@$br]"
> +	    return
> +	fi
> +    }
> +    PS1='\u@\h$(stgtag)\w\$ '
> +
> +fi

That's an annoying 430ms delay at every prompt, on my box. Does StGIT do
something expensive on every invocation?

Ben Clifford'd solution is pretty much instantaneous, and the following
extends it to StGIT (in a less clean but much faster way):

----------------------------------------------
__prompt_githead() {
    __PS_GIT="$(git-symbolic-ref HEAD 2>/dev/null)" || exit
    __PS_GIT="$(basename $__PS_GIT)"
    echo -n " $__PS_GIT"
    __PS_GIT=$(cat "${GIT_DIR:-.git}/patches/$__PS_GIT/current" \
               2>/dev/null) || exit
    echo -n ":$__PS_GIT"
}
PS1='[\u@\h \W$(__prompt_githead)]\$ '
----------------------------------------------

