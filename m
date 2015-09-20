From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 56/67] avoid sprintf and strcpy with flex arrays
Date: Sun, 20 Sep 2015 18:48:32 -0400
Message-ID: <CAPig+cSL3W58TSYEAFz3twvxt_brB=kY=LEwX6m5RhBsg6VV6g@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160956.GD29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 00:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdnPn-0006Qy-EA
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 00:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbbITWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 18:48:34 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34587 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbbITWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 18:48:33 -0400
Received: by vkhf67 with SMTP id f67so55533531vkh.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CjzZ4Xj5UK5zKFq+V6c3Rk6Zqexl35zl+i8RnMp6lMc=;
        b=Q31ZdJWpvabZbLQNBsfTUXcItYk5m5r8F6i0yyTuHO+Wwe0EdkuXl7ljp/WeNpUGDW
         qn4sEMLI3MAMjoqB1WLuP09Irel8xsTmIwn+3ED8UsXkJYzBVLYSdWDLdTdjX5oZUAx3
         9WFRvCzvYJ+c+Rvm0elLM0+ZbTzT90zda3pB2e51boBIvnx+SGDglKEgI3N1NYZFi0wu
         lL951zHfVmVBXppKe4ru/DFEiOmPOVYDsmO93/EdUkxo/U05rYCShMIz4+T/VihHRY9C
         pTUhNNUttLiHKOVN4z5VQCthk+GkIApBqCLcyT7wpZdgKeXwGVG9TUm/ta6HOmPfBMWT
         sVXg==
X-Received: by 10.31.11.202 with SMTP id 193mr11303252vkl.84.1442789312475;
 Sun, 20 Sep 2015 15:48:32 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Sun, 20 Sep 2015 15:48:32 -0700 (PDT)
In-Reply-To: <20150915160956.GD29753@sigill.intra.peff.net>
X-Google-Sender-Auth: 8roR2YRKn0BpjUPl3FsA-5sGwvc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278274>

On Tue, Sep 15, 2015 at 12:09 PM, Jeff King <peff@peff.net> wrote:
> When we are allocating a struct with a FLEX_ARRAY member, we
> generally compute the size of the array and then sprintf or
> strcpy into it. Normally we could improve a dynamic allocation
> like this by using xstrfmt, but it doesn't work here; we
> have to account for the size of the rest of the struct.
>
> But we can improve things a bit by storing the length that
> we use for the allocation, and then feeding it to xsnprintf
> or memcpy, which makes it more obvious that we are not
> writing more than the allocated number of bytes.
>
> It would be nice if we had some kind of helper for
> allocating generic flex arrays, but it doesn't work that
> well:
>
>  - the call signature is a little bit unwieldy:
>
>       d = flex_struct(sizeof(*d), offsetof(d, path), fmt, ...);
>
>    You need offsetof here instead of just writing to the
>    end of the base size, because we don't know how the
>    struct is packed (partially this is because FLEX_ARRAY
>    might not be zero, though we can account for that; but
>    the size of the struct may actually be rounded up for
>    alignment, and we can't know that).
>
>  - some sites do clever things, like over-allocating because
>    they know they will write larger things into the buffer
>    later (e.g., struct packed_git here).
>
> So we're better off to just write out each allocation (or
> add type-specific helpers, though many of these are one-off
> allocations anyway).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/archive.c b/archive.c
> index 01b0899..4ac86c8 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -171,13 +171,14 @@ static void queue_directory(const unsigned char *sha1,
>                 unsigned mode, int stage, struct archiver_context *c)
>  {
>         struct directory *d;
> -       d = xmallocz(sizeof(*d) + base->len + 1 + strlen(filename));
> +       size_t len = base->len + 1 + strlen(filename) + 1;
> +       d = xmalloc(sizeof(*d) + len);

Mental note: The new code makes this one longer than the original code...

>         d->up      = c->bottom;
>         d->baselen = base->len;
>         d->mode    = mode;
>         d->stage   = stage;
>         c->bottom  = d;
> -       d->len = sprintf(d->path, "%.*s%s/", (int)base->len, base->buf, filename);
> +       d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);

Considering that we need space for the '/' and the NUL, the new code
seems to be correct, and the old code was under-allocating, right?

>         hashcpy(d->oid.hash, sha1);
>  }
>
> diff --git a/fast-import.c b/fast-import.c
> index d0c2502..895c6b4 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -863,13 +863,15 @@ static void start_packfile(void)
>  {
>         static char tmp_file[PATH_MAX];
>         struct packed_git *p;
> +       int namelen;
>         struct pack_header hdr;
>         int pack_fd;
>
>         pack_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
>                               "pack/tmp_pack_XXXXXX");
> -       p = xcalloc(1, sizeof(*p) + strlen(tmp_file) + 2);
> -       strcpy(p->pack_name, tmp_file);
> +       namelen = strlen(tmp_file) + 2;

You mentioned this specially in the commit message, but from a brief
read of the code, it's still not obvious (to me) why this is +2 rather
than +1. Since you're touching the code anyhow, perhaps add an in-code
comment explaining it?

> +       p = xcalloc(1, sizeof(*p) + namelen);
> +       xsnprintf(p->pack_name, namelen, "%s", tmp_file);
>         p->pack_fd = pack_fd;
>         p->do_not_close = 1;
>         pack_file = sha1fd(pack_fd, p->pack_name);
> diff --git a/refs.c b/refs.c
> index c2709de..df6c41a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3984,10 +3984,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  static struct ref_update *add_update(struct ref_transaction *transaction,
>                                      const char *refname)
>  {
> -       size_t len = strlen(refname);
> -       struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
> +       size_t len = strlen(refname) + 1;
> +       struct ref_update *update = xcalloc(1, sizeof(*update) + len);
>
> -       strcpy((char *)update->refname, refname);
> +       memcpy((char *)update->refname, refname, len); /* includese NUL */

s/includese/includes/

>         ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
>         transaction->updates[transaction->nr++] = update;
>         return update;
