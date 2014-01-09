From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: [PATCH v2 3/4] merge: make prepare_to_commit responsible for write_merge_state
Date: Thu,  9 Jan 2014 00:45:43 +0000
Message-ID: <1389228344-38813-4-git-send-email-ryan@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
 <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ryan Biesemeyer <ryan@yaauie.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 01:47:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W13mg-0007VR-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbaAIArj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:47:39 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40382 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097AbaAIAri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 19:47:38 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so2571960pad.31
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 16:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vj3JTxnw08GpYM50LibdEDyW3qL/p1UAjex3lqXHhcA=;
        b=D4Sz+5cHYf6dwAUkkQUQnsatX/LcDxL6HSt0hIpOELcbkuPwVIt2Khwzd9pL25JXkK
         YNwIoQVINUnzfBNTEUDu9Shi5gNd63FdZCZYk9aP9Auo56C6JRsBZa2AsHwpG+s3KhXT
         YYJs6FWQ9VogbCBrSa6TxCfuUZ5wc8o2wiIHfYkH4ZuT1VWZDUlMC5vNGCjTHsDY1eI+
         brWtvxyYc6ONsoVygn3/N5ldi3O8Npjh/KK4TIkt0YMo3rCd9LzQqJ+5grq0XlSnA1Wz
         /nlRAmZ2xP6PKYAUtYnup7mTXUyWIeFshwaZtvuL4VcjoBSDaIhuGuwWaC/+G5ucsWuG
         yfrQ==
X-Gm-Message-State: ALoCoQmC65aCoYMxJgphKG2nPeJEdwrkvHnka/KBWBwEKqkEp0SFVxgMK6f2yrujeWqg7Bj16tRf
X-Received: by 10.68.203.197 with SMTP id ks5mr295477pbc.14.1389228457609;
        Wed, 08 Jan 2014 16:47:37 -0800 (PST)
Received: from beorn.local.com ([69.164.175.238])
        by mx.google.com with ESMTPSA id xs1sm6854477pac.7.2014.01.08.16.47.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 16:47:36 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240237>

When merging, make the prepare-commit-msg hook have access to the merge
state in order to make decisions about the commit message it is preparing.

Since `abort_commit` is *only* called after `write_merge_state`, and a
successful commit *always* calls `drop_save` to clear the saved state, this
change effectively ensures that the merge state is also available to the
prepare-commit-msg hook and while the message is being edited.

Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
---
 builtin/merge.c                    |  3 ++-
 t/t7505-prepare-commit-msg-hook.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4941a6c..b7bfc9c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -802,7 +802,6 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 		error("%s", err_msg);
 	fprintf(stderr,
 		_("Not committing merge; use 'git commit' to complete the merge.\n"));
-	write_merge_state(remoteheads);
 	exit(1);
 }
 
@@ -816,6 +815,8 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
+
+	write_merge_state(remoteheads);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
 	if (0 < option_edit)
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 697ecc0..7ccf870 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -183,4 +183,25 @@ test_expect_success 'with failing hook (merge)' '
   )
 '
 
+test_expect_success 'should have MERGE_HEAD (merge)' '
+
+	git checkout -B other HEAD@{1} &&
+	echo "more" >> file &&
+	git add file &&
+	rm -f "$HOOK" &&
+	git commit -m other &&
+	git checkout - &&
+	write_script "$HOOK" <<-EOF &&
+	if [ -s "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
+		exit 0
+	else
+		exit 1
+	fi
+	EOF
+	git merge other &&
+	test "`git log -1 --pretty=format:%s`" = "Merge branch '"'"'other'"'"'" &&
+	test ! -s "$(git rev-parse --git-dir)/MERGE_HEAD"
+
+'
+
 test_done
-- 
1.8.5
