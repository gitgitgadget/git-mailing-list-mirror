Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE2F1FADE
	for <e@80x24.org>; Sat,  9 Sep 2017 13:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbdIINNg (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 09:13:36 -0400
Received: from avasout08.plus.net ([212.159.14.20]:50652 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753519AbdIINNf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 09:13:35 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id 7RDZ1w0020M91Ur01RDarb; Sat, 09 Sep 2017 14:13:34 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=aFHsfBbdpozbKrwjF20A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Unexpected pass for t6120-describe.sh on cygwin
Message-ID: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
Date:   Sat, 9 Sep 2017 14:13:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

I ran the test-suite on the 'pu' branch last night (simply because
that was what I had built at the time!), which resulted in a PASS,
but t6120 was showing a 'TODO passed' for #52.

This is a test introduced by Michael's 'mg/name-rev-tests-with-short-stack'
branch, which uses 'ulimit -s' to try and force a stack overflow.
Unfortunately, 'ulimit -s' seems to have no effect on cygwin. I created
a test program (see below) to eat up the stack and tried running it
with various ulimit values (128, 12, 8), but it always seg-faulted
at the same stack-frame. (after using approx 2MB stack space).

So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests,
but haven't looked into it.

Given that 'ulimit' is a bash built-in, this may also be a problem
on MinGW and Git-For-Windows, but I can't test on those platforms.

Unfortunately, I can't spend more time on git today, hence this
heads up! ;-)

ATB,
Ramsay Jones

-- >8 --
diff --git a/test.c b/test.c
new file mode 100644
index 0000000..bcbb805
--- /dev/null
+++ b/test.c
@@ -0,0 +1,21 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+
+void test(uint64_t count)
+{
+	int i, junk[1024];
+
+	for (i = 0; i < 1024; i++)
+		junk[i] = count;
+	i = junk[count % 1024];
+	printf("%" PRIuMAX "\n", (uintmax_t)count);
+	fflush(stdout);
+	test(count + 1);
+}
+
+int main(int argc, char *argv[])
+{
+	test(0);
+	return 0;
+}

