From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 12/12] index-pack: resolve v4 one-base trees
Date: Sun, 8 Sep 2013 10:44:35 +0700
Message-ID: <CACsJy8BnJ-SLz2WUdmfJQt69x5N7VSMD1iXEpFsFfx1Qh=janQ@mail.gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com> <1378550599-25365-13-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309072312090.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 05:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIVw8-0008Ar-N2
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 05:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760005Ab3IHDpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 23:45:11 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:40708 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760002Ab3IHDpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 23:45:06 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so5461799oag.10
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=580Axrr10PiV2IRP/cQYD08v6z+LqI3GrEp7am9VKbw=;
        b=v+xtCngLz4T12QBI9prIMOoxoF4lDtfSMRQE8H4SAswdObxlnAVGYXNHjvPn4/L6ft
         Q3xa0gmA2vS4jwpu+AjhqubV49vAckuz7DUcBT9N+eeoS2ybNrpGsVvoveTiK6WyYvap
         tUWVRK/Z2305IscZeYcpXAyH/p0dib1wSrTUospAZYEa5K5887ft/GAYmJweXP4X9Cu5
         7gDotrB95MOaLjEej6P3COs3S7v5xH/OqGx5BGHxKFNnmMlFs+Fh2dywoQSP2gHq830K
         hexUnoFFN9OZxa15fzaIl98daj2cGeuHhyAPC4oeajiBgFYHLJlImyZ9p3avdGFUvmT+
         Pvpg==
X-Received: by 10.182.246.74 with SMTP id xu10mr6626653obc.23.1378611906285;
 Sat, 07 Sep 2013 20:45:06 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Sat, 7 Sep 2013 20:44:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309072312090.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234170>

On Sun, Sep 8, 2013 at 10:28 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> @@ -794,6 +799,83 @@ static void *unpack_raw_entry(struct object_entry *obj,
>>       return data;
>>  }
>>
>> +static void *patch_one_base_tree(const struct object_entry *src,
>> +                              const unsigned char *src_buf,
>> +                              const unsigned char *delta_buf,
>> +                              unsigned long delta_size,
>> +                              unsigned long *dst_size)
>> +{
>> +     unsigned int nr;
>> +     const unsigned char *last_base = NULL;
>> +     struct strbuf sb = STRBUF_INIT;
>> +     const unsigned char *p = delta_buf;
>> +
>> +     nr = decode_varint(&p);
>> +     while (nr && p < delta_buf + delta_size) {
>> +             unsigned int copy_start_or_path = decode_varint(&p);
>> +             if (copy_start_or_path & 1) { /* copy_start */
>> +                     struct tree_desc desc;
>> +                     struct name_entry entry;
>> +                     unsigned int copy_count = decode_varint(&p);
>> +                     unsigned int copy_start = copy_start_or_path >> 1;
>> +                     if (!src)
>> +                             die("we are not supposed to copy from another tree!");
>> +                     if (copy_count & 1) { /* first delta */
>> +                             unsigned int id = decode_varint(&p);
>> +                             if (!id) {
>> +                                     last_base = p;
>> +                                     p += 20;
>> +                             } else
>> +                                     last_base = sha1_table + (id - 1) * 20;
>> +                             if (hashcmp(last_base, src->idx.sha1))
>> +                                     die(_("bad tree base in patch_one_base_tree"));
>> +                     } else if (!last_base)
>> +                             die(_("bad copy count index in patch_one_base_tree"));
>> +                     copy_count >>= 1;
>> +                     if (!copy_count)
>> +                             die(_("bad copy count index in patch_one_base_tree"));
>> +                     nr -= copy_count;
>> +
>> +                     init_tree_desc(&desc, src_buf, src->size);
>> +                     while (tree_entry(&desc, &entry)) {
>> +                             if (copy_start)
>> +                                     copy_start--;
>> +                             else if (copy_count) {
>> +                                     strbuf_addf(&sb, "%o %s%c", entry.mode, entry.path, '\0');
>> +                                     strbuf_add(&sb, entry.sha1, 20);
>> +                                     copy_count--;
>> +                             } else
>> +                                     break;
>> +                     }
>> +             } else {        /* path */
>> +                     unsigned int path_idx = copy_start_or_path >> 1;
>> +                     const unsigned char *path;
>> +                     unsigned mode;
>> +                     unsigned int id;
>> +                     const unsigned char *entry_sha1;
>> +
>> +                     if (path_idx >= path_dict->nb_entries)
>> +                             die(_("bad path index in unpack_tree_v4"));
>> +                     id = decode_varint(&p);
>> +                     if (!id) {
>> +                             entry_sha1 = p;
>> +                             p += 20;
>> +                     } else
>> +                             entry_sha1 = sha1_table + (id - 1) * 20;
>
> You should verify that id doesn't overflow the sha1 table here.
> Similarly in other places.

I think it's unnecessary. All trees must have been checked by
unpack_tree_v4() in the first pass. Overflow should be caught there if
found.

-- 
Duy
