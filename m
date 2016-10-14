Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699C61F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 16:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbcJNQIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 12:08:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753498AbcJNQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 12:08:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A57424450B;
        Fri, 14 Oct 2016 12:07:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VNWavFwvsJIw3V8JMaZm/sjELtI=; b=ZdaVwc
        Qs6RYana4AFylRUUScJ+qskUii1oLVIFBuEDe74geU+cTLL1+wkOqHLU0dqG/aE7
        0gXdZbLHzBtstXHbQmxoUp8yTzzJArhNbYHx+wo/MIjljB312phX2qFEEZrPg63C
        0127eubdeH2rUQLrpb+ad+VhZ/QI/1q+zdsy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i68Fat0eCo5WxmB9/9Ksaczez4J6B+6z
        V+kSV/jIUoYN78X8glrMVyOnQdyrrVkOFdlkNN1K83oEUrYoKTbSnz24Ze/WKAoN
        viAs6DJKdRQfbk2PyudIJW18oUfKHzZ7G4s9lhU3jxWAkVwc2uqfejDC2zv5fV8q
        P+vxcrwru24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DBA84450A;
        Fri, 14 Oct 2016 12:07:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FD9944501;
        Fri, 14 Oct 2016 12:07:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org
Subject: Re: Why does git checkout -b touch the index?
References: <1476455756.32360.2.camel@frank>
Date:   Fri, 14 Oct 2016 09:07:55 -0700
In-Reply-To: <1476455756.32360.2.camel@frank> (David Turner's message of "Fri,
        14 Oct 2016 10:35:56 -0400")
Message-ID: <xmqq4m4e29t0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F970EE4-9228-11E6-9C5F-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> If I do "git checkout -b fleem", with no additional flags, why does it
> need to rewrite the index?  Or even read the index? 

The "reading" part can be explained easily.

It needs to show the list of dirty paths, which involves reading the
index, refreshing them in-core to cull the timestamp-only changes
out of the report.  

Once in-core index is refreshed, it is a waste not to write them out
if it can, so it is not surprising if it writes, too.

The real reason is a lot more involved.  "git checkout -b new" is
different from "git update-ref refs/heads/new HEAD" (i.e. create a
new branch at the same commit) followed by "git symbolic-ref HEAD
refs/heads/new" (i.e. point the HEAD at it).  If it were, I fully
agree with you that it shouldn't need to touch either index or
working tree at all.

It is "git branch new" followed by "git checkout new", and the
latter step does the full two-tree "read-tree" between the same two
commits.  I personally very much prefer "Switching between the same
two commits?  That should be a no-op by definition.", but we cannot
blindly that naive optimization, as it would break some use cases
(which I personally do not care too much about ;-).

For example, extra working tree files outside the "sparse" area are
removed when sparse-checkout is in use while switching from the
current branch to the new and identical branch.  I do not personally
agree with the behaviour, but that has been what the users accept;
there may be other funnies like that.
