From: Junio C Hamano <junkio@cox.net>
Subject: Re: On blame/pickaxe
Date: Tue, 17 Oct 2006 02:03:45 -0700
Message-ID: <7vwt6zjoum.fsf@assigned-by-dhcp.cox.net>
References: <20061016234547.21649.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 11:03:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZkrW-0002o7-Cf
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423174AbWJQJDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbWJQJDr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:03:47 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:47847 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1423174AbWJQJDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 05:03:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017090345.WFQW12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 05:03:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bM3Y1V00D1kojtg0000000
	Tue, 17 Oct 2006 05:03:33 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061016234547.21649.qmail@web31809.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 16 Oct 2006 16:45:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29038>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> 3. Passing the blame.
>> 
>> You (a <commit,path> tuple) are suspected for introducing
>> certain lines, and you would want to pass blame to your parent.
>> How would you do that?
>> 
>> First, you find if your parent has the same path; if not, you
>> find if between your parent and you there was a rename and find
>> the original path in the parent.  If you are a merge, you do so
>> for all your parents.  The path in the parent and your path may
>> have many common lines, and if the lines you are the suspect are
>> the same as the ones in the parent, you can pass the blame,
>> because these lines were there before you touched them.
>
> Do you handle the case where a merge had a conflict and
> the user changed the code (resolved) and then committed?
> In this case some lines will have to be blamed on the
> merge commit itself.

Working on a small example by hand is a good way to convince
yourself.  The whole point of "try to pass the blame, and take
the blame yourself only when you can't pass to anybody" is
precisely to handle the merges sanely.  The answer to your later
question also would become crystal clear with that exercise.

Suppose that we are looking at a merge that would give this in
its "git show" output:

diff --cc hello.c
index 3c27792,db3fdef..cec80d2
--- a/hello.c
+++ b/hello.c
@@@ -1,4 -1,6 +1,6 @@@
  int main(int ac, char **av)
  {
-       printf("hello, world.\n");
 -      const char *msg = "hello, world";
++      const char *msg = "hello, world.";
+ 
+       printf("%s\n", msg);
  }

First, we inspect the diff from the first parent:

        diff --git a/hello.c b/hello.c
        index 3c27792..cec80d2 100644
        --- a/hello.c
        +++ b/hello.c
        @@ -1,4 +1,6 @@
1        int main(int ac, char **av)
2        {
        -       printf("hello, world.\n");
3       +       const char *msg = "hello, world.";
4       +
5       +       printf("%s\n", msg);
6        }

That would find that lines 1, 2 and 6 came from the first parent
(line numbers are of the postimage; e.g. line 6 is the closing
brace).

We are still left with lines 3, 4, and 5.  So we will see the
difference from the second parent:

        diff --git a/hello.c b/hello.c
        index db3fdef..cec80d2 100644
        --- a/hello.c
        +++ b/hello.c
        @@ -1,6 +1,6 @@
1        int main(int ac, char **av)
2        {
        -       const char *msg = "hello, world";
3       +       const char *msg = "hello, world.";
4
5               printf("%s\n", msg);
6        }

It shows that lines 1, 2, 4, 5 and 6 are the same as the second
parent (again, line numbers are of the postimage).  This means
that we _could_ attribute line 1, 2 and 6 to the second parent
if we wanted to, but we have already passed blame for 1, 2 and 6
to the first parent [*1*] and only lines 4 and 5 are assigned to
the second parent.

At this point, we have no more parents to pass blame on and are
still left with line 3.  So we end up taking the blame for that
line ourselves.  The final blame output reflects that.

If you are interested, prepare an example repository using the
attached script, and try annotating E, like this:

	git pickaxe --not right~2 left -- E

This demonstrates the example in this message (first parent is
Right and the second is Left).

Annotating C with blame and pickaxe (use "-n -f" for clarity)
shows the limitation of the original 'blame' that can use only
one path per commit.  This is a corner case where two files
originally different in the common ancestor were later merged
into one.  pickaxe handles this case without -M.

	git blame -n -f C
        git pickaxe -n -f C

Annotating D with pickaxe with and without -M illustrates how
line movement is handled.

	git pickaxe -M D

Have fun.


[*1*] The really core part of git does not have any preference
among parents, but typically a merge commit is made with the
current branch head as its first parent and the other branch as
its second parent, so favoring the earlier parent over the later
ones makes a lot of sense in practice.  This is in line with
other parts of git, including the merge simplification done by
git-log.

-- 8< --
#!/bin/sh

test -d .git || {
	echo Run me in an empty directory.
	exit
}
git init-db

for i in 1 2 3 4 5 6 7 8 9 ; do echo line from initial $i ; done >A
for i in A B C D E F G H I ; do echo line from initial $i ; done >B
cp A D
cat >E <<EOF
int main(int ac, char **av)
{
	printf("hello, world\n");
}
EOF

git add A B D E
git commit --author='Initial <initial@author>' -m initial

git branch right
git branch left

# Left
git checkout left
for i in 1 2 3; do echo added by left; done >C
cat A >>C
rm -f A B
cat >E <<EOF
int main(int ac, char **av)
{
	const char *msg = "hello, world";

	printf("%s\n", msg);
}
EOF
git update-index --add --remove A B C E
git commit --author='Left <left@branch>' -m Left

# Right
git checkout right
cat B >C
for i in 1 2 3; do echo added by right; done >>C
rm -f A B
cat >E <<EOF
int main(int ac, char **av)
{
	printf("hello, world.\n");
}
EOF
git update-index --add --remove A B C E
git commit --author='Right <right@branch>' -m Right

echo "Merge -- this should fail which is expected and scripts fixes it up"
echo "Do not get alarmed with the error message."
git pull . left
echo "Fixing up..."
{
	git cat-file blob :3:C
	echo line by evil merge
	git cat-file blob :2:C
} >C
cat >E <<EOF
int main(int ac, char **av)
{
	const char *msg = "hello, world.";

	printf("%s\n", msg);
}
EOF
git update-index C E
git commit --author='Merge <merge@branch>' -m 'Changes are merged.'
rm -f C~*

{
	for i in 5 6 7; do echo line from initial $i ; done
	echo line modified while swapping 8
	for i in 9 1 2 3 4 ; do echo line from initial $i ; done
} >D

git update-index D
git commit --author='Swap <swap@branch>' -m 'Lines are swapped.'

echo "Now try annotating C, D and E with various options."
