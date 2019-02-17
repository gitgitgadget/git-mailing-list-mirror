Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA7C1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfBQP7W convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 17 Feb 2019 10:59:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:11165 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfBQP7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 10:59:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1HFxIr1080755
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Feb 2019 10:59:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Joe Ranieri'" <jranieri@grammatech.com>, <git@vger.kernel.org>
References: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
In-Reply-To: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
Subject: RE: [BUG] ls-files showing deleted files (unchecked lstat return value)
Date:   Sun, 17 Feb 2019 10:59:12 -0500
Message-ID: <000001d4c6d9$bceb5810$36c20830$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFJjgaAGbTDkZVlAQbFZ175xUV0Nab6lMOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 17, 2019 8:50, Joe Ranieri wrote:
> "git ls-files -m" can show deleted files, despite -d not having been specified.
> This is due to ls-files.c's show_files function calling lstat but not checking the
> return value before calling ie_modified with the uninitialized stat structure.

What version of git are you looking scanning? Commit 8989e1950a (2.21.0-rc1) has the following:

err = lstat(fullname.buf, &st);
if (show_deleted && err)
...

You may be correct that the following check:
 if (show_modified && ie_modified(repo->index, ce, &st, 0

may need to include !err. Is that your conclusion? Is there a test case you have to demonstrate this that I can include in the test suite?

The patch would be (subject to my bad mailer messing it up):

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a8762d46..fc21f47954 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -348,7 +348,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
                        err = lstat(fullname.buf, &st);
                        if (show_deleted && err)
                                show_ce(repo, dir, ce, fullname.buf, tag_removed);
-                       if (show_modified && ie_modified(repo->index, ce, &st, 0))
+                       if (show_modified && !err && ie_modified(repo->index, ce, &st, 0))
                                show_ce(repo, dir, ce, fullname.buf, tag_modified);
                }
        }

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



