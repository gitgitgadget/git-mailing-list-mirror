From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 05/12] cherry-pick: remember rerere-autoupdate
Date: Wed, 23 Apr 2014 21:44:44 -0500
Message-ID: <1398307491-21314-6-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pH-0007ef-DF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbaDXCzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:46 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:33071 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaDXCzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:36 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so2014045oag.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ut+NwqtdUdtP9Pd3GxmPx9tSa3urr9mR1g22hG6Wtck=;
        b=jmYKpkds0Ha3ouCtKO5FQbArXoEnLcZVKbOLMhrdzHd4cMXIkFRgH1lSPSpudf1ePo
         xMSGIBRIePYunl/QUVdSbnykHqxkhD3oOFmgwxWO+7k44iSSNaq63y4GNkFbK9ey0OJc
         bwUnA0fMTC7VrxTDlD84z919XVoZF/lLWmOEQBvQcq1hpj1gJGf03AYowMHbos53mjIG
         PyryMF9TyPrnTp2VNUqNd9MY7MTv96IWxIEVgIgEEScnQ5WxZASsbZrpCpx8A0ttvXbn
         0hDTF+7SwInU4FGr2/8LdUMSeNmSNxgh7VXdAw0oWiv9Z/aMmPO1HaGiga/NOeNxFQ2K
         ZXFg==
X-Received: by 10.60.155.35 with SMTP id vt3mr46144233oeb.32.1398308135871;
        Wed, 23 Apr 2014 19:55:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm11817553oeb.10.2014.04.23.19.55.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246920>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c                   | 10 +++++++++-
 t/t3504-cherry-pick-rerere.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index c01ad08..a258627 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -820,7 +820,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
-	} else
+	} else if (!strcmp(key, "options.allow-rerere-auto"))
+		opts->allow_rerere_auto = git_config_int(key, value);
+	else
 		return error(_("Invalid key: %s"), key);
 
 	if (!error_flag)
@@ -997,6 +999,12 @@ static void save_opts(struct replay_opts *opts)
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	if (opts->allow_rerere_auto) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%d", opts->allow_rerere_auto);
+		git_config_set_in_file(opts_file, "options.allow-rerere-auto", buf.buf);
+		strbuf_release(&buf);
+	}
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index e6a6481..274b2cc 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -42,4 +42,43 @@ test_expect_success 'cherry-pick conflict without rerere' '
 	test_must_fail test_cmp expect foo
 '
 
+test_expect_success 'cherry-pick --rerere-autoupdate' '
+	test_when_finished "rm -rf rerere" &&
+	(
+	git init rerere &&
+	cd rerere &&
+	test_config rerere.enabled true &&
+	echo one > content-a && git add content-a &&
+	echo one > content-b && git add content-b &&
+	git commit -m one &&
+	git checkout -b conflict master &&
+	echo conflict-a > content-a &&
+	git commit -a -m conflict-a &&
+	echo conflict-b > content-b &&
+	git commit -a -m conflict-b &&
+	git checkout master &&
+	echo two > content-a &&
+	echo two > content-b &&
+	git commit -a -m two &&
+	git checkout -b test &&
+	test_must_fail git cherry-pick master..conflict &&
+	echo resolved-a > content-a &&
+	git add content-a &&
+	test_must_fail git cherry-pick --continue &&
+	echo resolved-b > content-b &&
+	git add content-b &&
+	git cherry-pick --continue &&
+	git reset --hard master
+	git log --oneline --all --decorate --graph &&
+	test_must_fail git cherry-pick --rerere-autoupdate master..conflict &&
+	git log --oneline --all --decorate --graph &&
+	echo resolved-a > expected &&
+	test_cmp expected content-a
+	test_must_fail git cherry-pick --continue &&
+	echo resolved-b > expected &&
+	test_cmp expected content-b &&
+	git cherry-pick --continue
+	)
+'
+
 test_done
-- 
1.9.2+fc1.2.gfbaae8c
