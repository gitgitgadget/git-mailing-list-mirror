From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] git add: notice removal of tracked paths by default
Date: Tue, 19 Apr 2011 12:18:20 -0700
Message-ID: <7v1v0y59tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCGRY-0003y2-GN
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 21:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab1DSTSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 15:18:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab1DSTSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 15:18:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31FFD5296;
	Tue, 19 Apr 2011 15:20:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	WWflOKmagAOIRn3bxDBZq6ivuA=; b=pU6QW4HtiTBPLRcEYrcnVJmx5Jfk3JKLg
	F+qguCmNPDySmtarROK0W77ZqRZW/qDMslENfDipnxkHHZQ1c7btyQ4dDzheaMWY
	zR+zy76nYkRQut9E7DHxp1p/3aToBiO1F2QeCAcnzIXTbnok31zPqNUVh5o9Mk8T
	JIDxY2sqf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=q0F
	do+QWAGVYnjpTXzZJKYTxX2KMG4CNsJpxmkUv28PJidbEe0VFOdrCdW2ftJF9+1Y
	PCKsZgdXwZqnGz37R6pIG0JHxozSB5sDeaxCmFXzXER+K7YuXKkTnnlbRP82kISQ
	REfDuWSsqIcRRhaJ2qWBoHPC+DVCzI9J37a84Eqc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FEF85295;
	Tue, 19 Apr 2011 15:20:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 592CE5294; Tue, 19 Apr 2011
 15:20:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13D88E24-6ABA-11E0-9E9F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171811>

When run without "-u" or "-A" option,

    $ edit subdir/x
    $ create subdir/y
    $ rm subdir/z
    $ git add subdir/

does not notice removal of paths (e.g. subdir/z) from the working tree.
Make "git add" to pretend as if "-A" is given when there is a pathspec on
the command line.  "git add" without any argument continues to be a no-op.

When resolving a conflict to remove a path, the current code tells you to
"git rm $path", but now with this patch you can say "git add $path".  Of
course you can do "git add -A $path" without this patch.

In either case, the operation "git add" is about "adding the state of the
path in the working tree to the index".  The state may happen to be "path
removed", not "path has an updated content".

The semantic change can be seen by a breakage in t2200, test #15.  There,
a merge has conflicts in path4 (which is removed from the working tree),
and test checks "git add path4" to resolve it must fail, and makes sure
that the user must use "git rm path4" for that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This might not be such a good idea, and I do not have a strong opinion
 for this change, but merely a weatherbaloon.

 Having "git add ." notice removals might lead to mistakes ("oh, I only
 meant to record additions, and didn't want to record the removals"), but
 at the same time, leaving it not notice removals would lead to mistakes
 by the other people ("I added, removed and edited different paths, but
 why only removals are ignored?").

---
 builtin/add.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d39a6ab..0f534e3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -386,6 +386,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
+	/* default "git add pathspec..." to "git add -A pathspec..." */
+	if (!take_worktree_changes && argc)
+		addremove = 1;
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 	if ((addremove || take_worktree_changes) && !argc) {
-- 
1.7.5.rc3
