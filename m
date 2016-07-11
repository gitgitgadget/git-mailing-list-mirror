Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C6D1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbcGKSwK (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 14:52:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932473AbcGKSwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 14:52:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECAFF2C0F1;
	Mon, 11 Jul 2016 14:52:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iSexpJYsz3bxPU2HBavyFe5cOtA=; b=jQkm9k
	sc6DNkLO+XCmvRG2IHTF0gODHrYO/iMu+ft+aSldp/ehrGfO+WiMrq4ckqJ+B59n
	Dp+WZ+2M8H+aXuh6RMIro6bWiE3KUtbZ5oewAv0201S98jlF5zYnPFSuXjUMlpHj
	J463sh+7rNHwP1hxlJPmhkLnKq2MU5Vaz6dTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nW+kdvIH6XPlhOKP/u1zQoF363zhopfy
	xGsCpLtAl1yAuoKt0VrA8vvG9pPVgZSuCTF9MeCSkbuDCHHZWbeWPph4yFi+DWM1
	66OoZE6rIgtlXph/cu1lsC4lQ5E8foLfg5QuYSKt+35BQSejSzNQ+PkXEQi6pii+
	jBqYSSyKDHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3F6A2C0F0;
	Mon, 11 Jul 2016 14:52:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E8072C0EF;
	Mon, 11 Jul 2016 14:52:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
References: <20160708025948.GA3226@x>
	<xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
	<20160708064448.GA18043@x>
	<xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607090928500.6426@virtualbox>
	<20160709140931.GA3185@x>
	<CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
	<alpine.DEB.2.20.1607101255300.6426@virtualbox>
	<CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
	<alpine.DEB.2.20.1607101602320.6426@virtualbox>
Date:	Mon, 11 Jul 2016 11:52:05 -0700
In-Reply-To: <alpine.DEB.2.20.1607101602320.6426@virtualbox> (Johannes
	Schindelin's message of "Sun, 10 Jul 2016 16:16:16 +0200 (CEST)")
Message-ID: <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91091C7C-4798-11E6-A52C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> No, the point is, refs subsystem needs to know which refs is per-repo,
>> which is per-worktree. So far the rules are  "everything under refs,
>> except a few known exceptions, is per-repo" and "everything directly
>> under $GIT_DIR is per-worktree", which work fine. But if you allow to
>> move per-worktree to "refs" freely, then the "known exceptions" will
>> have to be updated every time a new per-worktree ref appears. It'll be
>> easier to modify the first rule as "everything under refs, except some
>> legacy exceptions and refs/worktree, is per-repo".
>
> Given the substantial pain and suffering I have due to per-worktree
> reflogs (and those are *just* HEAD's reflogs!), it appears to me that
> per-worktree refs would be a particularly poor feature.
>
> I agree that HEAD needs to be per-worktree, but already the fact that the
> HEADs of the worktrees, along with their reflogs, are *not* visible to
> all other worktrees causes substantial trouble.

Not so fast; it cuts both ways.

People who want multiple worktrees with branches checked out to work
in would want to do per-worktree things like bisection, which needs
tons more state than we'd be comfortable having directly under
$GIT_DIR (e.g. they may also want "git merge" or "git pull", which
would use MERGE_HEAD and FETCH_HEAD that are per-worktree and not
under refs/; "git bisect" would want to mark number of commits to
denote the perimeter of the area of the history being bisected and
they live refs/bisect/).

And when you are bisecting in the worktree dedicated for a topic,
it is a feature that your other worktrees do not need to see how
much history you narrowed down in that topic.
