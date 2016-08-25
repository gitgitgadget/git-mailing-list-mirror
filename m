Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5DC1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758045AbcHYUvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:51:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754179AbcHYUvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:51:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07D8A3921F;
        Thu, 25 Aug 2016 16:50:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=309wYCw9cVMKA1SEmzU4JsnztJk=; b=hY5HR0
        Bte/K9BzIuXAXJTS+XDTMbbI1DWvxKRJJXQSIjPdUU3Pm/QF39lnD9KtSw10I12k
        hG+aPU9EkKafgcp3LmCBK1UH97Ohl8ssDuEpDfxBdyHx1JDbDrC7dGEcX7zWLZVz
        elFvXPpD7n1tut5ZySSnG5kPXAek4ctXE5qQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LR0GtXmbmWW+IcxV/TBeG3D2tWKD/HpE
        idRah+98kAWa3JdX+Hr24xQbUTcQT4vGDchlIjT6Ts3MkeoTm1cqKsvU++7oB+HS
        tiPKI//CzpwyhVnvp5LDGWKyTmSuV8XAo6PhCW7YnKzSE0VeY8fBA02wmYafOcIK
        XnROPF0aqzg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 001233921E;
        Thu, 25 Aug 2016 16:50:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 808843921D;
        Thu, 25 Aug 2016 16:50:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Hedges Alexander <ahedges@student.ethz.ch>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Feature Request: Branch-Aware Submodules
References: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
        <CAGZ79kbHfofmowHnwzFrumc1XJHE=ZMQEwNSeOSyF7YDG+aSjw@mail.gmail.com>
Date:   Thu, 25 Aug 2016 13:50:29 -0700
In-Reply-To: <CAGZ79kbHfofmowHnwzFrumc1XJHE=ZMQEwNSeOSyF7YDG+aSjw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 Aug 2016 10:45:59 -0700")
Message-ID: <xmqqlgzklgiy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FF2562E-6B05-11E6-A284-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +cc Jacob and Lars who work with submodules as well.
>
> On Thu, Aug 25, 2016 at 2:00 AM, Hedges  Alexander
> <ahedges@student.ethz.ch> wrote:
>>
>> Right now updating a submodule in a topic branch and merging it into master
>> will not change the submodule index in master leading to at least two commit
>> for the same change (one in any active branch). This happened to me quite a few
>> times. To a newcomer this behavior is confusing and it leads to unnecessary
>> commits.
>
> So you roughly do
>
>     git checkout -b new-topic
>     # change the submodule to point at the latest upstream version:
>     git submodule update --remote <submodule-path>
>     git commit -a -m "update submodule"
>     git checkout master
>     git merge new-topic
>     # here seems to be your point of critic?
>     # now the submodule pointer would still point to the latest
> upstream version?

Isn't <submodule-path> subject to the usual 3-way merge when the
last step (i.e. a merge of new-topic branch into master in the
superproject) is made?  If 'master' hasn't changed <submodule-path>
since 'new-topic' forked from it, because 'new-topic' updated the
commit bound at <submodule-path>, doesn't "git merge new-topic" just
take that change as the normal "One side updated, the other did not
touch; take the update" merge?
