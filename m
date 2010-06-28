From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Add test for correct coloring of git log --decoration
Date: Mon, 28 Jun 2010 15:30:40 +0800
Message-ID: <1277710240-11378-1-git-send-email-ayiehere@gmail.com>
References: <7v6314fd6q.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 09:31:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT8o0-0005ia-9r
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 09:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab0F1Haz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 03:30:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56477 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab0F1Hay (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 03:30:54 -0400
Received: by pvg2 with SMTP id 2so1773955pvg.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gJoznPNXldT08k1Kin5bWp1fK98Y9h6bhprIDdwiNsY=;
        b=dII/yyFxhOilrw4l0DZZhlP0mkVVZ4iFetDddwAXpSbx5Rp8tugMfOUMMXfhuzUcV5
         HozUoO/Sk1vCUIO9Pfct+qdrbNITZ43fI2GLRccYn97FSSU99WgaSVtsnku2p1bn0moC
         iYELit9tbaiUmu/7GxZto/mLwDBGiyavnCTFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wqgOkm5K8J88wNcVgyN26gav2sshj5ab0RFTorbue8ndePKHmOXpI3us70jMHUYkXG
         3Kjfx70U6pVL7rtZ9JpWcQbZp1KccPmt3gOSheB/KFJtQLddokDGjUTA69EpLCiHgi+5
         0MyEZBbu6zLR1+ova+OVaIARp+td0YYJLVjHg=
Received: by 10.115.65.34 with SMTP id s34mr4805968wak.224.1277710254328;
        Mon, 28 Jun 2010 00:30:54 -0700 (PDT)
Received: from localhost.localdomain ([115.134.69.17])
        by mx.google.com with ESMTPS id d39sm43163447wam.4.2010.06.28.00.30.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 00:30:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.363.gac4b1
In-Reply-To: <7v6314fd6q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149818>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
On Mon, Jun 28, 2010 at 4:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ar/decorate-color (2010-06-24) 4 commits
>  - Allow customizable commit decorations colors
>  - log --decorate: Colorize commit decorations
>  - log-tree.c: Use struct name_decoration's type for classifying decoration
>  - commit.h: add 'type' to struct name_decoration
> 
> Tests, perhaps?  Otherwise looked sane.

Here is a proposed test for checking if the decorations are colored correctly.
It should be applied on top of 5e11bee65f601ba97dc4c61c75fcb2f448fdcb1c in pu.

I've tried adding 

	log --decorate --all --oneline --color=always

to t4013-diff-various.sh but it seems a bit out of place because my test only
test for colors, while no other test in that file test for colors, hence the
new test file (t4207-log-decoration-colors.sh).

nazri

 t/t4207-log-decoration-colors.sh |   70 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100755 t/t4207-log-decoration-colors.sh

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
new file mode 100755
index 0000000..260e71f
--- /dev/null
+++ b/t/t4207-log-decoration-colors.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Nazri Ramliy
+#
+
+test_description='Test for "git log --decorate" colors
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+  echo foo > foo.txt &&
+  git add foo.txt &&
+  test_tick &&
+  git commit -m first &&
+
+  echo bar > bar.txt &&
+  git add bar.txt &&
+  test_tick &&
+  git commit -m second &&
+
+  test_tick &&
+  EDITOR=cat git tag v1.0 &&
+
+  git clone . local_clone &&
+
+  cd local_clone &&
+  git config diff.color.commit yellow &&
+  git config color.decorate.branch green &&
+  git config color.decorate.remoteBranch red &&
+  git config color.decorate.tag yellow &&
+  git config color.decorate.stash magenta &&
+  git config color.decorate.HEAD cyan &&
+
+  echo baz >> foo.txt &&
+  git stash save baz
+'
+
+get_color()
+{
+  git config --get-color no.such.slot "$1"
+}
+
+# Colors
+c_reset=$(get_color reset)
+c_commit=$(get_color yellow)
+c_branch=$(get_color green)
+c_remoteBranch=$(get_color red)
+c_tag=$(get_color yellow)
+c_stash=$(get_color magenta)
+c_HEAD=$(get_color cyan)
+
+cat > expected << EOF
+${c_commit}COMMIT_ID (${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On master: baz
+${c_commit}COMMIT_ID (${c_HEAD}HEAD${c_reset}${c_commit},\
+ ${c_tag}tag: v1.0${c_reset}${c_commit},\
+ ${c_remoteBranch}origin/master${c_reset}${c_commit},\
+ ${c_remoteBranch}origin/HEAD${c_reset}${c_commit},\
+ ${c_branch}master${c_reset}${c_commit})${c_reset} second
+${c_commit}COMMIT_ID${c_reset} first
+EOF
+
+# We want log to show all, but the second parent to refs/stash is irrelevant
+# to this test since it does not contain any decoration, hence --first-parent
+test_expect_success 'Commit Decorations Colored Correctly' '
+  git log --first-parent --abbrev=10 --all --decorate --oneline --color=always |sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" > out &&
+  test_cmp expected out
+'
+
+test_done
-- 
1.7.1.245.g7c42e.dirty
