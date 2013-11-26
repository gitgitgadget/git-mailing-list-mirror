From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 08/28] shallow.c: add mark_new_shallow_refs()
Date: Tue, 26 Nov 2013 20:18:30 +0700
Message-ID: <CACsJy8DgaqtQUohRwek2+cPxTEssvtDGb812Uhjy+R7pib2O8Q@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1385351754-9954-9-git-send-email-pclouds@gmail.com> <xmqqli0cw2b9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 14:19:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlIXj-0004Ef-7F
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 14:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab3KZNTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 08:19:03 -0500
Received: from mail-qe0-f43.google.com ([209.85.128.43]:48247 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab3KZNTA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 08:19:00 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so5531417qeb.2
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z08HzWq7AGJkGx2lX/pf41a8tcEYgyMI57+83QBQCG0=;
        b=ADGBkB+ruhQR87wWGKlb6DBrgzSVhw2go91MMELiIi96eKpA1F55r1kfSAL3xSPtsq
         43gQIXiRglnfHDigH1kIKR5FoPmEywoOLmZ8o/IvzCgc7jQxeCziWvMrubKBi0s1QXdp
         ImcjrqIHeeX3R7BFrAAloN+5d4iArMKarGY2Io0DCKr359h37TYAzGn9jUOzOcP1VQ6z
         KuNTvfPTggXK3YqZbEHWCho6uIoyJERB5EekPk75KL2mqMcVsnoPSrgAFzSalhHlgmqu
         cfrS6MSRK5mdrHoJ/SjOnhz6r6IAtRVmTovQbtU7LL1uccMVxF1hm15B5tDQNuhfEriF
         +W4A==
X-Received: by 10.224.51.7 with SMTP id b7mr56004978qag.74.1385471940160; Tue,
 26 Nov 2013 05:19:00 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 26 Nov 2013 05:18:30 -0800 (PST)
In-Reply-To: <xmqqli0cw2b9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238384>

On Tue, Nov 26, 2013 at 5:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph.  the use of ->util field in this patch feels that it was
> something commit-slab data structure was invented to solve.

Good stuff! Thanks.

>> +             if (c->util == NULL)
>> +                     c->util = bitmap;
>> +             else {
>> +                     /*
>> +                      * Deliberately leak a lot in commit->util
>> +                      * because there can be many pointers to the
>> +                      * same bitmap. Probably should allocate in a
>> +                      * pool and free the whole pool at the end.
>> +                      */
>
> ... or perhaps make the bitmap into
>
>         struct {
>                 int refcnt;
>                 uint32_t bits[FLEX_ARRAY];
>         }
>
> and refcnt them?

I still prefer memory pools so I just need to do a few free() than
walking through all the commits again and refcnt-- or free() them.

>> +     /*
>> +      * Quick check to see if we may need to add new shallow
>> +      * roots. Go through the list of root candidates and check if
>> +      * they exist (either in current repo, or in the new pack, we
>> +      * can't distinguish).
>> +      *
>> +      * 1) If none of the new roots exist, the pack must connect to
>> +      *    the main object graph, which is already guarded by
>> +      *    current repo's shallow roots and we will not need to
>> +      *    consider adding new shallow roots, so we can exit early.
>> +      *
>> +      * 2) The pack may connect to some existing object islands in
>> +      *    current repo then add shallow roots to plug loose ends
>> +      *    from those islands. In that case, new shallow roots must
>> +      *    also exist in the repo as this stage (old objects plus
>> +      *    the new pack).
>> +      *
>> +      * 3) The last, easiest case, is the pack contains some
>> +      *    shallow roots, which may be used to tie up loose ends of
>> +      *    some new refs, or redundanty (tying up loose ends of new
>> +      *    object islands)
>> +      */
>> +     for (i = 0;i < shallow->nr; i++)
>> +             if (has_sha1_file(shallow->array[i]))
>> +                     break;
>> +     if (i == shallow->nr)
>> +             /*
>> +              * this is the first and also the common case, where
>> +              * the new pack does not carry any new shallow
>> +              * points. No need to to the expensive commit traverse
>> +              * dance below.
>> +              */
>> +             return 0;
>
> I am Confused.
>
> The loop only made sure that all the elements in the array[] is
> still missing (or, ... is this function supposed to be called before
> installing a new pack???  It is unclear.  But if new objects were
> unpacked while receiving, then there is no "not install the new
> objects and check" possible, so I'd assume this is called after
> receiving and registering a new pack to the object store).

Yes it's called after installing the new packs (or after unpacking).
I'll mention about this.

> But then, can it be that you had N-1 "shallow points" originally,
> the pack has a reference to a new missing commit, and the array has
> N "shallow points" in total?  Or is the caller expected to call this
> function with shallow pointing at a pre-transfer shallow points?

Another thing I did not mention is all shallow commits we have are
already filtered out by remove_reachable_shallow_points. By the time
you get here, the array only contains the shallow commits we don't
have that may or may not be referenced by a something (oh yeah I did
not handle tags!) in the new pack. So if all of them are missing (i.e.
the new pack does not reference to any of them), they're useless and
can be thrown away.

Sorry to break the patches this way and lose the overall call flow.
It's just too big to put all into one patch. 13/28 is the one that put
the pieces together but basically

 1. receive the remote's .git/shallow
 2. call remote_reachable_shallow_points() to exclude our shallow commits
 3. get the pack and install it (or unpack it)
 4. call this function to determine what new ref needs new shallow
commits from the result of #2

>> +     /*
>> +      * Prepare the commit graph to track what refs can reach what
>> +      * (new) shallow points.
>> +      */
>> +     nr = get_max_object_index();
>
> Hmph. At this point (again, there is no description on where in the
> overall sequence of events this function is designed to be called,
> so it is impossible to review the logic), is it expected that we
> have seen all the objects under the sun and marked them in a
> specific way?

No. At this point we just make sure to have clean flags in commit
objects. paint_down() is the one that walks through and marks them as
seen.
-- 
Duy
