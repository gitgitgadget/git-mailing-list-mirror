Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786161FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934152AbcKWWgk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 17:36:40 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:40645 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933575AbcKWWgj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 17:36:39 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tPHJ52hTKz5tlC;
        Wed, 23 Nov 2016 23:36:37 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CD3341D0D;
        Wed, 23 Nov 2016 23:36:36 +0100 (CET)
Subject: Re: [PATCH] git-gui: pass the branch name to git merge
To:     Junio C Hamano <gitster@pobox.com>
References: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org>
 <xmqqvavfpbph.fsf@gitster.mtv.corp.google.com>
 <1dc28731-9000-c3bf-fbed-0cb17c230d8b@kdbg.org>
 <5baaf25b-6f15-8002-97ea-97c5c6a4b4e4@kdbg.org>
 <xmqq4m2ym06p.fsf@gitster.mtv.corp.google.com>
Cc:     Pat Thoyts <patthoyts@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e61cc267-a59b-3be1-29db-c49d56f521f7@kdbg.org>
Date:   Wed, 23 Nov 2016 23:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m2ym06p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.11.2016 um 21:05 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> Am 22.11.2016 um 21:40 schrieb Johannes Sixt:
>>> Am 22.11.2016 um 20:16 schrieb Junio C Hamano:
>>>> Can't this be handled on the "git merge FETCH_HEAD" codepath
>>>> instead?
>>>
>>> Absolutely. Any takers? ;)
>>
>> I attempted to fix git merge FETCH_HEAD, but I do not see a trivial
>> solution.
>>
>> But on second thought, we have an excuse to pick my proposed git-gui
>> change anyway: Without that change and a fix in git-merge only, there
>> is still a regression for all users who use the latest git-gui but
>> some git version between 2.5.0 and the fixed git-merge...
> 
> I'll leave it up to Pat, as I do not read tcl very well ;-)

Sure!

In the mean time, here is my attempt to fix git merge FETCH_HEAD.
I would feel better if this were just taken as a starter for a
real fix by someone who is familiar with the area.

---- 8< ----
[PATCH] merge FETCH_HEAD: keep track of the branch names

'git merge FETCH_HEAD' is treated differently from 'git merge topic'
because FETCH_HEAD is not just a regular ref name, but contains the
names of the branches being merged. However, 'git merge' does not
store the names as the "remote description" of the merge parent
structure that is associated with merged commits, like an ordinary
'git merge topic' call does for the command line arguments.
A consequence is that conflict markers are not marked up with the
branch name, but with a raw object name. Parse off the branch names
from the FETCH_HEAD file and store them with the merged commits.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin/merge.c | 8 ++++++++
 commit.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index b65eeaa87d..328517b091 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1051,9 +1051,17 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 			continue; /* not-for-merge */
 		else {
 			char saved = merge_names->buf[pos + 40];
+			char eol = ptr ? *ptr : '\0';
 			merge_names->buf[pos + 40] = '\0';
+			if (ptr)
+				*ptr = '\0';
 			commit = get_merge_parent(merge_names->buf + pos);
+			set_merge_remote_desc(commit,
+					merge_names->buf + pos + 40 + 2,
+					merge_remote_util(commit)->obj);
 			merge_names->buf[pos + 40] = saved;
+			if (ptr)
+				*ptr = eol;
 		}
 		if (!commit) {
 			if (ptr)
diff --git a/commit.c b/commit.c
index 856fd4aeef..7ac2ce6518 100644
--- a/commit.c
+++ b/commit.c
@@ -1582,6 +1582,7 @@ void set_merge_remote_desc(struct commit *commit,
 	struct merge_remote_desc *desc;
 	FLEX_ALLOC_STR(desc, name, name);
 	desc->obj = obj;
+	free(commit->util);
 	commit->util = desc;
 }
 
-- 
2.11.0.rc1.52.g65ffb51

