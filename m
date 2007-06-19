From: Steven Grimm <koreth@midwinter.com>
Subject: Directory renames (was Re: blame follows renames, but log doesn't)
Date: Tue, 19 Jun 2007 11:28:28 -0700
Message-ID: <4678204C.6050409@midwinter.com>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com> <20070619071916.GC9177@thunk.org> <4677A7EF.500@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 19 20:28:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0iRM-00012G-3v
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 20:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbXFSS2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 14:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756839AbXFSS2b
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 14:28:31 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:49897
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753886AbXFSS2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 14:28:30 -0400
Received: (qmail 5035 invoked from network); 19 Jun 2007 18:28:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=NYxEi3+OI2kOwYLocMrNOA9x5D6dCnAr2By2GirBJi8WIb/fGFyUfJeACYdz1xKc  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 19 Jun 2007 18:28:30 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <4677A7EF.500@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50500>

Directory renames can break in more cases than just adding new files. 
Here's a demonstration based on a situation I ran into a few minutes ago 
on a real-world project.

$ git init
$ mkdir a
$ echo some contents > a/file1
$ echo other contents > a/file2
$ git add a
$ git commit -m "initial commit"

So far so good. Now there's a revision where the files happen to be 
identical. (On a new branch for later convenience.)

$ git checkout -b modifybranch
$ echo other contents > a/file1
$ git commit -a -m "commit that makes both files identical"

Now we rename the directory. (Again, the new branch will be used later.)

$ git checkout -b renamebranch
$ git mv a b
$ git commit -m "rename directory"

Make a change to file2.

$ echo more contents from renamebranch >> b/file2
$ git commit -a -m "add contents to file2"

Where did file2's contents come from?

$ git blame b/file2
a7dbcfdc a/file1 (Steven Grimm 2007-06-19 10:36:20 -0700 1) other contents
69a87194 b/file2 (Steven Grimm 2007-06-19 10:43:29 -0700 2) more contents

Which is wrong. The history of file2 has nothing to do with the history 
of file1, but git blame thinks it does. However, that's not what blew up 
on me in my real-world test; it gets better. Let's say one of the files 
changed in a different branch.

$ git checkout master
$ echo a change to file2 in master >> a/file2
$ git commit -a -m "file2 changed"

$ git merge renamebranch
Removed a/file1
Merge made by recursive.
 a/file1            |    1 -
 a/file2 => b/file1 |    0
 b/file2            |    2 ++
 3 files changed, 2 insertions(+), 1 deletions(-)
 delete mode 100644 a/file1
 rename a/file2 => b/file1 (100%)
 create mode 100644 b/file2

And this is just completely broken. What it *should* do is give me 
b/file1 with "other contents" from renamebranch, and b/file2 with a 
merge conflict since I added a different line to it in each branch. 
Instead, the merge succeeds with no conflict and applies the change in 
my current branch to the wrong file:

$ cat b/file1
other contents
a change to file2 in master
$ cat b/file2
other contents
more contents from renamebranch

There's one more variation on this theme that's broken in a similar but 
not identical way (this didn't happen in my real-world scenario but I 
ran into it while coming up with the above test case):

$ git checkout modifybranch
$ echo a change to file2 in modifybranch >> a/file2
$ git commit -a -m "a change in modifybranch"
$ git merge renamebranch
CONFLICT (delete/modify): a/file2 deleted in renamebranch and modified 
in HEAD. Version HEAD of a/file2 left in tree.
Automatic merge failed; fix conflicts and then commit the result.

This should definitely be a merge conflict, but it shouldn't be *this* 
merge conflict. What I'd expect here would be b/file1 == "other 
contents" and b/file2 with conflict markers.

$ ls a b
a:
file2

b:
file1   file2
$ cat a/file2
other contents
a change to file2 in modifybranch
$ cat b/file1
other contents
$ cat b/file2
other contents
more contents from renamebranch

In other words, no conflict markers at all, and I still have the old 
directory "a" with one of its two files in original form, but not the 
other file.

Hope that's illuminating or at least interesting to someone.

-Steve
