From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 7/9] stash: teach git stash show to always tolerate stash-like arguments.
Date: Tue, 10 Aug 2010 10:04:46 +1000
Message-ID: <1281398688-21008-8-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicMm-0001dO-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab0HJAGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45353 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371Ab0HJAGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:42 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so974893pvg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KptlrtsXaZL1QPfaYFovxUpcmtPhpFfRs2Up3dgT9V4=;
        b=EjveYUkWvr6VezxME25Yhgz3+OesG/Y0oYV7zyDU1I4UoNnvp+yFabiBFYAQ04vt+F
         4lEVrQC5xHxWFmNrmjMAhPeDki620oJh5T1LVwLBjnautafi/vxbzAiPjw0wNuABLtL8
         tdGnT6i6ixkyaNQBD3Nz0sbnpdkMUc4KWzr7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t2nN10ZJfbQLbt4Mhj6T7LGCZHXNrwDGRhC4cyQxBoU6bTk5+UDtZx4+yUb3AIR3x+
         GR2DEwZOd1xwnYT03qJUp0Du6tS1ZkhJg1dd50vQSBd49miWivlU+DRJrAzPLEX3KGTo
         Z9uxpF4WKWkeN0V7yoE1zuDlPWFFf6Z5xkAUA=
Received: by 10.142.238.20 with SMTP id l20mr11470172wfh.268.1281398801660;
        Mon, 09 Aug 2010 17:06:41 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153063>

Previously, git stash show would accept stash-like arguments, but
only if there was a stash on the stack.

Now, git stash accepts stash-like arguments always and only fails
if no stash-like argument is specified and there is no stash stack.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 97e3749..5b875ea 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -210,14 +210,19 @@ list_stash () {
 }
 
 show_stash () {
-	have_stash || die 'No stash found'
-
 	flags=$(git rev-parse --no-revs --flags "$@")
 	if test -z "$flags"
 	then
 		flags=--stat
 	fi
 
+	revs=$(git rev-parse --revs-only "$@")
+	if test -z "$revs"
+	then
+		have_stash || die "No stash found"
+		set -- ${ref_stash}@{0}
+	fi
+
 	assert_stash_like "$@"
 
 	git diff $flags $b_commit $w_commit
-- 
1.6.5.rc3.8.g8ba5e
