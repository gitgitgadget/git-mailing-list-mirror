From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 17/32] read-cache: split-index mode
Date: Wed, 30 Apr 2014 05:45:26 +0700
Message-ID: <CACsJy8Da=n+kh8_bUkJ11-dK09A6zOMnhBQJCsPCWcCJ2mY0pw@mail.gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
 <1398682553-11634-18-git-send-email-pclouds@gmail.com> <xmqq1twhnkbz.fsf@gitster.dls.corp.google.com>
 <CACsJy8BEJdA+d5DL94n4o3FRphs9bNPhX9oKK3MmOfTTBY=f9Q@mail.gmail.com> <xmqqiopskq1o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:46:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGmy-0003rU-62
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758039AbaD2Wp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:45:58 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:37532 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260AbaD2Wp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:45:57 -0400
Received: by mail-qc0-f176.google.com with SMTP id x13so1020839qcv.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1x9aZJLHUaoto1esYsw/RyXrUOHxr1ECmAu2TvTMZRY=;
        b=yaGR233sE0f3mioHC/Hk5d93sJHsbSa931YCnOX/fMcY/QVEL07ws1kgkUzmI1oERx
         k05xs9W4KlC+i4QhrRkSDHlGYB7VfAOEJwtJqk49XGoPM7c6oRVjz1/d4XbGSFairw++
         DU1yCKo2ITYc5bNde91v57nq2uHabx9fZ2if41sfVCDVgn8zH5iaVAU+gscdCdamG2xA
         vkMGMTKI+F15oJp77ggA7H4X7baxiJNeWoDrbP3pQMl9XeUmwd51/ssYTkatjBGg+IXX
         yBbftu1USvsD9SENRUC4+tl1R7iWRFtlh6WxcgMB+mVjYMH3Jf3ebjundA1ZiKQmgoXk
         iFOw==
X-Received: by 10.140.107.198 with SMTP id h64mr834386qgf.30.1398811556809;
 Tue, 29 Apr 2014 15:45:56 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 29 Apr 2014 15:45:26 -0700 (PDT)
In-Reply-To: <xmqqiopskq1o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247661>

On Wed, Apr 30, 2014 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> I do think it is sensible to keep two arrays of "struct cache_entry"
>>> around (one for base and one for incremental changes) inside
>>> index_state, and the patch seems to do so via "struct split_index"
>>> that does have a copy of saved_cache.  If the write-out codepath
>>> walks these two sorted arrays in parallel, shouldn't it be able to
>>> figure out which entry is added, deleted and modified without
>>> fattening this structure?
>>
>> So far without that "index" field I would have to resort to hasing
>> entries in both arrays to find the shared paths. But ideas are
>> welcome.
>
> Hmm, why do you need to hash, when both arrays are sorted?  Wouldn't
> it be just the matter of walking these two arrays in parallel,
> with one scanning index for each array initialized to the beginning,
> comparing the elements pointed by these indices, noting the side
> that comes earlier in the sort order and advancing the index on that
> side (or if they compare equal then advance both), ...?

And compare all names and stages (especially in the unpack-trees case,
when no entry is reused). I kinda hope to avoid that. Speaking about
reusing cache_entry, we won't be able to share cache_entry because
when it's freed in replace_index_entry, or remove_index_entry_at in
the main index, we need to locate the same entry in the shared index
as well and remove that stale pointer. Without sharing, we nearly
double memory usage from the beginning.
-- 
Duy
