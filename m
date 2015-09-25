From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: handle errors on setting tracking branches
Date: Fri, 25 Sep 2015 09:52:00 -0700
Message-ID: <xmqqzj0a4f2n.fsf@gitster.mtv.corp.google.com>
References: <1443090721-14519-1-git-send-email-ps@pks.im>
	<20150924140538.GA11666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 18:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfWEF-00053n-1i
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbbIYQwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 12:52:05 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32955 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbbIYQwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 12:52:02 -0400
Received: by pacex6 with SMTP id ex6so110426440pac.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JaTXJSpMd6bSGNt9yEiQqA3BX9jO0NAMiQn/XIPGJ2w=;
        b=p8h+um2AoUwP80eIbkRz7tuINDMak/6YQQEMj186Q59bbpbc4ZlqtLQTJR9pS8geow
         DmQ4SJFFjxCR17ktfvl0LFDiSM+7d+AWDPsoO1mYaDu8WnSQ2tFLKyw5Yd439QU7VkY+
         YnvBbsqjds3E62zZFpOCYRX+xzs23Zg1DRln69nYucOGE9NIHeQuJ/eTCeYk+TDc6IDd
         nPUCvgqcXCKUjUCzClv8SmaqO/kca7EgMWAoBJ6Zq3K7TnZfNkgrmzfRdwrfr3whcDA/
         k5+VZAyBR7sTd0PvE3blYxEXfZs4btHopE2yrBBu8Tbk+BMbjvz9z00wEIA0+gMSCNdl
         RdDQ==
X-Received: by 10.68.194.73 with SMTP id hu9mr8728040pbc.146.1443199921726;
        Fri, 25 Sep 2015 09:52:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id yt9sm4852176pac.32.2015.09.25.09.52.00
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 09:52:01 -0700 (PDT)
In-Reply-To: <20150924140538.GA11666@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Sep 2015 10:05:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278667>

Jeff King <peff@peff.net> writes:

> I count 4 callers in the current code, and none of them currently looks
> at the return value. Your patch updates setup_tracking() to propagate
> the error, which is good. But that is called from exactly one place,
> create_branch(), which also ignores the outcome. :-/
>
> I don't think we want to die() when the config fails. That might be the
> right thing for "branch --set-upstream-to", but probably not for
> "checkout -b". I think we need to look at each call site and see whether
> we should be propagating the error back. With the hope that we would
> ultimately affect the exit code of the command.
>
> In the case of branch creation, we are in a two-step procedure: create
> the branch, then set up its tracking config. We _could_ rollback the
> first step when the second step fails, but that is probably not worth
> the complication.
>
>> Actually, there are quite a few places where we don't check the
>> return values of git_config_set and related functions. I didn't
>> go through them yet, but might do so if you deem this to be of
>> value.
>
> I think more error-checking is better than less. But I do think it's
> worth plumbing through the error codes in each case.
>
> It's tempting to just die() when the operation fails, but as discussed
> above, that's not always the most appropriate thing.
>
>>  branch.c | 24 ++++++++++++++++--------
>>  branch.h |  3 ++-
>>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> The patch itself looks OK to me from a cursory read.

I agree with everything you said in the analysis, including that
this patch is a good first step in the right direction, but at the
same time it is a glorified no-op whose only external effect is to
make the error diagnosis a bit noisier.  A good first step in the
right direction with stride length of zero ;-)
