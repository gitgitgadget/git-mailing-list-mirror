Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F5320193
	for <e@80x24.org>; Thu,  4 Aug 2016 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933733AbcHDR2N (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 13:28:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758831AbcHDR2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 13:28:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 360A231CA5;
	Thu,  4 Aug 2016 13:28:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Q26BJW7tPrE7dEYiidmk3brMC0=; b=dza2P4
	xwnLTE1N/e/flYQzhB+gk1Yjh22pvEwQ8hL321hC3hpn86dALJF8oOSZ9DuXdnCc
	MtdE7LpQFzmzrzCEXLIGecMsyaCKsFG1vJtXvBnK6tBbxfPMFGAf+ucD4tfQS9Zh
	3SLrdgHP2hQ3pewuIIUG8/U1by4Izy12iyAto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJenp3OH6o4O8ZwI/5aj5XsU9N8reo0T
	+MMdGnkr4Pg+58WZgBemgl+itQNDevdVVgWoh3Zby9JFNQ8iUpjWrjlN15+8tBXQ
	etJZ4aMDIqPISX2t9Z2iq6gQ+hxmVp5UslrX5guIDIInwrYQzVrTR6lZuxsEUXj9
	ZyGZ9DIXYQ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CE8331CA4;
	Thu,  4 Aug 2016 13:28:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB52031CA0;
	Thu,  4 Aug 2016 13:28:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ed Greenberg <edg@greenberg.org>
Cc:	git@vger.kernel.org
Subject: Re: Problem with two copies of same branch diverging
References: <0aab65de-21a3-eb48-c5b0-3e36d924348a@greenberg.org>
Date:	Thu, 04 Aug 2016 10:28:07 -0700
In-Reply-To: <0aab65de-21a3-eb48-c5b0-3e36d924348a@greenberg.org> (Ed
	Greenberg's message of "Thu, 4 Aug 2016 11:08:34 -0400")
Message-ID: <xmqqshuk4f6g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D02D7D5C-5A68-11E6-B3C4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ed Greenberg <edg@greenberg.org> writes:

> Hi, Thanks for reading my question.
>
> I have two copies of code checked out at the same branch. Desktop and
> remote server.
>
> I use an IDE that automatically SFTP transfers each save from the
> desktop to the remote server, so I can run my changes on the server
> environment.

You are syncing _ONLY_ the working tree state without syncing Git
state at all, and that is why the server side gets confused.  You
have to stop doing that.

If you do not do any change on the server end, you can simply stop
having a git repository there; just treat its directory as what it
really is: a copy of the working tree, something akin to an
extracted tarball.

If you do change on both, you probably are better off without the
mechanism to copy working tree one-way that you currently have.
Just push or fetch between the two repositories and integrate the
local changes.

Having said all that.

> At the end of the session, I commit the code on my desktop, do a git
> push to the repo.

> When I look at the server, the code there is identical to what's on my
> desktop box and what I just comitted and pushed, but, of course, git
> status thinks it's all modified and wants me to either commit it or
> stash it.  

This is expected as pushing into the remote would not affect what is
checked out, most importantly, the index.  But this ...

> In fact, doing a git log on the server doesn't show my
> latest push.  

... indicates that you are not pushing to update the remote
repository correctly.  Once you get that part working correctly,
after you push at the end of the session, you should be able to do
"git reset" at the other side to tell Git to notice that the updated
working tree files that were transferred behind its back are now in
sync with what is supposed to be checked out.
