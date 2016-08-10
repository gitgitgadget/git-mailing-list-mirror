Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4A81FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602AbcHJV64 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:58:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933372AbcHJV6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 17:58:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9066B35018;
	Wed, 10 Aug 2016 17:58:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xIVcehehbxKd+V/X/ti/8KX2XGo=; b=wGo3QO
	SwIxoh7wlgpRUjmdnkOW29+V2nsZFDiDmKl2uAiFDTtf9ySkHCOLjPdrTpt8hlB/
	hmx9YPccIcMPZXj5Fav9onnT+Y69khkzsgdk9FCYcV3rqTPj+KdwXe6QXB+bYhgG
	AOjrMqlulhv/zaPFBYS1YnW2SyWM4MqusKFjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OUBnm0wBHyjWRR0GJOUdQyTpxcZQsnfX
	mxb4Pz5qILgD/vn25v/PymG9VKMNzarWk/a4kFtTNRZuPETGBm27muGpYUjl0mIl
	/dodmlivFHe92wOhB8XTYg7ZSuxHsKrb/NbjmA0pdUNLEWK7vxv5u9urVu4j/9xM
	qiDzLyLTm0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 884ED35017;
	Wed, 10 Aug 2016 17:58:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 116DA35015;
	Wed, 10 Aug 2016 17:58:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/2] diff: add --line-prefix option for passing in a prefix
References: <20160810211710.23173-1-jacob.e.keller@intel.com>
Date:	Wed, 10 Aug 2016 14:58:50 -0700
In-Reply-To: <20160810211710.23173-1-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Wed, 10 Aug 2016 14:17:09 -0700")
Message-ID: <xmqq4m6s476t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0756FA2-5F45-11E6-B9F1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> As suggested by Junio, I implemented --line-prefix to enable the graph
> display correctly. This works by a neat trick of adding to the msgbuf,
> so no code needs to be altered. I presumed that the line prefix should
> go *after* the graphs own prefix.

I do not understand the last sentence.

The motivation I suggested the --line-prefix for is for a scenario
in which "git log -p --graph" that recurses into a submodule causes
"git diff A B" between the two commits in a submodule to run; the
internal diff machinery driven by "log -p --graph" for the
superproject knows what the graph lines that depict the lineages of
history in the superproject should look like, but the "git diff A B"
in the submodule of course does not, so while showing e.g. "| | |"
(three lineages) for the history in the superproject, you would run
"git diff --line-prefix='| | | ' A B" and by showing them before
anything that "git diff A B" without the new option would have
produced, you could mimick and match the graph output in the
superproject.

In that scenario, the line prefix _is_ the graph's prefix in the
superproject.

You might be envisioning a future enhancement where the recursive
one uses not "-Submodule commit A"/"-Submodule commit B", and not
"diff A B", but "log -p A...B" in the submodule, and in such a case,
it might make sense to run "log -p --graph A...B" instead when the
command the end user run in the superproject asked for "--graph".
You would use the same "--line-prefix='| | | '" when running the
"log -p --graph A...B" command in the submodule, so that the output
for the submodule will go _after_ the graph of the superproject, but
in that case, the output for the submodule would also include its
own graph to show the relationship between A and B.  The line-prefix
must come before that graph part (and also if it is "git log" run in
the submodule, the same line-prefix must come before each line of
the log message output).

With that understanding/assumption, "line prefix should go after the
graph's own prefix" sounds like a wrong choice to me.  Shouldn't the
prefix go before everything else?

