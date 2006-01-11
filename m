From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (Updated) Exec git programs without using PATH.
Date: Wed, 11 Jan 2006 12:33:51 -0800
Message-ID: <7vek3esdw0.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
	<43C4075E.4070407@op5.se> <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	<1136924980.11717.603.camel@brick.watson.ibm.com>
	<7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
	<1136945538.11717.643.camel@brick.watson.ibm.com>
	<7v4q4bwavi.fsf@assigned-by-dhcp.cox.net>
	<1136999157.11717.658.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 21:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwmfN-00057y-MU
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWAKUdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWAKUdy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:33:54 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25065 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964831AbWAKUdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 15:33:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111203203.EQMS17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 15:32:03 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14512>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> The git suite may not be in PATH (and thus programs such as
>...
> Includes modifications by Junio C Hamano <junkio@cox.net>.

Thanks for the update (you did it even without line wrapping
this time).

I made further fixes last night and it is in the proposed
updates ("pu") branch.  This branch is used to hold and showcase
what I plan to eventually merge into the master branch, and
consists of the topic branches merged on top of what is in the
master branch.  To disect to see what shape I munged your patch
into, please look at it with gitk or gitweb and find "Merge
branch mo/exec" commit (my topic branches are named after patch
author and topic keyword).  The second parent of that commit is
the tip of the topic branch mo/exec when the merge was made.

A word of caution to people on the list (not limited to Michal)
is needed again, because it's been a while since I talked about
the proposed updates branch last time (which was pre 1.0.0
release IIRC).

The "pu" branch is regularly rebuilt by merging private topic
branches on top of the then-current master branch, by doing
this:

	$ git checkout pu
        $ git reset --hard master ;# build from scratch!
        $ git pull . topic1
        $ git pull . topic2
        $ ...
        $ git pull . topicN

What this means is that you (not just Michal---"people") should
not base your development on top of "pu" branch proper, since
you will have a hard time updating and merging.  Disecting my
"pu" branch to find the topic branch that corresponds to your
topic, and doing your development and patch preparation based on
that branch tip (and tell me that the patch is against your
topic branch, or "pu") is possible, but even that is not always
an easy option, since I may occasionally have to rebase my topic
branches as well.  You can always send in an updated patch based
on my master, and I'll manage with three-way merge to pick out
the real changes since your last iteration.

For your (primarily Michal, but other interested parties as
well) reference, here is the diff between your patch in the
message I am replying to and what I placed in the "pu" branch
last night.

-- >8 --
Updates on top of comments last night.

 - git-unpack-objects are run via execv_git_cmd, so no "git-"
   prefix should be given.

 - two more files need #include "exec_cmd.h".

---
diff --git a/receive-pack.c b/receive-pack.c
index 6120dbe..eae31e3 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -6,7 +6,7 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
-static char *unpacker[] = { "git-unpack-objects", NULL };
+static char *unpacker[] = { "unpack-objects", NULL };
 
 static int report_status = 0;
 
diff --git a/send-pack.c b/send-pack.c
index 4a420a6..990be3f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -3,6 +3,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "exec_cmd.h"
 
 static const char send_pack_usage[] =
 "git-send-pack [--all] [--exec=git-receive-pack] <remote> [<head>...]\n"
diff --git a/shell.c b/shell.c
index d40dfe4..fc0c73c 100644
--- a/shell.c
+++ b/shell.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "quote.h"
+#include "exec_cmd.h"
 
 static int do_generic_cmd(const char *me, char *arg)
 {
