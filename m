Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608CB20229
	for <e@80x24.org>; Fri, 21 Oct 2016 06:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbcJUGQS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 02:16:18 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:46457 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753849AbcJUGQR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Oct 2016 02:16:17 -0400
X-Greylist: delayed 1470 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Oct 2016 02:16:17 EDT
Received: from dimstar.local.net (c110-22-56-26.eburwd6.vic.optusnet.com.au [110.22.56.26])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTP id 1355A7840EC
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 16:51:32 +1100 (AEDT)
Received: (qmail 2633 invoked by uid 501); 21 Oct 2016 05:50:13 -0000
Date:   Fri, 21 Oct 2016 16:50:13 +1100
From:   Duncan Roe <duncan_roe@acslink.net.au>
To:     git <git@vger.kernel.org>
Subject: [BUG] [PATCH]: run-command.c
Message-ID: <20161021055013.GA31554@dimstar.local.net>
Mail-Followup-To: git <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=VIkg5I7X c=1 sm=1 tr=0
        a=/xIuaNGu1NPzt0yKkvdCVQ==:117 a=/xIuaNGu1NPzt0yKkvdCVQ==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=CH0kA5CcgfcA:10 a=xT7Xx2lwbq99A7q-vAEA:9 a=CjuIK1q_8ugA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prepare_shell_cmd() executes /bin/sh with superfluous arguments on all but
single-word shell commands.

For example, if .git/config has this alias (the sleep is to leave time to
examine output from ps, &c.):

[alias]
	tryme = "!echo $PWD;sleep 600"

running "git tryme" in one console and checking what it does in another

--- 1st xterm

16:42:12$ git tryme
/usr/src/git/.git
echo $PWD;sleep 600: line 1:  2602 Terminated              sleep 600
16:43:15$


--- 2nd xterm

16:42:06$ ps axf|grep -A2 trym[e]
 2599 pts/4    S+     0:00      \_ git tryme
 2601 pts/4    S+     0:00          \_ /bin/sh -c echo $PWD;sleep 600 echo $PWD;sleep 600
 2602 pts/4    S+     0:00              \_ sleep 600
16:42:45$ cat /proc/2601/cmdline | xargs -0 -n1 echo
/bin/sh
-c
echo $PWD;sleep 600
echo $PWD;sleep 600
16:43:04$ kill 2602
16:43:15$

---

There is an extra "-c" argument. This is caused by a missing "else", fixed by
the appended patch,

Cheers ... Duncan.

----------8<-------------------

--- a/run-command.c
+++ b/run-command.c
@@ -182,8 +182,8 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 		else
 			argv_array_pushf(out, "%s \"$@\"", argv[0]);
 	}
-
-	argv_array_pushv(out, argv);
+	else
+		argv_array_pushv(out, argv);
 	return out->argv;
 }

