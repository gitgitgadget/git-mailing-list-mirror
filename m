From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Wed, 21 Aug 2013 07:44:11 +0700
Message-ID: <CACsJy8C_5ORYvZZoKdDaD9D18MrbQApu4J6_tJ47i7bEjJd-GQ@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
 <1376854933-31241-16-git-send-email-t.gummerer@gmail.com> <CACsJy8A1NpYa6nr6vHKLd-Tap3PObabfUB34U90MH_OdfQJN9Q@mail.gmail.com>
 <87wqng3wpg.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 02:44:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBwXX-0000mw-7a
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 02:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab3HUAon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 20:44:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:38452 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3HUAom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 20:44:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so1992544obb.29
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 17:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sPsvZaKFrELKZqpITElkiwD0iHCWSC+3N7Lgfu9Iyj8=;
        b=bulEsXKZVpAWAWgVrcJrAFZcV/LlgSQnpp6jz77y0cRzng4BkgQJcGjgcAXXObpM+V
         YJ4PdCGyd56nVu2qJRR84mDujAi+8usPFwo57cie0pr2G4cvEgIpSTXAY/T6Jyv70wca
         34hnjKIu74WQoCyfRSqGagMLp8qClJCuyvjEL+qwvjd5tJqQmL0qXRr5EYcDPh6OIePF
         6b+0CeaaXwEt6AOVu3hyQnaaDA0mLXTr6+B7nKQZlGeidmNSsuutDWcEKA+I7JZyZOEq
         yPOb0QczqEyx3oqp/yhZetsmhQKUKJlq71+vnp097pCoBamcWe2BH4XYR8Gy/wzdGryC
         zrjA==
X-Received: by 10.60.47.230 with SMTP id g6mr4825463oen.62.1377045882339; Tue,
 20 Aug 2013 17:44:42 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 20 Aug 2013 17:44:11 -0700 (PDT)
In-Reply-To: <87wqng3wpg.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232673>

On Wed, Aug 21, 2013 at 3:59 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> +static int read_entries(struct index_state *istate, struct directory_entry *de,
>>> +                       unsigned int first_entry_offset, void *mmap,
>>> +                       unsigned long mmap_size, unsigned int *nr,
>>> +                       unsigned int foffsetblock)
>>> +{
>>> +       struct cache_entry *ce;
>>> +       int i, subdir = 0;
>>> +
>>> +       for (i = 0; i < de->de_nfiles; i++) {
>>> +               unsigned int subdir_foffsetblock = de->de_foffset + foffsetblock + (i * 4);
>>> +               if (read_entry(&ce, de->pathname, de->de_pathlen, mmap, mmap_size,
>>> +                              first_entry_offset, subdir_foffsetblock) < 0)
>>> +                       return -1;
>>
>> You read one file entry, say abc/def...
>
> You're not quite right here.  I'm reading def here, de is the root
> directory and de->sub[subdir] is the first sub directory, named abc/
>
>>> +               while (subdir < de->de_nsubtrees &&
>>> +                      cache_name_compare(ce->name + de->de_pathlen,
>>> +                                         ce_namelen(ce) - de->de_pathlen,
>>> +                                         de->sub[subdir]->pathname + de->de_pathlen,
>>> +                                         de->sub[subdir]->de_pathlen - de->de_pathlen) > 0) {
>>
>> Oh right the entry belongs the the substree "abc" so..
>
> abc/ comes before def, so lets read everything in that directory first.
>
>>> +                       read_entries(istate, de->sub[subdir], first_entry_offset, mmap,
>>> +                                    mmap_size, nr, foffsetblock);
>>
>> you recurse in, which will add following entries like abc/def and abc/xyz...
>
> Recurse in, add abc/def and abc/xyz, and increase nr in the recursion,
> so the new entry gets added at the right place.
>
>>> +                       subdir++;
>>> +               }
>>> +               if (!ce)
>>> +                       continue;
>>> +               set_index_entry(istate, (*nr)++, ce);
>>
>> then back here after recusion and add abc/def, again, after abc/xyz.
>> Did I read this code correctly?
>
> After the recursion add def to at the 3rd position in the index.  After
> that it looks like:
> abc/def
> abc/xyz
> def
>
> I hope that makes it a little clearer.

It does. Thanks.

>>> +       de = root_directory;
>>> +       last_de = de;
>>> +       while (de) {
>>> +               if (need_root ||
>>> +                   match_pathspec_depth(&adjusted_pathspec, de->pathname, de->de_pathlen, 0, NULL)) {
>>> +                       if (read_entries(istate, de, entry_offset,
>>> +                                        mmap, mmap_size, &nr,
>>> +                                        foffsetblock) < 0)
>>> +                               return -1;
>>> +               } else {
>>> +                       for (i = 0; i < de->de_nsubtrees; i++) {
>>> +                               last_de->next = de->sub[i];
>>> +                               last_de = last_de->next;
>>> +                       }
>>> +               }
>>> +               de = de->next;
>>
>> I'm missing something here. read_entries is a function that reads all
>> entries inside "de" including subdirectories and the first "de" is
>> root_directory, which makes it read the whole index in.
>
> It does, except when the adjusted_pathspec doesn't match the
> root_directory.  In that case all the subdirectories of the
> root_directory are added to a queue, which will then be iterated over
> and tried to match with the adjusted_pathspec.

That's what I missed. Thanks.
-- 
Duy
