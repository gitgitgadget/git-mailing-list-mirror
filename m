From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] reset: accept "git reset <tree> <path>"
Date: Tue, 19 Oct 2010 17:12:44 -0500
Message-ID: <20101019221244.GE32029@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 20 00:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8KTw-0007Tn-5j
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab0JSWQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:16:27 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54028 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab0JSWQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:16:26 -0400
Received: by qyk9 with SMTP id 9so889142qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dLLUhzWiKH1PFTFEwqDMPxBWN7AGYfvDe0Jw0+fgelI=;
        b=MeLbXWIwwtNcvBbpTGu+v0a9xBdh3OevifP3uoRth5GefZZC4r8COJ31arRvcZcCDC
         KXv1F04SuJ4RpDnWbRosktd+ns+LEo4AW7JO8Gqds6+ptBf8sdRpHbj+P9A9pFEp5qrB
         ljXjTKcgIdgBvxXOwU+ckP6UR5MzejIt7axAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=upKY2M8J0C43eWqeQ3ESU8k42vBThMmUraFSKHS8FgBvk5fiAtqRR84UqT2MAGTme+
         5dKcOj6+fOfjspCx7HCv4bGBbQWen/3/yUoNTZ0W/hXnW7wRQvl/OkqKxLdM57Yn3suC
         hOhB2CJcqzYx69AcdPVT3tgdxwXNLBNwdGqZo=
Received: by 10.229.223.210 with SMTP id il18mr5690324qcb.133.1287526583667;
        Tue, 19 Oct 2010 15:16:23 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm13587020qcb.27.2010.10.19.15.16.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 15:16:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019221005.GC32029@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159372>

The <rev> argument in

	git reset --hard <rev>
	git reset --soft <rev>

needs to be a commit to be sensible.  But in

	git reset <rev> -- <path> <path> ...

using other trees can be useful.

For example, to apply changes from a branch that has the current
branch merged as a subtree:

	git reset master:gitk-git -- .

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reset.c  |   11 ++++++-----
 t/t7102-reset.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index a52e6f8..2375472 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -306,15 +306,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	}
 
 	if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
 
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		die("Could not parse object '%s'.", rev);
-	hashcpy(sha1, commit->object.sha1);
-
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
 	if (i < argc) {
 		if (reset_type == MIXED)
@@ -323,10 +318,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
 		return read_from_tree(prefix, argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
+
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		die("Could not parse object '%s'.", rev);
+	hashcpy(sha1, commit->object.sha1);
+
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
 	if (reset_type != SOFT && reset_type != MIXED)
 		setup_work_tree();
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b8cf260..3e95da3 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -7,10 +7,18 @@ test_description='git reset
 
 Documented tests for git reset'
 
 . ./test-lib.sh
 
+test_exit_code () {
+	echo $1 >expect.code &&
+	shift &&
+	"$@"
+	echo $? >actual.code &&
+	test_cmp expect.code actual.code
+}
+
 test_expect_success 'creating initial files and commits' '
 	test_tick &&
 	echo "1st file" >first &&
 	git add first &&
 	git commit -m "create 1st file" &&
@@ -409,17 +417,40 @@ test_expect_success 'test resetting the index at give paths' '
 	test_must_fail git diff-index --cached --exit-code "$T" &&
 	test "$T" != "$U"
 
 '
 
+test_expect_success 'reset modified path from tree' '
+	echo hello >other &&
+	git reset --hard &&
+	git add other &&
+	T=$(git write-tree) &&
+	git rm -f other &&
+	test_exit_code 1 git reset $T other &&
+	git diff-index --cached --exit-code "$T"
+'
+
+test_expect_success 'try to reset from blob' '
+	git reset --hard &&
+	B=$(git rev-parse --verify HEAD:file1) &&
+	test_exit_code 128 git reset $B -- .
+'
+
 test_expect_success 'resetting an unmodified path is a no-op' '
 	git reset --hard &&
 	git reset -- file1 &&
 	git diff-files --exit-code &&
 	git diff-index --cached --exit-code HEAD
 '
 
+test_expect_success 'reset unmodified path from tree' '
+	git reset --hard &&
+	git reset HEAD^{tree} -- file1 &&
+	git diff-files --exit-code &&
+	git diff-index --cached --exit-code HEAD
+'
+
 cat > expect << EOF
 Unstaged changes after reset:
 M	file2
 EOF
 
-- 
1.7.2.3
