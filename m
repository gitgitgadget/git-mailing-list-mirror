From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/7] Rework diff options
Date: Mon, 26 Jun 2006 11:24:17 -0700
Message-ID: <7v64inixm6.fsf@assigned-by-dhcp.cox.net>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<7vslltopzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 20:25:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuvlY-0006gW-AU
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 20:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWFZSYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWFZSYj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 14:24:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60635 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932616AbWFZSYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 14:24:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626182438.TEDL8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 14:24:38 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22678>

Junio C Hamano <junkio@cox.net> writes:

> Here are a few problems I have seen:
>
>  - "git show --stat HEAD" gives '---' marker as Johannes and you
>    have already discussed (I do not mind this that much though);
>
>  - "--cc" seems to be quite broken.  "git show v1.0.0" nor "git
>    diff-tree --pretty --cc v1.0.0" does not give the log
>    message, and gives something quite confused instead.  I think
>    it is showing "-m -p" followed by "--cc".
>
> We may find more minor breakages, in addition to these, but I am
> reasonably sure we should be able to fix them in-tree.

Further impressions, while with a clean index and working tree.

First the good ones (improvements).

 - "git diff-index --patch-with-raw HEAD" gives empty result;
   the traditional one shows one empty line.

 - "git diff-tree -p --stat" and "git diff-tree --stat -p"
   works, as you planned.

 - "git diff-tree --root --patch-with-raw --summary" works; the
   traditional one misses --summary.

 - "git show --name-only HEAD" works; the traditional one always
   does --cc -p; the same for "git show -s HEAD".

Regressions, most of the minor.

 - "git diff-index -p --stat HEAD" gives one empty line; the
   traditional one gives empty.

 - "git diff-tree --patch-with-raw HEAD" for a non-merge commit
   misses the empty line between raw and patch.

 - "git diff-tree --cc HEAD" for an evil merge (a merge whose
   result does not match either parents, e.g. v1.0.0) shows extra
   two-tree diffs (presumably HEAD^1..HEAD and HEAD^2..HEAD)
   before showing what is expected.  The same for "git show". 

 - "git show --name-only HEAD" for an evil merge similarly shows
   extra two-tree diffs in --name-only format before showing
   what is expected.  Presumably the same bug as the above.

 - "git diff-tree -c HEAD" for an evil merge shows extra newline
   after the output.

 - Neither "git diff-tree -m -s HEAD" for a merge, "git diff-tree -s
   HEAD" for a non-merge does not squelch the output; same for
   "git whatchanged".

 - "git log --raw HEAD" descends into subdirectories.  It
   instead should show the top-level tree differences.

 - "git diff-tree --pretty --patch-with-stat HEAD" for a
   non-merge misses "---\n" before stat (I think you are aware
   of this).

 - "git show --cc HEAD" for a merge should do "---\n", followed
   by a stat for diff between HEAD^1..HEAD, followed by dense
   combined-diff for HEAD.
