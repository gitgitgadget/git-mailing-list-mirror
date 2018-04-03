Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51D71F404
	for <e@80x24.org>; Tue,  3 Apr 2018 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeDCWWj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 18:22:39 -0400
Received: from lucaswerkmeister.de ([94.130.58.99]:46312 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeDCWWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 18:22:38 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2018 18:22:38 EDT
Received: from localhost (unknown [IPv6:2a02:8109:92c0:22bb:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 54E5330F632;
        Wed,  4 Apr 2018 00:13:51 +0200 (CEST)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1522793631;
        bh=f6C/BXAayN0amAqBjDK44BgGmMRTgy/RvIjnXLTSdDk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding:From:Reply-To:Subject:Date:To:Cc:
         In-Reply-To:References:Message-Id:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version;
        b=ksu/IN/nZfsTWN/VM/RU+ctqVRtL3cTlhKyVispsO9mJZHQ10GLmkLQ7oSSFzsOvz
         Dvv/ZW+mwgCd7NJu+HKvwHogHzjNkkt0PiL0p4rmvbxhip+ZKerzXiU4PcDKN2bi1w
         u8pH54X+5hx9wmNUBJeO2wQyI8/5lRyKFHpjo9RY=
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
To:     git@vger.kernel.org
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] Fix condition for redirecting stderr
Date:   Wed,  4 Apr 2018 00:13:07 +0200
Message-Id: <20180403221307.29194-1-mail@lucaswerkmeister.de>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the --log-destination option was added in 0c591cacb ("daemon: add
--log-destination=(stderr|syslog|none)", 2018-02-04) with the explicit
goal of allowing logging to stderr when running in inetd mode, we should
not always redirect stderr to /dev/null in inetd mode, but rather only
when stderr is not being used for logging.

Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
---

Notes:
    I have to apologize to the list here… even though I proposed this
    option with the goal of using it on my server, for some reason I
    decided to only use it there after the next Git release had come
    out, and didn’t test it anywhere else. The code looked okay, but I
    missed this part near the end of daemon.c that made it ineffective,
    rendering the feature broken in the 2.17.0 release and making me
    look like an idiot :/ sorry, everyone.
    
    For what it’s worth, with this fix the feature appears to work as
    intended (I *have* tested it on my server now and log messages from
    git-daemon show up in the journal as intended, attributed to the
    correct unit and everything).

 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index fe833ea7d..9d2e0d20e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1459,7 +1459,7 @@ int cmd_main(int argc, const char **argv)
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
-	if (inetd_mode) {
+	if (log_destination != LOG_DESTINATION_STDERR) {
 		if (!freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 	}
-- 
2.16.3

