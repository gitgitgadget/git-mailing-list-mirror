From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/22] read-cache: write index-v5
Date: Sun, 7 Jul 2013 16:43:44 -0400
Message-ID: <CAPig+cTEGWPMya=u6JhYh4x+3+cE7T-vZsdo4t-w-_4-tMh5eA@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
	<1373184720-29767-19-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 22:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvvoF-0001aV-55
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 22:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab3GGUnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 16:43:47 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61397 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3GGUnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 16:43:46 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so3249411lba.30
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RWF2SmTUGqSEYlUoWcnHjnP+oKh1jCgriyxTNudEe+U=;
        b=q+EXmsPilAYkYsskfRkgYJss5YXXu1ONMc13TT3wNvguZVX8+DaZAoCHNYSS9YJPCN
         RDx0jdXl0JoFjKL/L7JVmP5UmqAJGbEhPvfVdy7/nsH3u9AKD9LaT6xJ/9ECp5QhjPqO
         qawQcuqWuAzemfOSgERHXae+6FCUSWAqKdxKsYgkVZkwfSjKe6wYHLGQ4Kq5BznUKJWT
         dXmewijIzAWYeXgf8oFUsjud9kncIgY2Taif3m8zvf3ncA77WjMsyzoqV15XXPYa8j4Q
         Rz21vmUvd84sOIBFo9CQUzih1LD4e7Hku6gg1E6v4kstCyG29IxmpFyPLTmjUA3kZwJW
         O8Ig==
X-Received: by 10.112.88.169 with SMTP id bh9mr9413158lbb.12.1373229824167;
 Sun, 07 Jul 2013 13:43:44 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sun, 7 Jul 2013 13:43:44 -0700 (PDT)
In-Reply-To: <1373184720-29767-19-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: _8PbaoFFJ91X7xne2ecsi63hQHo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229805>

On Sun, Jul 7, 2013 at 4:11 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Write the index version 5 file format to disk. This version doesn't
> write the cache-tree data and resolve-undo data to the file.
>
> The main work is done when filtering out the directories from the
> current in-memory format, where in the same turn also the conflicts
> and the file data is calculated.
>
> Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/read-cache-v5.c b/read-cache-v5.c
> index f1ad132..f056f6b 100644
> --- a/read-cache-v5.c
> +++ b/read-cache-v5.c
> +static int write_index_v5(struct index_state *istate, int newfd)
> +{
> +       struct cache_version_header hdr;
> +       struct cache_header hdr_v5;
> +       struct cache_entry **cache = istate->cache;
> +       struct directory_entry *de;
> +       struct ondisk_directory_entry *ondisk;
> +       int entries = istate->cache_nr;
> +       int i, removed, non_conflicted, total_dir_len, ondisk_directory_size;
> +       int total_file_len, conflict_offset, offset_to_offset;
> +       unsigned int ndir;
> +       uint32_t crc;
> +
> +       if (istate->partially_read)
> +               die("BUG: index: cannot write a partially read index");
> +
> +       for (i = removed = 0; i < entries; i++) {
> +               if (cache[i]->ce_flags & CE_REMOVE)
> +                       removed++;
> +       }
> +       hdr.hdr_signature = htonl(CACHE_SIGNATURE);
> +       hdr.hdr_version = htonl(istate->version);
> +       hdr_v5.hdr_nfile = htonl(entries - removed);
> +       hdr_v5.hdr_nextension = htonl(0); /* Currently no extensions are supported */
> +
> +       non_conflicted = 0;
> +       total_dir_len = 0;
> +       total_file_len = 0;
> +       de = compile_directory_data(istate, entries, &ndir, &non_conflicted,
> +                       &total_dir_len, &total_file_len);
> +       hdr_v5.hdr_ndir = htonl(ndir);
> +
> +       /*
> +        * This is needed because the compiler aligns structs to sizes multipe

s/multipe/multiple/

> +        * of 4
> +        */
> +       ondisk_directory_size = sizeof(ondisk->flags)
> +               + sizeof(ondisk->foffset)
> +               + sizeof(ondisk->cr)
> +               + sizeof(ondisk->ncr)
> +               + sizeof(ondisk->nsubtrees)
> +               + sizeof(ondisk->nfiles)
> +               + sizeof(ondisk->nentries)
> +               + sizeof(ondisk->sha1);
> +       hdr_v5.hdr_fblockoffset = htonl(sizeof(hdr) + sizeof(hdr_v5) + 4
> +               + (ndir + 1) * 4
> +               + total_dir_len
> +               + ndir * (ondisk_directory_size + 4)
> +               + (non_conflicted + 1) * 4);
> +
> +       crc = 0;
> +       if (ce_write(&crc, newfd, &hdr, sizeof(hdr)) < 0)
> +               return -1;
> +       if (ce_write(&crc, newfd, &hdr_v5, sizeof(hdr_v5)) < 0)
> +               return -1;
> +       crc = htonl(crc);
> +       if (ce_write(NULL, newfd, &crc, 4) < 0)
> +               return -1;
> +
> +       conflict_offset = sizeof(hdr) + sizeof(hdr_v5) + 4
> +               + (ndir + 1) * 4
> +               + total_dir_len
> +               + ndir * (ondisk_directory_size + 4)
> +               + (non_conflicted + 1) * 4
> +               + total_file_len
> +               + non_conflicted * (sizeof(struct ondisk_cache_entry) + 4);
> +       if (write_directories(de, newfd, conflict_offset) < 0)
> +               return -1;
> +       offset_to_offset = sizeof(hdr) + sizeof(hdr_v5) + 4
> +               + (ndir + 1) * 4
> +               + total_dir_len
> +               + ndir * (ondisk_directory_size + 4);
> +       if (write_entries(istate, de, entries, newfd, offset_to_offset) < 0)
> +               return -1;
> +       if (write_conflicts(istate, de, newfd) < 0)
> +               return -1;
> +       return ce_flush(newfd);
> +}
> +
