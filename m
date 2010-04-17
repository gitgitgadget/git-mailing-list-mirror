From: Clemens Buchacher <drizzd@aon.at>
Subject: [RFC/PATCH] blind rebase --onto
Date: Sat, 17 Apr 2010 20:44:33 +0200
Message-ID: <20100417184433.GA14864@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 17 20:45:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3D0p-0007pq-DI
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 20:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab0DQSoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 14:44:55 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:42413 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0DQSoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 14:44:54 -0400
Received: by bwz25 with SMTP id 25so4171623bwz.28
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=0TSqrkoXoz+L3AdXUqE7X4zAestcdVlYAaqbOX1eE9I=;
        b=JwPtYzw7/e0EPG10uBsepX6W69FH3jWmAXbnYrdSZy5d3XLWjFnUvVHIlGTaXGtBdE
         VhLh3S5RWaxn0Utway3JcYNvhPzNByA2lnJpP57B/1gzBaeB/v8L2gkEGxeHRglxjeSR
         Do1TOYCMPJ/EuLuEhnfnGOra7odOCGt54nnWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=WoL9qsDOd7brq+2FXT/GYwSwjyQA8neQoPz0E7wPnRjeQbGEncYTCTQ2tn+VGgUUM6
         WpkNskUKI7hiZWMV+f4ILySnCKwImXdZSODOvpDKgIiX/EmHtAHekHJQ4m2VJiv2UbBl
         KvkfLcUuYP7HSY3/Ic1FjmFFnuqRUhjOB/Yt0=
Received: by 10.103.64.13 with SMTP id r13mr2106097muk.135.1271529892325;
        Sat, 17 Apr 2010 11:44:52 -0700 (PDT)
Received: from darc.lan (p549A7BC9.dip.t-dialin.net [84.154.123.201])
        by mx.google.com with ESMTPS id j6sm19881775mue.44.2010.04.17.11.44.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 11:44:52 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O3D0L-0003BU-Sj; Sat, 17 Apr 2010 20:44:33 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145169>

Hi,

I know that there have been several discussions about rebase tracking in the
past and I admit that I was not following them too closely. So please feel
free to flame me if this idea is nothing new or even known to be bad. I
appreciate your comments and I will try to get up to speed on this topic as
soon as possible.

Clemens

--8<--
We start out with a history like this.

         G subtopic
        /
       E---F topic
      /
 A---B---C---D upstream

After rebasing topic to upstream, subtopic is still based on the old
history of topic.

         G subtopic
        /
       E       E'---F' topic
      /       /
 A---B---C---D upstream

If the changes introduced by E' differ from the ones introduced by E
in any way, rebase will try to re-apply E on top of F'. This is not
useful at all and will almost certainly result in needless conflicts.

This situation is described more verbosely in Section "RECOVERING FROM
UPSTREAM REBASE, The hard case" of the git-rebase(1) man page. The
suggested solution is to use as upstream the branch subtopic was
originally based on, i.e. in this case "rebase --onto topic
topic@{1}".

Since the "right" upstream to use could have been any other reflog
entry, this approach may require a significant amount of manual
digging through the reflog.

This patch introduces an algorithm to search the reflog automatically.
It searches the reflog for possible merge bases and chooses the one
with the "largest amount of common history".

In the example above, B is the merge base of subtopic and topic, but E
is the merge base of subtopic and topic@{1} and is a strict descendant
of B, which is why E has more common history with subtopic than B
does. Therefore, "rebase --onto topic" does the right thing in this
case, and it would still do the right thing if topic had been
rewritten multiple times in between.

Note 1: This patch requires some cleanup. The branch to be rebased
($branch) is evaluated only later in the code, which is why I am using
HEAD directly.

Note 2: The syntax should probably be something more noisy than
"rebase --onto <branch>", at least until this should prove to be
useful in many cases.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 git-rebase.sh |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..e1d4cbf 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -404,11 +404,38 @@ esac
 
 if test -z "$rebase_root"
 then
-	# The upstream head must be given.  Make sure it is valid.
-	upstream_name="$1"
-	shift
-	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-	die "invalid upstream $upstream_name"
+	if test $# -ge 1
+	then
+		# The upstream head must be given.  Make sure it is valid.
+		upstream_name="$1"
+		shift
+		upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+		die "invalid upstream $upstream_name"
+	else
+		test -n "$newbase" || usage
+		git rev-parse -q --verify "refs/heads/$newbase" >/dev/null ||
+		git rev-parse -q --verify "refs/remotes/$newbase" >/dev/null ||
+		die "not a branch: $newbase"
+		# Search newbase reflog for commit with the largest common
+		# history. In case of nonlinear history only the first branch
+		# found is followed while any parallel ones are discarded.
+		maxbase=
+		for tip in `git rev-list -g "$newbase"`
+		do
+			if base=$(git merge-base "$tip" HEAD) &&
+				(test -z "$maxbase" ||
+				(test -n "`git rev-list $maxbase..$base`" &&
+				 test -z "`git rev-list $base..$maxbase`"))
+			then
+				maxbase="$base"
+			fi
+		done
+		test -n "$maxbase" ||
+		die "Could not find a merge base for $newbase."
+		say "Using merge base $maxbase."
+		upstream_name="$maxbase"
+		upstream="$maxbase"
+	fi
 	unset root_flag
 	upstream_arg="$upstream_name"
 else
-- 
1.7.0.5.3.ga76e
