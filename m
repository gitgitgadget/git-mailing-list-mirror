X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Missing features in git
Date: 14 Nov 2006 08:49:58 -0500
Message-ID: <20061114134958.5326.qmail@science.horizon.com>
NNTP-Posting-Date: Tue, 14 Nov 2006 13:50:34 +0000 (UTC)
Cc: linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31346>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjyfv-00027p-AV for gcvg-git@gmane.org; Tue, 14 Nov
 2006 14:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965744AbWKNNuD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 08:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965816AbWKNNuD
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 08:50:03 -0500
Received: from science.horizon.com ([192.35.100.1]:20301 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S965744AbWKNNuA (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 08:50:00 -0500
Received: (qmail 5327 invoked by uid 1000); 14 Nov 2006 08:49:58 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've been writing some more git docs, and I came across a few
things git does that I'm not sure are desirable.


One thing I noticed is that with ref logs, you've just re-invented the
CVS problem of associating history with a name.  If you want to rename
a branch (say, from "mischacks" to something suitable for publication),
do you rename the log or not?  It's a less virulent form, but it seems
like the same disease.

Another minor quibble: AFAICT, "git checkout -f -m" is meaningless (-f
overrides -m), but doesn't complain.


One feature that I noticed is missing, is that there's no easy way to do a
"git reset --hard" while doing a "git checkout" style merge.

An example of when you'd want to do this is performing a "git bisect"
with a local "#define DEBUG 1" change.  Particularly if you
hit a non-compiling version and need to back up.

  
The only way to do this currently is somethig like:
        git checkout -b temp HEAD^
        git branch -f bisect temp
        git checkout bisect
        git branch -d temp

or the way git-bisect does it
  
        echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
        git checkout new-bisect || exit
        mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
        GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect
  
Either way, it reserves a second branch name, and seems like a bit of
a hack.  I'm already a bit annoyed that "bisect" is reserved but not
clearly documented as such, and note that the branch name "new-bisect",
which we are switched to temporarily, does not match the pattern
"refs/heads/bisect*" that bisect_start checks for.

The only thing I don't know is if this should be a git-checkout
option or a git-reset option.  The former shares far more code,
but the latter might make more logical sense.

  
Personally, I'd prefer if the requirement that HEAD point to
refs/heads were enforced when checking in rather than checking out.
  
Then you could check out an arbitrary version without any of the annoyance
above; I could "git checkout tags/foo" or even "git checkout deadbeef~3".
I wouldn't be on a current branch (which would necessitate changing
"git branch" output), so HEAD would simply contain an object ID directly
rather than being a symlink/symref.

It's a bit of a PITA auditing the code base to find everywhere affected
by changing this invariant, but it doesn't conceptually difficult.
Is there anything fundamental that this would break?


The above would make a "-b <newbranch>" option to git-commit more useful,
but it's not a half-bad idea as it is.  It's just one extra command
(git checkout -b newbranch; git commit), but it takes a bit of
thinking to realize that "git checkout", which normally modifies the
working directory, won't touch your ready-to-be-committed changes in
