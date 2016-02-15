From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 4/4] remote: use remote_is_configured() for add and rename
Date: Mon, 15 Feb 2016 18:42:30 +0100
Message-ID: <1455558150-30267-5-git-send-email-t.gummerer@gmail.com>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 18:43:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNBm-0001ZW-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbcBORnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:43:53 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34718 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcBORnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:43:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id b205so9443429wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqw4rGAGkeryYypoBV509s+vzrLqAICJis3rKV5HWRY=;
        b=fgQE3dQq/SHtMoITq7xuG/7YtQI49oqteqNtswa9yq2TsGIZwRf8SNZBkJOdWm9K+k
         hgq7ypood4DFs/feHkvmi6nN4djn5r8/NhF18Xc9G8VO4VKCotKvdH5gSMJd7VQ8odta
         wQDWFzeMb+M+eX16a43+MFv3yfoQrFxIp2d0SLWujPB8jfWSsC2Gj1TA8mC40fhmJbDu
         Da3z/LTX60rdbewVYHVGfzdZAE/M0IL3qDiu0M/p5z8GSTKDpEMoBlimYSnq1VkWZ4ES
         KZcZk6KMPOP4LeyPxxy7J5mSnGmbPkA6np/0yUo3yqyBbed//ZJMyr8mU7SrzXdXWsdp
         YQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqw4rGAGkeryYypoBV509s+vzrLqAICJis3rKV5HWRY=;
        b=Ut/rrVMSkJJPDbRHiQg6PK3xiEDOQ4fwh1A9TqNDRjBv1cqHCXlLXMxlBJcRTrBqqb
         hTAnGUqk9sUwdfT8g4vmkcKebsKz3ELg9skqMG8sA+WBWU2qZ1VdNw+F1drGPzKlOSjO
         2agLxkX4tysqbspaDtMfWieOezfK6zRh6k7MomjIbNTOgMN7ruXcXFu/mhsQLaJlFwI8
         yoNbib681IT/j+L7OKodPgfPx89GB0gbosPDqh343qa+MA5GOJfxfRGyInR3nwjVJJEc
         tQydPHjbG85fS86R3wf23F2IJojwR6ZfdTylSSLpczTyHhvDchD/bAo7hXrnRnIRsYa7
         71DQ==
X-Gm-Message-State: AG10YOS6vDsCSaSsXXcXWltQLBQDK1EeJnby+Jtki4zW/J8AfH/m/2jXZ0XojfzztANp0A==
X-Received: by 10.194.71.135 with SMTP id v7mr8229085wju.135.1455558226867;
        Mon, 15 Feb 2016 09:43:46 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id p125sm16203469wmd.16.2016.02.15.09.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 09:43:45 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286218>

Both remote add and remote rename use a slightly different hand-rolled
check if the remote exits.  The hand-rolled check may have some subtle
cases in which it might fail to detect when a remote already exists.
One such case was fixed in fb86e32 ("git remote: allow adding remotes
agreeing with url.<...>.insteadOf").  Another case is when a remote is
configured as follows:

  [remote "foo"]
    vcs = bar

If we try to run `git remote add foo bar` with the above remote
configuration, git segfaults.  This change fixes it.

In addition, git remote rename $existing foo with the configuration for
foo as above silently succeeds, even though foo already exists,
modifying its configuration.  With this patch it fails with "remote foo
already exists".

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/remote.c  |  7 ++-----
 t/t5505-remote.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 981c487..bd57f1b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -186,10 +186,7 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote && (remote->url_nr > 1 ||
-			(strcmp(name, remote->url[0]) &&
-				strcmp(url, remote->url[0])) ||
-			remote->fetch_refspec_nr))
+	if (remote_is_configured(remote))
 		die(_("remote %s already exists."), name);
 
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
@@ -641,7 +638,7 @@ static int mv(int argc, const char **argv)
 		return migrate_file(oldremote);
 
 	newremote = remote_get(rename.new);
-	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
+	if (remote_is_configured(newremote))
 		die(_("remote %s already exists."), rename.new);
 
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f1d073f..142ae62 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -157,6 +157,24 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'add existing foreign_vcs remote' '
+	git config --add remote.foo.vcs "bar" &&
+	test_when_finished git remote rm foo &&
+	echo "fatal: remote foo already exists." >expect &&
+	test_must_fail git remote add foo bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'add existing foreign_vcs remote' '
+	git config --add remote.foo.vcs "bar" &&
+	git config --add remote.bar.vcs "bar" &&
+	test_when_finished git remote rm foo &&
+	test_when_finished git remote rm bar &&
+	echo "fatal: remote bar already exists." >expect &&
+	test_must_fail git remote rename foo bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.7.1.410.g6faf27b
