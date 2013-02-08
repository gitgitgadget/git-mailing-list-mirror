From: Martijn van Oosterhout <kleptog@gmail.com>
Subject: git filter-branch --prune-empty not removing commits
Date: Fri, 8 Feb 2013 16:23:42 +0100
Message-ID: <CADWG95sHx6Z2Ukon8FAHKa1qUOj4shd4MbCwahwX++FVWJPDDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f22beb904fd0204d5382550
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 16:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3po9-0003jJ-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 16:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946552Ab3BHPXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 10:23:46 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46846 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946450Ab3BHPXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 10:23:45 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so3007772lbb.26
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 07:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=5cJq4p7V9QAtYMUfu0SMDfwMURfj7I+aaZ86Baqov6A=;
        b=FEuMSMSVSlCBpxUpHUR6Cylm/KaI83c0HYKwqYQnaWESHvyZSqycne+vmw+gMUhCzR
         r8phAYf/g4Jxpx1xtvsR3Q5tv0jBZxQR3Z/cfgf+LasRi4iKcE8uK7KZPKky3Ag9EMMU
         u+xifeBi6m9iKUV8gaxWqEqszyE8PaA2ay6l2y7qf8PSrjrKb/vsBcHtABNNEzWQ9qYR
         VgcMPxMLy1FPUD6lBVTLXCApucDtB2GnBs14nVDgIOFxyVgef7YDsNHSapvzjq0vovUM
         4mGDaTkwCZZeX6qCbDdootsfplVuJEItVmUJIMV1F98cmX4G0dtLeZpDu69xod84hbma
         LwpQ==
X-Received: by 10.152.147.130 with SMTP id tk2mr5269517lab.24.1360337022811;
 Fri, 08 Feb 2013 07:23:42 -0800 (PST)
Received: by 10.114.16.35 with HTTP; Fri, 8 Feb 2013 07:23:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215775>

--e89a8f22beb904fd0204d5382550
Content-Type: text/plain; charset=ISO-8859-1

Hoi,

Found a small issue with git filter-branch not removing empty commits
if they are the first commit in the tree. Find test script attached
and example output below.

I think the issue is in the function git_commit_non_empty_tree, which
doesn't handle this case. I think something like the following should
work:

 git_commit_non_empty_tree()
 {
+        if test $# = 1 && test -z "$(git ls-tree $1)" ; then
+                skip_commit "$@"
+        fi
         if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
                 map "$3"
         else
                 git commit-tree "$@"
         fi
 }

If you're wondering how I got here, it was by using git svn to import
a tree once converted by cvs2svn, which added empty commits to the svn
repo to indicate the creation of branches.

Have a nice day,

---- Test script output (note: destroys the foo subdirectory) ----
+ git version
git version 1.7.9.5
+ echo ======== Setup ========
+ git init foo
Initialized empty Git repository in /tmp/foo/.git/
+ export GIT_AUTHOR_NAME=foo
+ export GIT_AUTHOR_EMAIL=foo@example.com
+ export GIT_COMMITTER_NAME=foo
+ export GIT_COMMITTER_EMAIL=foo@example.com
+ cd foo
+ git write-tree
+ git commit-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904 -m Commit 1
+ COMMIT1=1dc65b84c016320ce0599f2bd78bcbb5e532658f
+ export GIT_AUTHOR_NAME=bar
+ export GIT_AUTHOR_EMAIL=bar@example.com
+ echo Hello World
+ git add file
+ git write-tree
+ git commit-tree 34b512cb05f8b709198d18d916ea6395c237ae0d -m Commit 2
-p 1dc65b84c016320ce0599f2bd78bcbb5e532658f
+ COMMIT2=11af492decae1284cd2d27af4c5a92b4aab46510
+ git branch -f master 11af492decae1284cd2d27af4c5a92b4aab46510
+ git log master --stat
commit 11af492decae1284cd2d27af4c5a92b4aab46510
Author: bar <bar@example.com>
Date:   Fri Feb 8 16:12:13 2013 +0100

    Commit 2

 file |    1 +
 1 file changed, 1 insertion(+)

commit 1dc65b84c016320ce0599f2bd78bcbb5e532658f
Author: foo <foo@example.com>
Date:   Fri Feb 8 16:12:13 2013 +0100

    Commit 1
+ echo ======== Bug: filter-branch --prune-empty not working ========
+ git filter-branch --prune-empty master
Rewrite 11af492decae1284cd2d27af4c5a92b4aab46510 (2/2)
WARNING: Ref 'refs/heads/master' is unchanged
+ git log master --stat
commit 11af492decae1284cd2d27af4c5a92b4aab46510
Author: bar <bar@example.com>
Date:   Fri Feb 8 16:12:13 2013 +0100

    Commit 2

 file |    1 +
 1 file changed, 1 insertion(+)

commit 1dc65b84c016320ce0599f2bd78bcbb5e532658f
Author: foo <foo@example.com>
Date:   Fri Feb 8 16:12:13 2013 +0100

    Commit 1

-- 
Martijn van Oosterhout <kleptog@gmail.com> http://svana.org/kleptog/

--e89a8f22beb904fd0204d5382550
Content-Type: application/octet-stream; name=test
Content-Disposition: attachment; filename=test
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hcxheebp0

IyEvYmluL3NoIC14CgpnaXQgdmVyc2lvbgoKZWNobyAiPT09PT09PT0gU2V0dXAgPT09PT09PT0i
CmdpdCBpbml0IGZvbwoKZXhwb3J0IEdJVF9BVVRIT1JfTkFNRT0iZm9vIgpleHBvcnQgR0lUX0FV
VEhPUl9FTUFJTD0iZm9vQGV4YW1wbGUuY29tIgpleHBvcnQgR0lUX0NPTU1JVFRFUl9OQU1FPSRH
SVRfQVVUSE9SX05BTUUKZXhwb3J0IEdJVF9DT01NSVRURVJfRU1BSUw9JEdJVF9BVVRIT1JfRU1B
SUwKCmNkIGZvbwoKQ09NTUlUMT0kKGdpdCBjb21taXQtdHJlZSAkKGdpdCB3cml0ZS10cmVlKSAt
bSAiQ29tbWl0IDEiKQoKZXhwb3J0IEdJVF9BVVRIT1JfTkFNRT0iYmFyIgpleHBvcnQgR0lUX0FV
VEhPUl9FTUFJTD0iYmFyQGV4YW1wbGUuY29tIiAgIAoKZWNobyAiSGVsbG8gV29ybGQiID4gZmls
ZQpnaXQgYWRkIGZpbGUKQ09NTUlUMj0kKGdpdCBjb21taXQtdHJlZSAkKGdpdCB3cml0ZS10cmVl
KSAtbSAiQ29tbWl0IDIiIC1wICRDT01NSVQxKQoKZ2l0IGJyYW5jaCAtZiBtYXN0ZXIgJENPTU1J
VDIKZ2l0IGxvZyBtYXN0ZXIgLS1zdGF0CgplY2hvICI9PT09PT09PSBCdWc6IGZpbHRlci1icmFu
Y2ggLS1wcnVuZS1lbXB0eSBub3Qgd29ya2luZyA9PT09PT09PSIKZ2l0IGZpbHRlci1icmFuY2gg
LS1wcnVuZS1lbXB0eSBtYXN0ZXIKZ2l0IGxvZyBtYXN0ZXIgLS1zdGF0Cgo=
--e89a8f22beb904fd0204d5382550--
