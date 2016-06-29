Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4501FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 17:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbcF2RXo (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 13:23:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751701AbcF2RXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 13:23:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9428526866;
	Wed, 29 Jun 2016 13:23:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bKkwi6T0WCFA07lItAED7NG26vU=; b=txBtAB
	A5eTuTuZI2F+4StoFT1DeZXjtTcFRimkP9PWayfDqv4Lr26+KXZG1py7XHDtfI+i
	t/qcwiwQUTkaeY3jhanhFFm13npakVWFrcgWzvpHbLuhwQWbhsDjstU77CpKU1oH
	f+JOh6lFBuSheXI/ZYT1PZfbKFKQUib+W8sis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BMJ6tuuIKlyOM6jUi2Xy8rjivy+LV+pF
	7YMDmO7DXCzUz82ThffVRZMp1M9lUdPKY3HAxmLCs4hMxhXbyn8o+yhEuuXX90ND
	su4WVjym+HF3IxiNNzl96uX6PgFG33/zZ2m4OhYFzDufb4q4V0Dj1eEE+wXyX1SC
	7Ft3ZEVLdCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D12A26865;
	Wed, 29 Jun 2016 13:23:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 128C926864;
	Wed, 29 Jun 2016 13:23:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	neuling@dakosy.de
Cc:	git@vger.kernel.org
Subject: Re: git pull --rebase should use fast forward merge if possible
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
	<xmqqd1n0552i.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 29 Jun 2016 10:23:05 -0700
In-Reply-To: <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jun 2016 09:32:21 -0700")
Message-ID: <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2585F232-3E1E-11E6-B9EB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Is it possible to change the behavior of "git pull 
>> --rebase=true|preserve|interactive" to use a fast forward merge if the 
>> remote branch is ahead and the local branch contains no new commits? 
>
> Interesting.  I do not think of a reason why we shouldn't.
>
> If we were still working in scripted Porcelain, it would have been a
> five minute hack, perhaps like this.
>
>  contrib/examples/git-pull.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)

... and if we have to work with built-ins, it becomes a lot larger
than a five-minute hack, unfortunately.

Something like this may have a chance of working ;-)

 builtin/pull.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index bf3fd3f..777ae56 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -878,10 +878,24 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (merge_heads.nr > 1)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(*merge_heads.sha1, curr_head);
-	} else if (opt_rebase) {
-		if (merge_heads.nr > 1)
-			die(_("Cannot rebase onto multiple branches."));
+	}
+	if (opt_rebase && merge_heads.nr > 1)
+		die(_("Cannot rebase onto multiple branches."));
+
+	if (opt_rebase) {
+		struct commit_list *list = NULL;
+		struct commit *merge_head, *head;
+
+		head = lookup_commit_reference(orig_head);
+		commit_list_insert(head, &list);
+		merge_head = lookup_commit_reference(merge_heads.sha1[0]);
+		if (is_descendant_of(merge_head, list)) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			return run_merge();
+		}
 		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
-	} else
+	}
+	else
 		return run_merge();
 }
