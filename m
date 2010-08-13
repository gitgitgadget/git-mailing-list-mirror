From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 2/2] pull --rebase: Avoid spurious conflicts and reapplying unnecessary patches
Date: Thu, 12 Aug 2010 19:50:50 -0600
Message-ID: <1281664250-2703-3-git-send-email-newren@gmail.com>
References: <1281664250-2703-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, santi@agolina.net,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 03:43:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjjIV-0002iP-Lj
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204Ab0HMBmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 21:42:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60742 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083Ab0HMBmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 21:42:50 -0400
Received: by mail-yx0-f174.google.com with SMTP id 6so697684yxg.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2eyIlqNDr0lPTV1PTS5rjDF5B1NwGxZqb6cG4xwh8tg=;
        b=nO02aJ/4fj6kXQbb3alca/7k4JFa2RFGdfFs25j5XzagFaUjB9nZF1OiIT5znZr0gO
         6DGdTGl4EhCoUGhEJudV1QCiK2k03wCNJwgPg6sGwcLNrDD0ljKAy7+H3ju++vAGClk4
         zYXQ0i92IbwWO24UDGkRbk0jus3nA/8SAwhPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PXPbNLwxLunYORAeNQg1yYPUaj6FnHXFrjevGr0KUz08gn8XeFRy70LUcv1RzbZgnW
         f02zbF+bBlFgH5DvT7fOZqO7YUYlgBQocCg/70Xb/HY92j3SvPePIWgD0+GGIlhQOhA4
         PBrbfc3RKUksYgC2EsQDQDzVs+8Hm3tssXD5k=
Received: by 10.231.146.136 with SMTP id h8mr1006032ibv.0.1281663769473;
        Thu, 12 Aug 2010 18:42:49 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id j2sm607195iba.12.2010.08.12.18.42.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 18:42:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.43.gbae63
In-Reply-To: <1281664250-2703-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153454>

Prior to c85c792 (pull --rebase: be cleverer with rebased upstream
branches, 2008-01-26), pull --rebase would run
  git rebase $merge_head
which resulted in a call to
  git format-patch ... --ignore-if-in-upstream $merge_head..$cur_branch

This resulted in patches from $merge_head..$cur_branch being applied, a=
s
long as they did not already exist in $cur_branch..$merge_head.
Unfortunately, when upstream is rebased, $merge_head..$cur_branch also
refers to "old" commits that have already been rebased upstream, meanin=
g
that many patches that were already fixed upstream would be reapplied.
This could result in many spurious conflicts, as well as reintroduce
patches that were intentionally dropped upstream.

So the algorithm was changed in c85c792 (pull --rebase: be cleverer wit=
h
rebased upstream branches, 2008-01-26) and d44e712 (pull: support rebas=
ed
upstream + fetch + pull --rebase, 2009-07-19).  Defining $old_remote_re=
f to
be the most recent entry in the reflog for @{upstream} that is an ances=
tor
of $cur_branch, pull --rebase was changed to run
  git rebase --onto $merge_head $old_remote_ref
which results in a call to
  git format-patch ... --ignore-if-in-upstream $old_remote_ref..$cur_br=
anch

The whole point of this change was to reduce the number of commits bein=
g
reapplied, by avoiding commits that upstream already has or had.

In the rebased upstream case, this change achieved that purpose.  It is
worth noting, though, that since $old_remote_ref is always an ancestor =
of
$cur_branch (by its definition), format-patch will not know what upstre=
am
is and thus will not be able to determine if any patches are already
upstream; they will all be reapplied.

In the non-rebased upstream case, this new form is usually the same as =
the
original code but in some cases $old_remote_ref can be an ancestor of
   $(git merge-base $merge_head $cur_branch)
meaning that instead of avoiding reapplying commits that upstream alrea=
dy
has, it actually includes more such commits.  Combined with the fact th=
at
format-patch can no longer detect commits that are already upstream (si=
nce
it is no longer told what upstream is), results in lots of confusion fo=
r
users (e.g. "git is giving me lots of conflicts in stuff I didn't even
change since my last push.")

Cases where additional commits could be reapplied include forking from =
a
commit other than the tracking branch, or amending/rebasing after pushi=
ng.
Cases where the inability to detect upstreamed commits cause problems
include independent discovery of a fix and having your patches get
upstreamed by some alternative route (e.g. pulling your changes to a th=
ird
machine, pushing from there, and then going back to your original machi=
ne
and trying to pull --rebase).

=46ix the non-rebased upstream case by ignoring $old_remote_ref wheneve=
r it
is contained in $(git merge-base $merge_head $cur_branch).  This should
have no affect on the rebased upstream case.

Acked-by: Santi B=C3=A9jar <santi@agolina.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-pull.sh     |    9 +++++++++
 t/t5520-pull.sh |    4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index a09a44e..8eb74d4 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -273,6 +273,15 @@ then
 	exit
 fi
=20
+if test true =3D "$rebase"
+then
+	o=3D$(git show-branch --merge-base $curr_branch $merge_head $oldremot=
eref)
+	if test "$oldremoteref" =3D "$o"
+	then
+		unset oldremoteref
+	fi
+fi
+
 merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || e=
xit
 case "$rebase" in
 true)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 85a6b23..0b489f5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -186,7 +186,7 @@ test_expect_success 'setup for detecting upstreamed=
 changes' '
 	)
 '
=20
-test_expect_failure 'git pull --rebase detects upstreamed changes' '
+test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
 	 test -z "$(git ls-files -u)"
@@ -215,7 +215,7 @@ test_expect_success 'setup for avoiding reapplying =
old patches' '
 	)
 '
=20
-test_expect_failure 'git pull --rebase does not reapply old patches' '
+test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
 	 test 1 =3D $(find .git/rebase-apply -name "000*" | wc -l)
--=20
1.7.2.1.43.gbae63
