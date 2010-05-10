From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 8/8] merge: --log appends shortlog to message if specified
Date: Tue, 11 May 2010 01:17:52 +0800
Message-ID: <1273511872-4924-9-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWd1-0007lB-IS
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab0EJRSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63452 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0EJRSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:32 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1771315pwi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cwLBBJvanSECXNJgo4l3roL2X8POtqT8QdDpv3Pcv/Y=;
        b=lBiZpYcI3dK8vWDS37qFoYKRTfUum0hxn5ckwsYcHPleQUiZOfZQts3+t/phe6bzSy
         AiG3q5z8kvSIxw/LBBxT80JpEXkI0VLHeCbtreRALN7XxEsEIbbiaktfFAeWFtpBxKDl
         KGER8dzJK36Ved3CDwPTxarfZDJdC6cPXYo1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JC5H5YGn3qsY8EXBSak8ADWWeyNiWhXHDSHtgSVp7GWlBLUPasY3zeLlvYKi7b79Jf
         WUasruBLI7d0Rt/EpkgFIMX9iTZcw+bHLTWm8jQLwQdktuwgtYXduc+VshKeK/ZErBEg
         v3foneoZsMAOLjW8pQbbFaEOMNQxcwJSa3y+E=
Received: by 10.115.64.16 with SMTP id r16mr184475wak.163.1273511912609;
        Mon, 10 May 2010 10:18:32 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146834>

When the user specifies a message, use fmt_merge_msg_shortlog() to
append the shortlog.

Previously, when a message was specified, we ignored the merge title
("Merge <foo> into <bar>") and shortlog from fmt_merge_msg().

Update the documentation for -m to reflect this too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-merge.txt     |    7 ++++++-
 builtin/fmt-merge-msg.c         |    3 +++
 builtin/merge.c                 |   18 +++++++++++-------
 t/t7604-merge-custom-message.sh |    2 +-
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c2325ef..84043cc 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -58,7 +58,12 @@ include::merge-options.txt[]
 
 -m <msg>::
 	Set the commit message to be used for the merge commit (in
-	case one is created). The 'git fmt-merge-msg' command can be
+	case one is created).
+
+	If `--log` is specified, a shortlog of the commits being merged
+	will be appended to the specified message.
+
+	The 'git fmt-merge-msg' command can be
 	used to give a good default for automated 'git merge'
 	invocations.
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 48548cf..4420425 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -298,6 +298,9 @@ static int do_fmt_merge_msg(int merge_title, int merge_summary,
 		rev.ignore_merges = 1;
 		rev.limited = 1;
 
+		if (suffixcmp(out->buf, "\n"))
+			strbuf_addch(out, '\n');
+
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string, origins.items[i].util,
 					head, &rev, limit, out);
diff --git a/builtin/merge.c b/builtin/merge.c
index bc7e5e7..37ce4f5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -990,18 +990,22 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		/*
 		 * All the rest are the commits being merged;
 		 * prepare the standard merge summary message to
-		 * used as the merge message.  If remote
+		 * be appended to the given message.  If remote
 		 * is invalid we will die later in the common
 		 * codepath so we discard the error in this
 		 * loop.
 		 */
-		if (!have_message) {
-			for (i = 0; i < argc; i++)
-				merge_name(argv[i], &merge_names);
+		for (i = 0; i < argc; i++)
+			merge_name(argv[i], &merge_names);
+
+		if (have_message && option_log)
+			fmt_merge_msg_shortlog(&merge_names, &merge_msg);
+		else if (!have_message)
 			fmt_merge_msg(option_log, &merge_names, &merge_msg);
-			if (merge_msg.len)
-				strbuf_setlen(&merge_msg, merge_msg.len-1);
-		}
+
+
+		if (!(have_message && !option_log) && merge_msg.len)
+			strbuf_setlen(&merge_msg, merge_msg.len-1);
 	}
 
 	if (head_invalid || !argc)
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index af53df1..9114785 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -40,7 +40,7 @@ test_expect_success 'merge c2 with a custom message' '
 	test_cmp exp.subject actual
 '
 
-test_expect_failure 'merge --log appends to custom message' '
+test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
 	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
-- 
1.7.1.189.g07419
