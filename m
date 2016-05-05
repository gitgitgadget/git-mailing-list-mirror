From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
Date: Thu, 05 May 2016 10:22:55 -0700
Message-ID: <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu May 05 19:23:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayMzQ-0007Oh-PH
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 19:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbcEERXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 13:23:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750854AbcEERW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 13:22:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0716D180D3;
	Thu,  5 May 2016 13:22:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAKMnybgmmJFBhxRZB93INzoNUk=; b=WBlrzh
	QeY8ZS+0TCtHBRXDInSughECvs49Q5QbbDhEOrmKAr4j39+JuU5hNgl/6wZ2tCm0
	04mk3tgy5eQYY17VlGk84mheOYclgoS+Q522kRUP6rfQq7v1UqVxy/zunKtGynUb
	iQpF3GdZA1nFwcUZDiBGoK8DGFid51QDOimpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b8ppwzcyFpCOpTLlNAHQfeVo2SWV7szd
	bRx6suq9rLtK5epttJsaAjcTGL9+aYAkCfQLc/IkmUck2nqAG6uXcLfpah+JUicP
	drbJW+WpPm/Css8KLLk18hSHRcsFazbOalKfpcs1PayIVKL+PHMhOr0bSDMOn70O
	Nxz1Vrv+UXQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F4C180D2;
	Thu,  5 May 2016 13:22:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C450180D1;
	Thu,  5 May 2016 13:22:57 -0400 (EDT)
In-Reply-To: <1462458182-4488-1-git-send-email-orgads@gmail.com> (Orgad
	Shaneh's message of "Thu, 5 May 2016 17:23:02 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0281B450-12E6-11E6-B177-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293655>

Pat, we haven't heard from you for a long time.  Are you still
around and interested in helping us by maintaining git-gui?

Otherwise we may have to start recruiting a volunteer or two to take
this over.

Thanks.

Orgad Shaneh <orgads@gmail.com> writes:

> git commit --amend preserves the author details unless --reset-author is
> given.
>
> git-gui discards the author details on amend.
>
> Fix by reading the author details along with the commit message, and
> setting the appropriate environment variables required for preserving
> them.
>
> Reported long ago in the mailing list[1].
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/243921
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>  git-gui/lib/commit.tcl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 864b687..60edf99 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -1,8 +1,13 @@
>  # git-gui misc. commit reading/writing support
>  # Copyright (C) 2006, 2007 Shawn Pearce
>  
> +set author_name ""
> +set author_email ""
> +set author_date ""
> +
>  proc load_last_commit {} {
>  	global HEAD PARENT MERGE_HEAD commit_type ui_comm
> +	global author_name author_email author_date
>  	global repo_config
>  
>  	if {[llength $PARENT] == 0} {
> @@ -34,6 +39,10 @@ You are currently in the middle of a merge that has not been fully completed.  Y
>  					lappend parents [string range $line 7 end]
>  				} elseif {[string match {encoding *} $line]} {
>  					set enc [string tolower [string range $line 9 end]]
> +				} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
> +					set author_name $name
> +					set author_email $email
> +					set author_date $time
>  				}
>  			}
>  			set msg [read $fd]
> @@ -107,8 +116,12 @@ proc do_signoff {} {
>  
>  proc create_new_commit {} {
>  	global commit_type ui_comm
> +	global author_name author_email author_date
>  
>  	set commit_type normal
> +	set author_name ""
> +	set author_email ""
> +	set author_date ""
>  	$ui_comm delete 0.0 end
>  	$ui_comm edit reset
>  	$ui_comm edit modified false
> @@ -327,6 +340,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>  	global ui_comm selected_commit_type
>  	global file_states selected_paths rescan_active
>  	global repo_config
> +	global env author_name author_email author_date
>  
>  	gets $fd_wt tree_id
>  	if {[catch {close $fd_wt} err]} {
> @@ -366,6 +380,11 @@ A rescan will be automatically started now.
>  		}
>  	}
>  
> +	if {$author_name ne ""} {
> +		set env(GIT_AUTHOR_NAME) $author_name
> +		set env(GIT_AUTHOR_EMAIL) $author_email
> +		set env(GIT_AUTHOR_DATE) $author_date
> +	}
>  	# -- Create the commit.
>  	#
>  	set cmd [list commit-tree $tree_id]
