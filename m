From: Junio C Hamano <junkio@cox.net>
Subject: Should "git-read-tree -m -u" delete files?
Date: Fri, 24 Jun 2005 15:08:44 -0700
Message-ID: <7v1x6rbe6r.fsf_-_@assigned-by-dhcp.cox.net>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<pan.2005.06.24.13.16.10.406827@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 00:14:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlwPO-0008QL-0J
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 00:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbVFXWRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbVFXWOm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 18:14:42 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20674 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263215AbVFXWIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 18:08:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050624220845.WXUQ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Jun 2005 18:08:45 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.06.24.13.16.10.406827@smurf.noris.de> (Matthias
 Urlichs's message of "Fri, 24 Jun 2005 15:16:13 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MU" == Matthias Urlichs <smurf@smurf.noris.de> writes:

MU> The only problem I have with it is that "git-read-tree -m -u"
MU> doesn't delete files yet. To repeat my question from last week:
>>> Would it be safe to add all files for which
>>> read_tree.c:merge_cache:fn() returns zero to a "delete me" list?
MU> (files on which which then actually get deleted, of course, if g-r-t
MU> doesn't find any problems.)

As the guilty party for the "read-tree two-way semantics table"
you quoted in your "question from last week" message, I should
have replied sooner but could not.  Sorry about that [*1*].

Anyway, here are my answers.

 (1) No, merge_function[] returning zero just means "I did not
     cause anything to change the number of already processed
     entries".  When it wants to delete an entry, it explicitly
     marks the entry to be deleted by calling deleted_entry(),
     and the deletion is processed at the very end by
     check_updates() function.  Note that we do _not_ return
     zero in this case.

 (2) The part you quoted in your "last week" message is case 10;
     the current code does delete the path with -u [*2*].

 (3) There could be cases where twoway_merge() does not delete a
     clean path that _should_ be removed.  If that is the case
     then you have spotted a bug --- I would appreciate it if
     you can show a reproduction recipe.  I have looked at the
     function briefly again while writing this reply and did not
     find suspicious code that would just return 0 without
     calling deleted_entry(), though.

 (4) Using --emu23 (followed by git-merge-cache, of course),
     instead of doing "git-read-tree -m -u H M", should remove
     deleted paths as well.


[Footnote]

*1* I was on a crazy travel schedule, going just for 3 days last
week and then for another 2 days this week to Japan from US west
coast, two 10-hour roundtrip flights X-<.  Now I am back and
hopefully fully functional ;-).

*2* The part you quoted in your previous message was this.  I am
re-quoting from the original to give it a bit more context:

    Two Tree Merge
    ~~~~~~~~~~~~~~
    ...
    In this case, the "git-read-tree -m $H $M" command makes sure
    that no local change is lost as the result of this "merge".
    Here are the "carry forward" rules:

            I (index)           H        M        Result
           -------------------------------------------------------
         ...
            clean I==H  I==M
           ------------------
         ...
         10 yes   yes   N/A     exists   nothing  remove path from cache

This case is covered by this test in t1002:

    test_expect_success \
        '10 - path removed.' \
        'rm -f .git/index &&
         echo rezrov >rezrov &&
         git-update-cache --add rezrov &&
         git-read-tree -m -u $treeH $treeM &&
         git-ls-files --stage >10.out &&
         cmp M.out 10.out &&
         sha1sum -c M.sha1'

Where paths involved are:

	path		treeH		treeM
       -----------------------------------------------------
        bozbar		exists		modified from treeH
        frotz		does not exist	added in treeM
        nitfol		exists		same as in treeH
        rezrov		exists		deleted in treeM

and after this test runs, you can see that the path "rezrov"
gets removed from your work tree.  Insert "exit" just before the
next test, run "cd t && sh t1002-*.sh -i -v", and inspect what
is in the "t/trash" directory.


