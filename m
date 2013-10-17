From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Thu, 17 Oct 2013 13:08:20 -0700
Message-ID: <xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<201310171909.r9HJ9mxd007908@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Thu Oct 17 22:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtrw-0002EN-HA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 22:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762433Ab3JQUIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 16:08:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758233Ab3JQUIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 16:08:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FDFB4B9FE;
	Thu, 17 Oct 2013 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KanmK8C/8wWrqs/ZeWy/ltNprIY=; b=bWlQXM
	8Ne83rvRGhTVkz0ipm412XqQXhyc9LzvDpZfwcsc6Xa+uBwCfGRs2JrZwgT9uSOp
	hjBgxFgDdY56WH0ZhIwhO/Yq+R44ph6IpJmXzigR0smUpxC3bEPUv9zrJx17LwHP
	ZAYbHsZnjk9ijmdXhJba4Wq4dWdInjmY1QwSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ME1sxnYMlAl6Dvzq4/n+zmsylvvPfLTY
	MxV5mifDSqJDWe8m6Vmf2EECmsAh0hrpVV6z/dtsAzmHR7dLu5bgsEQHfGN8r1EP
	evYlopPdHVWukI7FXg7hLg5mQJhoNzE6n4xKxmaxrF8H+fLH+pVUVwEORltXh0xN
	8l7diqX9AoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01BE54B9F9;
	Thu, 17 Oct 2013 20:08:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 737BA4B9F8;
	Thu, 17 Oct 2013 20:08:22 +0000 (UTC)
In-Reply-To: <201310171909.r9HJ9mxd007908@freeze.ariadne.com> (Dale
	R. Worley's message of "Thu, 17 Oct 2013 15:09:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFA90E94-3767-11E3-A4E4-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236315>

worley@alum.mit.edu (Dale R. Worley) writes:

> I must admit I've never seen the design (and I personally doubt that
> the design has ever been written down).  But at least the following
> commands work correctly on a detached worktree if the current
> directory contains the .git directory, because I am using them in a
> production manner:
>
>     git add

If you have this:

	/repositories/proj.git/{refs,objects,...}
	/working/trees/proj-wt1/

where proj-wt1 is a working tree for that proj.git repository, the
idea was to set these:

	GIT_DIR=/repositories/proj.git
        GIT_WORK_TREE=/working/trees/proj-wt1
        export GIT_DIR GIT_WORK_TREE

and then working in /working/trees/proj-wt1 or any of its
subdirectory should work as if you did not have these two
environment variables and had /working/trees/proj-wt1/.git instead
of /repositories/proj.git as the repository.  To make that use case
work was the motivation behind these environment variables.

	Side note: without GIT_WORK_TREE environment (or
	core.worktree), there is no way to tell where the top level
	is, so you were limited to always be at the top level of
	your working tree if you used GIT_DIR to refer to a
	repository that is not embedded in your working tree.  There
	were some changes in this area, but I do not recall the
	details offhand.

Now, when you say "the cwd contains the .git directory", do you mean

	cd /repositories
        git add ../working/trees/proj-wt1/file

updates "file" in the /repositories/proj.git/index?  Or do you mean
this?

	cd /repositories/proj.git
        git add ../../working/trees/proj-wt1/file

Or this?

	cd /repositories
	edit ../working/trees/proj-wt1/file
	git add file

Most of the commands you listed do not need to look at the actual
working tree files, so I would expect e.g. "git log" or "git log
paths..." to work but I am wondering what your definition of "works"
with respect to the pathspecs, especially when you talk about
starting Git command _outside_ the working tree (whether the working
tree has its repository embedded in it is not very relevant).
