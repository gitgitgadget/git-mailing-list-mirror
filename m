From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 15:14:24 -0800
Message-ID: <7vsltf6o8f.fsf@assigned-by-dhcp.cox.net>
References: <20051129214055.8689.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 00:14:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhEgA-0004dG-Uh
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 00:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVK2XO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 18:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVK2XO1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 18:14:27 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14729 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964806AbVK2XO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 18:14:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129231253.QTOI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 18:12:53 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12969>

linux@horizon.com writes:

> This seems odd to me.  There's an alternate implementation that
> I described that makes a lot more sense to me, based on my current
> state of knowledge.  Can someone explain why my idea is silly?

It is not silly.  Actually we have "been there, done that".

We used to leave the higher stages around in the index after
automerge failure.  Note that you would not just have stage2 in
such a case.  stage1 keeps the common ancestor, stage2 has what
you started with, and stage3 holds the version from other
branch.  diff-stages can be used to diff between these stages.
We _could_ have added feature to either diff-stages or
diff-files to compare between stageN and working tree.

However, this turned out to be not so convenient as we wished
initially.  What you would do after inspecting diffs between
stage1 and stage3, between stage2 and stage3 and between stage1
and stage2 typically ends up doing what "merge" have tried (and
failed) manually anyway, and being able to find the conflict
markers by simply running "git diff" was just as good, except
that we risk getting still-unresolved files checked in if the
user is not careful.

If you want to be clever about an automated merge, you could
write a new merge strategy to take the three trees and produce a
better automerge result.  That is what Fredrik has done in his
git-merge-recursive (now default).  Or you could "improve"
git-merge-one-file to take three blob object names and leave
file~1 file~2 file~3 in the working tree, instead of (or in
addition to) leaving a "merge" result with conflict markers, to
give the user ready access to the version from each stage.
