From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/3] v5 index branch breakage on cygwin
Date: Tue, 04 Sep 2012 19:44:35 +0100
Message-ID: <50464C13.6060307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: t.gummerer@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yTB-0001jC-0G
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab2IDTHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:22 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40950 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932617Ab2IDTHT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:19 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 31D5F128076;
	Tue,  4 Sep 2012 20:07:18 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 32EAE128075;	Tue,  4 Sep 2012 20:07:17 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:16 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204773>


Hi Thomas,

The current pu branch is *very* broken on cygwin; practically every
test fails. A git-bisect session points to:

    $ git bisect good
    a4f6670277d5dc0b082139efe162100c6d7a91b8 is the first bad commit
    commit a4f6670277d5dc0b082139efe162100c6d7a91b8
    Author: Thomas Gummerer <t.gummerer@gmail.com>
    Date:   Thu Aug 16 11:58:38 2012 +0200

        read-cache.c: Re-read index if index file changed

        Add the possibility of re-reading the index file, if it changed
        while reading.

        The index file might change during the read, causing outdated
        information to be displayed. We check if the index file changed
        by using its stat data as heuristic.

        Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

    :100644 100644 6a8b4b1e6859b7a8df2624e80b9da47df6cd1648 cdd8480cc7c3ab373dab1ca9
    4d77a3154f7d0fbd M      read-cache.c
    $

Since this appears to be a cygwin specific problem, I wasn't too surprised
to see that the code added in this commit involves the stat functions. (Yes,
this is another example of problems caused by the "schizophrenic stat()
functions").

A little debugging shows that the index_changed() function was always returning
true, so that the loop was executed 50 times and git then die()s.

We note that fstat() is a "cygwin native" function, whereas lstat() is executing
the "WIN32 optimised" function. The problematic 'struct stat' fields are st_uid,
st_gid and st_ino, which fstat() fills with "appropriate" values (st_uid=1005,
st_gid=513, st_ino=<non-zero value>), whereas the the WIN32 version of lstat()
always returns zero in these fields.

I have no wish to spread the insanity, but nonetheless I implemented a "WIN32
optimised" version of fstat(). This was a great improvement, but there were
still a few failing tests. git-stash, in particular, seemed to be problematic.
A git-bisect session pointed at exactly the same commit as above! *ahem*

A spot of debugging shows that index_changed() was always returning true ...
Here, the new fstat() function was returning zero in those fields, whereas the
lstat() function was returning "appropriate values" ...

The difference here is caused by git-stash calling git with an GIT_INDEX_FILE
set to an _absolute_ path, such as:

    /home/ramsay/git/t/trash directory.t3903-stash/.git/index.stash.2440

This has the effect of disabling the "optimisation" and calling the "cygwin
native" lstat() function. *ho hum*

So, the only sensible fix is to not include those fields in the index_changed
predicate on cygwin; which is what the first patch does. The testsuite now
runs just fine (well as fine as before, anyway!).

The other two patches don't affect the correctness of the code, so please
feel free to ignore them if you like.

ATB,
Ramsay Jones


Ramsay Allan Jones (3):
  read-cache.c: Fix index reading breakage on cygwin
  read-cache.c: Pass 'struct stat' parameters by reference
  read-cache.c: Simplify do loop conditional expression

 read-cache.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
1.7.12
