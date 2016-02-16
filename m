From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 4/4] remote: use remote_is_configured() for add and rename
Date: Tue, 16 Feb 2016 10:47:52 +0100
Message-ID: <1455616072-20838-5-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Cc: sunshine@sunshineco.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:47:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcEb-0005m3-4Q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbcBPJrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:47:45 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36012 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbcBPJrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:47:40 -0500
Received: by mail-wm0-f51.google.com with SMTP id g62so96982483wme.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jN6R0Sgu6vqMbi730+fEa/hJ4Lv55N8x5D8vzCmg0Uw=;
        b=Cg5/DqpRvsGq59G4Hx3UxiocOF+e9Fn07cRrcuuYZish8MVrtFWDf1tHanEGvFt7So
         rNxpqTKKQVi421bjB8zo6SKX+NrNiZwHVL+OqpDXQ0yvyarBusXC9KY7GpM/0Ddc1E1H
         qWJJ2poKwb+xSEqg3ymtVf4FI+myDRqgeH89j85UCf0ObshZV0ECgWG+TiiyHy2d0USx
         5i8A/CwAqVTdnUqgPI8AD62MnELF4umyGZ6BCQMuXxo2sT+/nkJVQusxJPxISJPxWUev
         0eP54o9PIDkUQqdFYlrhIPUoVxC/gAIeo1B3mI/W3PQ6gXPlofEi8xDB5AzrJyPbfo95
         xjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jN6R0Sgu6vqMbi730+fEa/hJ4Lv55N8x5D8vzCmg0Uw=;
        b=EXtcQjiQ1iAJF+0BcBAb/HAkNsG0bEclQa5ZFpO9XJiH6XxBXQTs7H69mZcUQr5Z6C
         HW79+UTyslIR7FvyufFvAv09n32zlHdddZTgwm0XA+ALEK8qM0cleHvnt4uS44aXXTBC
         0bDel32/LW8m7xXDqSv966Zm0J1wuOI/AmPa1DSRkfptwsuVasM5NH321dAfr6HnOqix
         LJHyZpzqeSs2IZqphk8FLvVaLMoGNAif4hBP1hGx9VxyVkYay9aq2JieoN+hdsIVQ2Vd
         m9z2LpSFakdchtwT3I3GZD8STSKIJ4vO9Ad64qhHKmF2oHMXMLnyh6eAhasFyiyFB8MF
         uqTA==
X-Gm-Message-State: AG10YOQS/mZ7UKgeIzsHi42jyocOL3G6Ur0qToTZ26OKe8KImaIyWJxElAy7/BqMre/jxA==
X-Received: by 10.194.92.147 with SMTP id cm19mr24456711wjb.32.1455616059496;
        Tue, 16 Feb 2016 01:47:39 -0800 (PST)
Received: from localhost (host161-107-dynamic.2-87-r.retail.telecomitalia.it. [87.2.107.161])
        by smtp.gmail.com with ESMTPSA id ka7sm29240586wjb.8.2016.02.16.01.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 01:47:38 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286335>

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
 t/t5505-remote.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

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
index f1d073f..94079a0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -157,6 +157,21 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'add existing foreign_vcs remote' '
+	test_config remote.foo.vcs bar &&
+	echo "fatal: remote foo already exists." >expect &&
+	test_must_fail git remote add foo bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'add existing foreign_vcs remote' '
+	test_config remote.foo.vcs bar &&
+	test_config remote.bar.vcs bar &&
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
