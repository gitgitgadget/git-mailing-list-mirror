From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] Handles slashes in branch names
Date: Thu, 19 Jul 2007 12:17:01 -0700
Message-ID: <87r6n4td8y.fsf@hubert.paunchy.net>
References: <87y7hctf6o.fsf@hubert.paunchy.net>
	<20070719184418.GA22463@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbVI-0003kO-Sn
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933921AbXGSTRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934117AbXGSTRL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:17:11 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:60553 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933856AbXGSTRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:17:09 -0400
X-Greylist: delayed 2506 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2007 15:17:09 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6JJH5iE008653;
	Thu, 19 Jul 2007 12:17:05 -0700
Received: from localhost (adsl-75-26-187-235.dsl.scrm01.sbcglobal.net [75.26.187.235])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6JJH4dm023831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Jul 2007 12:17:04 -0700
Received: by localhost (Postfix, from userid 1000)
	id 438641E8009; Thu, 19 Jul 2007 12:17:01 -0700 (PDT)
In-Reply-To: <20070719184418.GA22463@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Thu\, 19 Jul 2007 14\:44\:18 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53021>

When a branch name has a slash and autotagging is enabled, guilt barfs
when updating the stack tags.  Make these branch names work.

Also allow guilt to create the patches directory for these branches.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

>
> Why mangle the branch name when we can do:
>
> mkdir -p `basename $GIT_DIR/refs/tags/${branch}_top`
> git-rev-parse .... 
>
> Sure, it is ugly, but it preserves the branch name. Am I missing something?
>

Yours is a lot less ugly than mine was.

 guilt      |    1 +
 guilt-init |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/guilt b/guilt
index 214def4..c913bd6 100755
--- a/guilt
+++ b/guilt
@@ -338,6 +338,7 @@ update_stack_tags()
 		# there are patches applied, therefore we must get the top,
 		# bottom and base hashes, and update the tags
 
+		mkdir -p `dirname $GIT_DIR/refs/tags/${branch}_top`
 		git-rev-parse HEAD > "$GIT_DIR/refs/tags/${branch}_top"
 		head -1 < $applied | cut -d: -f1 > "$GIT_DIR/refs/tags/${branch}_bottom"
 		git-rev-parse $(head -1 < $applied | cut -d: -f1)^ > "$GIT_DIR/refs/tags/${branch}_base"
diff --git a/guilt-init b/guilt-init
index ffe2434..9136f89 100755
--- a/guilt-init
+++ b/guilt-init
@@ -24,7 +24,7 @@ if [ -d "$GUILT_DIR/$branch" ]; then
 fi
 
 [ ! -d "$GUILT_DIR" ] && mkdir $GUILT_DIR
-mkdir $GUILT_DIR/$branch
+mkdir -p $GUILT_DIR/$branch
 touch $GUILT_DIR/$branch/series
 touch $GUILT_DIR/$branch/status
 
-- 
1.5.2
