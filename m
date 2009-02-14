From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sat, 14 Feb 2009 01:39:29 -0800
Message-ID: <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 10:41:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYH1D-00047Q-CO
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbZBNJjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZBNJjg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:39:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZBNJjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:39:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 29B772B1A6;
	Sat, 14 Feb 2009 04:39:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 321E62B1A5; Sat,
 14 Feb 2009 04:39:31 -0500 (EST)
In-Reply-To: <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 13 Feb 2009 23:21:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6319F100-FA7B-11DD-A7DE-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109852>

1.6.2 will have @{-1} syntax advertised as "usable anywhere you can use
a branch name".  However, "git merge @{-1}" did not work.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I know "show-branch @{-1} HEAD" does not dereference @{-1}, but I
   suspect there may be many others.

 builtin-merge.c     |   15 ++++++++++++---
 t/t0100-previous.sh |   23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 885fad9..6d2160d 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -356,9 +356,14 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	struct object *remote_head;
 	unsigned char branch_head[20], buf_sha[20];
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf bname = STRBUF_INIT;
 	const char *ptr;
 	int len, early;
 
+	len = strlen(remote);
+	if (interpret_nth_last_branch(remote, &bname) == len)
+		remote = bname.buf;
+
 	memset(branch_head, 0, sizeof(branch_head));
 	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
 	if (!remote_head)
@@ -371,7 +376,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!hashcmp(remote_head->sha1, branch_head)) {
 		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 			sha1_to_hex(branch_head), remote);
-		return;
+		goto cleanup;
 	}
 
 	/* See if remote matches <name>^^^.. or <name>~<number> */
@@ -411,7 +416,8 @@ static void merge_name(const char *remote, struct strbuf *msg)
 				    sha1_to_hex(remote_head->sha1),
 				    truname.buf + 11,
 				    (early ? " (early part)" : ""));
-			return;
+			strbuf_release(&truname);
+			goto cleanup;
 		}
 	}
 
@@ -432,10 +438,13 @@ static void merge_name(const char *remote, struct strbuf *msg)
 			strbuf_remove(&line, ptr-line.buf+1, 13);
 		strbuf_addbuf(msg, &line);
 		strbuf_release(&line);
-		return;
+		goto cleanup;
 	}
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
 		sha1_to_hex(remote_head->sha1), remote);
+cleanup:
+	strbuf_release(&buf);
+	strbuf_release(&bname);
 }
 
 static int git_merge_config(const char *k, const char *v, void *cb)
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index db51b42..315b9b3 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -22,5 +22,28 @@ test_expect_success 'branch -d @{-12} when there is not enough switches yet' '
 	git rev-parse --verify refs/heads/master
 '
 
+test_expect_success 'merge @{-1}' '
+	git checkout A &&
+	test_commit B &&
+	git checkout A &&
+	test_commit C &&
+	git branch -f master B &&
+	git branch -f other &&
+	git checkout other &&
+	git checkout master &&
+	git merge @{-1} &&
+	git cat-file commit HEAD | grep "Merge branch '\''other'\''"
+'
+
+test_expect_success 'merge @{-1} when there is not enough switches yet' '
+	git reflog expire --expire=now &&
+	git checkout -f master &&
+	git reset --hard B &&
+	git branch -f other C &&
+	git checkout other &&
+	git checkout master &&
+	test_must_fail git merge @{-12}
+'
+
 test_done
 
-- 
1.6.2.rc0.80.ge11dd
