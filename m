From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool--lib.sh: make check_unchanged return 1 on
 invalid read
Date: Mon, 19 Sep 2011 13:37:44 -0700
Message-ID: <7vaaa09skn.fsf@alter.siamese.dyndns.org>
References: <1316462592-27255-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5kb9-00086A-D3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab1ISUhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:37:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682Ab1ISUhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:37:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E03757E8;
	Mon, 19 Sep 2011 16:37:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HG2j/7yZ4AIlx/47q8k/us0hRVQ=; b=goM+jr
	FtgObF/Ujt9denukCXo4ywA6cC6R2ARng06DJPw4U96pv/hyrJ7S3uIAcV86EZAk
	GuK7tHOVF95PWf67gHFqTaAbe0h9KGU2YiqE061smN3pBozUYIDUKOz5a2lxPxS3
	ZJ58/gXYfbm+GZsoQWMW9JpBoad0VrQ3Lob+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trH813MHm2LAcLZYfwNJiHn9uvflvQRH
	eGNeFYcpIEVNPEBcC+bpPqzkH6y2QpYcGv9lMTHfdRSvAR0aUqYD7B1ssjgxR5F2
	8Zj9xWNxHqTL9LHQXHhkwMe8qiN5IS4EmTCsKH1keLiqjccLvJbAAZsi9KW9UzU9
	JLNr0VH666g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 365C157E7;
	Mon, 19 Sep 2011 16:37:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A5E357E3; Mon, 19 Sep 2011
 16:37:45 -0400 (EDT)
In-Reply-To: <1316462592-27255-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 19 Sep 2011 16:03:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B0E21B2-E2FF-11E0-8255-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181703>

Jay Soffian <jaysoffian@gmail.com> writes:

> Else when the user hits ctrl-c at the "Was the merge successful?
> [y/n]" prompt, mergetool goes into an infinite loop asking
> for input.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

We still seem to miss one "read" unchecked in resolve_symlink_merge(),
even with this patch.

>  git-mergetool--lib.sh |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 8fc65d0400..0eb424484c 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -21,7 +21,11 @@ check_unchanged () {
>  		do
>  			echo "$MERGED seems unchanged."
>  			printf "Was the merge successful? [y/n] "
> -			read answer
> +			if ! read answer
> +			then
> +				status=1
> +				break
> +			fi

I suspect that it would be more consistent with 6b44577 (mergetool: check
return value from read, 2011-07-01), which this patch is a follow-up to,
to do:

	read answer || return 1

here.

Thanks.
