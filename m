From: Jing Xue <jingxue@digizenstudio.com>
Subject: [PATCH] Replace the cryptic messages from "git stash show".
Date: Sat, 15 Dec 2007 00:14:25 -0500
Message-ID: <20071215051425.GA9118@fawkes>
References: <20071214012838.GA8914@fawkes> <7vir32xdn3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 06:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3PMd-0004if-1s
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 06:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbXLOFOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 00:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbXLOFOj
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 00:14:39 -0500
Received: from k2smtpout05-02.prod.mesa1.secureserver.net ([64.202.189.57]:38186
	"HELO k2smtpout05-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbXLOFOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 00:14:38 -0500
Received: (qmail 30935 invoked from network); 15 Dec 2007 05:14:38 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-02.prod.mesa1.secureserver.net (64.202.189.57) with ESMTP; 15 Dec 2007 05:14:37 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id E0501100B60;
	Sat, 15 Dec 2007 05:14:37 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8F+jlWXgQrE; Sat, 15 Dec 2007 00:14:27 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 44091100A10;
	Sat, 15 Dec 2007 00:14:27 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id E45DA9ACFB; Sat, 15 Dec 2007 00:14:25 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vir32xdn3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68374>

On Thu, Dec 13, 2007 at 05:34:40PM -0800, Junio C Hamano wrote:
> 
> I agree "git stash show" should not give cryptic error message, but I
> think you should do this only when the user did not explicitly say which
> stash to show (that is, we should still give error message if the user
> said "git stash show garbage").

Good point. Actually I found out that if there _are_ some stashes and an
invalid name is given, the current behavior is still printing
refs/stash, which I think is not quite right. So I also try to fix that
while I'm at it.

Now "git stash show" will keep quiet and just exit if there are no
stashes at all. "git stash show some-non-existent-stash" will always
print a clear message indicating the case.

---
 git-stash.sh |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..40e93dd 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -116,13 +116,30 @@ show_stash () {
 	flags=$(git rev-parse --no-revs --flags "$@")
 	if test -z "$flags"
 	then
-		flags=--stat
+		diff_flags=--stat
+	else
+		diff_flags=$flags
+	fi
+	s=$(git rev-parse --revs-only --no-flags "$@")
+	if test -z "$s"
+	then
+		arguments=$@
+		if test "${flags}" = "${arguments}"
+		then
+			s=$(git rev-parse --revs-only --no-flags $ref_stash)
+			if test -z "$s"
+			then
+				return 0
+			fi
+		else
+			eval stash_name=\$$#
+			die "Can't find any stash with name $stash_name"
+		fi
 	fi
-	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@")
 
 	w_commit=$(git rev-parse --verify "$s") &&
 	b_commit=$(git rev-parse --verify "$s^") &&
-	git diff $flags $b_commit $w_commit
+	git diff $diff_flags $b_commit $w_commit
 }
 
 apply_stash () {
-- 
1.5.4.rc0.8.gd381b
