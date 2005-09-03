From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sat, 03 Sep 2005 01:25:50 -0700
Message-ID: <7vek867e29.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 10:26:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBTLY-0006Lb-9v
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 10:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbVICIZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 04:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbVICIZx
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 04:25:53 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29606 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161186AbVICIZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 04:25:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903082552.RPFT18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 04:25:52 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <7vek87djat.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Sep 2005 18:36:10 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8039>

Junio C Hamano <junkio@cox.net> writes:

> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>> I currently have two klibc trees,
>
> I cloned them to take a look.  You_do_ seem to have a lot of
> renames.

Well, I think I understand how your trees ancestry looks like,
but still haven't come up with a good problem definition.  I am
sorry that this message is not a solution for your problem but
would end up to be just my rambling and thinking aloud.

The ancestry looks like this:

       ----#4-#5---#7   #0: 1.0.14 released, next version is 1.0.15
      /      /              5691e96ebfccd21a1f75d3518dd55a96b311d1aa
     /---#1-#3---#6     #1: Explain why execvpe/execlpe work the way they do.
    //     /                1d774a8cbd8e8b90759491591987cb509122bd78
  #0-----#2             #2: 1.1 released, next version is 1.1.1
                            3a41b60f6730077db3f04cf2874c96a0e53da453
                        #3: Merge of #2 into #1
                            7ab38d71de2964129cf1d5bc4e071d103e807a0d
                        #4: socketcalls aren't always *.S files; they can...
                            f52be163e684fc3840e557ecf242270926136b67
                        #5: Merge of #3 into #4
                            2e2a79d62a96b6b0d4bc93697fe77cd3030cdfd9
                        #6: Warnings cleanup
                            f5260f8737517f19a03ee906cd64dfc9930221cd
                        #7: Remove obsoleted files from merge
                            59709a172ee58c9d529a8c4b6f5cf53460629cb3

and you are trying to merge #6 into #7 (or #7 into #6).  #6 does
not have usr/kinit and nfsmount at the top; #7 has nfsmount
under usr/kinit/.

The merge base of #6 and #7 is #3.  #3->#7 involves many renames
like nfsmount/sunrpc.h -> usr/kinit/nfsmount/sunrpc.h, while
#3->#6 involves no renames.  This can be seen by 

       $ git-diff-tree -M --diff-filter=R -r '#3' '#7' | wc -l

These renames are introduced by #5 merge, whose immediate
ancestors are #3 and #4.

Now, there is a question.  When you merge #6 and #7, development
between #3 and #7 have a lot of renames, while #3 and #6 do not.
What should this merge do?  Should it follow the rename, and if
so why?

Maybe I am trying to solve a wrong problem.  First I thought
there should be an automated way for merge to tell whether
renames done in one branch should be ignored, but that may be
better left under human control.  By looking at #6, #7 and #3
alone, even with looking at #5 which introduced the renames, I
do not see a good reason for the merge machinery to dictate that
these renames are to be followed or ignored when merging #6 and
#7.

So this is not what we ordinary call a 'merge', but what really
is happening is something else .  Let's say the tree you would
want to end up with is 'similar' to #6 but contains the changes
done on the branch leading to #7, except #7 has renames unwanted
for moving #6 forward.  Is that what we should be solving?

Then, I think we could do something along these lines, perhaps?

 - Ask git-diff-tree about changes betwen #3 (merge-base) and
   #7.

        git-diff-tree -M --diff-filter=R -r '#3' '#7' |
        sed -e 's/^[^	]*	//' >.rename-tmp

   This will give us list of <old-name> <new-name>, one pair on
   each line, separated with tabs.

 - check out '#7', and move files around reversing the rename we
   found in the previous step.  Make a throw-away tree out of it;
   we do not even have to have a commit.

        git checkout -b junk7 '#7'
        while read name3 name7
        do
	    test -f $name7 || { echo $name7; continue; }
	    git rename $name7 $name3
        done <.rename-tmp
	tree7_sans_rename=$(git-write-tree)
	git reset --hard junk7

 - check out '#6', and run three-way merge like this.

	git checkout -b junk6 '#6'
        git-read-tree -m -u '#3' '#6' $tree7_sans_rename

 - Notice I did not run merge-cache above.  I suspect that #6
   and #7 just have overlaps but there may be a lot of things
   missing from #7 that you would rather keep (I am not familiar
   with the relationship between these two projects, so I am
   just guessing).  First let's see what is in the tree:

    $ git-ls-files --unmerged
    100644 450e5c7f5c4f4c90df8f60fc98b96cb7db25a502 1       MCONFIG
    100644 450e5c7f5c4f4c90df8f60fc98b96cb7db25a502 2       MCONFIG
    100644 41fdd07af8c4e3eebbafcc3ced8b361882fe4c0d 1       MRULES
    100644 41fdd07af8c4e3eebbafcc3ced8b361882fe4c0d 2       MRULES
    100644 521bf99c2ab1f647156bf16a7f977e951fb9cdb0 1       ash/Makefile
    100644 521bf99c2ab1f647156bf16a7f977e951fb9cdb0 2       ash/Makefile
    100644 66ba9bb16f8289dc8c1af7d1cd49e5f563b5f624 1       gzip/MCONFIG
    100644 66ba9bb16f8289dc8c1af7d1cd49e5f563b5f624 2       gzip/MCONFIG
    100644 d5f9f94be0795accd8b02e2743ab899ac7ca661e 1       gzip/Makefile
    100644 d5f9f94be0795accd8b02e2743ab899ac7ca661e 2       gzip/Makefile
    100644 472f09205986fd9c2f9c7da6e31b45cebb9fe0af 1       ipconfig/MCONFIG
    ...

   Stage 1 is from #3, 2 is from #6, and these files does not
   exist in the faked sans-rename version of #7.  I presume that
   you would want to keep them in #6, so we keep them without
   letting git-merge-cache to remove them by:

	git-ls-files --unmerged | cut -f2 | uniq |
        xargs git-update-cache --

   This still may be slurping a lot of files that only exist in
   #7 but not in #6 in your cache (for example, I suspect you do
   not want to slurp usr/kinit/ into #6 with this 'merge').  You
   may need to remove them, using 'rm -f <file> &&
   git-update-cache --remove <file>'.

 - Then we merge-cache as usual.

	git-merge-cache -o git-merge-one-file-script -a
                      
