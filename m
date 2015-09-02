From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: release lockfile in non-writing functions
Date: Wed, 02 Sep 2015 12:43:49 -0700
Message-ID: <xmqqpp20mwsq.fsf@gitster.mtv.corp.google.com>
References: <20150901221409.GA23274@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 21:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXDwp-0005cw-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 21:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbbIBTnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 15:43:52 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33351 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbbIBTnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 15:43:51 -0400
Received: by pacex6 with SMTP id ex6so15997221pac.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UD2jnRtK6Us6KdU/Zc+qIMIfvEMTZrY2lV/bp52WEOo=;
        b=qFz7UfdGh+Jgch3ZAmN+Ys7KRrI/b2Px3P0h9wNF8M+07WLbeAOokpsToxEHj89/jA
         Dxj8qZvS2M42hqGr4jl5BmftpViIECaypgClejo88qvR3ju/8oXoHIbI5ueUJL5tzDZ/
         GNHaoQJzMecHm1dLEbwZl8GjtguJAYQx98D4ZnwJ7xXXCN1vwook37xCtkpW1LoIAAe4
         T8IGKAX1SdBVJNjwT/zJ+cBTWqm4Er5c8xr3tQeA3JHgffJ4eFE3fEOZ21bxbQR6lJL1
         gtZJoz08T1sjFqZu1gBxA98gRHPeVxAoY5SqI/A+3O1vucH2K/NJPKrjD4URfrhG2R1N
         khbw==
X-Received: by 10.68.195.231 with SMTP id ih7mr59687047pbc.26.1441223031103;
        Wed, 02 Sep 2015 12:43:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id cb6sm1995020pac.10.2015.09.02.12.43.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 12:43:50 -0700 (PDT)
In-Reply-To: <20150901221409.GA23274@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Sep 2015 18:14:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277117>

Jeff King <peff@peff.net> writes:

> There's a bug in builtin/am.c in which we take a lock on
> MERGE_RR recursively. But rather than fix am.c, this patch
> fixes the confusing interface from rerere.c that caused the
> bug. Read on for the gory details.
>
> The setup_rerere() function both reads the existing MERGE_RR
> file, and takes MERGE_RR.lock. In the rerere() and
> rerere_forget() functions, we end up in write_rr(), which
> will then commit the lock file.
>
> But for functions like rerere_clear() that do not write to
> MERGE_RR, we expect the caller to have handled
> setup_rerere(). That caller would then need to release the
> lockfile, but it can't; the lock struct is local to
> rerere.c.
>
> For builtin/rerere.c, this is OK. We run a single rerere
> operation and then exit immediately, which has the side
> effect of rolling back the lockfile.
>
> But in builtin/am.c, this is actively wrong. If we run "git
> am -3 --skip", we call setup-rerere twice without releasing
> the lock:
>
>   1. The "--skip" causes us to call am_rerere_clear(), which
>      calls setup_rerere(), but never drops the lock.
>
>   2. We then proceed to the next patch.
>
>   3. The "--3way" may cause us to call rerere() to handle
>      conflicts in that patch, but we are already holding the
>      lock. The lockfile code dies with:
>
>      BUG: prepare_tempfile_object called for active object

Thanks.  I've been re-acquainting with the internals of rerere and
agree with your approach to this issue.

Let's merge this before -rc1.
