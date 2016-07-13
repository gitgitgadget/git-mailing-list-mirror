Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590EA2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 21:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcGMV7r (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 17:59:47 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:39737 "EHLO
	homiemail-a101.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbcGMV7p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 17:59:45 -0400
Received: from homiemail-a101.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a101.g.dreamhost.com (Postfix) with ESMTP id 2632C117E06A;
	Wed, 13 Jul 2016 14:59:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=zUEgV
	XsaoLHFLPb31QNJJmtuF90=; b=s19JOqSUIeBszI/8xGXxpZgteRwX37LXfPeBl
	qBmYMqo0I+k0FcprtCa/Nh1526FlA/mYxmaOwQU3OTdQzZQCajyMUenBWVttfqkV
	qR7ZDNTDjTINYGegKk6LDnqPQ0iCGcIc3rV420cChg2C/H0++GJb9YVC/6UW7dul
	SIgwaQ=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a101.g.dreamhost.com (Postfix) with ESMTPSA id 9C145117E065;
	Wed, 13 Jul 2016 14:59:43 -0700 (PDT)
Subject: Re: [PATCH v14 00/21] index-helper/watchman
To:	Duy Nguyen <pclouds@gmail.com>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
 <CACsJy8Br-rSTKjpt2ykn8YyFruy8CZoXWm287BtTRcAYY2DjVw@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, kmaggg@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:	David Turner <novalis@novalis.org>
Message-ID: <5786B9CE.6010703@novalis.org>
Date:	Wed, 13 Jul 2016 17:59:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Br-rSTKjpt2ykn8YyFruy8CZoXWm287BtTRcAYY2DjVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 07/12/2016 02:24 PM, Duy Nguyen wrote:
> Just thinking out loud. I've been thinking about this more about this.
> After the move from signal-based to unix socket for communication, we
> probably are better off with a simpler design than the shm-alike one
> we have now.
>
> What if we send everything over a socket or a pipe? Sending 500MB over
> a unix socket takes 253ms, that's insignificant when operations on an
> index that size usually take seconds. If we send everything over
> socket/pipe, we can trust data integrity and don't have to verify,
> even the trailing SHA-1 in shm file.

I think it would be good to make index operations not take seconds.

In general, we should not need to verify the trailing SHA-1 for shm 
data.  So the index-helper verifies it when it loads it, but the git 
(e.g.) status should not need to verify.

Also, if we have two git commands running at the same time, the 
index-helper can only serve one at a time; with shm, both can run at 
full speed.

> So, what I have in mind is this, at read index time, instead of open a
> socket, we run a separate program and communicate via pipes. We can
> exchange capabilities if needed, then the program sends the entire
> current index, the list of updated files back (and/or the list of dirs
> to invalidate). The design looks very much like a smudge/clean filter.

This seems very complicated.  Now git status talks to the separate 
program, which talks to the index-helper, which talks to watchman.  That 
is a lot of steps!

I think we should wait until we heard from the Windows folks what the 
problems with the current solution are, and see what design they come up 
with.

> For people who don't want extra daemon, they can write a short script
> that saves indexes somewhere in tmpfs, and talk to watchman or
> something else. I haven't written this script, but I don't think it
> takes long to write one. Windows folks have total freedom to implement
> a daemon, a service or whatever and use this program as front end. How
> the service talks to this program is totally up to them. For people
> who want to centralize everything, they can have just one daemon and
> have the script to talk to this daemon.
>
> I can see that getting rid of file-based stuff simplifies some
> patches. We can still provide a daemon to do more advanced stuff (or
> to make it work out of the box). But it's not a hard requirement and
> we probably don't need to include one right now. And I think it makes
> it easier to test as well because we can just go with some fake file
> monitor service instead of real watchman.

I think the daemon also has the advantage that it can reload the index 
as soon as it changes.  This is not quite implemented, but it would be 
pretty easy to do.  That would save a lot of time in the typical workflow.
