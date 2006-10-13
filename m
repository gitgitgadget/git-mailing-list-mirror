From: Junio C Hamano <junkio@cox.net>
Subject: Re: On blame/pickaxe
Date: Fri, 13 Oct 2006 00:54:24 -0700
Message-ID: <7vu028d51r.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 13 09:54:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYHsD-0004AW-L5
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 09:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWJMHy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 03:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWJMHy0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 03:54:26 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31124 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751387AbWJMHyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 03:54:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013075425.QADD18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 03:54:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZjuU1V0021kojtg0000000
	Fri, 13 Oct 2006 03:54:28 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Oct 2006 18:43:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28832>

In an earlier message, I talked about pickaxe data structure
that has potential for blaming more than one paths in a single
revision.

I was talking about the future enhancements, but it turns out
that there is a corner case that the feature is already needed
using the classic blame algorithm, and running blame shows its
limitation through.

The scenario is like this:

 - initial has two files A and B
 - branch left renames A to C and adds stuff at the top.
 - branch right renames B to C and adds stuff at the bottom.
 - left and right is merged and leaves one file, C, by taking
   what both branches did.
 - annotate C from the top.

The parts that came from A and B in the initial revision should
be assigned to these files in the initial commit.  If you look
at the blame output, you will see it fails to do so.  pickaxe
gives what is expected.

-- >8 --
#!/bin/sh

if test -d .git
then
        echo 'please run this in a fresh empty directory'
	exit
fi

git init-db

for i in 1 2 3 4 5 6 7 8 9 ; do echo line line line $i ; done >A
for i in A B C D E F G H I ; do echo line line line $i ; done >B

git add A B
git commit --author='Initial <initial@author>' -m initial

git branch right
git branch left

# Left
git checkout left
for i in 1 2 3; do echo added by left; done >C
cat A >>C
rm -f A B
git update-index --add --remove A B C
git commit --author='Left <left@branch>' -m Left

# Right
git checkout right
cat B >C
for i in 1 2 3; do echo added by right; done >>C
rm -f A B
git update-index --add --remove A B C
git commit --author='Right <right@branch>' -m Right

# Merge them; this should fail which is expected
git pull . left
{
	git cat-file blob :3:C
	git cat-file blob :2:C
} >C
git update-index C
git commit --author='Merge <merge@branch>' -m 'Changes are merged.'
rm -f C~*

echo blame
git blame -f -n -t C

echo pickaxe
git pickaxe -f -n -t C
