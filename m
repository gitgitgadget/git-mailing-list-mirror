Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE80C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87368206E0
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=corrigendum.ru header.i=@corrigendum.ru header.b="BwFxHmcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLOSeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:34:23 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:45607 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbfLOSeX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Dec 2019 13:34:23 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 13:34:21 EST
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 5B1FB18C10E2;
        Sun, 15 Dec 2019 21:26:41 +0300 (MSK)
Received: from iva8-6403930b9beb.qloud-c.yandex.net (iva8-6403930b9beb.qloud-c.yandex.net [2a02:6b8:c0c:2c9a:0:640:6403:930b])
        by mxback7j.mail.yandex.net (mxback/Yandex) with ESMTP id KV5eeSmomK-Qfrqicj5;
        Sun, 15 Dec 2019 21:26:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1576434401; bh=WtDj0CX9Svm1BdafXHZ29qzF/MQuDXCJjW09kjjMbbk=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=BwFxHmcBysxJCX23G+zoZ9B7d1+IriHfbE/btEkL/QqHvjbHWIB+QSHoix/cUnyTc
         FbQXwjEs/xCncsqKJXNR8GgzFQG4NJu+4KGK36W/PhU7eZdl3kRLMJR4SQ2WpnakKB
         FGK3CWa89/T54R77xjeB5BeT+XBtwwn2f5/LsSGQ=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
Received: by iva8-6403930b9beb.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id nKC3q8rnn0-Qe18NfKZ;
        Sun, 15 Dec 2019 21:26:40 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
        <dpb@corrigendum.ru>
To:     paulus@ozlabs.org
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87?=
         =?UTF-8?q?=D0=B5=D0=BD=D0=BA=D0=BE?= <dpb@corrigendum.ru>
Subject: [PATCH] gitk: fix the context menu not appearing in the presence of submodule diffs
Date:   Sun, 15 Dec 2019 21:25:50 +0300
Message-Id: <20191215182550.397-1-dpb@corrigendum.ru>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, submodule diffs can cause the diff context menu to fail
to appear because of a couple bugs in parseblobdiffline:

* it appends the submodule name to ctext_file_lines instead of
  a line number, which breaks the binary search in find_ctext_fileinfo;

* it can desynchronize ctext_file_names and ctext_file_lines
  by appending to the former but not the latter, which also breaks
  find_ctext_fileinfo.

Fix both of these.

Note: a side effect of this patch is that the context menu also
starts appearing when you right-click on submodule diffs (and not just
regular diffs). The menu is non-functional in this case, though,
since you can't run blame on submodules.

Signed-off-by: Роман Донченко <dpb@corrigendum.ru>
---
 gitk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index da84e22..2a9bd45 100755
--- a/gitk
+++ b/gitk
@@ -8224,10 +8224,10 @@ proc parseblobdiffline {ids line} {
 	if {$currdiffsubmod != $fname} {
 	    $ctext insert end "\n";     # Add newline after commit message
 	}
-	set curdiffstart [$ctext index "end - 1c"]
-	lappend ctext_file_names ""
 	if {$currdiffsubmod != $fname} {
-	    lappend ctext_file_lines $fname
+	    set curdiffstart [$ctext index "end - 1c"]
+	    lappend ctext_file_names ""
+	    lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
 	    makediffhdr $fname $ids
 	    set currdiffsubmod $fname
 	    $ctext insert end "\n$line\n" filesep
-- 
2.24.1.windows.2

