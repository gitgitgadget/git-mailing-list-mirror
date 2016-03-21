From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] commit: do not lose SQUASH_MSG contents
Date: Mon, 21 Mar 2016 23:29:40 +0100
Message-ID: <56F075D4.2020002@cs-ware.de>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
 <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
 <xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
 <xmqqziu7h01f.fsf@gitster.mtv.corp.google.com> <56E5B3F9.6070404@cs-ware.de>
 <xmqqpouwapnd.fsf@gitster.mtv.corp.google.com>
 <xmqq4mc8ak3n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:29:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai8Kg-0003ow-UC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 23:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbcCUW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 18:29:51 -0400
Received: from srv1.79p.de ([213.239.234.118]:59591 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbcCUW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 18:29:50 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f28:2600:70c2:8792:8700:c30d] (p200300886F28260070C287928700C30D.dip0.t-ipconnect.de [IPv6:2003:88:6f28:2600:70c2:8792:8700:c30d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id D1236224477;
	Mon, 21 Mar 2016 23:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1458599387;
	bh=CDU8egH7FP5Rt+PJmHIzfj5xQPZcaSZMRkSbbfbrNFA=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To;
	b=RxDI3alfemaJBQ4Svf5YWjaoPi2X40IScZpix7HDOPgaeRfpreuM9ip4e06nC75Vs
	 cUy5rajtYyiEQZKW4UgmvFmUSE7RX+tPxiYdiLHil6PrmJ1+RiRWPmMX1STYqWk7Oj
	 +rdbWrWRadM1akHnW3qdAY8DfKU6xMH708zy0+7YsTxF30xXB2Hyb29LViTJdf2tpp
	 a7ioti95+rQ3IGk+m0fQYldlV5FXqhaYtNE61HI0LKxC8R+EjFaWbhInAulT/A15GR
	 tPc2/ixrZ1Bx8MVhqWdfUAupM2GgiNctL7i7BuvDEC/iPycPFFWuVnmDObeh7KW0OH
	 coxWCIjFwlSkg==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqq4mc8ak3n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289472>

When concluding a conflicted "git merge --squash", the command
failed to read SQUASH_MSG that was prepared by "git merge", and
showed only the "# Conflicts:" list of conflicted paths.

Place the contents from SQUASH_MSG at the beginning, just like we
show the commit log skeleton first when concluding a normal merge,
and then show the "# Conflicts:" list, to help the user write the
log message for the resulting commit.

Test by Junio C Hamano <gitster@pobox.com>.

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
---
 builtin/commit.c | 11 ++++++++++-
 t/t7600-merge.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..d40b788 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -726,9 +726,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				      &sb, &ctx);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(), &statbuf)) {
+		/*
+		 * prepend SQUASH_MSG here if it exists and a
+		 * "merge --squash" was originally performed
+		*/
+		if (!stat(git_path_squash_msg(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+				die_errno(_("could not read SQUASH_MSG"));
+			hook_arg1 = "squash";
+		} else
+			hook_arg1 = "merge";
 		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
-		hook_arg1 = "merge";
 	} else if (!stat(git_path_squash_msg(), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 302e238..ba35e00 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -33,9 +33,11 @@ printf '%s\n' 1 2 3 4 5 6 7 8 9 >file
 printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >file.1
 printf '%s\n' 1 2 3 4 '5 X' 6 7 8 9 >file.5
 printf '%s\n' 1 2 3 4 5 6 7 8 '9 X' >file.9
+printf '%s\n' 1 2 3 4 5 6 7 8 '9 Y' >file.9y
 printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >result.1
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
+printf '%s\n' 1 2 3 4 5 6 7 8 '9 Z' >result.9z
 >empty
 
 create_merge_msgs () {
@@ -128,6 +130,12 @@ test_expect_success 'setup' '
 	git tag c2 &&
 	c2=$(git rev-parse HEAD) &&
 	git reset --hard "$c0" &&
+	cp file.9y file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 7" &&
+	git tag c7 &&
+	git reset --hard "$c0" &&
 	cp file.9 file &&
 	git add file &&
 	test_tick &&
@@ -218,6 +226,26 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
+test_expect_success 'merge --squash c3 with c7' '
+	git reset --hard c3 &&
+	test_must_fail git merge --squash c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	{
+		cat <<-EOF
+		Squashed commit of the following:
+
+		$(git show -s c7)
+
+		# Conflicts:
+		#	file
+		EOF
+	} >expect &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	test_cmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.7.4.windows.1
