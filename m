From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] rebase: Squelch the "fatal: Not an error." message
Date: Tue, 23 Mar 2010 17:03:05 -0700
Message-ID: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/mixed; boundary=Apple-Mail-15--975990616
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 01:03:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuE4g-0007WH-Jt
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 01:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab0CXADt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 20:03:49 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:42487 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab0CXADs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 20:03:48 -0400
Received: from randymail-a11.g.dreamhost.com (caiajhbdcbbj.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 0973217B463
	for <git@vger.kernel.org>; Tue, 23 Mar 2010 17:03:48 -0700 (PDT)
Received: from [192.168.1.17] (173-13-153-133-sfba.hfc.comcastbusiness.net [173.13.153.133])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id BC24C109E8B
	for <git@vger.kernel.org>; Tue, 23 Mar 2010 17:03:07 -0700 (PDT)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143059>


--Apple-Mail-15--975990616
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

When `git rebase --onto newbase upstream` is executed with
upstream being equal to the current commit, `git rebase` will
call `git format-patch` with "upstream..upstream" as the commits
to generate patches for. This causes a spurious error message to
be thrown which should be squelched.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
This patch was inspired by a common error encountered when using `git =
pull --rebase`, particularly in the case where there are no local =
commits that need rebasing and the fetched head was a force-pushed =
history modification (e.g. from git filter-branch). The error itself is =
actually caused by running `git rebase --onto newbase upstream` where =
upstream is the same commit as HEAD. This causes `git format-patch` to =
be called with "upstream..upstream" as the range and it complains. My =
solution was to squelch all errors from `git format-patch`, though I am =
unsure if the "fatal: Not a range." error is the only error that can be =
raised in this situation.

git-rebase.sh |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)


--Apple-Mail-15--975990616
Content-Disposition: attachment;
	filename=0001-rebase-Squelch-the-fatal-Not-an-error.-message.patch
Content-Type: text/x-patch;
	name="0001-rebase-Squelch-the-fatal-Not-an-error.-message.patch"
Content-Transfer-Encoding: 7bit

diff --git a/git-rebase.sh b/git-rebase.sh
index e0eb956..8868dee 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -544,7 +544,7 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		$root_flag "$revisions" |
+		$root_flag "$revisions" 2>/dev/null |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?

--Apple-Mail-15--975990616--
