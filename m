From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Sat, 11 May 2013 01:38:32 -0700
Message-ID: <CAJDDKr7-sMrX=2Aek1LY8knM2jFPs933eLj3iZdTa68YYv-6Og@mail.gmail.com>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
	<20130511062336.GD3394@elie>
	<CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
	<20130511082203.GA953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 10:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub5KR-0002b8-If
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab3EKIif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:38:35 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:43150 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3EKIid (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:38:33 -0400
Received: by mail-ea0-f177.google.com with SMTP id o10so2567490eaj.36
        for <git@vger.kernel.org>; Sat, 11 May 2013 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tIzHW6xtVTMQ+/n7hsAOdCo2hjZVqHlT4DsxPEmOrtM=;
        b=rfDAxSUH0zVSNzzYa870WbbRd12FW1/fBXj03v6AJkWtJ9SzYMGXXvMzK7UELBJ230
         hSB/ibjjBwqAX2un96UlbOWXd0UVWasWphbGUO5u2QMbduNWTwkzr08ejNKFtflusAoX
         FbwxsXq0cvA6YvzAZ7jqSVYy6qifL3oubyCOfuYvkJ4f/mEROq4ITVbjmefW0AbFPK1y
         +uOf0mN6Hfclt2uFU6G9bo49PjYBSrt9/KRfqjEhyy4sHUW91IbdhNdoppTbBJ3GcbKq
         IwUI6NJ+odBQ9n+qmU+Z5pDf2whFagylq9vT+NOD8J55oQ7Xz4GcU0THZeowmwk7EFSu
         3LsA==
X-Received: by 10.15.24.72 with SMTP id i48mr30232632eeu.37.1368261512117;
 Sat, 11 May 2013 01:38:32 -0700 (PDT)
Received: by 10.14.32.65 with HTTP; Sat, 11 May 2013 01:38:32 -0700 (PDT)
In-Reply-To: <20130511082203.GA953@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223944>

On Sat, May 11, 2013 at 1:22 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 11, 2013 at 12:11:05AM -0700, David Aguilar wrote:
>
>> > Does this perform better or worse than just setting
>> > BLK_SHA1=YesPlease?  I'd naively think it could go either way: on one
>> > hand adding another library dependency can slow down startup, and on
>> > the other hand the implementation may or may not be optimized better
>> > than the generic block-sha1/ implementation.
>>
>> Pretty much identical.
>>
>> Here are the timings (I should probably read t/perf/README and get
>> better numbers):
>>
>> Best of ten
>> $ time git rev-list --all --objects >/dev/null
>> [...]
>
> I'm not sure that's a great test of sha1 performance. It will hash the
> commit and tree objects it loads during the traversal, but that time is
> almost certainly dwarfed by zlib inflation and by lookup_object.
>
> Adding "--verify-objects" would sha1 the blobs, too, which might be more
> reasonable (or running "git fsck"). Something like "git add" on a large
> blob would also be a good test.

Thanks.  Here are the numbers with --verify-objects:

$ time git rev-list --all --objects --verify-objects >/dev/null

# CommonCrypto 32.24s user 4.65s system 99% cpu 37.098 total
# master       33.00s user 4.68s system 99% cpu 37.852 total
# BLK_SHA1     54.17s user 4.67s system 99% cpu 58.928 total

Doing BLK_SHA1 seems like less of a good idea now, so I think my
latest re-roll might be the way to go...
--
David
