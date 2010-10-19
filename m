From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] reset: accept "git reset -- <path>" from unborn branch
Date: Tue, 19 Oct 2010 17:13:31 -0500
Message-ID: <20101019221331.GF32029@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
 <20101019182845.GE25139@burratino>
 <7vhbgiyoo9.fsf@alter.siamese.dyndns.org>
 <20101019221005.GC32029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 00:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8KUf-0007dQ-IG
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab0JSWRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:17:12 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62275 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab0JSWRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:17:11 -0400
Received: by qyk9 with SMTP id 9so889851qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aX9B6jTFej9ZUz9/KvvDjX4t6VJmoZkTFhqADI0qJEc=;
        b=jIPAn6es+E1uyLQwsDVOIuaWaetdYviuIMbzFfGz1aO2FFNUBNxp7/AvHLcBLAALAn
         Gr2bkGUK65JIHCXhEtIrfIPaVyAGrWZLGwtVdL7fmAng00Vetw3AqSaFombv5oXfi+qn
         QeZQgHuqvwrIGDcS+csM6+iDFzOUOu6+5pyUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JNgxtPszXqZDPl868NShvtiAm/CBa7lneDVxqJRpOdNr4FtVkJT9J78ckVsGXJD2Vf
         kJxHe0I8Q7J22TRPR9nReAAl3DKyaS2VriFr8zv3IW6T8fpwxS0oZMIeJJ3LUv/EjIoU
         ZpE7tvkPhnAg3jO65iHILm82v7tWIOQnXrelM=
Received: by 10.229.96.17 with SMTP id f17mr5681684qcn.142.1287526630809;
        Tue, 19 Oct 2010 15:17:10 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n7sm9346366qcu.40.2010.10.19.15.17.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 15:17:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019221005.GC32029@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159373>

A common workflow:

	git checkout <branch>
	... hack hack hack ...
	git add -- <path1> <path2>
	git reset -- <path1>; # oops, that one isn't ready yet
	git commit

One might try to use 'git reset' to undo the effect of 'git add' on an
unborn branch, too, but it doesn't work:

	... hack hack hack ...
	$ git add -- <path1> <path2>
	$ git reset -- <path1>
	fatal: Failed to resolve 'HEAD' as a valid ref.

It is obvious that the operator meant to remove the entry for <path1>,
so just do that.

This patch only affects the "git reset <path>" syntax; explicit
use of "git reset HEAD <path>" will still error out.

Suggested-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reset.c         |   15 ++++++++++++-
 t/t7106-reset-unborn.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100755 t/t7106-reset-unborn.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 2375472..ff57764 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -234,12 +234,14 @@ static void die_if_unmerged_cache(int reset_type)
 }
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int unborn_branch = 0;
 	int patch_mode = 0;
-	const char *rev = "HEAD";
+	const char *implicit_HEAD = "HEAD";
+	const char *rev = implicit_HEAD;
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
 	char *reflog_action, msg[1024];
 	const struct option options[] = {
@@ -303,11 +305,18 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type != NONE)
 			die("--patch is incompatible with --{hard,mixed,soft}");
 		return interactive_reset(rev, argv + i, prefix);
 	}
 
-	if (get_sha1(rev, sha1))
+	if (rev == implicit_HEAD) {
+		/* We may be on a branch yet to be born. */
+		resolve_ref("HEAD", sha1, 0, NULL);
+		if (is_null_sha1(sha1)) {
+			unborn_branch = 1;
+			hashcpy(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN);
+		}
+	} else if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
 
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
@@ -319,10 +328,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 					reset_type_names[reset_type]);
 		return read_from_tree(prefix, argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 
+	if (unborn_branch)
+		die("Failed to resolve 'HEAD' as a valid ref.");
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		die("Could not parse object '%s'.", rev);
 	hashcpy(sha1, commit->object.sha1);
 
diff --git a/t/t7106-reset-unborn.sh b/t/t7106-reset-unborn.sh
new file mode 100755
index 0000000..7baaffd
--- /dev/null
+++ b/t/t7106-reset-unborn.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='git reset from a branch yet to be born'
+. ./test-lib.sh
+
+>empty
+
+index_is_empty () {
+	git ls-files >actual &&
+	test_cmp empty actual
+}
+
+test_expect_success 'reset to remove file' '
+	echo one >file &&
+	git add file &&
+	git reset file &&
+	index_is_empty
+'
+
+test_expect_success 'reset after rm to remove file' '
+	echo one >file &&
+	git add file &&
+	rm file &&
+	git reset -- file &&
+	index_is_empty
+'
+
+test_expect_success 'reset file that does not match index' '
+	echo one >file &&
+	git add file &&
+	echo two >file &&
+	git reset -- file &&
+	index_is_empty
+'
+
+test_expect_success 'reset absent file' '
+	git reset -- file &&
+	index_is_empty
+'
+
+test_expect_success 'reset HEAD <files> from unborn branch' '
+	test_must_fail git reset HEAD -- .
+'
+
+test_expect_success 'reset HEAD from unborn branch' '
+	test_must_fail git reset HEAD &&
+	test_must_fail git reset HEAD --
+'
+
+test_done
-- 
1.7.2.3
