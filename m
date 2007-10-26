From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make rebase smarter
Date: Fri, 26 Oct 2007 14:02:26 -0700
Message-ID: <7vk5p9wpwd.fsf@gitster.siamese.dyndns.org>
References: <1193328386.4522.352.camel@cacharro.xalalinux.org>
	<1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, federico@novell.com
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 23:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWKL-00018d-Rw
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 23:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbXJZVCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 17:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbXJZVCd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 17:02:33 -0400
Received: from rune.pobox.com ([208.210.124.79]:52786 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698AbXJZVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 17:02:32 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4D7AE1509DA;
	Fri, 26 Oct 2007 17:02:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F22414E4D7;
	Fri, 26 Oct 2007 17:02:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62445>

Steven Walter <stevenrwalter@gmail.com> writes:

> It is a common workflow to run "git fetch; git rebase origin/<foo>" Where
> foo is the remote tracking branch.  git-rebase should default to using
> the remote tracking branch if no other ref is given.

This would be a reasonable choice between refusing outright and
picking one possible action.  I do not have a strong preference
as to what that "one possible action" should be, but if people
like to base on the remote tracking branch set to merge by
default, I am fine with it.

> +	curr_branch=$(git symbolic-ref -q HEAD)
> +	curr_branch=${curr_branch//refs\/heads\//}
> +	merge=$(git config branch.$curr_branch.merge)
> +	remote=$(git config branch.$curr_branch.remote)
> +	fetch=$(git config remote.$remote.fetch)
> +
> +	expanded=$(git fetch--tool expand-refs-wildcard "0000000000000000000000000000000000000000 $merge" "$remote" "$fetch")
> +	upstream_name=${expanded/#*:/}
> +fi
>  upstream=`git rev-parse --verify "${upstream_name}^0"` ||
>      die "invalid upstream $upstream_name"

 * How does this work if there is no such tracking configuration?

   - branch.<curr>.merge may be missing;
   - branch.<curr>.remote may be missing;
   - remote.<remote>.fetch may be explicit, multiple and/or non-wildcard;

 * ${parameter/pattern/string} is a bashism we do not allow in
   git scripts.

Problems in the implementation aside, it probably makes sense to
first have a helper function that takes a local branch name and
computes the remote tracking branch that a given local branch is
set to merge from, if exists, and use it here.  I suspect there
are other places in the Porcelain that would benefit from such a
helper function.
