From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Sat, 11 May 2013 18:21:14 +0200
Message-ID: <1368289280-30337-5-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYF-0007SE-KP
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab3EKQVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:36 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33650 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3EKQVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:33 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn3so1567999wib.16
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gqSbDF/aN5i/lJ/gB0QguxI7F4E5h/1UKEJ7/a5U2so=;
        b=Vd4gu0U+MzE6kUHpeI+zesmb7D8pfnXD0a1+wR7Tr7cYQ0yFiaYolGhYSz+j1wJ1bh
         3d7DF2S+YDkdohm7BWoddfOtsdMAccoXvx8zp5ZIw7bN5ouX23pD1+BhEhvCWaw8t+P8
         nnW1rKniuXpW8f0ev0NFd9zNV2JYgzyUF5V3Bk6Apmue9Kf30MWrxYJKV9aU7rTkCc5T
         s8WsvUFV2r2Bvosn7C8D5wIH1NL0JpCtHrdhvsdYG6oTl08jsVBqMcDQHD7UQcWi4bEE
         tva3XiFlsipvUfsvotlpHgU/VWDbSwCVDQZdnUuc1wjTbQIK5YPORbcz4yoE1utobkDz
         X5wg==
X-Received: by 10.194.92.197 with SMTP id co5mr30871310wjb.41.1368289292347;
        Sat, 11 May 2013 09:21:32 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223984>

Although we definitely support and encourage use of multi-level branch
names, we have never conciously tried to give support for multi-level
remote names. Currently, they are allowed, but there is no evidence that
they are commonly used.

Now, they do provide a source of problems when trying to expand the
"$nick/$name" shorthand notation (where $nick matches a remote name)
into a full refname. Consider the shorthand "foo/bar/baz": Does this
parse as $nick = foo, $name = bar/baz, or $nick = foo/bar, $name = baz?

Since we need to be unambiguous about these things, we hereby declare
that a remote name shall never contain a '/' character, and that the
only correct way to parse "foo/bar/baz" is $nick = foo, $name = bar/baz.

This patch teaches 'git remote' to reject remote names with slashes,
and adds tests verifying this.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/remote.c  |  4 ++--
 t/t5505-remote.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5e54d36..6e7369d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -195,7 +195,7 @@ static int add(int argc, const char **argv)
 		die(_("remote %s already exists."), name);
 
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
-	if (!valid_fetch_refspec(buf2.buf))
+	if (!valid_fetch_refspec(buf2.buf) || strchr(name, '/'))
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
@@ -646,7 +646,7 @@ static int mv(int argc, const char **argv)
 		die(_("remote %s already exists."), rename.new);
 
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
-	if (!valid_fetch_refspec(buf.buf))
+	if (!valid_fetch_refspec(buf.buf) || strchr(rename.new, '/'))
 		die(_("'%s' is not a valid remote name"), rename.new);
 
 	strbuf_reset(&buf);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dd10ff0..f7098fe 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -621,6 +621,12 @@ test_expect_success 'reject adding remote with an invalid name' '
 
 '
 
+test_expect_success 'reject adding remote with slash in name' '
+
+	test_must_fail git remote add multi/level .
+
+'
+
 # The first three test if the tracking branches are properly renamed,
 # the last two ones check if the config is updated.
 
@@ -668,6 +674,12 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 
 '
 
+test_expect_success 'rename a remote with slash in name' '
+
+	test_must_fail git remote rename upstream up/stream
+
+'
+
 cat > remotes_origin << EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
-- 
1.8.1.3.704.g33f7d4f
