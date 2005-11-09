From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Tue, 08 Nov 2005 22:28:01 -0800
Message-ID: <7vslu6mj2m.fsf@assigned-by-dhcp.cox.net>
References: <E1EZgAs-0008B4-QZ@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 07:28:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZjRH-0000Rw-FY
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 07:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVKIG2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 01:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbVKIG2D
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 01:28:03 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38891 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030422AbVKIG2C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 01:28:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109062741.OIFV16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 01:27:41 -0500
To: Jon Loeliger <jdl@freescale.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11387>

Jon Loeliger <jdl@freescale.com> writes:

> Hmmm. That didn't go too well. Concisely:
>
>     % git merge -s recursive "Grab dev stuff" master dev
>     Trying really trivial in-index merge...
>     fatal: Merge requires file-level merging
>     Nope.
>     Traceback (most recent call last):
>       File "/usr/bin/git-merge-recursive", line 8, in ?
> 	from gitMergeCommon import *
>     ImportError: No module named gitMergeCommon
>     Automatic merge failed/prevented; fix up by hand

Could you check diff between /usr/bin/git-merge-recursive and
git-merge-recursive.py in your source tree and see if the
appending to sys.path points at the right place (i.e. where the
make installs gitMergeCommon.py)?  Mine looks like this:

  --- git-merge-recursive.py      2005-11-08 02:27:08.000000000 +0000
  +++ /usr/bin/git-merge-recursive        2005-11-09 06:17:58.000000000 +0000
  @@ -1,10 +1,10 @@
  -#!/usr/bin/python
  +#!/usr/bin/python2.4

   import sys, math, random, os, re, signal, tempfile, stat, errno, traceback
   from heapq import heappush, heappop
   from sets import Set

  -sys.path.append('''@@GIT_PYTHON_PATH@@''')
  +sys.path.append('''/usr/share/git-core/python''')
   from gitMergeCommon import *

   originalIndexFile = os.environ.get('GIT_INDEX_FILE',

By default we set prefix to $HOME so ~/bin/git-merge-recursive
would import ~/share/git-core/python/gitMergeCommon.py.  Binary
packaging typically set prefix to /usr, so the executable is in
/usr/bin, and should import from /usr/share/git-core/python/,
which is as your make log shows:

> [ tail end of the make install output ]
>
> install -d -m755 '/usr/share/git-core/templates/'
> (cd blt && tar cf - .) | \
> (cd '/usr/share/git-core/templates/' && tar xf -)
> make[1]: Leaving directory `/usr/src/git-core/templates'
> install -d -m755 '/usr/share/git-core/python'
> install gitMergeCommon.py '/usr/share/git-core/python'
