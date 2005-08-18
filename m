From: Jan Veldeman <jan.veldeman@gmail.com>
Subject: [RFC] Stgit - patch history / add extra parents
Date: Thu, 18 Aug 2005 21:57:53 +0200
Message-ID: <20050818195753.GA9066@fanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 18 21:57:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5qUI-0000qX-8b
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 21:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVHRTzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 15:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHRTzj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 15:55:39 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:36321 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932414AbVHRTzi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 15:55:38 -0400
Received: by zproxy.gmail.com with SMTP id r28so340345nza
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 12:55:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=aUiHIORouk+zM8Sw/vLyjc8kpLrg7xFHLEMdjC8Ffd6yUK/FJ7O8WWXJZB7wxCb7T2oFfT3BoHyJI2jurqwiDWx//GWcpYQbtmrKwgTct1kG5/CIPMq+RkJl/qiVmVzZfiMkg0BmYC/NTwmyyxwLg6UbkRw3hN8bPCtjffXmCtg=
Received: by 10.36.221.52 with SMTP id t52mr1710221nzg;
        Thu, 18 Aug 2005 12:55:35 -0700 (PDT)
Received: from localhost ([84.195.185.241])
        by mx.gmail.com with ESMTP id 19sm4194561nzp.2005.08.18.12.55.34;
        Thu, 18 Aug 2005 12:55:35 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I like stgit very much, but I feel there is still something missing:
stgit is very handy when you use it for patches which should be pushed to
mainline rather quickly. But for pacthes which won't be pushed immediately
to mainline, it would be usefull to have a history of the patches itself.

The patch below, together with the following script could be used to
make snapshots of the patch stack (I call it freeze, as I thought snapshot
was already going to be used for something else):

#!/bin/bash
# stg-freeze
set -ex
top=$(stg top)

# Freeze the current stack
branchname=$(basename $(readlink .git/HEAD))
while read patch
do
	cp .git/patches/$branchname/$patch/top .git/patches/$branchname/$patch/parent
done < .git/patches/$branchname/applied

# Refresh the patches
stg pop -a
stg push -t $top
# end stg-freeze

Note: this is a proof of concept, when/if it would be incorporated, it
should be implemented in stgit itself, and a bit more efficient, especially
the refreshing of the patches ;-)

This is how it works: when not doing anything, stgit works as normal.
Once stg-freeze is called, it creates .git/patches/$branchname/$patch/parent
which contains the SHA1 id of the "frozen" patch. By refreshing the stack,
all patches now include the corresponding frozen patch as a parent.

The following script is a test I use. Add stg-freeze to the path and
source/run it in an empty directory, view with gitk afterwards:

###
echo "Initial commit" | cg-init
stg init

stg new a -mpatch-1
echo a > a
stg add a
stg refresh -mpatch-1
stg new b -mpatch-2
echo b > b
stg add b
stg refresh -mpatch-2
stg-freeze
stg pop
echo a2 >> a
stg refresh -mpatch-1-update
stg push
stg-freeze
echo b2 >> b
stg refresh -mpatch-2-update


stg pop -a
echo c > c
cg-add c
cg-commit -m"Mainline advance"
stg push -a

stg-freeze

stg pop -a
echo d > d
cg-add d
cg-commit -m"Mainline advance 2"
stg push -a

stg pop -a
echo e > e
cg-add e
cg-commit -m"Mainline advance 3"
stg push -a

###

Comments/remarks are very welcome.

---
 stgit/stack.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -140,6 +140,13 @@ class Patch:
         elif os.path.isfile(fname):
             os.remove(fname)
 
+    def get_parents(self):
+        parents=[]
+        if (self.__get_field('parent') != None):
+                parents = parents + [self.__get_field('parent')]
+        parents = parents + [ self.get_bottom() ]
+        return parents
+
     def get_bottom(self):
         return self.__get_field('bottom')
 
@@ -362,7 +369,7 @@ class Series:
         if not committer_email:
             committer_email = patch.get_commemail()
 
-        commit_id = git.commit(message = descr, parents = [patch.get_bottom()],
+        commit_id = git.commit(message = descr, parents = patch.get_parents(),
                                allowempty = True,
                                author_name = author_name,
                                author_email = author_email,
