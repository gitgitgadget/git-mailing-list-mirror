Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B84203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbcGYRdj (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:33:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752488AbcGYRdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:33:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 468D230E2E;
	Mon, 25 Jul 2016 13:33:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mqiytBd60iurDTysrUOZ/mRRpXE=; b=xyu6pa
	zjvdX8sHQjTdLte2IbAR5Sf72wQ6PO8UkQVBQX3R/iNgXnrgoxkNa2NQrFQeeWoT
	Y4QSq9Of+8tPWLHYw2qAzHr4zhN1O6Sk69NCMWYXl+nS2A0JBsqkEpbuYRBBIJGJ
	7n7cl9Q04DfludC5GROOEGKEz3Rq/NJkHhK8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KHnC9ATvfSJtGOzO+QrPwJkXRERaxoGr
	da7sBOuIYY+G3iwWTWd9hMB7QE/VdT2y2LdoPzjfMAMQMypl0UoA3ARcBndNHrJ3
	YR1WW32QeLBA0QCoi6SLwXolOKn3eGqwiBF1u+lkz4DR9f8cmcU0lFtVKjLQJuoO
	qTOB6/kjzvw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E83F30E2D;
	Mon, 25 Jul 2016 13:33:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A26CE30E2B;
	Mon, 25 Jul 2016 13:33:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by mailsplit
References: <20160722224739.GA22961@whir>
	<xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
	<xmqqd1m3825y.fsf@gitster.mtv.corp.google.com>
	<20160725084357.GA8025@starla>
Date:	Mon, 25 Jul 2016 10:33:32 -0700
In-Reply-To: <20160725084357.GA8025@starla> (Eric Wong's message of "Mon, 25
	Jul 2016 08:43:57 +0000")
Message-ID: <xmqqzip562s3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9BDC67E-528D-11E6-A813-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

>> Also, doesn't it break "git rebase" (non-interactive), or anything
>> that internally runs format-patch to individual files and then runs
>> am on each of them, anything that knows that each output file from
>> format-patch corresponds to a single change and there is no need to
>> split, badly if we do this unconditionally?
>
> Yes, rebase should probably unescape is_from_line matches.

This shouldn't matter for "git rebase", as it only reads from the
mbox "From <commit object name> <datestamp>" line to learn the
original commit and extract the log message directly from there.

But a third-party script that wants to read format-patch output
would be forced to upgrade, which is a pain if we make this change
unconditionally.

>> IOW, shouldn't this be an optional feature to format-patch that
>> is triggered by passing a new command line option that currently
>> nobody is passing?
