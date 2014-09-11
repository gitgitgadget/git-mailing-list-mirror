From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitk: write only changed configuration variables
Date: Thu, 11 Sep 2014 10:19:56 -0700
Message-ID: <xmqqtx4edqgz.fsf@gitster.dls.corp.google.com>
References: <1410412888-10187-1-git-send-email-max@max630.net>
	<1410412888-10187-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS82W-0003Id-N9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaIKRUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:20:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53265 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaIKRUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:20:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B03F838630;
	Thu, 11 Sep 2014 13:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ngxqoG8vOg5g8k6qazB206Auh1Q=; b=cqgCr6
	4zfM5zW7dxY4C2rJPp+0n2tg11pFq/21oDyahxouGcCA8vdidznSSPSSpNmBNlwT
	ToOhvno1YGXy5lZBYMLXD49w5w/sFXCQrMgt0iz02jHeCHKrXWvTq0SZxmmfUnYP
	EM8bYLb47h1OGKNvCqYIhKk8zNQFcBcT25EZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pVcV4+aDVNZerBwFs8UFhLjwXbaXR4+U
	7EIz6F/PRtxY+VNeWRTWQUj8WI4mAhQTAF+4AEORjiaGLXId/eQWBokP0RhKtdSG
	uww3EfUrOU3TJrbZsxtjnShA8t9k8jxM04CnR28UkTG1qCFff8PdI2eE7GaL0Lf2
	46GdCKbQhkg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8909E3862F;
	Thu, 11 Sep 2014 13:19:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E6BE738626;
	Thu, 11 Sep 2014 13:19:58 -0400 (EDT)
In-Reply-To: <1410412888-10187-3-git-send-email-max@max630.net> (Max
	Kirillov's message of "Thu, 11 Sep 2014 08:21:27 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB6510EE-39D7-11E4-A214-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256856>

Max Kirillov <max@max630.net> writes:

> If a variable is changed in a concurrent gitk or manually it is
> preserved unless it has changed in this instance

It would have been easier to understand why this is a desirable
change if you stated what problem you are trying to solve before
that sentence.  "If I do X, Y happens, which is bad for reason Z.
With this change, Y no longer happens as long as I do not do W."

> This change does not affect geometry and views save; geometry does not
> need it, and views need special merging, which treats each view
> separately rather that fully replace the shole list.

s/sh/wh/ I presume?

>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  gitk | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/gitk b/gitk
> index 6069afe..6e22024 100755
> --- a/gitk
> +++ b/gitk
> @@ -2804,12 +2804,25 @@ proc doprogupdate {} {
>      }
>  }
>  
> +proc config_variable_change_cb {name name2 op} {
> +    global config_variable_changed
> +    if {$op eq "write"} {
> +	set config_variable_changed($name) 1
> +    }
> +}

Hmm, wouldn't it make more sense to save the original value where
you set up the variable trace, and make the savestuff procedure do a
3-way merge?  That way, when you and the other party changed a
variable to a different value, you can give a better diagnosis to
the user to know what is going on. If both of you changed to the
same value, then the end result would be the same, of course.
