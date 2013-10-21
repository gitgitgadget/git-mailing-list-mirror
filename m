From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Mon, 21 Oct 2013 14:51:24 -0400
Message-ID: <201310211851.r9LIpOaH000372@freeze.ariadne.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<201310171909.r9HJ9mxd007908@freeze.ariadne.com>
	<xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
	<201310182225.r9IMP4i3002659@freeze.ariadne.com> <xmqqy55qurmf.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 21 20:51:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYKZe-000769-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 20:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab3JUSv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 14:51:27 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:41088
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624Ab3JUSv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Oct 2013 14:51:26 -0400
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id fo9X1m0050QuhwU5AurRkk; Mon, 21 Oct 2013 18:51:25 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id furR1m0011KKtkw3NurRt0; Mon, 21 Oct 2013 18:51:25 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9LIpOr9000373;
	Mon, 21 Oct 2013 14:51:24 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9LIpOaH000372;
	Mon, 21 Oct 2013 14:51:24 -0400
In-reply-to: <xmqqy55qurmf.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1382381485;
	bh=5MHcgii/zJWuYDKitmDY9d6JRHztea2wbKYpPEwJ7rU=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=RuhwJTy/GQHzKXqQ5DyupNrdU2xHxXX+1Mp5rBGpx7g1tQb/MddvFRGg8XaT31b+W
	 hcmfDVbi4+AH6CkKo0z64MVEOszJSokR5oGaf7e3ZcpYpFjSuQ66n/5wOaJ7QDzazy
	 fiMKq1ysJZU1BbbLWibDdbmMA/SXqQHRo51OWgeiW6eF6JO0fEgG5aVjxsBSiZJSHH
	 c9POTKIvWYE3N5p/5VGpDxxmf5vHGpP3pagN0Jm6htvCV7Wpy/AfzO52+y4B6wHG8L
	 sNKFMHicwdl6z0DF+TSV70JA6VP3q3YnKVK9WGEMbfe6qC0BeTzBIVZejYhCrp++Ik
	 gSr50vh65uvkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236443>

> From: Junio C Hamano <gitster@pobox.com>

> > ... it's not clear why GIT_WORK_TREE exists, ...
> 
> The configuration item came _way_ later than the environment, and we
> need to keep users and scripts from old world working, that is why.

OK, that explains a great deal.  IIRC, I first became aware that
detached worktrees are possible through the documentation of
core.worktree.  As Git's architecture has a tight binding between the
repository and the worktree, it made a great deal of sense to me that
the repository points to the detached worktree.  And the absence of
core.worktree, a non-detached worktree, is essentially equivalent to
having core.worktree specify the directory containing the .git
directory.

So the obvious way (to me) to invoke Git with a detached worktree is
to set GIT_DIR to point to the repository, and the repository points
to the root of the worktree.  If the command operates on the worktree,
Git can compare the cwd with the worktree root to determine the
relative path of files.

(And you can see that in this situation, Git doesn't have to search
upward to try to determine where the worktree root is.)

What you're saying is that there's an older mode of operation where
the repository does not point to the worktree.  Instead, the caller
has to set GIT_DIR to locate the repository and GIT_WORK_TREE to
locate the worktree.  This would be prone to error, because the user
is responsible for always pairing the repository with the correct
worktree; it doesn't enforce the architectural assumption that the
repository is paired with a work tree.

Dale
