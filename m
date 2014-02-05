From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Thu, 6 Feb 2014 06:48:45 +0700
Message-ID: <CACsJy8Aj-5MzRjDxfWkOVtqxjo+w7v6uEjGfGAj_9s59t5eiYA@mail.gmail.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <1391480409-25727-1-git-send-email-pclouds@gmail.com> <1391480409-25727-2-git-send-email-pclouds@gmail.com>
 <xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com> <xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
 <20140205002725.GA3858@lanh> <xmqqob2l5vl2.fsf@gitster.dls.corp.google.com> <xmqqbnyl5sde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 00:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBCDY-00060V-7t
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 00:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbaBEXtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 18:49:17 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60810 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbaBEXtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 18:49:16 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so1695754qab.33
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 15:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l8PE5AENgv+dkd5CML4NFB9Zug/pronEI386C/ybTak=;
        b=AhvaRaiV+v0+tVRyO8n/FCl5l1QYrs7pIV2nRW+4YLsUCKg05Rt/q4dbkuvn3THX0C
         kt7srGYBRasKUNeHBPGoUFQaQhRunn0TMxCuA+vVrGSuKcQk8MkMdUA+VlUDDr8ycr9K
         zd1fd5AtsGrUwEtHNFBrKOUbabHhuX/RaPCSteBUC2VqPqUgQVAHDHo01cXhK+svQsVH
         2M9V3o2Sj0kqx2fZPgFcO48ToSfhAvPUug5Q0pKI+DYzljm2P6lkXnZMbAe9X0gYG9jp
         urIj4fjfJK5MIbAb1oAOGLecQ517XCXU3y6iWw92eMT2Hl41L4QpKZv4i0yOkMzE+Fvm
         6eng==
X-Received: by 10.140.47.212 with SMTP id m78mr7042348qga.21.1391644156060;
 Wed, 05 Feb 2014 15:49:16 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 5 Feb 2014 15:48:45 -0800 (PST)
In-Reply-To: <xmqqbnyl5sde.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241678>

On Thu, Feb 6, 2014 at 1:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Yes, indeed.  I wonder why your new test did not notice it, though
>> ;-)
>
> ... and the answer turns out to be that it was not testing the right
> thing.  On top of that faulty version, this will fix it.

Yes, write-tree should test that well.

> Your suggestion to move CE_INTENT_TO_ADD to mark-intent-to-add makes
> sense but a caller needs to be adjusted to drop the duplicated flag
> manipulation.

No no. I found that duplicate, but I did not suggest removing it
because it is needed there..

> @@ -613,8 +614,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>         ce->ce_namelen = namelen;
>         if (!intent_only)
>                 fill_stat_cache_info(ce, st);
> -       else
> -               ce->ce_flags |= CE_INTENT_TO_ADD;
>
>         if (trust_executable_bit && has_symlinks)
>                 ce->ce_mode = create_ce_mode(st_mode);

A few lines down, there's ie_match_stat() call that will check
CE_INTENT_TO_ADD and returns "changed" immediately without looking at
stat data. If stat info is used, it may (not so sure) return "not
changed", the exit path is taken and mark_intent_to_add() is ignored.
-- 
Duy
