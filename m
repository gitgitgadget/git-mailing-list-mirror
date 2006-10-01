From: "Michael Cassar" <m.e.cassar@gmail.com>
Subject: [BUG] 'git mv a/fileA b/fileB' causes 'c/fileC' to be deleted
Date: Mon, 2 Oct 2006 00:21:38 +1000
Message-ID: <750170aa0610010721p66899ba5pcc7efa13be4cd10a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 01 16:21:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU2CY-0006Xh-5R
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 16:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWJAOVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWJAOVk
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 10:21:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:14491 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932186AbWJAOVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 10:21:39 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1435305wxc
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 07:21:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pkzVLBfsae6XXnkYrpvjnzkTnfa9ShE9+o8Y5CbCuSv9J/H1MtjkRwWWd/bC6RXvzw15AEa5fLNOTSaBk68gFgZJOE1ot9vwbY9mIv/yv3ZDA5bxDfdA7T4zyReo9PeCNS+DYkU+lzeWlCj7otICfknf1odbLJrFZkmHIpF7Yjs=
Received: by 10.70.84.6 with SMTP id h6mr4752405wxb;
        Sun, 01 Oct 2006 07:21:39 -0700 (PDT)
Received: by 10.70.42.9 with HTTP; Sun, 1 Oct 2006 07:21:38 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28180>

Hi,

I'm new to git, so this may be user error, but I am getting some
strange behaviour using the 'git mv' command. In particular,
attempting to move a file from one directory to another (performing
a rename in the process) causes an unrelated third-party file to
be deleted after commit.

I have flicked through the git man pages and googled for git mv
related issues, but haven't come up with anything.

Here is a transcript. These results are reproducable using the same
files, but I can't seem to reproduce with different files.


## Create initial respository

[mike@simba ~] git version
git version 1.4.2.1

[mike@simba ~] mkdir repos; cd repos

[mike@simba ~/repos] git init-db
defaulting to local storage area

[mike@simba ~/repos] cp -r ~/thesis_work/* .

[mike@simba ~/repos] ls -a
.  ..  .git  metathesis  notes  papers  partA

[mike@simba ~/repos] git add metathesis notes papers partA

[mike@simba ~/repos] git commit -m 'initial import'
Committing initial tree 77d618ebc7c8e655c1d2f0e223e1957b6b5ff247

## Files that we are going to deal with. Note that 'outline.txt' is an
## innocent third party.

[mike@simba ~/repos] sha1sum partA/outline.txt
891256d20531ebc288f1abb5e23f9979597889d3  partA/outline.txt

[mike@simba ~/repos] sha1sum papers/unsorted/Thesis.pdf
52446ade19a067253e8407bf092b52e5efa35247  papers/unsorted/Thesis.pdf

## Move 'Thesis.pdf' to a new name, and commit

[mike@simba ~/repos] git mv papers/unsorted/Thesis.pdf
papers/all-papers/new-name.pdf

[mike@simba ~/repos] git commit -m 'moved a file'

## Have a look at what git just did. In particular, note that 'outline.txt'
## has magically appeared in the log

[mike@simba ~/repos] cg log -f | head
commit aa544a0d58118eb01fa6768e438fa0f521d6095b
tree 07c4971e3946b7c33742515e8915ec6e8abc4e40
parent 0d4292e44aa999707eddf31c4bbcadd711a170be
author mike <mike@simba.home> Sun, 01 Oct 2006 23:39:06 +1000
committer mike <mike@simba.home> Sun, 01 Oct 2006 23:39:06 +1000

    * papers/all-papers/new-name.pdf, partA/outline.txt:

    moved a file

## What changes are in the commit?

[mike@simba ~/repos] git show aa544a0d58118eb01fa6768e438fa0f521d6095b
| head -19
commit aa544a0d58118eb01fa6768e438fa0f521d6095b
Author: mike <mike@simba.home>
Date:   Sun Oct 1 23:39:06 2006 +1000

    moved a file

diff --git a/papers/all-papers/new-name.pdf b/papers/all-papers/new-name.pdf
new file mode 100644
index 0000000..5441543
Binary files /dev/null and b/papers/all-papers/new-name.pdf differ
diff --git a/partA/outline.txt b/partA/outline.txt
deleted file mode 100644
index d3ac280..0000000
--- a/partA/outline.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-
-Thesis Part A
-
[rest of file outline.txt deleted]

Is this just me being an idiot, or could there be a bigger problem
here?

Please CC me in any replies.

Cheers,

Mike
