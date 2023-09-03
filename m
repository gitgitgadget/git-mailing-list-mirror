Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD2EC71153
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 04:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjICEuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 00:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjICEuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 00:50:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA8CC5
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 21:50:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F04B1A01A9;
        Sun,  3 Sep 2023 00:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7MggxzAN3kimcaf56snjlHM8vwqJFMOSoygU4P
        x+Cyk=; b=yhfsWq/9VTa64kltntoNJM5+PbPX2+bjnBuirzWYCcvlxG/aiGhykE
        b6PjzGwYvFbyhfb+O7BlYPQk+ER5yssHN2b80T+p+NYvItRRfvuwA5IA7vuoThn7
        n8SpQjTgyExfJS5eoBwefsBZcCMghUR0fm5/2+3xuhDSfvGVKFtiY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 771971A01A6;
        Sun,  3 Sep 2023 00:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E55BE1A01A5;
        Sun,  3 Sep 2023 00:50:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <xmqq4jkckuy7.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        02 Sep 2023 16:37:52 -0700")
References: <xmqq1qfiubg5.fsf@gitster.g>
        <20230902221641.1399624-1-wesleys@opperschaap.net>
        <20230902221641.1399624-3-wesleys@opperschaap.net>
        <xmqq4jkckuy7.fsf@gitster.g>
Date:   Sat, 02 Sep 2023 21:50:18 -0700
Message-ID: <xmqqlednuagl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62545072-4A15-11EE-A12E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you rewind to lose commits from the branch you are (re)building
> against, and what was rewound and discarded was part of the work you
> are building, whether it is on a local branch or on a remote branch
> that contains what you have already pushed, they will be discarded,
> it is by design, and it is a known deficiency with the fork-point
> heuristics.  How the fork-point heuristics breaks down is rather
> well known ...

Another tangent, this time very closely related to this topic, is
that it may be worth warning when the fork-point heuristics chooses
the base commit that is different from the original upstream,
regardless of how we ended up using fork-point heuristics.

Experienced users may not be confused when the heuristics kicks in
and when it does not (e.g. because they configured, because they
used the "lazy" form, or because they gave "--fork-point" from the
command line explicitly), but they still may get surprising results
if a reflog entry chosen to be used as the base by the heuristics is
not what they expected to be used, and can lose their work that way.
Imagine that you pushed your work to the remote that is a shared
repository, and then continued building on top of it, while others
rewound the remote branch to eject your work, and your "git fetch"
updated the remote-tracking branch.  You'll be pretty much in the
same situation you had in your reproduction recipe that rewound your
own local branch that you used to build your derived work on and
would lose your work the same way, if you do not notice that the
remote branch has been rewound (and the fork-point heuristics chose
a "wrong" commit from the reflog of your remote-tracking branch.

Perhaps something along the lines of this (not even compile tested,
though)...  It might even be useful to show a shortlog between the
.restrict_revision and .upstream, which is the list of commits that
is potentially lost, but that might turn out to be excessively loud
and noisy in the workflow of those who do benefit from the
fork-point heuristics because their project rewinds branches too
often and too wildly for them to manually keep track of.  I dunno.


 builtin/rebase.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git c/builtin/rebase.c w/builtin/rebase.c
index 50cb85751f..432a97e205 100644
--- c/builtin/rebase.c
+++ w/builtin/rebase.c
@@ -1721,9 +1721,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (keep_base && options.reapply_cherry_picks)
 		options.upstream = options.onto;
 
-	if (options.fork_point > 0)
+	if (options.fork_point > 0) {
 		options.restrict_revision =
 			get_fork_point(options.upstream_name, options.orig_head);
+		if (options.restrict_revision &&
+		    options.restrict_revision != options.upstream)
+			warning(_("fork-point heuristics using %s from the reflog of %s"),
+				oid_to_hex(&options.restrict_revision->object.oid),
+				options.upstream_name);
+	}
 
 	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));

