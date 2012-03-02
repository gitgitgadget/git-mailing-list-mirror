From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: add support for DeltaWalker
Date: Thu, 01 Mar 2012 20:37:09 -0800
Message-ID: <7vpqcvk496.fsf@alter.siamese.dyndns.org>
References: <1330652872-916-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3KF7-0003Df-KI
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 05:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab2CBEhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 23:37:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074Ab2CBEhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 23:37:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24E8F7F70;
	Thu,  1 Mar 2012 23:37:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+xgpNzkwWWthGtXlVjri8D1Bwc=; b=E/u7c3
	JFYnLqSPQleHN2Ojsq3L0Fv2gPVP4OvdI8eqtcpMWm5gugNX1NOJ2sqEQyIZQ1vM
	sphno6havt7xDh3Lvk1yaPDe7RfrmGyaLyN/Fllj6HyLgpMozI+zFYbSyC30QlLi
	ziTiOVKYHrw0z5kVnIAGYJWXFpcOBW1pLWWkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m1U0FxQkhhR7kpTHBwUSY9gIeKrGi6Zj
	04ypP0RdZJyJ3xSh3prn4vwkYHo3ohESGUSP+KA17YHeOyBy1+SYBPZcCCOZFvcR
	d6K7d3tobGLEor5Tm5dwzSy/ki2445vwHQio1PsU5rgjfZMOFq7rw0dAhZnOrxCZ
	Zb6GrTWm+8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC5F7F6F;
	Thu,  1 Mar 2012 23:37:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E5A57F6E; Thu,  1 Mar 2012
 23:37:10 -0500 (EST)
In-Reply-To: <1330652872-916-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 1 Mar 2012 20:47:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FF8625A-6421-11E1-8F72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192000>

Tim Henigan <tim.henigan@gmail.com> writes:

> Since bc7a96a8965d, integration with external diff/merge tools requires
> a mergetools/$tool file to be present.
>
> This commits adds support for DeltaWalker.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
> Tested with DeltaWalker v1.9.8 on Ubuntu 11.10 and msysgit on Win7.
>
>
>  mergetools/DeltaWalker |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 mergetools/DeltaWalker

I see that the earlier refactoring to make mergetool backend pluggable is
starting to pay off rather nicely.  It is not "since ..., requires ...",
but "thanks to ..., adding a random new tool is just a matter of dropping
a trivial shell snippet in the directory".

> diff --git a/mergetools/DeltaWalker b/mergetools/DeltaWalker
> new file mode 100644
> index 0000000..ae66686
> --- /dev/null
> +++ b/mergetools/DeltaWalker
> @@ -0,0 +1,13 @@
> +diff_cmd () {
> +       "$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
> +}

I noticed that most if not all of the mergetool plug-ins have these ugly
/dev/null redirects everywhere, and I also suspect that this may be
inherited from the first bad instance with copy-and-paste.  I was about to
suggest doing these redirection on the calling side in git-mergetool.sh
but there are some that do not want them, so perhaps each plug-in needs to
decide if they want redirection individually.

> +merge_cmd () {
> +       if $base_present
> +       then
> +               "$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$PWD/$MERGED" >/dev/null 2>&1
> +       else
> +               "$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$PWD/$MERGED" >/dev/null 2>&1
> +       fi

Perhaps doing the above like this might make it a bit less of an eye-sore.

	if $base_present
        then
		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$PWD/$MERGED"
	else
		"$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$PWD/$MERGED"
	fi >/dev/null 2>&1

> +       status=$?

This is highly dubious.  Looking at existing mergetools/*, I think the
caller expects merge_cmd to signal success or failure with $?, so you
probably just want to drop this line; the caller will then get the $?
that was set by the "$merge_tool_path" command.

That is how your diff_cmd is communicating with its caller after all, no?

> +}
