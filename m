Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00961F803
	for <e@80x24.org>; Wed,  9 Jan 2019 22:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAIWTC (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 17:19:02 -0500
Received: from hel.is.scarlet.be ([193.74.71.26]:22970 "EHLO hel.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfAIWTC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 17:19:02 -0500
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 17:19:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1547071849;
        bh=dwI7u22hmjnEBT9ovh9cXWmWzEk9XgmQx8fhryOXwV4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=aaJN7hJbISy2EZYX2yyTSUaochAqcURoHfyIqWZF+/DWLk8LStYg4i16MDy4IwcIX
         6Pdsnofp8uaYIpEIXrnhrg00pzs5r+mmeE7kiTldehOBLlVP8OBDQNwXekq3ImShv6
         1W6X1ApdLXkExb/mgzxH0oClkgQNsMHLAThSLNng=
Received: from localhost.localdomain (ip-213-49-92-123.dsl.scarlet.be [213.49.92.123])
        by hel.is.scarlet.be (8.15.2/8.14.9) with ESMTPS id x09MAm11030208
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 9 Jan 2019 23:10:49 +0100
X-Scarlet: d=1547071849 c=213.49.92.123
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>, Johannes Sixt <j6t@kdbg.org>,
        Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH] diff: ensure correct lifetime of external_diff_cmd
Date:   Wed,  9 Jan 2019 23:10:07 +0100
Message-Id: <20190109221007.21624-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DCC-scarlet.be-Metrics: hel 20001; Body=7 Fuz1=7 Fuz2=7
X-Virus-Scanned: clamav-milter 0.98.1-exp at hel
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to getenv(3)'s notes:

    The implementation of getenv() is not required to be reentrant.  The
    string pointed to by the return value of getenv() may be statically
    allocated, and can be modified by a subsequent call to getenv(),
    putenv(3), setenv(3), or unsetenv(3).

Since strings returned by getenv() are allowed to change on subsequent
calls to getenv(), make sure to duplicate when caching external_diff_cmd
from environment.

This problem becomes apparent on Git for Windows since fe21c6b285df
(mingw: reencode environment variables on the fly (UTF-16 <-> UTF-8)),
when the getenv() implementation provided in compat/mingw.c was changed
to keep a certain amount of alloc'ed strings and freeing them on
subsequent calls.

This fixes https://github.com/git-for-windows/git/issues/2007:

    $ yes n | git -c difftool.prompt=yes difftool fe21c6b285df fe21c6b285df~100

    Viewing (1/404): '.gitignore'
    Launch 'bc3' [Y/n]?
    Viewing (2/404): 'Documentation/.gitignore'
    Launch 'bc3' [Y/n]?
    Viewing (3/404): 'Documentation/Makefile'
    Launch 'bc3' [Y/n]?
    Viewing (4/404): 'Documentation/RelNotes/2.14.5.txt'
    Launch 'bc3' [Y/n]?
    Viewing (5/404): 'Documentation/RelNotes/2.15.3.txt'
    Launch 'bc3' [Y/n]?
    Viewing (6/404): 'Documentation/RelNotes/2.16.5.txt'
    Launch 'bc3' [Y/n]?
    Viewing (7/404): 'Documentation/RelNotes/2.17.2.txt'
    Launch 'bc3' [Y/n]?
    Viewing (8/404): 'Documentation/RelNotes/2.18.1.txt'
    Launch 'bc3' [Y/n]?
    Viewing (9/404): 'Documentation/RelNotes/2.19.0.txt'
    Launch 'bc3' [Y/n]? error: cannot spawn ¦?: No such file or directory
    fatal: external diff died, stopping at Documentation/RelNotes/2.19.1.txt

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---
 diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index dc9965e836..f69687e288 100644
--- a/diff.c
+++ b/diff.c
@@ -492,6 +492,9 @@ static const char *external_diff(void)
 	external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
 	if (!external_diff_cmd)
 		external_diff_cmd = external_diff_cmd_cfg;
+	else
+		external_diff_cmd = xstrdup(external_diff_cmd);
+
 	done_preparing = 1;
 	return external_diff_cmd;
 }
-- 
2.20.1.windows.1

