From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 17:40:55 +0700
Message-ID: <CACsJy8D9dsxOA6xVmhxa7N20OxEQ1a63rQm6QCtwq9ThG6E3RA@mail.gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com> <1397108075-30891-1-git-send-email-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 12:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYCQF-0007WS-WD
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 12:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935066AbaDJKl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 06:41:27 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:38431 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934795AbaDJKl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 06:41:26 -0400
Received: by mail-qc0-f170.google.com with SMTP id x13so4171035qcv.15
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2Z3GxBVWX18hznCcu6I4PF1C/6CILAWROR0/HOVkFNU=;
        b=odjDAJaVOd+6VtzVoo+OwrMjhefQTOqTgVwrP8km4lpdwbYBYapaJ2UcVVZn8hYkOh
         AnTnxX37os7pYFoQ9uIPYtAK2exxV0BvV/Noh26AnJKVMT0y1OE7zPqm8SqoYwTfWfWr
         K0kTQ6b72RrvQwg5k2YWrOVY5QfVDk52hulTsweEj/RH5/guy56ITxy2jtTyzR7XdWJl
         J9QyXFlXyjysURKzKvRD6p8RyolHPEw9esv9FtTefI5QBT1492ucOKDbh2Iw5Z9kuFy1
         Lcw3gv5FL7BdjCPZoskFGmWwIVdZk0lYY7+BXjWaVTXhjIM3EITz2uYochB1tRGM0Vsn
         ifqg==
X-Received: by 10.224.36.129 with SMTP id t1mr19042197qad.88.1397126485599;
 Thu, 10 Apr 2014 03:41:25 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Thu, 10 Apr 2014 03:40:55 -0700 (PDT)
In-Reply-To: <1397108075-30891-1-git-send-email-yiannis.marangos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246014>

On Thu, Apr 10, 2014 at 12:34 PM, Yiannis Marangos
<yiannis.marangos@gmail.com> wrote:
> +/*
> + * This function verifies if index_state has the correct sha1 of an index file.
> + * Don't die if we have any other failure, just return 0.
> + */
> +static int verify_index_from(const struct index_state *istate, const char *path)
> +{
> +       int fd;
> +       struct stat st;
> +       struct cache_header *hdr;
> +       void *mmap_addr;
> +       size_t mmap_size;
> +
> +       if (!istate->initialized)
> +               return 0;
> +
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0)
> +               return 0;
> +
> +       if (fstat(fd, &st))
> +               return 0;
> +
> +       /* file is too big */
> +       if (st.st_size > (size_t)st.st_size)
> +               return 0;
> +
> +       mmap_size = (size_t)st.st_size;
> +       if (mmap_size < sizeof(struct cache_header) + 20)
> +               return 0;
> +
> +       mmap_addr = mmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +       close(fd);
> +       if (mmap_addr == MAP_FAILED)
> +               return 0;
> +
> +       hdr = mmap_addr;
> +       if (verify_hdr(hdr, mmap_size) < 0)
> +               goto unmap;

verify_hdr() is a bit expensive because you need to digest the whole
index file (could big as big as 14MB on webkit). Could we get away
without it? I mean, is it enough that we pick the last 20 bytes and
compare it with istate->sha1? If we only need 20 bytes, pread() may be
better than mmap().

The chance of SHA-1 collision is small enough for us to ignore, I
think. And if a client updates the index without updating the trailing
sha-1, the index is broken and we don't have to worry about
overwriting it.

> +
> +       if (hashcmp(istate->sha1, (unsigned char *)hdr + mmap_size - 20))
> +               goto unmap;
> +
> +       munmap(mmap_addr, mmap_size);
> +       return 1;
> +
> +unmap:
> +       munmap(mmap_addr, mmap_size);
> +       return 0;
> +}
-- 
Duy
