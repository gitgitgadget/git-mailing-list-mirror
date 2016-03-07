From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] mergetool: honor tempfile configuration when resolving delete conflicts
Date: Sun, 06 Mar 2016 18:34:16 -0800
Message-ID: <xmqqbn6rrp7b.fsf@gitster.mtv.corp.google.com>
References: <1457218586-18654-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Joe Einertson <joe@kidblog.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 03:34:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acl04-0001zW-1t
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 03:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbcCGCeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 21:34:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751717AbcCGCeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 21:34:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 109484B2E2;
	Sun,  6 Mar 2016 21:34:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SPif+PeUzhlRgNPpUVfXr77Jhrk=; b=oEfnRS
	MEfgXR0+MN8VjJ4dAEA+YugOb6WYiqUExPx1bhKhgH7OM51bEEx9wq2db+g+610i
	4/cxU3UJBKWnDpfTxht/uOjJ2dQj8bv0MVh9kEnuz8e2CDrB8+fEyBE1otx5yu9S
	KiElTHdBlrHlcHN4o2Fc5zCKQAQOsyK8V79Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LDunRlWvTSm0e3DY4vKyCoXvc0PpclUH
	+yiQ0kyAp5OCXY6xWhzKYTdKpb4YLBVWxGdsrMpJp0g8v2aKt6jPR23yaQo1zTSt
	EgvLres251IgCDbtEJdFO8OvBBFWblDuPn7J0Di08gRWB0caALsDCKpIHeXEockh
	tZ5tTAUc7Ck=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 066B34B2E1;
	Sun,  6 Mar 2016 21:34:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DE874B2E0;
	Sun,  6 Mar 2016 21:34:17 -0500 (EST)
In-Reply-To: <1457218586-18654-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sat, 5 Mar 2016 14:56:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16F1E4EE-E40D-11E5-84BB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288379>

David Aguilar <davvid@gmail.com> writes:

> Teach resolve_deleted_merge() to honor the mergetool.keepBackup and
> mergetool.keepTemporaries configuration knobs.
>
> This ensures that the worktree is kept pristine when resolving deletion
> conflicts with the variables both set to false.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> v2 uses test.  2/2 is the same as before, and was not sent this round.

Thanks, will queue.

By the way, the fact that 2/2 did not make you realize that your
"if" statement was broken in the v1 1/2 patch indicates that the
codepath is not covered by the added test, doesn't it?  I was sort
of expecting an updated patch for 2/2 for this reason...

>  git-mergetool.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9f77e3a..4a9e9ca 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -126,7 +126,12 @@ resolve_deleted_merge () {
>  		case "$ans" in
>  		[mMcC]*)
>  			git add -- "$MERGED"
> -			cleanup_temp_files --save-backup
> +			if test "$merge_keep_backup" = "true"
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
