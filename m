From: tytso@mit.edu
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Mon, 5 Jul 2010 15:22:01 -0400
Message-ID: <20100705192201.GI25518@thunk.org>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Mon Jul 05 21:22:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVrF6-0006A8-IB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 21:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab0GETWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 15:22:07 -0400
Received: from thunk.org ([69.25.196.29]:35187 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab0GETWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 15:22:04 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OVrEx-0005Cc-FM; Mon, 05 Jul 2010 15:22:03 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OVrEv-0004Ep-QH; Mon, 05 Jul 2010 15:22:01 -0400
Content-Disposition: inline
In-Reply-To: <20100705185238.GS22659@josefsipek.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150288>

On Mon, Jul 05, 2010 at 02:52:38PM -0400, jeffpc@josefsipek.net wrote:
> 
> I think we might need a little bit more logic in this patch...
> 
> if I commit, and immediately after push 10 patches, wouldn't the HEAD end up
> with a commit that's ~10 minutes in the future?

Hmm, good point.  I hadn't considered that case.  The most common case
happens when I rebase to a new release, and then do a "guilt push -a".
In that case the time that start with isn't "now", but whenver the
last release happened, which is typically far enough in the past that
we don't end up in the future.  However, I agree that's a concern.

How about this?

> I do like the idea of git-commit warning/erroring, but I don't think that
> guilt issuing a warning is necessary.  Afterall, it's only a timestamp
> change.  It might be a bit of a shock for anyone looking at the timestamps
> expecting them to be out of order (based on the patch times), but I think
> it's better than warning all the time.

I guess I didn't worry too much since "guilt push -a" is pretty noisy
anyway.  I've shortened the message, but if you think it's better to
pull the message altogether feel free...

						- Ted

>From d5659084435a885e05a8fc9afbffe8cdd9535828 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 4 Jul 2010 22:06:08 -0400
Subject: [PATCH] guilt: Make sure the commit time is increasing

Git has various algorithms, most notably in git rev-list, git
name-rev, and others, which depend on the commit time increasing.  We
want to keep the commit time the same as much as possible, but if
necessary, adjust the time stamps of the patch files to obey this
constraint.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/guilt b/guilt
index b6e2a6c..edcfb34 100755
--- a/guilt
+++ b/guilt
@@ -535,6 +535,17 @@ commit()
                         export GIT_AUTHOR_EMAIL="`echo $author_str | sed -e 's/[^<]*//'`"
 		fi
 
+		ct=$(git log -1 --pretty=%ct)
+		if [ $ct -gt $(stat -c %Y "$p") ]; then
+		    echo "Adjusting mod time of" $(basename "$p")
+		    ct=$(expr $ct + 60)
+		    if [ $ct -gt $(date +%s) ]; then
+			touch "$p"
+		    else
+			touch -d @$(expr $ct + 60) "$p"
+		    fi
+		fi
+
 		# must strip nano-second part otherwise git gets very
 		# confused, and makes up strange timestamps from the past
 		# (chances are it decides to interpret it as a unix
-- 
1.7.0.4
