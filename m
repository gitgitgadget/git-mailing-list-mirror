X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] Bash snippet to show branch and patch in bash prompt
Date: Mon, 30 Oct 2006 17:03:05 +0200
Message-ID: <45461429.4020108@tromer.org>
References: <4545CC6F.90001@tromer.org> <20061030105926.14328.55180.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 15:11:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <20061030105926.14328.55180.stgit@lathund.dewire.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30500>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeYfv-0008SA-Q4 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 16:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030373AbWJ3PDk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 10:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWJ3PDk
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 10:03:40 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:51905 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S964977AbWJ3PDj (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 10:03:39 -0500
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id k9UF3RpH023809; Mon, 30 Oct 2006 17:03:31
 +0200
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

On 2006-10-30 12:59, Robin Rosenberg wrote:
> From: Robin Rosenberg <robin.rosenberg@dewire.com>

> +    function stgtag
> +    {
> +	git_dir=$(git-rev-parse --git-dir 2> /dev/null)
> +	ref=$(git-symbolic-ref HEAD 2> /dev/null)

Abort early if we're not in a git repo:
	git_dir=$(git-rev-parse --git-dir 2> /dev/null) || return
	ref=$(git-symbolic-ref HEAD 2> /dev/null) || return


> +	br=${ref/refs\/heads\//}

You want to strip a prefix only, so this is safer:
	br=${ref#refs/heads/}


> +	top=$(cat $git_dir/patches/$br/current 2>/dev/null)

All variables should be declared local to avoid polluting the bash
variable namespace. Likewise, the function name deserves a couple of
underscores.


> +	if [[ -n "$br$top" ]];then
> +	    echo "[$top@$br]"

It seems better to put the StGIT top after the tag, so that stg push/pop
shifts less of the prompt, making it easier to see the change visually.


Corresponding modified version:

-------------------------------------------
if [ "$PS1" ]; then
    function __prompt_git()
    {
        local git_dir ref br top;
	git_dir=$(git-rev-parse --git-dir 2> /dev/null) || return
	ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
	br=${ref#refs/heads/}
	top=$(cat $git_dir/patches/$br/current 2>/dev/null) \
		&& top="#$top"
	echo "[$br$top]"
    }
    PS1='\u@\h$(__prompt_git)\w\$ '
fi
-------------------------------------------

Conditionally prepending the "#" to $top can be done more concisely via
${top:+#$top} but I used the more readable version.

