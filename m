From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 17/24] read-cache: read cache-tree in index-v5
Date: Sat, 24 Aug 2013 07:09:33 +0700
Message-ID: <CACsJy8Br8EaEtoZeaz2eLKvxDmPJqUc02bYsL_OSLJvJ2dBU-g@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-18-git-send-email-t.gummerer@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Aug 24 02:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1Qn-0006C6-CM
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab3HXAKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:10:06 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:41027 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3HXAKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:10:05 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so1327482obc.20
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=voBr5A7iQem0ckOFoezTpW6zJugLTwTlzZDXYw7SUEs=;
        b=JxgxhfFTG5rdRFC+MPd9Bb2hBQUl9D2TniJO9kiCWjidEPzI69XF7eJZ3KgDfIPxq6
         eSc1Otsmlvxj6rhvOsp09EkPy2fy08lojw6PoEUq2Uib67fQxdIYh5Iy5GJiG6ef7kpT
         ZcUHb42DnEAek5V9RLMPVNIWnpiDEWqBTjxhP1mD96+3C60oaj1+JjGpk848E0mxOemE
         dxUlGf1xHlrrS7ibyHWOvPj1usFevqH1vBe+obb9aO0x8bfFXgRNszNDfMv9wZtzUTwO
         vowOMXDABNhigA9HIY4dUn5ZmMwZ6nuNvxQ/UtbMpA+vHwlF0R3qD+uZYXq55odTQdtE
         uFCQ==
X-Received: by 10.60.118.41 with SMTP id kj9mr1981778oeb.31.1377303003857;
 Fri, 23 Aug 2013 17:10:03 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 23 Aug 2013 17:09:33 -0700 (PDT)
In-Reply-To: <1376854933-31241-18-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232849>

On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +/*
> + * This function modifies the directory argument that is given to it.
> + * Don't use it if the directory entries are still needed after.
> + */

There goes my hope of keeping directory_entry* in core so that at
write-time, after validation, we only need to recreate some trees
instead of all of them..

Or we could make cache-tree keep references to directory_entry. If a
cache-tree is not invalidated, then the attached directory_tree should
be reused..

> +static struct cache_tree *cache_tree_convert_v5(struct directory_entry *de)
> +{
> +       if (!de->de_nentries)
> +               return NULL;
> +       sort_directories(de);
> +       return convert_one(de);
> +}
> +
>  static int read_entries(struct index_state *istate, struct directory_entry *de,
>                         unsigned int first_entry_offset, void *mmap,
>                         unsigned long mmap_size, unsigned int *nr,
> @@ -591,6 +668,7 @@ static int read_index_v5(struct index_state *istate, void *mmap,
>                 }
>                 de = de->next;
>         }
> +       istate->cache_tree = cache_tree_convert_v5(root_directory);
>         istate->cache_nr = nr;
>         return 0;
>  }

Otherwise we do need to free root_directory down to the deepest
subtrees, I think. People have been complaining about read-cache
leaking memory like mad, so this is a real issue. Even if you keep
references in cache-tree, you still need to free it
cache_tree_invalidate_path() to avoid leaking
-- 
Duy
