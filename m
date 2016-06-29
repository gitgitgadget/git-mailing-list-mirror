Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2231FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 16:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbcF2Qc0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 12:32:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751372AbcF2QcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 12:32:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 867382763D;
	Wed, 29 Jun 2016 12:32:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kdyTaP9pGyZmKnxo4aUr7jcMbiM=; b=MVL0iP
	Gf73RKKx1zy2F2kJm2rNya3BYM2VZ1WcmVmSEvRqgkyxux/g5rzf/4snOPaf5liq
	Izq9wM+qAiRp2x4Ktd0C3IFTCgImpwjNNQzSacSV7ocueewSIJCBOoEmc6Fq+TRC
	rBx/ZysVbamEwY+IDm6ckQ1N6LdofpQX04Cs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ETd6x8ciK2FcTGQcwDsreqMOVk8Do5/E
	2ap4h/qMszK4zxsFUB2mOUJzMstxusL+xQcxDi4YbjCroZfhYa/RGxOXK4eYi5q/
	o/g4sVVBHv0GRHVwA4CLScgbW51ZbHQw7P+0nL9+Odl9aUzqZNDwEywZUZGALqVn
	9DbCjgCzg4U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DD2E2763B;
	Wed, 29 Jun 2016 12:32:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1486B2763A;
	Wed, 29 Jun 2016 12:32:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	neuling@dakosy.de
Cc:	git@vger.kernel.org
Subject: Re: git pull --rebase should use fast forward merge if possible
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
Date:	Wed, 29 Jun 2016 09:32:21 -0700
In-Reply-To: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
	(neuling@dakosy.de's message of "Wed, 29 Jun 2016 18:18:37 +0200")
Message-ID: <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F29FE68-3E17-11E6-B0C6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

neuling@dakosy.de writes:

> since I have added "pull.rebase=preserve" to my global configuration I 
> wonder why "git pull" also trys to rebase if a fast forward merge is 
> possible. 
>
> A fast forward merge would speed up every pull if your local branch 
> contains no new commits and the remote branch is ahead. The result would 
> be the same. 
>
> Is it possible to change the behavior of "git pull 
> --rebase=true|preserve|interactive" to use a fast forward merge if the 
> remote branch is ahead and the local branch contains no new commits? 

Interesting.  I do not think of a reason why we shouldn't.

If we were still working in scripted Porcelain, it would have been a
five minute hack, perhaps like this.

 contrib/examples/git-pull.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
index 6b3a03f..3648040 100755
--- a/contrib/examples/git-pull.sh
+++ b/contrib/examples/git-pull.sh
@@ -358,6 +358,14 @@ fi
 
 if test true = "$rebase"
 then
+	if git merge-base --is-ancestor "$orig_head" "$merge_head"
+	then
+		# We can just fast-forward, as "git rebase --no-ff"
+		# is nonsense.
+		git merge --ff-only "$merge_head"
+		exit
+	fi
+
 	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
 	if test "$oldremoteref" = "$o"
 	then
