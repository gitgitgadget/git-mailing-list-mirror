Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43CD20133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdCCQej (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:34:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57819 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751823AbdCCQeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 11:34:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D232A5F7B3;
        Fri,  3 Mar 2017 11:16:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=2
        ujGO2cwyBuoD8Wr5M59Qo+QMv4=; b=wS8T943M5E41XzqZK5yo3LLX/wy7kpolB
        j4VP21Iev6u+vVzv1rAw9bv7ig++VFUgeornK/FErjC3DMmhGGwn2EnNivTXfESl
        pB3Gw8psAI/jOPha0OmVQwViFhMDPNh/jEm+EieHM/iqdUHefWX9BdRGJoo6ublt
        pOFdRkfDeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=riA
        dH7fXigtEysXvOcZcYdPOG44mPYQzr1aAnP/U7YFOE/mPLaVkWPaC+pMm7rLwOU6
        BoeRzDzrlWVNs59JyRMRfGquBRHnoVDsgE+Dl4L2l1G3KMgKOLN767X0mRlr3LTl
        5oJjcArtaZADnl2UD3BlcoGCZyBasTcVbdiEmbJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C84485F7B2;
        Fri,  3 Mar 2017 11:16:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 397125F7AF;
        Fri,  3 Mar 2017 11:16:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: bisect-helper: we do not bisect --objects
Date:   Fri, 03 Mar 2017 08:16:11 -0800
Message-ID: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7EE472A-002C-11E7-BBBB-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since "bisect--helper" was introduced in 1bf072e366
("bisect--helper: implement "git bisect--helper"", 2009-03-26),
after setting up the "rev-list $bad --not $good_ones" machinery, the
code somehow prepared to mark the trees and blobs at the good boundary
as uninteresting, only when --objects option was given.  This was kept
across a bit of refactoring done by 2ace9727be ("bisect: move common
bisect functionality to "bisect_common"", 2009-04-19) and survives
to this day.

However, "git bisect" does not care about tree/blob object
reachability at all---it purely works at the commit DAG level and
nobody passes (and nobody should pass) "--objects" option to the
underlying rev-list machinery.  Remove the dead code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Christian, do you recall what we were thinking when we added this
   mark_edges_uninteresting() call in this program?  If you don't,
   don't worry--this was done more than 8 years ago.  I am just
   being curious and also a bit being cautious in case I am missing
   something.

   Thanks.

 bisect.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 30808cadf7..86c5929a23 100644
--- a/bisect.c
+++ b/bisect.c
@@ -634,8 +634,6 @@ static void bisect_common(struct rev_info *revs)
 {
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
-	if (revs->tree_objects)
-		mark_edges_uninteresting(revs, NULL);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
