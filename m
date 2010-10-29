From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 1/2] Documentation: suggest "reset --merge" more often
Date: Fri, 29 Oct 2010 03:38:36 -0500
Message-ID: <20101029083836.GB26290@burratino>
References: <20101029083516.GA26290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 10:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBkU6-0000Rp-C3
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760790Ab0J2Iiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:38:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52234 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0J2Iio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:38:44 -0400
Received: by gyg4 with SMTP id 4so1792282gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DFD7TNF05PlG+YgpET0jHnzdSboxSzekaY0eslqUG1A=;
        b=MPjaRFp9gFMNNoGm7NxjZNPT4bCZFsSv0Z2fIyLXJhPByxeMAwHNRqPjwmgtY4sROq
         XifyA/iZtwIu2t562orcwq0ssXRYMFK0WfVFUXRy46wRQQ02I1olHHrHcK/+K8E+ecdB
         nmzgK5//Yt02sXF9Il5bPz9wu34nku3ncVyWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a57lsJSdcPxO3oE7hp+XrQ1zjVH8nSfFG/1cAz3wD1X8Eb4evtwJ5ablU/8J4rTmhD
         uy6Je0GwB8La/4BLXBq29AjRBvaHPXyERuJP9joPucUxzHYWrz70srS6NWguCPyQiqXf
         Ax5rAmy4RlzrD+Gmo6GEniu/5VFgm1Dl271KI=
Received: by 10.150.186.12 with SMTP id j12mr9415360ybf.390.1288341523749;
        Fri, 29 Oct 2010 01:38:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z5sm1530500yhc.27.2010.10.29.01.38.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 01:38:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101029083516.GA26290@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160320>

With its new semantics, "git reset --merge" is more suitable for
undoing a failed merge than "git reset --hard" is.  It is especially
nice if you forget that you are in a merge and make a change or two:

  git merge something-complicated
  ... notice conflicts, walk away ...
  vi foo.c
  git commit; # fails because the index has unmerged entries
  git reset --merge

The modern (post-1.7.0) semantics of git reset --merge ensure that
the changes to foo.c will be preserved by this sequence of commands,
unless foo.c was one of the files with conflicts.

So in the spirit of ed4a6baa (Documentation: suggest `reset --merge`
in How Merge Works section, 2010-01-23), recommend it in place of
"reset --hard".

One caveat: for habitual adders-to-index, "git reset --merge" is
no better than "git reset --hard" (though still no worse).

  vi foo.c
  git add -u
  git diff --cached --check; # fails because conflict markers are present
  git reset --merge; # equivalent to git reset --hard

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge.txt   |    2 +-
 Documentation/git-reset.txt   |    9 +++++----
 Documentation/user-manual.txt |    9 ++++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 84043cc..498931b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -213,7 +213,7 @@ After seeing a conflict, you can do two things:
 
  * Decide not to merge.  The only clean-ups you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; `git-reset --hard` can
+   up working tree changes made by 2. and 3.; `git reset --merge` can
    be used for this.
 
  * Resolve the conflicts.  Git will mark the conflicts in
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index fd72976..1d0d9e6 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -179,7 +179,7 @@ $ git pull                         <1>
 Auto-merging nitfol
 CONFLICT (content): Merge conflict in nitfol
 Automatic merge failed; fix conflicts and then commit the result.
-$ git reset --hard                 <2>
+$ git reset --merge                <2>
 $ git pull . topic/branch          <3>
 Updating from 41223... to 13134...
 Fast-forward
@@ -189,9 +189,10 @@ $ git reset --hard ORIG_HEAD       <4>
 <1> Try to update from the upstream resulted in a lot of
 conflicts; you were not ready to spend a lot of time merging
 right now, so you decide to do that later.
-<2> "pull" has not made merge commit, so "git reset --hard"
-which is a synonym for "git reset --hard HEAD" clears the mess
-from the index file and the working tree.
+<2> "pull" has not made merge commit, so "git reset --merge"
+which is a synonym for "git reset --merge HEAD" clears the mess
+from the index file and the working tree.  "git reset --hard"
+would work as well.
 <3> Merge a topic branch into the current branch, which resulted
 in a fast-forward.
 <4> But you decided that the topic branch is not ready for public
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fc56da6..9120ad5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1372,12 +1372,19 @@ Undoing a merge
 ---------------
 
 If you get stuck and decide to just give up and throw the whole mess
-away, you can always return to the pre-merge state with
+away, you can always return to the last commit's state with
 
 -------------------------------------------------
 $ git reset --hard HEAD
 -------------------------------------------------
 
+If you have changes that should be preserved in files not touched by
+the merge, instead use
+
+-------------------------------------------------
+$ git reset --merge HEAD
+-------------------------------------------------
+
 Or, if you've already committed the merge that you want to throw away,
 
 -------------------------------------------------
-- 
1.7.2.3.557.gab647.dirty
