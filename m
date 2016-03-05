From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mergetool: honor tempfile configuration when resolving delete conflicts
Date: Fri, 04 Mar 2016 23:21:24 -0800
Message-ID: <xmqqy49xwft7.fsf@gitster.mtv.corp.google.com>
References: <1457159948-10645-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Joe Einertson <joe@kidblog.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 08:21:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac6Wx-0002V8-3K
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 08:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108AbcCEHVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 02:21:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750952AbcCEHV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 02:21:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4176C45E82;
	Sat,  5 Mar 2016 02:21:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDJUxPL6VCEGM6Y+4WM/it9ETek=; b=C5aeBG
	CwJfjoMHrYWAh/ZBLsOgshk7AA+sZv1gaFQBN44cIddVj3/oXulyUhpRoxLZ2gjn
	a5OoQj1xJkgMUUdOcUJtZQfqfFrnBuYczzCTwAfPe5x3l1BcwaKpKyB5FJfvu2rx
	VzrNkBGOwhNQvFo+wm+pb8Cu9i4IJ594Z17hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZ/TN0h1O2BfCHl2t2QCrU7hJswEa6ig
	MsjuoYZUk5b0sNCGJ2nNhzcxrRsjyNlhju0oF0tFLTr8PkDd+vAgHZwrbg2pseFa
	x/1IU0Nqe4WdwF7b6FVZLQq4gBsXbqIeN0YnW0QZ/AACmMKD4ABJNT+GZq/JCijz
	2PzvjObylgU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3936545E81;
	Sat,  5 Mar 2016 02:21:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B037445E7F;
	Sat,  5 Mar 2016 02:21:25 -0500 (EST)
In-Reply-To: <1457159948-10645-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 4 Mar 2016 22:39:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DEED367C-E2A2-11E5-BD68-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288298>

David Aguilar <davvid@gmail.com> writes:

> Teach resolve_deleted_merge() to honor the mergetool.keepBackup and
> mergetool.keepTemporaries configuration knobs.
>
> This ensures that the worktree is kept pristine when resolving deletion
> conflicts with the variables both set to false.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9f77e3a..615265d 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -126,7 +126,12 @@ resolve_deleted_merge () {
>  		case "$ans" in
>  		[mMcC]*)
>  			git add -- "$MERGED"
> -			cleanup_temp_files --save-backup
> +			if "$merge_keep_backup" = "true"

The command run as the "if" condition is probably "test", like in
the other hunk?

> +			then
> +				cleanup_temp_files --save-backup
> +			else
> +				cleanup_temp_files
> +			fi
>  			return 0
>  			;;
>  		[dD]*)
> @@ -135,6 +140,10 @@ resolve_deleted_merge () {
>  			return 0
>  			;;
>  		[aA]*)
> +			if test "$merge_keep_temporaries" = "false"
> +			then
> +				cleanup_temp_files
> +			fi
>  			return 1
>  			;;
>  		esac
