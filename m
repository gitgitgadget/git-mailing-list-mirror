From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Thu, 02 Jan 2014 15:56:48 -0800
Message-ID: <xmqqa9fendj3.fsf@gitster.dls.corp.google.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
	<1388415138-11011-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 00:56:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vys8G-0004Nx-UA
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 00:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaABX4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 18:56:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaABX4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 18:56:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DC4960379;
	Thu,  2 Jan 2014 18:56:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2yKu3zy/dA63Id8lDvsbMDZMXaI=; b=IIYmTH
	AW5UJpGf3Ss3Kqo3K4OE80H5OIozA39h7mtcqY652aw/KBAPynRsaSm7/ypk9A7i
	yyilbqxdjRNmqq6PcX5jp1EJefi4cG92piuFk3ulwvwSn/mRKrJzsuztZGpmWkBX
	qP1h3TmTBEHBG+lVefmOitoTUPtb17ENaODCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tgeEzcpZuCf8L0qv4KydmGyTbMvR0mux
	4YT1aWR0mm4rvK5nRhgWwsi5Ktpd8WpS0JTCjJBnXdlBF4/x5ZClG4haXnWW9ktR
	dpJUe6WbuVjyMjyRk1MsMLcnd9d+hPRHJytFCPb/jz+aEdMvk2ws6R1FAiadBYMB
	7zQTf6xtqag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2947660378;
	Thu,  2 Jan 2014 18:56:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D1AB60375;
	Thu,  2 Jan 2014 18:56:51 -0500 (EST)
In-Reply-To: <1388415138-11011-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 30 Dec 2013 20:22:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C9D9808-7409-11E3-911C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239896>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  	branch.*.*)
>  		local pfx="${cur%.*}." cur_="${cur##*.}"
> +		if [ "$pfx" == "branch.autosetupmerge." ] ||
> +			[ "$pfx" == "branch.autosetuprebase." ]; then
> +			return
> +		fi
>  		__gitcomp "remote pushremote merge mergeoptions rebase" "$pfx" "$cur_"
>  		return
>  		;;

I do not quite understand this change.

If we are looking at "branch.autosetupmerge." followed by something,
who typed that final dot?  If you are working on a topic about
auto-setup-merge and named your branch "autosetupmerge", don't you
want to be able to configure various aspect of that branch via
branch.autosetupmerge.{remote,merge} etc., just like you can do so
for your "topic" branch via branch.topic.{remote,merge} etc.,
regardless of your use of "autosetupmerge" option across branches?

Besides, it smells fishy to me that you need to enumerate and
special case these two here, and then you have to repeat them below
in a separate case arm.

>  	branch.*)
>  		local pfx="${cur%.*}." cur_="${cur#*.}"
> -		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
> +		__gitcomp_2 "$(__git_heads)" "
> +			autosetupmerge autosetuprebase
> +			" "$pfx" "$cur_" "."
>  		return
>  		;;
>  	guitool.*.*)
