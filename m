From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 2/2] repack: Remove stale .keep files before repacking
Date: Fri, 01 Apr 2011 03:34:27 +0200
Message-ID: <201104010334.28048.johan@herland.net>
References: <201103311246.25645.johan@herland.net>
 <20110331190429.GC16981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 03:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5TG5-0001u4-CT
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab1DABef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 21:34:35 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58145 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1DABee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:34:34 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIY00I7V9PKFT20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 01 Apr 2011 03:34:32 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B59911EEEE27_D952BA8B	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 01:34:32 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A2CFF1EEED24_D952BA5F	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 01:34:29 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIY00IYA9PHKJ20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 01 Apr 2011 03:34:29 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110331190429.GC16981@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170546>

When a push is aborted, receive-pack sometimes leave stale .keep files in the
objects/pack/ directory. Fortunately, these files are easily identified by
looking at their contents, which is of the form:

  receive-pack $pid on $host

By recognizing this format we can determine whether the .keep file is stale,
and can be safely deleted: If the $host part matches the current hostname,
and there is currently no process with $pid, we can safely assume that the
.keep file no longer refers to a running receive-pack process, and deleting
it should be perfectly safe.
---

On Thursday 31 March 2011, Jeff King wrote:
> On Thu, Mar 31, 2011 at 12:46:25PM +0200, Johan Herland wrote:
> > 3. Do I need to scan for and remove stale .keep files in a cron job
> > 
> >    in order to keep repos healthy and clonable?
> 
> If we fix (1), then hopefully it is not as much of an issue. But
> probably "git gc" should clean up stale ones after a while.

This patch tries to automatically remove stale .keep files. However,
it's still work-in-progress, as I don't know how to portably (a) ask
for the current hostname (so that I can compare it to the one in the
.keep file), or (b) test for whether a given PID is running on the
system (to determine whether the receive-pack process that wrote the
.keep file is still alive).

Feedback appreciated.


...Johan


 git-repack.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 624feec..f59e4c4 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -56,6 +56,18 @@ PACKTMP="$PACKDIR/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
+HOST=`hostname || echo "localhost"` # FIXME: Portability?
+for e in `cd "$PACKDIR" && find . -type f -name '*.keep' | sed -e 's/^\.\///'`
+do
+	cat "$PACKDIR/$e" | if read word pid on host
+	then
+		test "$word" = "receive-pack" -a "$on" = "on" -a "$host" = "$HOST" || continue
+		ps -p "$pid" > /dev/null && continue # FIXME: Portability?
+		rm -f "$PACKDIR/$e"
+		say Removed stale keep file $PACKDIR/$e.
+	fi
+done
+
 # There will be more repacking strategies to come...
 case ",$all_into_one," in
 ,,)
-- 
1.7.4
