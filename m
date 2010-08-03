From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 2/3] stash: Allow git stash branch to process commits that look like stashes but are not stash references.
Date: Tue,  3 Aug 2010 20:36:14 +1000
Message-ID: <1280831775-30759-3-git-send-email-jon.seymour@gmail.com>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, jon.seymour@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 12:39:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgEth-0002y1-Os
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab0HCKiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 06:38:07 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:65290 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab0HCKiF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:38:05 -0400
Received: by pxi14 with SMTP id 14so1596418pxi.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5jhr/aKnLI+zzv6js4mWogVD/vRaG26a8xaOUeyD2yU=;
        b=jqn/zkWbGS1G8bw6GhXeHoivzOeOeWpLi/qUgr5G7oRcVZjkY8yWte035vOAJf1BjZ
         +bs3nwiO+4PomN0apAvn9OPMy/oCHPO52UVT/RU7xPkFLM7nbBTfFV4NjIRYGHgAPlIk
         hEXllQu19vaw4DhMBk2fqLLVk7HfzUR3liTf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FF8OCjmB7SpPtL3Ax7VZOo+Bckw51tvvIAaCHye8R0bmm7qQENIvdbN8airqID2V0m
         r7RMky0rCqCvytYM1Wu7o6V5mAF7aYzLv8i+TgZMQ08eKsqj8BLtJ0pNcUIsH6+2NSEn
         qmlCqywXl04dy+/UBHr0TWyGNvqReJdDOuAuk=
Received: by 10.114.111.13 with SMTP id j13mr8822229wac.123.1280831884414;
        Tue, 03 Aug 2010 03:38:04 -0700 (PDT)
Received: from localhost.localdomain (r220-101-137-36.cpe.unwired.net.au [220.101.137.36])
        by mx.google.com with ESMTPS id c24sm13374316wam.19.2010.08.03.03.38.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:38:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.111.g8fc90
In-Reply-To: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152503>

This patch allows git stash branch to work with stash-like commits created by git stash create.

Two changes were required:

* relax the pre-condition so that a stash stack is required if and only if a stash argument is not specified
* don't attempt to drop a stash argument that doesn't look like a stash reference.


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1d95447..432ddae 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -225,6 +225,12 @@ show_stash () {
 	git diff $flags $b_commit $w_commit
 }
 
+if_stash_ref() {
+	ref="$1"
+	shift
+	test "${ref#stash}" = "${ref}" -a "${ref#$ref_stash}" = "${ref}" || "$@"
+}
+
 apply_stash () {
 	applied_stash=
 	unstash_index=
@@ -359,20 +365,20 @@ drop_stash () {
 }
 
 apply_to_branch () {
-	have_stash || die 'Nothing to apply'
 
 	test -n "$1" || die 'No branch name specified'
 	branch=$1
 
 	if test -z "$2"
 	then
+		have_stash || die 'Nothing to apply'
 		set x "$ref_stash@{0}"
 	fi
 	stash=$2
 
 	git checkout -b $branch $stash^ &&
 	apply_stash --index $stash &&
-	drop_stash $stash
+	if_stash_ref "$stash" drop_stash "$stash"
 }
 
 # The default command is "save" if nothing but options are given
-- 
1.7.2.1.111.g8fc90
