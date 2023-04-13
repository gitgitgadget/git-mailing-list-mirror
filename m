Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D2C7619A
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 01:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDMB4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDMB4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 21:56:54 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D82618F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 18:56:52 -0700 (PDT)
Received: from [2400:4160:1877:2b00:dfc8:d49:8ec3:6947] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mh@glandium.org>)
        id 1pmmCc-003Cod-0M
        for git@vger.kernel.org;
        Thu, 13 Apr 2023 01:56:48 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1pmmCW-00AnAO-W9
        for git@vger.kernel.org; Thu, 13 Apr 2023 10:56:41 +0900
Date:   Thu, 13 Apr 2023 10:56:40 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: similarity index vs. whitespaces
Message-ID: <20230413015640.h6npzp47tnob7bq2@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I hit an interesting case of copy-detection "failure" after renaming a
python script and changing indentation in it at the same time: git show
-C wouldn't detect it as a rename unless I lowered the similarity index
significantly. But from a human perspective, the similarity index feels
wrong.

Here's a small illustrative example:
$ git init qux
$ cd qux
$ cat > qux <<EOF
a
b
c
d
e
f
EOF
$ git add qux
$ git commit -a -m qux
$ git mv qux hoge
$ sed -i 's/[cde]/  \0/' hoge
$ git commit -a -m hoge
$ git diff -C HEAD^!
diff --git a/hoge b/hoge
new file mode 100644
index 0000000..9ab6fcc
--- /dev/null
+++ b/hoge
@@ -0,0 +1,6 @@
+a
+b
+  c
+  d
+  e
+f
diff --git a/qux b/qux
deleted file mode 100644
index 0fdf397..0000000
--- a/qux
+++ /dev/null
@@ -1,6 +0,0 @@
-a
-b
-c
-d
-e
-f

$ git diff -C10% HEAD^!
diff --git a/qux b/hoge
similarity index 33%
rename from qux
rename to hoge
index 0fdf397..9ab6fcc 100644
--- a/qux
+++ b/hoge
@@ -1,6 +1,6 @@
 a
 b
-c
-d
-e
+  c
+  d
+  e
 f

From a human perspective 33% similarity feels way too low here. I know
it's essentially counting lines in the diff, but that feels limited.

What do you think?

Mike
