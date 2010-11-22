From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --abort: do not update branch ref
Date: Sun, 21 Nov 2010 19:11:46 -0800
Message-ID: <7v1v6evyq5.fsf@alter.siamese.dyndns.org>
References: <1290337881-26449-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 04:12:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKMp9-0002i8-SD
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 04:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab0KVDMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 22:12:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab0KVDMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 22:12:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EBBA2221;
	Sun, 21 Nov 2010 22:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8yrU+OFzjxnp8YDRnxNWktw+kKk=; b=tIMlxgpfRS3VUylC7gjbAC7
	drVv2t4FMfE6q2iWz0BQRKlfE0VVXpvNxvXESEYoMTtCsCudMp1ftpO4RPtj0JOB
	1bMCL8DvCr12guUSAN+22bhwVHrStEhNIWxokUVDNwTpyqaJYi3GyiG/7eZKPENx
	+pH8YMO9ETl4lgl/ulZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lM4CqK9xtQ7cC1QCvHDyKfOaxWoQfpGyD1rM961n+nzMqLmga
	xZTb9gL51ENZRUrUfGVYz+hE/a28nLez6t3Pho17oSM+XwJXXN2S4Q3kdZUwpbsh
	xwIJ7mglTc8O1t6XCmqahx5ZPTXFsql9z6D00QGQ3Xge3N3Ue50d4aWV4E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F3BD221F;
	Sun, 21 Nov 2010 22:12:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F724221E; Sun, 21 Nov 2010
 22:12:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4BF83EEC-F5E6-11DF-BF4E-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161879>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> diff --git a/git-rebase.sh b/git-rebase.sh
> index ec08f9c..3d194b1 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -278,12 +278,17 @@ do
>  		if test -d "$dotest"
>  		then
>  			GIT_QUIET=$(cat "$dotest/quiet")
> -			move_to_original_branch
>  		else
>  			dotest="$GIT_DIR"/rebase-apply
>  			GIT_QUIET=$(cat "$dotest/quiet")
> -			move_to_original_branch
>  		fi

Micronit.  It appears that GIT_QUIET is set to the same value in either
case, so perhaps you would also want to move it outside of the if block,
i.e.

	test -d "$dotest" || dotest="$GIT_DIR/rebase-apply"
        GIT_QUIET=$(cat "$dotest/quiet)
        ... your rewrite to move_to_original_branch here ...

no?  Staring at it further, I wonder who pays attention to GIT_QUIET in
this codepath that will soon exit, though.

> +		head_name="$(cat "$dotest"/head-name)" &&
> +		case "$head_name" in
> +		refs/*)
> +			git symbolic-ref HEAD $head_name ||
> +			die "Could not move back to $head_name"
> +			;;
> +		esac
>  		git reset --hard $(cat "$dotest/orig-head")
>  		rm -r "$dotest"
>  		exit
