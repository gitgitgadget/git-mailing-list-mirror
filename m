From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon,  7 May 2012 11:09:47 +0200
Message-ID: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 11:09:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRJx6-0004TY-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab2EGJJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 05:09:52 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47588 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab2EGJJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:09:51 -0400
Received: by werb10 with SMTP id b10so1111279wer.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=PK+DaT4Qq04fg5RYD1bAzhv9oRlEHP3l/QY8n2dMPaI=;
        b=j3HMr04VvQyA7Gd7oe4BSsPTZ7ZS66vNAlv7ghkUsXZIbw3p2Wcq3XizXo0Pz+akf2
         L5SM+Pz/VUeq8eaGjowRUh24lutChm4fCoKxyU/9YkM4hTw6MU9jj4aEtONNaSFagT+E
         b/5i9HgBxa9bsiMGchFb4DmcZr2g4DqsuhVcuwgVWYtQomdRQqE1QV/swkyMLjoDEUOj
         9bKPwVCqcC3sV3W5MS6JpLUg1pTkra/k/ieeyyd20odOGB29qIYzf17qi3Gird1wD5v7
         kBTwRy3WNzMpPXDHJzuL5YxZYm2FpHPlZHd3iBSiY2KvwJ/+f6PCwXb9hQMK+m6FF+Un
         NZsQ==
Received: by 10.180.24.7 with SMTP id q7mr32861543wif.11.1336381790434;
        Mon, 07 May 2012 02:09:50 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id h8sm32122982wix.4.2012.05.07.02.09.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 02:09:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197244>

When cloning a large repository over a local file-system, git
can use hard-links to the old repository files, making the
repository-cloning very fast. However, git also perform an
implicit checkout of the files, which can be a lengthy
operation.

Inform the user about this, and move the logic to notify the
user that we are done until we actually are.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I just tried to clone a very large (proprietary) repository over
a local filesystyem, and the output struck me as confusing:

---8<---
$ git clone some-repo.git some-other-repo
Cloning into 'some-other-repo'...    <happens instantly>
done.                                <hangs for minutes>
$
---8<---

Now, seems to be because repo gets hard-linked, so the cloning
part did not actually take much time. However, we perform a
check-out at the end, and this does take time for my large repo.
So the behavior probably makes sense from a git-internals point
of view.

But from an end-user point of view, it's confusing. I asked git
to clone, and it told me it finished, only to hang around for
several minutes while, judging by the output, doing nothing.

So, perhaps it could make sense to do something along these lines?

This gives me this output instead:

---8<---
$ git clone some-repo.git some-other-repo
Cloning into 'some-repo'...    <happens instantly>
Checking out HEAD...           <hangs for minutes>
done.
$
---8<---

...which seems much more informative to me.

 builtin/clone.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd5c96..3f863a1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -368,9 +368,6 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
-
-	if (0 <= option_verbosity)
-		printf(_("done.\n"));
 }
 
 static const char *junk_work_tree;
@@ -544,6 +541,9 @@ static int checkout(void)
 	if (option_no_checkout)
 		return 0;
 
+	if (0 <= option_verbosity)
+		printf(_("Checking out HEAD...\n"));
+
 	head = resolve_refdup("HEAD", sha1, 1, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
@@ -870,5 +870,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	strbuf_release(&value);
 	junk_pid = 0;
+
+	if (is_local && 0 <= option_verbosity)
+		printf(_("done.\n"));
+
 	return err;
 }
-- 
1.7.10.1.457.g8275905
