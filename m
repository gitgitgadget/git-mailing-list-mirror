From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: clean up temp files when aborted
Date: Thu, 24 Jan 2013 11:54:43 -0800
Message-ID: <7vbocebblo.fsf@alter.siamese.dyndns.org>
References: <1359051829-21331-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	"Theodore Ts'o" <tytso@mit.edu>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyStJ-0006eY-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab3AXTyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:54:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572Ab3AXTyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:54:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7495DB059;
	Thu, 24 Jan 2013 14:54:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tbQLkz/gBTLrHY+A+JqZZ2/anVg=; b=qKR39p
	ZZOKHm8S08EnVV708DSmnxWTNPSFNWQg3V10suV3ctzRl8cWEP5QQNxQ8o9V72Nh
	5yeTphBGoWYhormRO+qWrVTPj5D0qdTNGj+v6/vu0c0GOuqCSG9WdII912Of7NiZ
	k+Tau+6by8Q6YkZTVUl35jgCXwIQbj3lTWxps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wa4mQM/fpQFuzrOE0TYsbUYwK8qzpDTJ
	kUUaadgqDLL2PNhHBGhaWRLT9Bks/tuih4I64ejUceBnchuldu4YkJp6AW3R7hMY
	bUvm0ZR7EbNsStyXZ4tywQfcFSm/PNYxy4EpEvmxrJ3muH3dMJeHiXTsIEVJvyqX
	U8abv3wvW4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C73B058;
	Thu, 24 Jan 2013 14:54:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACD6FB056; Thu, 24 Jan 2013
 14:54:44 -0500 (EST)
In-Reply-To: <1359051829-21331-1-git-send-email-hordp@cisco.com> (Phil Hord's
 message of "Thu, 24 Jan 2013 13:23:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E65A95A2-665F-11E2-9A68-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214444>

Phil Hord <hordp@cisco.com> writes:

> When handling a symlink conflict or a deleted-file conflict, mergetool
> stops to ask the user what to do. If the user chooses any option besides
> "(a)bort", then the temporary files which mergetool created in
> preparation for handling the conflict are removed.  But these temporary
> files are not removed when the user chooses to abort the operation.
>
>     $ git cherry-pick other/branch
>     error: could not apply 4e43581... Fix foo.c
>
>     $ git status --short
>     DU foo.c
>
>     $ git mergetool
>     Merging:
>     foo.c
>
>     Deleted merge conflict for 'foo.c':
>       {local}: deleted
>       {remote}: modified file
>     Use (m)odified or (d)eleted file, or (a)bort? a
>     Continue merging other unresolved paths (y/n) ? n
>
>     $ git status --short
>     DU foo.c
>     ?? foo.c.BACKUP.16929.c
>     ?? foo.c.BASE.16929.c
>     ?? foo.c.LOCAL.16929.c
>     ?? foo.c.REMOTE.16929.c
>
> These temporary files should not remain after the mergetool operation is
> completed.

Aren't there cases where people "abort" so that they can have a
chance inspect them outside mergetool program?  If there are no such
cases, then I would agree with your claim "should not remain", but
the proposed log message does not explay why it is sure that there
are no such use cases.

>
> Remove the temporary files by calling the cleanup_temp_files when the
> user chooses to abort the mergetool operation.
>
> It looks like 'cleanup_temp_files' without the --save-backups option is
> the correct thing to do, and this is how this commit is implemented. But
> some other paths do use --save-backups resulting in a foo.c.orig file
> being left behind.  That seems to be a different bug, though.
>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---
>  git-mergetool.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index c50e18a..bb93b70 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -90,6 +90,7 @@ resolve_symlink_merge () {
>  			return 0
>  			;;
>  		[aA]*)
> +			cleanup_temp_files
>  			return 1
>  			;;
>  		esac
> @@ -118,6 +119,7 @@ resolve_deleted_merge () {
>  			return 0
>  			;;
>  		[aA]*)
> +			cleanup_temp_files
>  			return 1
>  			;;
>  		esac
