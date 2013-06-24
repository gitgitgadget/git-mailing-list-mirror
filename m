From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] config doc: rewrite push.default section
Date: Sun, 23 Jun 2013 21:33:04 -0700
Message-ID: <1372048388-16742-3-git-send-email-gitster@pobox.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyTj-0004hQ-VP
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab3FXEd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3FXEdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C9C1265A9
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=p0kp
	QimZmgMvLbx1+p7j9KSRvbo=; b=g2ovrG6Jpdyx1eInUAIOiufvo2is6lqdWowy
	h3eUky+OYAf0KpMGa/FOCk4x8HWmU1xkiXDbngeJ4xYt+1hDqXCZIlfNoGqmpiox
	AURKTZe/faVcv0hWe6qftIsrIA8PPjMdME3sTXsTxyTIUYVMS6DPf7wvgHaGXKlg
	k01NylM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vPxCgK
	I1hU2xch2gwWsWGELvpCdaWl0o6bqV74CSZ5fyqIExMdOWTbllzj4BXbmdojj0gL
	pQO1HJftQgoo0sPfBOQNHXb7ExGwqKMJPqk/iuIDSrnV7WJPDd0f0PrEhR3TmgVt
	CjHQUaDI4NLmu6ouz/xZ4V3B90n3KTbPKtsig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5041B265A8
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B80D1265A5
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:13 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2EC09B3C-DC87-11E2-AC06-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228774>

From: Ramkumar Ramachandra <artagnon@gmail.com>

4d35924e (Merge branch 'rr/triangle', 2013-04-07) introduced support
for triangular workflows, but the push.default values still assume
central workflows.

Rewrite the descriptions of `nothing`, `current`, `upstream` and
`matching` for greater clarity, and explicitly explain how they
should behave in triangular workflows.

Leave `simple` as it is for the moment, as we plan to change its
meaning to accommodate triangular workflows in a later patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 72 +++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fd4035..5d8ff1a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1826,39 +1826,55 @@ pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
 push.default::
-	Defines the action `git push` should take if no refspec is given
-	on the command line, no refspec is configured in the remote, and
-	no refspec is implied by any of the options given on the command
-	line. Possible values are:
+	Defines the action `git push` should take if no refspec is
+	explicitly given.  Different values are well-suited for
+	specific workflows; for instance, in a purely central workflow
+	(i.e. the fetch source is equal to the push destination),
+	`upstream` is probably what you want.  Possible values are:
 +
 --
-* `nothing` - do not push anything.
-* `matching` - push all branches having the same name in both ends.
-  This is for those who prepare all the branches into a publishable
-  shape and then push them out with a single command.  It is not
-  appropriate for pushing into a repository shared by multiple users,
-  since locally stalled branches will attempt a non-fast forward push
-  if other users updated the branch.
-  +
-  This is currently the default, but Git 2.0 will change the default
-  to `simple`.
-* `upstream` - push the current branch to its upstream branch
-  (`tracking` is a deprecated synonym for this).
-  With this, `git push` will update the same remote ref as the one which
-  is merged by `git pull`, making `push` and `pull` symmetrical.
-  See "branch.<name>.merge" for how to configure the upstream branch.
+
+* `nothing` - do not push anything (error out) unless a refspec is
+  explicitly given. This is primarily meant for people who want to
+  avoid mistakes by always being explicit.
+
+* `current` - push the current branch to update a branch with the same
+  name on the receiving end.  Works in both central and non-central
+  workflows.
+
+* `upstream` - push the current branch back to the branch whose
+  changes are usually integrated into the current branch (which is
+  called `@{upstream}`).  This mode only makes sense if you are
+  pushing to the same repository you would normally pull from
+  (i.e. central workflow).
+
 * `simple` - like `upstream`, but refuses to push if the upstream
   branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners. It will become the default
-  in Git 2.0.
-* `current` - push the current branch to a branch of the same name.
---
+  option and is well-suited for beginners.
 +
-The `simple`, `current` and `upstream` modes are for those who want to
-push out a single branch after finishing work, even when the other
-branches are not yet ready to be pushed out. If you are working with
-other people to push into the same shared repository, you would want
-to use one of these.
+This mode will become the default in Git 2.0.
+
+* `matching` - push all branches having the same name on both ends.
+  This makes the repository you are pushing to remember the set of
+  branches that will be pushed out (e.g. if you always push 'maint'
+  and 'master' there and no other branches, the repository you push
+  to will have these two branches, and your local 'maint' and
+  'master' will be pushed there).
++
+To use this mode effectively, you have to make sure _all_ the
+branches you would push out are ready to be pushed out before
+running 'git push', as the whole point of this mode is to allow you
+to push all of the branches in one go.  If you usually finish work
+on only one branch and push out the result, while other branches are
+unfinished, this mode is not for you.  Also this mode is not
+suitable for pushing into a shared central repository, as other
+people may add new branches there, or update the tip of existing
+branches outside your control.
++
+This is currently the default, but Git 2.0 will change the default
+to `simple`.
+
+--
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.8.3.1-721-g0a353d3
