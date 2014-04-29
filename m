From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 17/32] read-cache: split-index mode
Date: Tue, 29 Apr 2014 08:43:36 +0700
Message-ID: <CACsJy8BEJdA+d5DL94n4o3FRphs9bNPhX9oKK3MmOfTTBY=f9Q@mail.gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
 <1398682553-11634-18-git-send-email-pclouds@gmail.com> <xmqq1twhnkbz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 03:44:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wex5n-0007TA-L5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 03:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbaD2BoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 21:44:09 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:53221 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaD2BoI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 21:44:08 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so3808942qab.22
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 18:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mPSXh3Mb1kYjegrtiRQ8FnyBcP+hNSLkYPq5jFcuO+o=;
        b=m2QMhVakakfmvoL1FB5dcM7+YaLWKbrrhxAk3StS2aD06/EZfKAKSC13dkdc0reDyG
         G3BbhC08v2mGyHtwBzmUTTENI2acWeHQfov+6v7qij2d3xCLA/3ai2Au3xuyrhyB3waU
         8zdq0CCzHQRCvfkCrhVzvNdWNSuzzk/0sd7Zc51C7XYkCxvqg8prn634UmYBNE7sOCb1
         moQjZdd9Thk259Btvm+VAXrRFnsnmT2KXMijMi1U9v2PmYwy1C3POwnBLSUE4/rloFwa
         tHQsk7zytTOoc1p61JW7lI3Ck8I7BmTRgJbK52ePJS7wZ1qljtwSDKYCj0MgXelatka6
         EkjA==
X-Received: by 10.140.80.40 with SMTP id b37mr4026448qgd.98.1398735847557;
 Mon, 28 Apr 2014 18:44:07 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 28 Apr 2014 18:43:36 -0700 (PDT)
In-Reply-To: <xmqq1twhnkbz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247507>

On Tue, Apr 29, 2014 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/cache.h b/cache.h
>> index 0f6247c..90a5998 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -135,6 +135,7 @@ struct cache_entry {
>>       unsigned int ce_mode;
>>       unsigned int ce_flags;
>>       unsigned int ce_namelen;
>> +     unsigned int index;     /* for link extension */
>>       unsigned char sha1[20];
>>       char name[FLEX_ARRAY]; /* more */
>>  };
>
> I am not sure if we want to keep an otherwise unused 8-byte around
> per cache entry (especially for a large project where the split
> index mode should matter) after we read the index.
>
> I expected to see some code where entries in this incremental index
> are used to override the entries from the base/shared index, but
> merge_base_index() seems to do just memcpy() to discard the former
> and replace them with the latter.  Is this step meant to work at
> all, or is it a smaller step meant to be completed in later patches?

This field only matters at write time, not read time. It's to quickly
detect if an entry is shared, see prepare_to_write_split_index().

> I do think it is sensible to keep two arrays of "struct cache_entry"
> around (one for base and one for incremental changes) inside
> index_state, and the patch seems to do so via "struct split_index"
> that does have a copy of saved_cache.  If the write-out codepath
> walks these two sorted arrays in parallel, shouldn't it be able to
> figure out which entry is added, deleted and modified without
> fattening this structure?

So far without that "index" field I would have to resort to hasing
entries in both arrays to find the shared paths. But ideas are
welcome.
--=20
Duy
