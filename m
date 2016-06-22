Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B36720189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbcFVQMH (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:12:07 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37047 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbcFVQMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:12:06 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so42483994ith.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:12:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZWiXKvRhUWRxR4lgnjOMyoYwxdM4mIxxPuAwLBZBWE=;
        b=GSNzpzYyWi7z6aAR5iALpDEkpteeuuUauyMBcqxmaOEWyrG/i8czFDVVcUQGGRyooD
         LCZcgTzvuCOyzRp9NwfJuQlw6OaVXXpPDmb1xA0asysRQNHNZB5q5RdgwiQms2bKiJxM
         QE7uSra+CrSOPP/Ie7ZOzsVfgBh/KU93w1xz9FdrtWgd3AoWt+L8GH0HzFD63QIZARJx
         qDAnpREGya0vn7RR5sXGMhKj41tuORn82iY6TjkPcv0vMvYJ5zd+1CaSBWx8HIKClUx7
         y7FP7qPrK8xjS+90tsL7diSHBK56WZjipjBsSAkXHa4LsIIiMhDc5py/1tcQ8CsPdp27
         jiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZWiXKvRhUWRxR4lgnjOMyoYwxdM4mIxxPuAwLBZBWE=;
        b=MV75k2Cp8gj/yUGfgs3DgmamF5Ga4ji+EIA0QNRQuYuUc26CYIxpjTUOQchDPUluf8
         zZmWAeFRU/po2cOKFVPLFJJstv8bhQNa+cGCCOePJAedixc3QmTEz8VwfqizcCKScnRC
         Pd4SsnEUKpFSyXCLneti8mazBrQhuYfOLaIqxSXIGZA05S4XqkKRcEfol4uoPvfEF4nK
         rSGZyPgQDJS3XWKNsl46MKvf4zRNY2xUmWEPVCUSVUOkWD2kKfKpS/HPqgGHI6DNyz0x
         dRgG67+6qb8LMoO6INxa3kujl5NVnA1S9VXOQC97BwfubJsSnWfVuFIoN2wq0Ka1LYt4
         bv6g==
X-Gm-Message-State: ALyK8tIJJGWEXB7tz5MsDvmuhbxETNnjWnud7R/mJAxInr+ikpP6KFNfAljYIPl2Rwx5btXHBRR0Yzbyv0beIA==
X-Received: by 10.36.123.199 with SMTP id q190mr15847823itc.42.1466611925281;
 Wed, 22 Jun 2016 09:12:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 22 Jun 2016 09:11:35 -0700 (PDT)
In-Reply-To: <xmqqinx2nonl.fsf@gitster.mtv.corp.google.com>
References: <20160621211412.28752-1-charles@hashpling.org> <20160621211412.28752-2-charles@hashpling.org>
 <xmqqinx2nonl.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 22 Jun 2016 18:11:35 +0200
Message-ID: <CACsJy8C9Dh_Owr3UFJnCtvXserG4V-e1ws8ZY52ME1yr+fefOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Charles Bailey <charles@hashpling.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -396,7 +396,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
>>                * cache version instead
>>                */
>>               if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
>> -                     if (ce_stage(ce))
>> +                     if (ce_stage(ce) || ce_intent_to_add(ce))
>>                               continue;
>>                       hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
>>               }
>
> OK, so this function handles searching in either the index or the
> working tree.
>
> The first hunk used to unconditionally discard paths marked as
> i-t-a, even when we are looking at the working tree, which is
> clearly useless, and we stop rejecting i-t-a paths too early, which
> is good.
>
> The second hunk is for "grep --cached" but also covers two other
> cases.  What are these?
>
> CE_VALID is used by "Assume unchanged".  Because the user promised
> that s/he will take responsibility of keeping the working tree
> contents in sync with what is in the index by not modifying it, even
> when we are not doing "grep --cached", we pick up the contents from
> the index and look for the string in there, instead of going to the
> working tree.  In other words, even though at the mechanical level
> we are looking into the index, logically we are searching in the
> working tree.  Is it sensible to skip i-t-a entries in that case?
>
> I think the same discussion would apply to CE_SKIP_WORKTREE (see
> "Skip-worktree bit" in Documentation/git-update-index.txt).
>
> So I wonder if a better change would be more like
>
>         for (...) {
>                 if (!S_ISREG(ce->ce_mode))
>                         continue; /* not a regular file */
>                 if (!ce_path_match(ce, pathspec, NULL)
>                         continue; /* uninteresting */
> +               if (cached && ce_intent_to_add(ce))
> +                       continue; /* path not yet in the index */
>
>                 if (cached || ...)
>                         UNCHANGED FROM THE ORIGINAL
>
> perhaps?

I did wonder a bit about these cases. But, can i-t-a really be
combined with CE_VALID or CE_SKIP_WORKTREE? CE_SKIP_... is
automatically set and should not cover i-t-a entries imo (I didn't
check the implementation). CE_VALID is about real entries, yes you
could do "git update-index --assume-unchanged <ita-path>" but it does
not feel right to me.

If cached is false and ce_ita() is true and either CE_VALID or
CE_SKIP_WORKTREE is set, we would continue to grep an _empty_ SHA-1.
But I think we should grep_file() instead, at least for CE_VALID.
-- 
Duy
