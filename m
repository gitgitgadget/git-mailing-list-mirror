From: Jeff King <peff@peff.net>
Subject: Re: Bug: 'git am --abort' can silently reset the wrong branch
Date: Fri, 8 May 2009 04:28:26 -0400
Message-ID: <20090508082826.GA29737@coredump.intra.peff.net>
References: <20090506191945.GG6325@blackpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eduardo Habkost <ehabkost@raisama.net>
X-From: git-owner@vger.kernel.org Fri May 08 10:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LRc-0002uQ-UZ
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198AbZEHI22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbZEHI21
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:28:27 -0400
Received: from peff.net ([208.65.91.99]:49610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454AbZEHI2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:28:25 -0400
Received: (qmail 17046 invoked by uid 107); 8 May 2009 08:28:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 May 2009 04:28:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2009 04:28:26 -0400
Content-Disposition: inline
In-Reply-To: <20090506191945.GG6325@blackpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118586>

On Wed, May 06, 2009 at 04:19:46PM -0300, Eduardo Habkost wrote:

> I've ben bitten by this multiple times, while maintaining a multi-branch
> repository. 'git am --abort' can drop the whole history of a branch, if you
> switch branches before running it. Below are the steps to reproduce the
> problem:

Yeah, it would be nice if there was a safety valve here to cause "git am
--abort" to realize that you had switched branches out from under it and
not bother with resetting HEAD (but it should still blow away
.git/rebase-apply).

Below is a patch which accomplishes that. However, I'm not sure it is
the right direction. Switching branches and clobbering some other branch
with --abort is just _one_ thing you can do to screw yourself. You could
also have been doing useful work on the _same_ branch, and that would
get clobbered by --abort.  However, I'm not sure if we have a good way
of telling the difference between "work which I did to try to get these
patches to apply, but which should be thrown away when I abort" and
"work which I did because I forgot I had an active git-am".

So maybe just picking the changed-branch situation is the best we can
do. I'd be interested to hear comments from others.

This patch works for git-am; we would also need to do something similar
for rebase.

-- >8 --
am: try not to clobber alternate branches on --abort

A user in the middle of a failed git-am may forget that they
are there and begin doing other work. They may later realize
that the "am" session is still active (when trying to rebase
or apply another patch), at which point they are tempted to
"git am --abort". However, this resets their HEAD back to
ORIG_HEAD, clobbering any work they have done in the
meantime.

This patch detects the situation where the branch has
changed and skips the reset step (which assumes the user has
the tree in a state they like now).

---
diff --git a/git-am.sh b/git-am.sh
index 6d1848b..4d5f408 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -244,10 +244,13 @@ then
 			exec git rebase --abort
 		fi
 		git rerere clear
-		test -f "$dotest/dirtyindex" || {
+		if ! test -f "$dotest/dirtyindex" &&
+		     test "`git symbolic-ref -q HEAD`" = \
+		          "`cat "$dotest/start-ref"`"
+		then
 			git read-tree --reset -u HEAD ORIG_HEAD
 			git reset ORIG_HEAD
-		}
+		fi
 		rm -fr "$dotest"
 		exit ;;
 	esac
@@ -304,6 +307,7 @@ else
 			git update-ref -d ORIG_HEAD >/dev/null 2>&1
 		fi
 	fi
+	git symbolic-ref -q HEAD >"$dotest/start-ref"
 fi
 
 case "$resolved" in
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 2b912d7..8e62e76 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -62,4 +62,19 @@ do
 
 done
 
+test_expect_success 'am --abort does not clobber changed branch' '
+	rm -f otherfile-* &&
+	git checkout -b other &&
+	echo content >unrelated &&
+	git add unrelated &&
+	git commit -m other &&
+	git rev-parse other >expect &&
+	git checkout master &&
+	test_must_fail git am 000[1245]-*.patch &&
+	git checkout other &&
+	git am --abort &&
+	git rev-parse other >actual &&
+	test_cmp expect actual
+'
+
 test_done
