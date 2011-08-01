From: Johan Herland <johan@herland.net>
Subject: BUG?: git diff with 3 args consults work tree when it shouldn't
Date: Mon, 1 Aug 2011 19:35:11 +0200
Message-ID: <201108011935.11373.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 19:50:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwcq-0003N2-8e
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab1HARt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 13:49:56 -0400
Received: from smtp.opera.com ([213.236.208.81]:50141 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab1HARty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 13:49:54 -0400
X-Greylist: delayed 881 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Aug 2011 13:49:54 EDT
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p71HZBEw024587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 1 Aug 2011 17:35:11 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178364>

Hi,

I'm viewing the combined diff of a merge commit where the correct 
resolution involved the removal of a conflicting file. In short, the 
(simplified) scenario is:

    A
   / \
  O   M
   \ /
    B

where commit O does not contain the file, branches A and B add 
conflicting versions of the file, and merge M removes the file (see 
below for a full command session illustrating the scenario).

When I view the combined diff of the merge (using "git diff M A B" or 
"git show M" ), it seems the resulting diff depends on the 
existence/contents of the file in my *current work tree*. I.e. if I 
checkout O or M (where the file is missing) before producing the diff, 
the result seems correct, but if I put a garbage version of the file in 
my work tree (without adding or committing it at all), the garbage shows 
up in the diff, as follows:

  $ git diff M A B
  diff --cc file
  index 34b6a0c,732c85a..0000000
  --- a/file
  +++ b/file
  @@@ -1,1 -1,1 +1,1 @@@
  - contents contributed by A
   -contents contributed by B
  ++garbage contents from my work tree

AFAICS, when producing combined diffs, the diff code should not look up 
the file in the current work tree, since the diff arguments refer to 
existing commits, and do not indicate that the work tree should be 
consulted at all.


...Johan


Example session illustrating the problem:

$ git init repo
Initialized empty Git repository in ./repo/.git/
$ cd repo
$ echo foo > foo
$ git add foo
$ git commit -m foo
[master (root-commit) c6d62c2] foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git checkout -b a
Switched to a new branch 'a'
$ echo spam > file
$ git add file
$ git commit -m spam
[a d2d3128] spam
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
$ git checkout -b b master
Switched to a new branch 'b'
$ echo eggs > file
$ git add file
$ git commit -m eggs
[b 72e8252] eggs
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
$ git checkout -b m
Switched to a new branch 'm'
$ git merge a
Auto-merging file
CONFLICT (add/add): Merge conflict in file
Automatic merge failed; fix conflicts and then commit the result.
$ git rm file
file: needs merge
rm 'file'
$ git commit -m merge
[m c096356] merge
$ git diff m a b
diff --cc file
index 34b6a0c,732c85a..0000000
deleted file mode 100644,100644
--- a/file
+++ /dev/null
$ ### HERE IS WHERE IT GOES WRONG:
$ echo xyzzy > file
$ git diff m a b
diff --cc file
index 34b6a0c,732c85a..0000000
--- a/file
+++ b/file
@@@ -1,1 -1,1 +1,1 @@@
- spam
 -eggs
++xyzzy



-- 
Johan Herland, <johan@herland.net>
www.herland.net
