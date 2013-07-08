From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 8 Jul 2013 09:01:43 +0700
Message-ID: <CACsJy8A65JGUtdJnGuC20vUfQLQfrtDzj7Eb8pgP9RTqP1Po_w@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 04:02:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw0mU-000823-Md
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 04:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab3GHCCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 22:02:14 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57447 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3GHCCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 22:02:14 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so4851722obb.4
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e0Dudufh7JEdtkozbj3KwHZ8bJ9bToOleyTeK/MrYJM=;
        b=nHEInr5HBQg+VZC0yoqa5fRyByrx7XM+3yRu++MvLqZL4oUbc8zRZ3/F/aPOFBbgwg
         YqwTk2+iYfDDSrl/97+kqNcHzr46+Bc04CQJPBrab3hrreytfvtSjXpgIwHuDbwNzrp2
         dUZjVzr9dYjmev9DMua9D529QJAEPGre95QnMbTMsk8GEW9+n8AjFJX9eESWERl6wcqg
         oZdDNkeQ3258Bpy+bjaBDSqbPsYH2enT8iUu61P/y3PByqCGHm88jwzZQOgzAc827Kfz
         4MLpVFjVnUJlQ2KovoioMVBCGzohS9SVtXq0DnrA2s25yUJPoz3q9kvr/7mC2CMEFLXT
         dzHg==
X-Received: by 10.182.215.133 with SMTP id oi5mr18688901obc.83.1373248933109;
 Sun, 07 Jul 2013 19:02:13 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sun, 7 Jul 2013 19:01:43 -0700 (PDT)
In-Reply-To: <1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229820>

On Sun, Jul 7, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Add an api for access to the index file.  Currently there is only a very
> basic api for accessing the index file, which only allows a full read of
> the index, and lets the users of the data filter it.  The new index api
> gives the users the possibility to use only part of the index and
> provides functions for iterating over and accessing cache entries.
>
> This simplifies future improvements to the in-memory format, as changes
> will be concentrated on one file, instead of the whole git source code.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  cache.h         |  57 +++++++++++++++++++++++++++++-
>  read-cache-v2.c |  96 +++++++++++++++++++++++++++++++++++++++++++++++--
>  read-cache.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  read-cache.h    |  12 ++++++-
>  4 files changed, 263 insertions(+), 10 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 5082b34..d38dfbd 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -127,7 +127,8 @@ struct cache_entry {
>         unsigned int ce_flags;
>         unsigned int ce_namelen;
>         unsigned char sha1[20];
> -       struct cache_entry *next;
> +       struct cache_entry *next; /* used by name_hash */
> +       struct cache_entry *next_ce; /* used to keep a list of cache entries */
>         char name[FLEX_ARRAY]; /* more */
>  };

>From what I read, doing

    ce = start;
    while (ce) { do(something); ce = next_cache_entry(ce); }

is the same as

    i = start_index;
    while (i < active_nr) { ce = active_cache[i]; do(something); i++; }

What's the advantage of using the former over the latter? Do you plan
to eliminate the latter loop (by hiding "struct cache_entry **cache;"
from public index_state structure?
--
Duy
