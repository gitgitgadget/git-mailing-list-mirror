From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-update hook: update working copy
Date: Thu, 01 Nov 2007 18:02:15 -0700
Message-ID: <7vd4ut7948.fsf@gitster.siamese.dyndns.org>
References: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Nov 02 02:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inkw5-0007qL-Vm
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 02:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbXKBBC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 21:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbXKBBC0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 21:02:26 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:37298 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbXKBBC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 21:02:26 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C39A72EF;
	Thu,  1 Nov 2007 21:02:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 422D2913E9;
	Thu,  1 Nov 2007 21:02:44 -0400 (EDT)
In-Reply-To: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz>
	(Sam Vilain's message of "Fri, 2 Nov 2007 13:45:04 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63046>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Now that git-stash is available, it is not so unsafe to push to a
> non-bare repository, but care needs to be taken to preserve any dirty
> working copy or index state.  This hook script does that, using
> git-stash.

Honestly, I am reluctant to do things that _encourages_ pushing
into a live tree.

 - Who guarantees that the reflog is enabled for the HEAD?

 - Who guarantees that a human user is not actively editing the
   work tree files without saving?  You would not see "dirty
   state", the editor would notice "the file was modified since
   you started editing it" and tell so to the user, but the user
   cannot recover from the situation without knowing to do the
   three-way merge between HEAD@{1}, HEAD and the index _anyway_.

> +update_wc() {
> +	ref=$1
> +	echo "Push to checked out branch $ref" >&2
> +	if (cd $GIT_WORK_TREE; git-diff-files -q --exit-code >/dev/null)
> +	then
> +		wc_dirty=0
> +	else
> +		echo "W:unstaged changes found in working copy" >&2
> +		wc_dirty=1
> +		desc="working copy"
> +	fi
> +	if git diff-index HEAD@{1} >/dev/null

Are you missing "--cached" here?

> +	if [ "$wc_dirty" -ne 0 -o "$index_dirty" -ne 0 ]
> +	then
> +		new=$(git rev-parse HEAD)
> +		git-update-ref --no-deref HEAD HEAD@{1}
> +		echo "W:stashing dirty $desc - see git-stash(1)" >&2
> +		(cd $GIT_WORK_TREE
> +		git stash save "dirty $desc before update to $new")
> +		git-symbolic-ref HEAD "$ref"

This part feels somewhat dangerous.  What happens if we are
interrupted in the middle of these commands?

> +	fi
> +
> +	# eye candy - show the WC updates :)
> +	echo "Updating working copy" >&2
> +	(cd $GIT_WORK_TREE
> +	git-diff-index -R --name-status HEAD >&2
> +	git-reset --hard HEAD)
> +}

And I would have expected you would unstash the dirty state here.
Are there any reason not to?
