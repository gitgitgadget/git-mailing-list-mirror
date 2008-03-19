From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Tue, 18 Mar 2008 22:20:56 -0800
Message-ID: <402c10cd0803182320k134116cas5f62389482f2650a@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
	 <m363vkvvzb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4sd-0004ng-0A
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759859AbYCSU01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759866AbYCSU00
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:26:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:27926 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759956AbYCSU0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:26:22 -0400
Received: by fk-out-0910.google.com with SMTP id 19so716254fkr.5
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 13:26:19 -0700 (PDT)
Received: by 10.82.145.7 with SMTP id s7mr5216396bud.24.1205907656455;
        Tue, 18 Mar 2008 23:20:56 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 18 Mar 2008 23:20:56 -0700 (PDT)
In-Reply-To: <m363vkvvzb.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77536>

Thanks to you and everyone else for useful input.  Some of this input
ended up in the documentation.  I will provide an updated patch
tomorrow.  I expect to have a final patch for submission some time
next week.

I have added some more documentation:


diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2af33d8..5af5436 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -36,7 +36,7 @@ include::merge-options.txt[]
 <remote>::
        Other branch head merged into our branch.  You need at
        least one <remote>.  Specifying more than one <remote>
-       obviously means you are trying an Octopus.
+       usually means you are trying an Octopus.


 include::fast-forward-options.txt[]
@@ -133,6 +133,47 @@ merge (which is typically a fraction of the whole
tree), you can
 have local modifications in your working tree as long as they do
 not overlap with what the merge updates.

+If more than one commit are specified for the merge, git will try to
+reduce the number of commits (real parents) by eliminating commits
+than can be reached from other commits.  The commit message will
+reflect the actual commits specified but the merge strategy will be
+selected based on the real parents always including `HEAD`.  The real
+parents (only including `HEAD` if it is real) are the parents recorded
+in the merge commit object.
+
+The following shows master and three topic branches.  TopicB is based
+on TopicA, TopicA is previously branched off from master, and TopicC
+is based on the current `HEAD` of master:
+
+------------
+                    o---o---o  TopicB
+                   /
+          o---o---o  TopicA
+         /
+    o---o---o---o---o---o  master
+                         \
+                          o---o  TopicC
+------------
+
+A merger of master with TopicA, TopicB, and TopicC will select the
+merge strategy based on the three branches master, TopicB, and TopicC
+(TopicA is eliminated since it can be reached from TopicB).  TopicB
+and TopicC are the only real parents and are therefore the only
+parents recorded in the merge commit object:
+
+------------
+         % git co master
+         % git merge TopicA TopicB TopicC
+
+                    o---o---o  TopicB
+                   /         \
+          o---o---o  TopicA   \
+         /                     \
+    o---o---o---o---o---o       o  master
+                         \     /
+                          o---o  TopicC
+------------
+
 When there are conflicts, these things happen:

 1. `HEAD` stays the same.

On Tue, Mar 18, 2008 at 8:27 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>  I'd mention here receive.denyNonFastForward option as a way to set
>  this globally for all branches, for public bare publishing
>  repositories; AFAIK for push and I think also for fetch.

The denyNonFastForward option have nothing to do with merges.  It only
applies to push on the server side.  A merge is not involved when
doing a push.

-- 
Sverre Hvammen Johansen
