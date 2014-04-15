From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: show staged submodules regardless of ignore config
Date: Tue, 15 Apr 2014 15:34:25 -0700
Message-ID: <xmqqwqeqi5n2.fsf@gitster.dls.corp.google.com>
References: <53444FA8.7020504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:34:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaBw2-0006yD-D8
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 00:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbaDOWe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 18:34:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbaDOWe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 18:34:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4E57DE9D;
	Tue, 15 Apr 2014 18:34:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hUpd89NdA5Lz2BjPyYOKVpHyXdM=; b=IhX5XG
	yQYCFHj1wnsjL4y2U6DYSvm613oTXfv2QBs1uP3QU5STZGJchuZTSy+3ePSRmSD+
	h3Fb3d2vP6X8UDJLpwZ98R16MPQ9HzXFDnUlPZNrxEAbTSsHWfaOHCGTqym4q9wP
	d1P4Yt3vot8s5Rc8CiwTN63Sshy2NN+K5jc5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n2jCQW4Zh4L0JcpuKjtP9s/tKRV1xyIx
	EJ15GtZWfcUDS5CnS1CcXjHaMCeEHO17s0L8RsUl65taLyhnpKLSdSUF0HeYMetk
	70QLtH/MvIvUs+S2SBUeQjrziCnE2zyXDCz5WuLPqR5sqD5KqvGf8AUd1e0dGVnC
	BIoYzBIniTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21CC37DE9C;
	Tue, 15 Apr 2014 18:34:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D3307DE9B;
	Tue, 15 Apr 2014 18:34:26 -0400 (EDT)
In-Reply-To: <53444FA8.7020504@web.de> (Jens Lehmann's message of "Tue, 08 Apr
	2014 21:36:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 19CE2B04-C4EE-11E3-8BB4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246307>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
> "all" suppresses all output of submodule changes for gitk. This is really
> confusing, as even when the user chooses to record a new commit for an
> ignored submodule by adding it manually this change won't show up under
> "Local changes checked in to index but not committed".
>
> Fix that by using the '--ignore-submodules=dirty' option for both callers
> of "git diff-index --cached" when the underlying git version supports that
> option.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

I'll tentatively queue this on jl/gitk-show-added-submodule-changes
and park it on 'pu', but I'd prefer it to come to me through your
tree.

I'll be tagging 2.0.0-rc0 later this week; if you have some
accumulated changes (I saw that your public repository has an
initial vietnamese translation patch that I still do not have),
please plan to get them in by the end of next week.

Thanks.

>  gitk | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/gitk b/gitk
> index 90764e8..f6efaa6 100755
> --- a/gitk
> +++ b/gitk
> @@ -5205,11 +5205,15 @@ proc dohidelocalchanges {} {
>  # spawn off a process to do git diff-index --cached HEAD
>  proc dodiffindex {} {
>      global lserial showlocalchanges vfilelimit curview
> -    global hasworktree
> +    global hasworktree git_version
>
>      if {!$showlocalchanges || !$hasworktree} return
>      incr lserial
> -    set cmd "|git diff-index --cached HEAD"
> +    if {[package vcompare $git_version "1.7.2"] >= 0} {
> +	set cmd "|git diff-index --cached --ignore-submodules=dirty HEAD"
> +    } else {
> +	set cmd "|git diff-index --cached HEAD"
> +    }
>      if {$vfilelimit($curview) ne {}} {
>  	set cmd [concat $cmd -- $vfilelimit($curview)]
>      }
> @@ -7705,7 +7709,7 @@ proc addtocflist {ids} {
>  }
>
>  proc diffcmd {ids flags} {
> -    global log_showroot nullid nullid2
> +    global log_showroot nullid nullid2 git_version
>
>      set i [lsearch -exact $ids $nullid]
>      set j [lsearch -exact $ids $nullid2]
> @@ -7726,6 +7730,9 @@ proc diffcmd {ids flags} {
>  	    }
>  	}
>      } elseif {$j >= 0} {
> +	if {[package vcompare $git_version "1.7.2"] >= 0} {
> +	    set flags "$flags --ignore-submodules=dirty"
> +	}
>  	set cmd [concat | git diff-index --cached $flags]
>  	if {[llength $ids] > 1} {
>  	    # comparing index with specific revision
