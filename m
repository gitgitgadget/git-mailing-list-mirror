From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] reset: accept "git reset HEAD <path>" from unborn branch
Date: Tue, 19 Oct 2010 17:14:15 -0500
Message-ID: <20101019221415.GG32029@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 20 00:18:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8KVY-0007pE-Eq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab0JSWR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:17:58 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61838 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0JSWRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:17:55 -0400
Received: by qwa26 with SMTP id 26so1672256qwa.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vJSbuGs0WExbWDK63rIoUSj2dvne6WqkTKhFwXfRWts=;
        b=laifrWIAoG7p6mEaUf1Pqaoh7uEWqAofpKouEZgjtyFOQBqklfV5S8anD6IUU3t+hw
         2ZOmdZUElNl/ycMghocA6t5tkUYvziUNxdrSFYHfR4XAuEvO12FS7YMW22385cRPfV5s
         ba1xEq8KFWMeiL/ow88zIRr5L7DCA2MItYxRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cuD+NvUObHDyHgQerVGEQBHk6mJN70T96oyEBdd0EC2RV0oH4V5wx0kd/WeTpbzzXC
         mZpriqCoy7LFUjLud4Uh0rr2q/ZB58WxRmyChopRZ3wkO+jhKEWivObpdeJ3PDtC/3Z1
         NpXOWuhlI4I9jNpph2PVOr/BJtZltSwXJhIyg=
Received: by 10.224.137.204 with SMTP id x12mr4016602qat.73.1287526675197;
        Tue, 19 Oct 2010 15:17:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm12647078qck.37.2010.10.19.15.17.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 15:17:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019221005.GC32029@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159374>

If I try:

	... hack hack hack ...
	git add .
	rm <path1>; # bad file!
	git reset <path1>

git will respond by informing me that this use of <path1> is
ambiguous.  So I might try to disambiguate:

	git reset HEAD <path1>

This works when HEAD represents a branch, but not in the 'new
repository' ('branch yet to be born') case.

Even in the unborn branch case, it is clear what the operator meant
to do (namely, remove the entry for <path1>), so do that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reset.c         |    5 ++---
 t/t7106-reset-unborn.sh |    5 ++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index ff57764..d9a5702 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -236,12 +236,11 @@ static void die_if_unmerged_cache(int reset_type)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int unborn_branch = 0;
 	int patch_mode = 0;
-	const char *implicit_HEAD = "HEAD";
-	const char *rev = implicit_HEAD;
+	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
 	char *reflog_action, msg[1024];
 	const struct option options[] = {
@@ -305,11 +304,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type != NONE)
 			die("--patch is incompatible with --{hard,mixed,soft}");
 		return interactive_reset(rev, argv + i, prefix);
 	}
 
-	if (rev == implicit_HEAD) {
+	if (!strcmp(rev, "HEAD")) {
 		/* We may be on a branch yet to be born. */
 		resolve_ref("HEAD", sha1, 0, NULL);
 		if (is_null_sha1(sha1)) {
 			unborn_branch = 1;
 			hashcpy(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN);
diff --git a/t/t7106-reset-unborn.sh b/t/t7106-reset-unborn.sh
index 7baaffd..c03f309 100755
--- a/t/t7106-reset-unborn.sh
+++ b/t/t7106-reset-unborn.sh
@@ -37,11 +37,14 @@ test_expect_success 'reset absent file' '
 	git reset -- file &&
 	index_is_empty
 '
 
 test_expect_success 'reset HEAD <files> from unborn branch' '
-	test_must_fail git reset HEAD -- .
+	echo one >file &&
+	git add file &&
+	git reset HEAD -- . &&
+	index_is_empty
 '
 
 test_expect_success 'reset HEAD from unborn branch' '
 	test_must_fail git reset HEAD &&
 	test_must_fail git reset HEAD --
-- 
1.7.2.3
