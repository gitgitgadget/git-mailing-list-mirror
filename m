From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A new merge algorithm, take 2
Date: Sat, 27 Aug 2005 22:23:23 -0700
Message-ID: <7vmzn2prck.fsf@assigned-by-dhcp.cox.net>
References: <20050827205135.GB16587@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 07:23:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Fdm-0002hf-Aj
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 07:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVH1FX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 01:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVH1FX1
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 01:23:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:6608 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750825AbVH1FX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 01:23:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828052323.XHMT15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 01:23:23 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050827205135.GB16587@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sat, 27 Aug 2005 22:51:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7862>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> The main changes compared to the previous version are:
>
> * Lots of clean up.
> * Some of the scripts have been renamed to better match the naming
>   convention used in Git.
> * A new option ('-s') has been added to git-merge-cache
> * Unclean merges are detected and reported
> * Clean merges are committed

I have not looked deeply into your Graph thing, so I'd comment
only on a couple of points in the external interfaces area.

I am not sure why you need to be touching merge-cache.  I
suspect that reading directly from "ls-files --stage -z" might
be easier and certainly less intrusive.  I do not have immediate
objections to "read-tree -i", though.  I think it is useful.

When there is a merge conflict, the current code leaves the
index in unmerged state and intermediate merge result with
conflict marker is left in the working tree.  It appears that
your code changes this and puts the blob with conflict markers
in the index file.  Leaving things in unmerged state has two
advantages:

 - you _could_ run git-diff-stages to see what the changes in
   both sides are.

 - you cannot accidentally make a commit from such an index file
   state; in fact you cannot even write it out as a tree.

I understand why you do it this way, and I do not find your way
_too_ problematic, but we do need to realize that this is making
things somewhat more prone to human errors.

I have to admit that I find that "even when merging the
merge-base candidates results in a file with conflict markers in
it, the parts with the conflict markers often gets changed in
the heads being merged, and the conflict markers will be gone
from the result" trick very cute and interesting.  By itself it
has certain amusement value, and if it works well in practice
that is great.

> +print 'Merging', h1, 'with', h2
> +h1 = runProgram(['git-rev-parse', '--revs-only', h1]).rstrip()
> +h2 = runProgram(['git-rev-parse', '--revs-only', h2]).rstrip()

Here, '--verify" would be the right flag to give to these.  Perhaps:

    h1 = runProgram(['git-rev-parse', '--verify', ('%s^0' % h1)]).rstrip()
