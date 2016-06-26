Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBAC20179
	for <e@80x24.org>; Sun, 26 Jun 2016 17:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbcFZRuA (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 13:50:00 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:53429 "EHLO
	homiemail-a75.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbcFZRt7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 13:49:59 -0400
Received: from homiemail-a75.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a75.g.dreamhost.com (Postfix) with ESMTP id 266215EC079;
	Sun, 26 Jun 2016 10:49:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=PogX7
	sEQGKaYWDYFBcLzGHAJpdM=; b=NjeF1Ewv5un1YzVS3+0odVJ1Df0gjtHFckEBA
	gKWc7y2ONNBhBrXWbEzkqE9Q73dhMs3xC4tewObsXl4FRx5RT2AQJXJDQh6D2slq
	83YlnU9XcDiVaa2T/XExrRQGt8ns4WoGqb6RwgC83klYrg0HgLaP1xCpxQbe1oRA
	Bdb7a0=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a75.g.dreamhost.com (Postfix) with ESMTPSA id AF7625EC072;
	Sun, 26 Jun 2016 10:49:58 -0700 (PDT)
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Eric Wong <e@80x24.org>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
 <576ED9A2.8070202@novalis.org> <20160626085347.GA4053@dcvr.yhbt.net>
Cc:	Duy Nguyen <pclouds@gmail.com>, kamggg@gmail.com,
	git@vger.kernel.org
From:	David Turner <novalis@novalis.org>
Message-ID: <577015C5.8070407@novalis.org>
Date:	Sun, 26 Jun 2016 13:49:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160626085347.GA4053@dcvr.yhbt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/26/2016 04:53 AM, Eric Wong wrote:
> David Turner <novalis@novalis.org> wrote:
>> On 06/25/2016 10:33 AM, Duy Nguyen wrote:
>>>> +               /*
>>>> +                * Our connection to the client is blocking since a client
>>>> +                * can always be killed by SIGINT or similar.
>>>> +                */
>>>> +               set_socket_blocking_flag(client_fd, 0);
>>>
>>> Out of curiosity, do we really need this? I thought default behavior
>>> was always blocking (and checked linux kernel, it seemed to agree with
>>> me). Maybe for extra safety because other OSes may default to
>>> something else?
>>
>> Yes -- see this bug report for details:
>> https://bugs.python.org/issue7995
>
> I realize it's an issue with BSDs, but it still seems
> unnecessary, here:
>
> 1) the packet_read => get_packet_data => read_in_full => xread
>     call chain already poll()s on EAGAIN/EWOULDBLOCK.
>     write_in_full => xwrite busy loops on EAGAIN/EWOULDBLOCK.
>     xwrite should probably poll, too; but I guess EAGAIN is
>     uncommon with small writes.

That is a CPU-burning busy loop on a non-blocking socket.

> 2) you create the listen fd you call accept on and never set
>     non-blocking on it.  It might be an issue one day if
>     we use socket activation and inherit a socket, but the
>     retries mentioned in 1) should cover that case.

Hm.  I wonder why I thought I had made it non-blocking.

I'm sort of reluctant to change this as I no longer have a Mac to test 
on.  Does someone else have a Mac that they can use to test this?

