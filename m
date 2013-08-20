From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Tue, 20 Aug 2013 21:16:41 +0700
Message-ID: <CACsJy8CNHNj6dScPUCiRnv=zqT9QfY+=v3ECsnUR2uR4nkFQHg@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Aug 20 16:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmkO-0000nO-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab3HTORS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:17:18 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:39309 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3HTORN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:17:13 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so824423oag.31
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DQiJCRIERh1V+PGZDlDOmYAW2pV8YUKGHBzRbZLe9Zg=;
        b=KELHa4CRypikEo2dQ1E+7gqNFUdToeuw4XyPnDMyIex+Q/vxDKq8l3Kj7j8hiVqzLf
         3zBT8mrNpCI4Zt2iUh2XWrsnQBGbRocXo2d2eykGvXQhOqXycXRmOXQCUW25+70VOrD+
         JCnW8+k6dm4WOwRC2IpOXCk33Rq0tozepGCOYPKo+gm/PUa8P7QWYtognP00JMkIZWiQ
         d6Ta4x/REG/0yBBsERx2LmpqpFjFDa45JNH/dE6iWPLrXKsMksMU/gYDZzWUZDv7E9cy
         sZa0hmFh7y4opg1bWMSA7YPhEI61WGvAI52JhfetoKVxEYwtJoxDZ2u9cncSindQwzaE
         a+Ng==
X-Received: by 10.60.62.101 with SMTP id x5mr1844851oer.24.1377008232845; Tue,
 20 Aug 2013 07:17:12 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 20 Aug 2013 07:16:41 -0700 (PDT)
In-Reply-To: <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232599>

On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
> +                     void *mmap, unsigned long mmap_size,
> +                     unsigned int first_entry_offset,
> +                     unsigned int foffsetblock)
> +{
> +       int len, offset_to_offset;
> +       char *name;
> +       uint32_t foffsetblockcrc, *filecrc, *beginning, *end, entry_offset;
> +       struct ondisk_cache_entry *disk_ce;
> +
> +       beginning = ptr_add(mmap, foffsetblock);
> +       end = ptr_add(mmap, foffsetblock + 4);
> +       len = ntoh_l(*end) - ntoh_l(*beginning) - sizeof(struct ondisk_cache_entry) - 5;
> +       entry_offset = first_entry_offset + ntoh_l(*beginning);
> +       name = ptr_add(mmap, entry_offset);
> +       disk_ce = ptr_add(mmap, entry_offset + len + 1);
> +       *ce = cache_entry_from_ondisk(disk_ce, pathname, name, len, pathlen);
> +       filecrc = ptr_add(mmap, entry_offset + len + 1 + sizeof(*disk_ce));
> +       offset_to_offset = htonl(foffsetblock);
> +       foffsetblockcrc = crc32(0, (Bytef*)&offset_to_offset, 4);
> +       if (!check_crc32(foffsetblockcrc,
> +               ptr_add(mmap, entry_offset), len + 1 + sizeof(*disk_ce),
> +               ntoh_l(*filecrc)))
> +               return -1;
> +
> +       return 0;
> +}

Last thought before book+bed time. I wonder if moving the name part to
the end of the entry (i.e. chaging on disk format) would simplify this
code. The new ondisk_cache_entry would be something like this

struct ondisk_cache_entry {
   uint16_t flags;
   uint16_t mode;
   struct cache_time mtime;
   uint32_t size;
   int stat_crc;
   unsigned char sha1[20];
   char name[FLEX_ARRAY];
};
-- 
Duy
