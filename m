Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C7F1F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeDTIEB (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:04:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:36613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbeDTIDz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:03:55 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdHLB-1eieuN0sqn-00iXux; Fri, 20
 Apr 2018 10:03:50 +0200
Date:   Fri, 20 Apr 2018 10:03:34 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Dan Jacques <dnj@google.com>
Subject: [PATCH 1/3] gettext: avoid initialization if the locale dir is not
 present
In-Reply-To: <cover.1524211375.git.johannes.schindelin@gmx.de>
Message-ID: <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de>
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NaM1DZNao1yCucTUmgNRkTJ9YcU8aoRCrQyMARCaEGN7xCBWOko
 btQCrGpuY35Nr0wLZ56pBd8iA9sCM7rN4YN9YDoN3Qe4xuZK0G81PYKWtc9BkLXVF9y3f6q
 9RdrZtnGcs/O8mzXEUwsIw7Z7cGp8txexwmuFfreTzRDZNpdvSoklZUHewsQ/GWL4ip2OVQ
 XsOks2r8N5Wq2o1kfcWBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H3itjLvgtrw=:/4LY7T1mD+1eReYr+i7vbr
 zzs5dOWET4JFGdZaM0g2Rv6RrmplGX9A5HVDnWATRINe04w4OgjMRH8RmBP4TI89hSs9IGhA8
 7PHKYdBmPVFQkl/D0ZXPDJpt3oOltXWwzeJ537zo8d68o5qKsLzxaTMi7bpyhECRQKs9psQ5Y
 IrTVav2QFVzBT0veF8+DdoAODZPLpAwEtIek4zAlcImHyt93Z+3B6bJDtFrtfCqqY3Gk/ZOiW
 XOjuLsNM+wyYduOqeMvMlyfDlFFP4d/mKlIbj9Sdxd+VmBq4mDGWTrOlo+h6rgD9zXB/IpXx/
 ik2JSKTgppjDc5z3HfPQHHDcsD98HvZ513pFJLNcizlpF/6weTPpvBiIREmuaw+h+VMmLlau+
 yHZofQalpl65DeVuzzWGf57uKk9065izpz0+w+22bv0fYt08eqTuppZaQMLaznh9VUvHL4AD0
 /Wfk/tjmfBro+qKHVMac04/VJr+mWqgV1UlZ5uaJO+IjxvCnp+4yU43HQhIcY7QfDQFQnscoT
 DWRSpq5pjkBBwUexgwFkXBOrBn7F4UD1hznMIqOBoXUzol/9yctNszNR2JlL9/+W9bIchQG56
 Ad/hcQ7bI67Jaf7TJpzpYypyLtFHQjzn15qXgCNsjYk9DmbcwPjJvegIH8v3ZgKnhUHLSXA3L
 uK2joRKgrwXAgUQyolzlZA7U9kPLinUeLs2DHUBLcQTRpJOyQijDq4vBum4HAtlNq6fpkikTP
 Zm9S1F88egAeCNxYA+j0XnzrX+50ShZgI9qYC7FIinIeUkceSKrtbw8uItAhXnMaGZ6O034ZP
 0rd1IaVMj4oGb2sflizmzbi63cqkMDlgqChLFCmt+0xVas7HQc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The runtime of a simple `git.exe version` call on Windows is currently
dominated by the gettext setup, adding a whopping ~150ms to the ~210ms
total.

Given that this cost is added to each and every git.exe invocation goes
through common-main's invocation of git_setup_gettext(), and given that
scripts have to call git.exe dozens, if not hundreds, of times, this is
a substantial performance penalty.

This is particularly pointless when considering that Git for Windows
ships without localization (to keep the installer's size to a bearable
~34MB): all that time setting up gettext is for naught.

So let's be smart about it and skip setting up gettext if the locale
directory is not even present.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gettext.c b/gettext.c
index baba28343c3..701355d66e7 100644
--- a/gettext.c
+++ b/gettext.c
@@ -163,6 +163,9 @@ void git_setup_gettext(void)
 	if (!podir)
 		podir = system_path(GIT_LOCALE_PATH);
 
+	if (!is_directory(podir))
+		return;
+
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
-- 
2.17.0.windows.1.15.gaa56ade3205


