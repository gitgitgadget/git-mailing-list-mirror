From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: invalidate i-t-a paths after writing trees
Date: Sat, 10 Nov 2012 18:04:32 +0700
Message-ID: <CACsJy8DEwpg0gY1o6gSB747W5fAYYxz97e-qnkQthSut3B7Eag@mail.gmail.com>
References: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
 <1352459040-14452-1-git-send-email-pclouds@gmail.com> <7vy5ibouo4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@jonathonmah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX8sQ-0001x5-Io
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 12:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab2KJLFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 06:05:05 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54974 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab2KJLFE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 06:05:04 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4877650oag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oxlrq+G2B/wM3Oh1G0Md4avFZyHIrwNaZd6kojlD3no=;
        b=f8Ls6R7CEx40lGLmzirW/5eBi9L5vB7SwouSJZ4NMiAVPFg4jBPVWuzeZrlKbQehHn
         Xjzh5TEoh2JaAjtAddaF2+9By8LZn9P+HS2pY56+ZLliDaSiUVOHhKVZ5VCDwMeH7Elk
         EoYeT6lGr8RhbHE/fAeMPpkYKAWYdx6D0cI+54++qF/fQ+/QpfNFas3abkDr1mmHhoxX
         BsnC+tbiHuVVNaVZ4KSPYzWIKnAB8UHRc7u0Y4QfT6zx1KnP2qWEElLcJChQhyttQKP7
         bVOjMHAaIqRU11Z7xNvAHZ2s1iI0NVckmX8Kgm5ZFH9tR0L1Go5RIcn7igpMKXcr1xR8
         eMqg==
Received: by 10.60.27.68 with SMTP id r4mr10072214oeg.53.1352545502765; Sat,
 10 Nov 2012 03:05:02 -0800 (PST)
Received: by 10.182.49.41 with HTTP; Sat, 10 Nov 2012 03:04:32 -0800 (PST)
In-Reply-To: <7vy5ibouo4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209270>

On Fri, Nov 9, 2012 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/cache-tree.c b/cache-tree.c
>> index 28ed657..30a8018 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -381,6 +381,9 @@ int cache_tree_update(struct cache_tree *it,
>>       i =3D update_one(it, cache, entries, "", 0, flags);
>>       if (i < 0)
>>               return i;
>> +     for (i =3D 0; i < entries; i++)
>> +             if (cache[i]->ce_flags & CE_INTENT_TO_ADD)
>> +                     cache_tree_invalidate_path(it, cache[i]->name)=
;
>>       return 0;
>>  }
>
> I notice there is another special case for CE_REMOVE but there is
> nothing that adjusts the cache-tree for these entries in the current
> codebase.
>
> I suspect the original code before we (perhaps incorrectly) updated
> the code not to error out upon I-T-A entries was fine only because
> we do not attempt to fully populate the cache-tree during a merge in
> the unpack-trees codepath, which will mark the index entries that
> are to be removed with CE_REMOVE in the resulting index.
>
> The solution implemented with this patch will break if we start
> updating the cache tree after a successful merge in unpack-trees, I
> suspect.

I don't understand. I thought we handled CE_REMOVE correctly (i.e. no
CE_REMOVE entries in cache tree even after a successful merge). Or
should we keep CE_REMOVE in cache tree after a successful merge?

> An alternative might be to add a "phoney" bit next to "used" in the
> cache_tree structure, mark the cache tree as phoney when we skip an
> entry marked as CE_REMOVE or CE_ITA, and make the postprocessing
> loop this patch adds aware of that bit, instead of iterating over
> the index entries; instead, it would recurse the resulting cache
> tree and invalidate parts of the tree that have subtrees with the
> "phoney" bit set, or something.

Yeah, that sounds better.
--=20
Duy
