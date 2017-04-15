Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368EA20D09
	for <e@80x24.org>; Sat, 15 Apr 2017 10:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbdDOKjc (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 06:39:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35890 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdDOKja (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 06:39:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id o21so14953904wrb.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2Td/Ax5EOHZZGx9lp7vz6SGZcfrCfKPvaIf0c5LNiM=;
        b=BGU/cLyAW60k+ZAEQpZ3TCiMG+3SSddAnwZDJEE7G85BFzxghyqTwxTtul8lXSzLCa
         0Vg454tMq3ryj8vOO3BpcyneMizT3/Op+/5OQ+ZBruGsfq3C7zN00Y7a+bJ9SufAanSn
         tADTo9IvZ2gCLWgolHJpufMYXo9yq1WvG8VRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v2Td/Ax5EOHZZGx9lp7vz6SGZcfrCfKPvaIf0c5LNiM=;
        b=ikQzzmbLNyRCM79hnEfTq03cID+4FmGbNvSP1i0grmPNfFztxUnGXpubskvv1it5vA
         m52gcxgetq3agYr0XdVlHgXc1XTtPuQ9w2PSuqQqlf+6vBouRTUABtaM20YAOArBT6TQ
         apPMKp5g2as64+lrUYcl75PBhm8506C8aLcH943YedajvgiudT1rSS+5sR3/qkHHoDeN
         iL9Hu8+cPhH07Aocynp+C78qouROKCoGdpR5oAc0OLL7tNfXBhckhTUu3fSkKunZL8ux
         JQdEW95NlBYN9hE/e1iiwxsrBdOAkXWasHld60PQRmTdFU+AK7S1nsd2Q+/adWt8wqbw
         75eg==
X-Gm-Message-State: AN3rC/4NtxE9i124g4hEvi6nOFEoM9Gz2V2fwXg/pvfwX0XYlwWX96eP
        iCKCuq2fG2TLXQ==
X-Received: by 10.223.164.65 with SMTP id e1mr11411961wra.105.1492252769286;
        Sat, 15 Apr 2017 03:39:29 -0700 (PDT)
Received: from ldiamand-t3610.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id y63sm2072774wme.31.2017.04.15.03.39.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 15 Apr 2017 03:39:28 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sam Hocevar <sam@hocevar.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/3] git-p4: add read_pipe_text() internal function
Date:   Sat, 15 Apr 2017 11:36:08 +0100
Message-Id: <20170415103609.6002-3-luke@diamand.org>
X-Mailer: git-send-email 2.12.2.719.gcbd162c
In-Reply-To: <20170415103609.6002-1-luke@diamand.org>
References: <20170415103609.6002-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing read_pipe() function returns an empty string on
error, but also returns an empty string if the command returns
an empty string.

This leads to ugly constructions trying to detect error cases.

Add read_pipe_text() which just returns None on error.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index eab319d76..584b81775 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -160,17 +160,42 @@ def p4_write_pipe(c, stdin):
     real_cmd = p4_build_cmd(c)
     return write_pipe(real_cmd, stdin)
 
-def read_pipe(c, ignore_error=False):
+def read_pipe_full(c):
+    """ Read output from  command. Returns a tuple
+        of the return status, stdout text and stderr
+        text.
+    """
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
     expand = isinstance(c,basestring)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
-    if p.returncode != 0 and not ignore_error:
-        die('Command failed: %s\nError: %s' % (str(c), err))
+    return (p.returncode, out, err)
+
+def read_pipe(c, ignore_error=False):
+    """ Read output from  command. Returns the output text on
+        success. On failure, terminates execution, unless
+        ignore_error is True, when it returns an empty string.
+    """
+    (retcode, out, err) = read_pipe_full(c)
+    if retcode != 0:
+        if ignore_error:
+            out = ""
+        else:
+            die('Command failed: %s\nError: %s' % (str(c), err))
     return out
 
+def read_pipe_text(c):
+    """ Read output from a command with trailing whitespace stripped.
+        On error, returns None.
+    """
+    (retcode, out, err) = read_pipe_full(c)
+    if retcode != 0:
+        return None
+    else:
+        return out.rstrip()
+
 def p4_read_pipe(c, ignore_error=False):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error)
-- 
2.12.2.719.gcbd162c

