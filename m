From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git pull" doesn't know "--edit"
Date: Sat, 11 Feb 2012 10:21:03 -0800 (PST)
Message-ID: <alpine.LFD.2.02.1202111016340.28503@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 19:21:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwHZY-0002Qc-C6
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 19:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab2BKSVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 13:21:16 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47981 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab2BKSVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 13:21:15 -0500
Received: by daed14 with SMTP id d14so3257055dae.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 10:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        bh=D361vWDF6gPRcAIBBPliR6UbFo9xjFEaCtxtpPl3E6o=;
        b=tQXjzd9Y6kI1gV5eIsuSIqoi2Rg1k0vmTHJTUVyA0EktBvbOp+skmbTZ/5bgVQxkK2
         itLY7QCjgcpyhzZoRk3TI3UOHxFrlVh4WAUGt3zc5FoVtUIbNyYhXI6yoeYbFhgzRU4O
         I2LItMohZS9oDTFUth249IYGVOjxchv4paSLk=
Received: by 10.68.196.161 with SMTP id in1mr29178594pbc.10.1328984474997;
        Sat, 11 Feb 2012 10:21:14 -0800 (PST)
Received: from [192.168.1.87] (c-67-168-200-136.hsd1.or.comcast.net. [67.168.200.136])
        by mx.google.com with ESMTPS id b7sm24172510pba.2.2012.02.11.10.21.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 10:21:12 -0800 (PST)
X-X-Sender: torvalds@i5.linux-foundation.org
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190525>


Ok, so now "git merge" defaults to editing when interactive - lovely. But 
when testing that, I noticed that while you can say

   git merge --[no-]edit ..branch..

that does not work with "git pull". You get a message like

  error: unknown option `no-edit'
  usage: git fetch [<options>] [<repository> [<refspec>...]]
     or: git fetch [<options>] <group>
     or: git fetch --multiple [<options>] [(<repository> | <group>)...]
     or: git fetch --all [<options>]

      -v, --verbose         be more verbose
      -q, --quiet           be more quiet
      --all                 fetch from all remotes
  ...

which is because that stupid shell script doesn't know about the new 
flags, and just passes it to "git fetch" instead.

Now, I really wanted to just make "git pull" a built-in instead of that 
nasty shell script, but I'm lazy. So here's the trivial updates to 
git-pull.sh to at least teach it about -e/--edit/--no-edit.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
This hasn't seen a lot of testing, but it looks pretty obvious

 git-pull.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index d8b64d7a67a1..434c139f077e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -40,7 +40,7 @@ test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity= progress= recurse_submodules=
-merge_args=
+merge_args= edit=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
@@ -70,6 +70,10 @@ do
 		no_commit=--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
 		no_commit=--commit ;;
+	-e|--edit)
+		edit=--edit ;;
+	--no-edit)
+		edit=--no-edit ;;
 	--sq|--squ|--squa|--squas|--squash)
 		squash=--squash ;;
 	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
@@ -278,7 +282,7 @@ true)
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval="git-merge $diffstat $no_commit $squash $no_ff $ff_only"
+	eval="git-merge $diffstat $no_commit $edit $squash $no_ff $ff_only"
 	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
