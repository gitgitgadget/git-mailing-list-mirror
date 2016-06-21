Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32031FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbcFUSow (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751466AbcFUSov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6824625ADA;
	Tue, 21 Jun 2016 14:31:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ehCiaq66toZgJgK4oQsupN1Hulw=; b=FDtpya
	0gbDH1TJccpLHDJbEc2bOzYY3HFkRHTcEYTaS78w/pEPMcQASmeFBidXAzWeg4rk
	2OpqSzfuXXNo5fxqui07iTJukxaxtUINIS8Uph83Yf8COpYjpsX7FCneAcw5xy5h
	M00Z4tBqyVKHCaFWf3VVfzL/MO8IQHXgj7fpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRA3tBDkgdFuzfp7aZWF8+9bwyTXwSEt
	nW9PF/OwpNwDag8YAwmzecnC6QFK4xnMR+ZVV1ygu0qHd3hife52lT5ZnM+Toa/M
	vAg17s3k9LirAxlNsb7OzaHuuNau47NTklpK8d0RvmMN5pPhvwyFtZVQs70OHKm0
	ecySyGQpYhk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5759B25AD9;
	Tue, 21 Jun 2016 14:31:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEF2A25AD8;
	Tue, 21 Jun 2016 14:31:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
	<xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
	<87lh1z78fr.fsf@thinkpad.rath.org> <87oa6ubeq4.fsf@thinkpad.rath.org>
Date:	Tue, 21 Jun 2016 11:31:04 -0700
In-Reply-To: <87oa6ubeq4.fsf@thinkpad.rath.org> (Nikolaus Rath's message of
	"Tue, 21 Jun 2016 11:04:35 -0700")
Message-ID: <xmqq7fdiqtqv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 515B15CC-37DE-11E6-AA30-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nikolaus Rath <Nikolaus@rath.org> writes:

> On Jun 20 2016, Nikolaus Rath <Nikolaus@rath.org> wrote:
>> On Jun 20 2016, Junio C Hamano <gitster@pobox.com> wrote:
>>> Nikolaus Rath <Nikolaus@rath.org> writes:
>>>
>>>> What's the best way to find all commits in a branch A that have not been
>>>> cherry-picked from (or to) another branch B?
>>>>
>>>> I think I could format-patch all commits in every branch into separate
>>>> files, hash the Author and Date of each files, and then compare the two
>>>> lists. But I'm hoping there's a way to instead have git do the
>>>> heavy-lifting?
>>>
>>> "git cherry" perhaps?
>>
>> That seems to work only the "wrong way around". I have a tag
>> fuse_3_0_start, which is the common ancestor to "master" and
>> "fuse_2_9_bugfix". I'd like to find all the commits from fuse_3_0_start
>> to master that have not been cherry-picked into fuse_2_9_bugfix.

Hmm, so the topology roughly would look like:

            A'--B'--D' 2fix
           /
          o---A---B---C---D---E---F master
	3start

And you want to find commits in 3start..master that do not have
equivalent in 3start..2fix

"git cherry --help" starts like this:

    NAME
           git-cherry - Find commits yet to be applied to upstream

    SYNOPSIS
           git cherry [-v] [<upstream> [<head> [<limit>]]]

    DESCRIPTION
           Determine whether there are commits in <head>..<upstream>
           that are equivalent to those in the range <limit>..<head>.

Applying that to our picture, we want to find commits yet to be
applied to 2fix, and do so by comparing the commits between
3start..master and 3start..2fix.

I find that the first sentence of the description is fuzzy
("Determine whether" would imply that you would get "Yes/No" but
what we want is "here are the commits that do not have counterpart
in 2fix"), but we already know <upstream> corresponds to 2fix
(i.e. we are finding ones yet to be applied to there, which can be
inferred from the NAME line), so <head> must be 'master' That means
that <limit> corresponds to 3start, and we will be comparing commits
in two ranges:

    master..2fix (i e. <head>..<upstream>, which is the same thing as 3start..2fix)
    3start..master (i.e. <limit>..<head>)

So perhaps "git cherry -v 2fix master 3start"?
