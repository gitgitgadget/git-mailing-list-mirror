Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9AE1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 18:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeDRSPJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 14:15:09 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:54912 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbeDRSPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 14:15:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40R9JT5DWFz5tlM;
        Wed, 18 Apr 2018 20:15:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7EAE710B;
        Wed, 18 Apr 2018 20:15:04 +0200 (CEST)
Subject: Re: [RFC PATCH] ident: don't cache default date
To:     phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <20180418102236.7183-1-phillip.wood@talktalk.net>
 <87vacoeovh.fsf@evledraar.gmail.com>
 <85ecb584-77a7-f818-14c9-1019873d87f9@talktalk.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d4aee85d-956f-ac93-b909-6dfeb5ea8fd7@kdbg.org>
Date:   Wed, 18 Apr 2018 20:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <85ecb584-77a7-f818-14c9-1019873d87f9@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.04.2018 um 19:47 schrieb Phillip Wood:
> On 18/04/18 12:27, Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Apr 18 2018, Phillip Wood wrote:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> as it is created by running an separate instance of 'git commit'.  If
>>> the reworded commit is follow by further picks, those later commits
>>> will have an earlier committer date than the reworded one. This is
>>> caused by git caching the default date used when GIT_COMMITTER_DATE is
>>> not set. Fix this by not caching the date.
>>>
>>> Users expect commits to have the same author and committer dates when
>>> the don't explicitly set them. As the date is now updated each time
>>> git_author_info() or git_committer_info() is run it is possible to end
>>> up with different author and committer dates. Fix this for
>>> 'commit-tree', 'notes' and 'merge' by using a single date in
>>> commit_tree_extended() and passing it explicitly to the new functions
>>> git_author_info_with_date() and git_committer_info_with_date() when
>>> neither the author date nor the committer date are explicitly
>>> set. 'commit' always passes the author date to commit_tree_extended()
>>> and relied on the date caching to have the same committer and author
>>> dates when neither was specified. Fix this by setting
>>> GIT_COMMITTER_DATE to be the same as the author date passed to
>>> commit_tree_extended().
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> Reported-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>>
>>> I'm slightly nervous that setting GIT_COMMITTER_DATE in
>>> builtin/commit.c will break someone's hook script. Maybe it would be
>>> better to add a committer parameter to commit_tree() and
>>> commit_tree_extended().

While I like the basic theme of your patch, I think we should fix this
case in a much simpler way, namely, use the infrastructure that was
introduced for git-am.

I've shamelessly lifted the commit message from your patch.

---- 8< ----
Subject: [PATCH] sequencer: reset the committer date before commits

Now that the sequencer commits without forking when the commit message
isn't edited all the commits that are picked have the same committer
date. If a commit is reworded it's committer date will be a later time
as it is created by running an separate instance of 'git commit'.  If
the reworded commit is follow by further picks, those later commits
will have an earlier committer date than the reworded one. This is
caused by git caching the default date used when GIT_COMMITTER_DATE is
not set. Reset the cached date before a commit is generated
in-process.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index f9d1001dee..f0bac903a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1148,6 +1148,8 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		goto out;
 	}
 
+	reset_ident_date();
+
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
-- 
2.17.0.69.g0c1d01d9b6
