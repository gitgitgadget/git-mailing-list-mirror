Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19FDA20189
	for <e@80x24.org>; Sun, 19 Jun 2016 04:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcFSEry (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 00:47:54 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:34006 "EHLO
	homiemail-a75.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765AbcFSErx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 00:47:53 -0400
Received: from homiemail-a75.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a75.g.dreamhost.com (Postfix) with ESMTP id D40A45EC079;
	Sat, 18 Jun 2016 21:47:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=JD6Ld
	ccXQgAoz+y2FWBBPXsWN2M=; b=gFk8jwJRXWOzLb0VIrsnnu3Jn1jNP8GRIoXAx
	XA2R30dml4g0ce4wHyWKYVAnvt0mstYN7CMnbkRXOODsc7Lnb2nvnjKUPXMeCSAS
	EDBZjCrLN9xSqgkdMntDrg3LprVdJEjhmOb9Qj5ZW3PfwJ9dKgHeM/ZQfLg2qMwK
	lCQMAQ=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a75.g.dreamhost.com (Postfix) with ESMTPSA id 7AAB75EC05C;
	Sat, 18 Jun 2016 21:47:52 -0700 (PDT)
Subject: Re: [PATCH] pathspec: prevent empty strings as pathspecs
To:	Junio C Hamano <gitster@pobox.com>, Emily Xie <emilyxxie@gmail.com>
References: <20160619005704.1771-1-emilyxxie@gmail.com>
 <xmqqmvmhyiut.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	David Turner <novalis@novalis.org>
Message-ID: <576623F7.3020700@novalis.org>
Date:	Sun, 19 Jun 2016 00:47:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvmhyiut.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/18/2016 11:10 PM, Junio C Hamano wrote:
> Emily Xie <emilyxxie@gmail.com> writes:
>
>> For any command that takes a pathspec, passing an empty string will
>> execute the command on all files in the current directory. This
>> results in unexpected behavior. For example, git add "" adds all
>> files to staging, while git rm -rf "" recursively removes all files
>> from the working tree and index. This patch prevents such cases by
>> throwing an error message whenever an empty string is detected as a
>> pathspec.
>
> This change is likely to break people's existing scripts.
>
> For example, a script may want to inspect some state of the whole
> working tree and then after the inspection was satisfactory do
> something that affects paths that are inside the directory you were
> originally in.  You would write something like this:
>
> 	#!/bin/sh
> 	original=$(git rev-parse --show-prefix)
>
>          cd "$(git rev-parse --show-toplevel)"
>          ... do the whole-tree pre-inspection
>          ... using various git commands here
>
> 	# Then finally do the "action"
>          git add "$original"
>
> This works even if you happen to be at the top-level of the working
> tree, but with your patch it suddenly breaks.  It may be trivial to
> update the script to use "." when $original is empty, but that is
> not an excuse.  The important thing is that they need to be told
> about having to change their script before this change actually
> happens.  Suddenly breaking other people without telling is simply
> rude and unacceptable.

The help for rev-parse --show-prefix says:
"When the command is invoked from a subdirectory, show the path of
the current directory relative to the top-level directory."

This doesn't say what it does when invoked at the top-level.  Maybe we 
should just change it to output "./", which would make such scripts 
work?  It would not necessarily fix all possible scripts, but it would 
fix these.  It seem odd to insist on preserving this undocumented 
behavior of git add/rm.

> At least you would need two-step process to introduce a change like
> this to warn the people whose tools and workflows you are breaking.
> That is, (1) in one release, you add code to only detect the case
> you will be changing the behaviour in a later version and give
> warning messages, and (2) in another release that is several release
> cycles later, stop warning and actually change the behaviour.
>
> That is, if we assume that passing an empty string by mistake is a
> problem in the real world that we want to save users from.

I discovered this when one of our shell-scripts had a variable was 
accidentally empty.  The user I was supporting was very confused.  So I 
think it is a problem in the real world.


