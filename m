Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1401FA14
	for <e@80x24.org>; Thu, 25 May 2017 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940778AbdEYMAV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 08:00:21 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:30569 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935583AbdEYMAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 08:00:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wYSWL6yhwz5tlC;
        Thu, 25 May 2017 14:00:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D3D1F4335;
        Thu, 25 May 2017 14:00:13 +0200 (CEST)
Subject: [PATCH v3 2/2] Windows: do not treat a path with backslashes as a
 remote's nick name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
References: <cover.1495261020.git.j6t@kdbg.org>
 <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
 <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
 <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
 <alpine.DEB.2.21.1.1705231245300.3610@virtualbox>
 <xmqqinkrjkfb.fsf@gitster.mtv.corp.google.com>
 <c36ae9af-b566-5bb3-ad70-ee7f0051ca9a@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <10ee6b91-cd54-d43a-4cfb-d3baa2af7e7a@kdbg.org>
Date:   Thu, 25 May 2017 14:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <c36ae9af-b566-5bb3-ad70-ee7f0051ca9a@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, the remote repository name in, e.g., `git fetch foo\bar`
is clearly not a nickname for a configured remote repository. However,
the function valid_remote_nick() does not account for backslashes.
Use is_dir_sep() to check for both slashes and backslashes on Windows.

This was discovered while playing with Duy's patches that warn after
fopen() failures. The functions that read the branches and remotes
files are protected by a valid_remote_nick() check. Without this
change, a Windows style absolute path is incorrectly regarded as
nickname and is concatenated to a prefix and used with fopen(). This
triggers warnings because a colon in a path name is not allowed:

C:\Temp\gittest>git fetch C:\Temp\gittest
warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
From C:\Temp\gittest
 * branch            HEAD       -> FETCH_HEAD

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 24.05.2017 um 07:45 schrieb Johannes Sixt:
> Am 24.05.2017 um 00:08 schrieb Junio C Hamano:
>> So in short:
>>
>>   (1) Hannes's patches are good, but they solve a problem that is
>>       different from what their log messages say; the log message
>>       needs to be updated;

I do not resend patch 1/2 as it is unchanged in all regards. This 2/2
changes the justification; patch text is unchanged.

 remote.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index ad6c5424ed..1949882c10 100644
--- a/remote.c
+++ b/remote.c
@@ -645,7 +645,12 @@ static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
 		return 0;
-	return !strchr(name, '/'); /* no slash */
+
+	/* remote nicknames cannot contain slashes */
+	while (*name)
+		if (is_dir_sep(*name++))
+			return 0;
+	return 1;
 }
 
 const char *remote_for_branch(struct branch *branch, int *explicit)
-- 
2.13.0.55.g17b7d13330
