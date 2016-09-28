Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5508A1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbcI1Rw3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:52:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58256 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751670AbcI1RwV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:52:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA00F42037;
        Wed, 28 Sep 2016 13:52:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TNlgtvHKVKO4yCZS4r6KUDxL1tg=; b=ybG4zM
        4kqK7xvC3BUXm5qOPVH1ieCvhgxOCc0J4lx2ihy6GdJGRCIvCJNFCI6cN950rX2d
        59sCfpBACEerT51qF3bFlUaZ2LTrIykmiGOt1bZFtBhutGaMlYzozzZdxlGTbVaK
        Z9MZbBFm3e24swd90hQsjnUS/OU4iq2FN1Y90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lddklgDo3S1DpMZhaKDqUkjdWoudwqCD
        YSOPjncUJZ8AW+Nk4HG0B8CPzKrt4irvFyhpUm7938OuAt9vOhfQRyxyI+byU9ly
        nraiRsQKz2xV3I9gSsteNSU4Dwy11QaWspFk1TNteJPCc1BNEVYQgpDdJiscQ9eq
        ANlcBi0vvmk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B263F42036;
        Wed, 28 Sep 2016 13:52:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34C5742035;
        Wed, 28 Sep 2016 13:52:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Peart" <peartben@gmail.com>
Cc:     <git@vger.kernel.org>, "Ben Peart" <Ben.Peart@microsoft.com>,
        <pclouds@gmail.com>, "Jeff Hostetler" <jeffhost@microsoft.com>,
        <philipoakley@iee.org>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
References: <004d01d219aa$0a941fa0$1fbc5ee0$@gmail.com>
Date:   Wed, 28 Sep 2016 10:52:15 -0700
In-Reply-To: <004d01d219aa$0a941fa0$1fbc5ee0$@gmail.com> (Ben Peart's message
        of "Wed, 28 Sep 2016 13:02:04 -0400")
Message-ID: <xmqqtwczkj3k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CEA1970-85A4-11E6-B2D3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Peart" <peartben@gmail.com> writes:

> The fact that "git checkout -b NEW" updates the index and as a
> result reflects any changes in the sparse-checkout and the issue 
> Junio pointed out earlier about not calling show_local_changes 
> at the end of merge_working_tree are the only difference in behavior
> I am aware of.  Both of these are easily rectified.
>
> That said, given we are skipping huge amounts of work by no longer 
> merging the commit trees, generating a new index, and merging the 
> local modifications in the working tree, it is possible that there are
> other behavior changes I'm just not aware of.

That is OK.  It is not ok to leave such bugs at the end of the
development before the topic is merged to 'master' to be delivered
to the end users, but you do not have to fight alone to produce a
perfect piece of code with your first attempt.  That's what the
reviews and testing period are for.

If you are shooting for the same behaviour, then that is much better
than "make 'checkout -b NEW' be equivalent to a sequence of
update-ref && symbolic-ref, which is different from others", which
was the second explanation you gave earlier.  I am much happier with
that goal.

But if that is the case, I really do not see any point of singling
out "-b NEW" case.  The following property MUST be kept:

 (1) "git checkout -b NEW", "git checkout", "git checkout HEAD^0"
     and "git checkout HEAD" (no other parameters to any of them)
     ought to give identical index and working tree.  It is too
     confusing to leave subtly different results that will lead to
     hard to diagnose bugs for only one of them.

That would make the "do we skip unpack_trees() call?" decision a lot
simpler to make, I would suspect.  We only need to see "are the two
trees we would fed unpack_trees() the same as HEAD's tree?" and do
not have to look at new_branch and other irrelevant things at all.
What happens in the ref namespace is immaterial, as making or
skipping an unpack_trees() call would not affect anything other than
the resulting index and the working tree.  If we want to keep that
sparse-checkout wart, we would also need to see if the control file
sparse-checkout keeps in $GIT_DIR/ exists, but the result will be
much simpler set of rules, and would hopefully help remove the "the
optimization kicks in following logic that is an unreviewable-mess"
issue.



