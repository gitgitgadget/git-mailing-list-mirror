Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60FA20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 05:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeLLFgC (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 00:36:02 -0500
Received: from mail.javad.com ([54.86.164.124]:58167 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLFgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 00:36:02 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 02E473E861;
        Wed, 12 Dec 2018 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1544592961;
        bh=MI/omObnIpJXdIYlJTs8PVQ3+Psyq+Ttq6Qh6fVgLnU=; l=2427;
        h=Received:From:To:Subject;
        b=j0tR6Ez2ThzHFLqLpzsCImUB5m4otDbWLxueLdMs9YwN1Pa1GM3NEZWwI580BHZSb
         LOVQeNgH7MaK+9kIMHP9h2WeSEi1LnzHlSPKafRhyZp6NpMcp2DXA4sT1goODrUmKA
         5EmptXVRlz2I7HAFYnD8DMfPdwKHfj/bZdCLFKmc=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gWxBe-00017J-D3; Wed, 12 Dec 2018 08:35:58 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 12 Dec 2018 08:35:58 +0300
In-Reply-To: <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Jun 2018 08:54:17 -0700")
Message-ID: <871s6n5mtd.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Sergey Organov <sorganov@gmail.com> writes:
>
>> When cherry-picking multiple commits, it's impossible to have both
>> merge- and non-merge commits on the same command-line. Not specifying
>> '-m 1' results in cherry-pick refusing to handle merge commits, while
>> specifying '-m 1' fails on non-merge commits.
>

[...]

> Now, it appears, at least to me, that the world pretty much accepted
> that the first-parent worldview is often very convenient and worth
> supporting by the tool, so the next logical step might be to set
> opts->mainline to 1 by default (and allow an explicit "-m $n" from
> the command line to override it).  But that should happen after this
> patch lands---it is logically a separate step, I would think.
>

[...]

>> +	} else if (1 < opts->mainline)
>> +		/* Non-first parent explicitly specified as mainline for
>> +		 * non-merge commit */
>
> Style.
>
> 	/*
> 	 * Our multi-line comments are to be
> 	 * formatted like this.
> 	 */

Comment style fixed:

-- 8< --

When cherry-picking multiple commits, it's impossible to have both
merge- and non-merge commits on the same command-line. Not specifying
'-m 1' results in cherry-pick refusing to handle merge commits, while
specifying '-m 1' fails on non-merge commits.

This patch allows '-m 1' for non-merge commits. Besides, as mainline is
always the only parent for a non-merge commit, it made little sense to
disable it in the first place.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e1a4dd1..d0fd61b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1766,9 +1766,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			return error(_("commit %s does not have parent %d"),
 				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
-	} else if (0 < opts->mainline)
-		return error(_("mainline was specified but commit %s is not a merge."),
-			oid_to_hex(&commit->object.oid));
+	} else if (1 < opts->mainline)
+		/*
+		 *  Non-first parent explicitly specified as mainline for
+		 *  non-merge commit
+		 */
+		return error(_("commit %s does not have parent %d"),
+			     oid_to_hex(&commit->object.oid), opts->mainline);
 	else
 		parent = commit->parents->item;
 
-- 
2.10.0.1.g57b01a3

