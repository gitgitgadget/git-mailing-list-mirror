From: Junio C Hamano <gitster@pobox.com>
Subject: Re: nested git repos (not submodules)
Date: Thu, 09 Feb 2012 20:16:25 -0800
Message-ID: <7vd39ns4py.fsf@alter.siamese.dyndns.org>
References: <jh1vo3$7af$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 05:16:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvhuS-0006gv-Rk
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 05:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265Ab2BJEQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 23:16:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758253Ab2BJEQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 23:16:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0677975CD;
	Thu,  9 Feb 2012 23:16:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pO3QXrVggKNvUSecvjE101bx/yM=; b=w/MoM7
	uD0bcl3h2hQ/n9BlMYcZDH5g3AK1PKg+NQcapwy8PuFwMisFodI1hh23qDNU/XHx
	vleU8GsX3yNgeZi8krn2RE9SLj1ctqw9mIYn5hDWb99EivuAE84vTsoSGsAeRVnT
	TNmw0hP/QG9iV6m6bR0ROHACykL/Ud+OjfluE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZUy9J5NQXbcbDmKfepHc9dO8ELbbzzSr
	glf1WxxqQ2ncBTSEpaUplou2ljTt8I3XnxobwIZhhsv9dslX9lOgJHTLuz9uMYSQ
	3NqTKj0pzElW8k6BKJDv/cbGOVKkHxQx5TM0tqK5zBahn4SkwbSKa519EBT5xe1v
	t7KxM+hdWmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F07C875CC;
	Thu,  9 Feb 2012 23:16:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80C4B75CB; Thu,  9 Feb 2012
 23:16:26 -0500 (EST)
In-Reply-To: <jh1vo3$7af$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Thu, 9 Feb 2012 20:34:42 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFDBA3FC-539D-11E1-91FB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190378>

"Neal Kreitzinger" <neal@rsss.com> writes:

> In the worktree of a particular git repo, the user has made a subdir 
> (worktree/subdir) of the worktree (worktree/.git) its own repo 
> (worktree/subdir/.git).  Is there a danger of worktree/.git and 
> worktree/subdir/.git crossing wires?  

The repository controlled by worktree/.git should behave as if subdir/
does not exist, except that obviously the project cannot have a regular
file "subdir" in it.  When you chdir to worktree/subdir, everything in
there should behave as if worktree/.git directory does not exist.

At least that is the design, and it indeed is how I arrange my primary
working tree (I have two "clones" at /git/git.git/ and /git/git.git/Meta,
and the latter has a checkout of the "todo" branch), so I would make
noises about any breakage for such a layout.

I do not know offhand if an attempt to add files inside subdir to the
repository controlled by worktree/.git is always correctly prohibited by
the code, though, as our code often forgets to error out "stupid user
mistakes", and running "git add subdir/bar" when in worktree/ falls into
that category.

And the use of that layout predates the submodules by a large margin.
In fact, when people suggest use of submodules when the toplevel and the
sublevel do not even need tight version dependencies, some of their use
cases might be better supported by using the simply-nested layout without
even letting the toplevel be aware of the sublevel.
