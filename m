Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB923C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7E52220C
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hCOSxSjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIXT4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:56:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58598 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgIXT4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 15:56:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0E988F016;
        Thu, 24 Sep 2020 15:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8C3uaYxBUWuFSw3sOXbF0U/kDkc=; b=hCOSxS
        jsOmNZd1UNwPVCeTPgVvKI2W+ac+m4nVE0h5HfoSjs+q+kMFS5DiwhtqHineEolj
        636A28QdjzfVGSilNu0t1oJEE+xD4RRG1Sy9MhrZxQ87FUPlW7thnAhSpPj2BTJp
        hEGEPZczAIIW6BxqQ9LcqFatCR/O+Z5nETvl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qw5+Nu854qzFL2yAiMnV5WnmLBMA1b4r
        bkeb9TSTgpsEtInGq+Il+hK/QPBCdwfk+DpwpJs7w92wn5J6J7cfR1D/Nm0264U+
        f7UR7xGU3RFhrT1lLqN2EXH33e+FoDOTXdTYUp4CR3rDC6k+AeTGEP2LQwP2EWCx
        S8QHYplqbrk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E70028F015;
        Thu, 24 Sep 2020 15:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 147458F012;
        Thu, 24 Sep 2020 15:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <20200924060344.15541-1-chriscool@tuxfamily.org>
        <xmqqsgb7m2bq.fsf@gitster.c.googlers.com>
Date:   Thu, 24 Sep 2020 12:56:11 -0700
In-Reply-To: <xmqqsgb7m2bq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 24 Sep 2020 11:55:53 -0700")
Message-ID: <xmqqk0wjlzj8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF14FDCC-FE9F-11EA-913D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We may need to audit recent additions of get_oid_committish() calls
> in our codebase.  I suspect there may be other instances of the same
> mistake.

Interim progress report.  I've only looked at files that use
get_oid_treeish() but audited all uses of get_oid_*ish() in them.

The results are as follows.

 * builtin/reset.c::parse_args() makes get_oid_committish() and
   get_oid_treeish() only to discard the object name, because it
   wants to ensure the args can be peeled down to such.  OK.

 * builtin/reset.c::cmd_reset() applies get_oid_committish() and
   get_oid_treeish() to the result taken from the above, but then
   uses lookup_commit_reference() and parse_tree_indirect() to peel
   the result to the desired type.  OK.

 * notes.c::init_notes() uses get_oid_treeish() to validate that the
   notes ref can be read as a tree, and then uses get_tree_entry()
   on it, which in turn uses read_object_with_reference() for
   tree_type so it tolerates a commit object.  OK.


I didn't audit the following hits of get_oid_committish().  There
might be a similar mistake as you made in v2, or there may not be.

I am undecided if I should just move on, marking them as
left-over-bits ;-)



builtin/blame.c:		if (get_oid_committish(i->string, &oid))
builtin/checkout.c:		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
builtin/rev-parse.c:	if (!get_oid_committish(start, &start_oid) && !get_oid_committish(end, &end_oid)) {
builtin/rev-parse.c:	if (get_oid_committish(arg, &oid) ||
commit.c:	if (get_oid_committish(name, &oid))
revision.c:	if (get_oid_committish(arg, &oid))
sequencer.c:		    !get_oid_committish(buf.buf, &oid))
sha1-name.c:		st = repo_get_oid_committish(r, sb.buf, &oid_tmp);
sha1-name.c:	if (repo_get_oid_committish(r, dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
sha1-name.c:int repo_get_oid_committish(struct repository *r,
t/helper/test-reach.c:		if (get_oid_committish(buf.buf + 2, &oid))

