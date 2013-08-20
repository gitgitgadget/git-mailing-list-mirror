From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Tue, 20 Aug 2013 23:13:12 +0200
Message-ID: <87txik3w2f.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-16-git-send-email-t.gummerer@gmail.com> <CACsJy8CNHNj6dScPUCiRnv=zqT9QfY+=v3ECsnUR2uR4nkFQHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 23:13:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtEx-0004HZ-7D
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab3HTVNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:13:19 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:62177 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab3HTVNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:13:18 -0400
Received: by mail-wi0-f179.google.com with SMTP id hr7so926329wib.12
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=i9gaPhl/vrx0s4CsBhM1uZRZaaL3B12p4G3KP784sHc=;
        b=Ry8FGeNd0MBMma1dSaTg5IFqpK/HkfqEfq4O7yDH5RzE5Wl7vK1JAWKcqCljiD12TY
         nWQtFe/kz/vDdOogS5dvJPKT1IJ8U0pfzuqKNzY7Q3kM/Iat/kUBdII09N1ps/dswfEB
         QKmZisNkV1C6v2paoyvLEmKKUuZIJBfDwpugs6XqYRTvF4XCSV5xWZ2m3O46xQl/myoF
         c2EmsxfLiumtBsr261s7siiIMC5Vv+YwJq/lA4EhPFdjTvQd9Go6emyS0iyFu8Ev5A4h
         SGFsWzb6sa1qIMTNp3m8So3bhzPv6U1AXkl6Jy/LSsYHarb2DADMnkt9wbKm4mygaBM7
         0qFQ==
X-Received: by 10.194.93.3 with SMTP id cq3mr3007993wjb.26.1377033197704;
        Tue, 20 Aug 2013 14:13:17 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:7e6d:62ff:fe8c:90ce])
        by mx.google.com with ESMTPSA id b13sm26822721wic.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 14:13:16 -0700 (PDT)
In-Reply-To: <CACsJy8CNHNj6dScPUCiRnv=zqT9QfY+=v3ECsnUR2uR4nkFQHg@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232647>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
>> +                     void *mmap, unsigned long mmap_size,
>> +                     unsigned int first_entry_offset,
>> +                     unsigned int foffsetblock)
>> +{
>> +       int len, offset_to_offset;
>> +       char *name;
>> +       uint32_t foffsetblockcrc, *filecrc, *beginning, *end, entry_offset;
>> +       struct ondisk_cache_entry *disk_ce;
>> +
>> +       beginning = ptr_add(mmap, foffsetblock);
>> +       end = ptr_add(mmap, foffsetblock + 4);
>> +       len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry) - 5;
>> +       entry_offset = first_entry_offset + ntoh_l(*beginning);
>> +       name = ptr_add(mmap, entry_offset);
>> +       disk_ce = ptr_add(mmap, entry_offset + len + 1);
>> +       *ce = cache_entry_from_ondisk(disk_ce, pathname, name, len, pathlen);
>> +       filecrc = ptr_add(mmap, entry_offset + len + 1 + sizeof(*disk_ce));
>> +       offset_to_offset = htonl(foffsetblock);
>> +       foffsetblockcrc = crc32(0, (Bytef*)&offset_to_offset, 4);
>> +       if (!check_crc32(foffsetblockcrc,
>> +               ptr_add(mmap, entry_offset), len + 1 + sizeof(*disk_ce),
>> +               ntoh_l(*filecrc)))
>> +               return -1;
>> +
>> +       return 0;
>> +}
>
> Last thought before book+bed time. I wonder if moving the name part to
> the end of the entry (i.e. chaging on disk format) would simplify this
> code. The new ondisk_cache_entry would be something like this
>
> struct ondisk_cache_entry {
>    uint16_t flags;
>    uint16_t mode;
>    struct cache_time mtime;
>    uint32_t size;
>    int stat_crc;
>    unsigned char sha1[20];
>    char name[FLEX_ARRAY];
> };

I think it simplifies it a bit, but not too much, the only thing I see
avoiding the use of the name variable.  I think it will also simplify
the writing code a bit.  The only negative part would be for bisecting
the index, but that would still be possible, and only slightly more
complicated.  I'll give it a try tomorrow and check if it's worth it.
