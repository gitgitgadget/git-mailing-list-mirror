From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/16] pack-objects: use a faster hash table
Date: Tue, 25 Jun 2013 23:28:12 +0530
Message-ID: <CALkWK0krR=PaGC6iX8abmSswr7HBtzU61-7DR00xA3CyW80dtA@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com> <1372116193-32762-4-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 19:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrXW5-0003RL-RA
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 19:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab3FYR6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 13:58:54 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44853 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3FYR6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 13:58:53 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so28305705iea.39
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1tm/DUCyA8MGrtsuBBahb/et/9j0YEImuKJlv9D19ks=;
        b=EK8toPXBPJf+/1FRGoJicYxO/vn9iR1koml3h0Rq7nMZCk0tSdax03ZcmMRzp+M4WV
         u1lwDID/8kWjfHal7GllZ5hd638Ty0y83YmefvyhCuk2t6s0eOKtxrAMEUZq1OeNtEgG
         e6c0RrJH85zyJjznkKOVLaaCishWun7O9nyUNkjqfJVWXTjIt8mJkW7S3rMMtUf7Atm1
         kZDlXTgPK2IdVV+0ylQ190yf459XiUPfejVoIleelnxbJTWVhdyumljPf4PNUwWSdRWe
         DJkQEq1p2Nl1QhPpX636HxSh4vrQ37H1IkB8VjsoTjdsHdLUTrhtizUYM5btgSzZqArG
         Ewxw==
X-Received: by 10.42.190.74 with SMTP id dh10mr124481icb.35.1372183132958;
 Tue, 25 Jun 2013 10:58:52 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 25 Jun 2013 10:58:12 -0700 (PDT)
In-Reply-To: <1372116193-32762-4-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228982>

Vicent Marti wrote:
> When replacing the old hash table implementation in `pack-objects` with
> the khash_sha1 table, the insertion time is greatly reduced:

Why?  What is the exact change?

> The big win here, however, is in the massively reduced amount of hash
> collisions

Okay, so there seems to be some problem with how collisions are
handled in the hashtable.

> -static int locate_object_entry_hash(const unsigned char *sha1)
> -{
> -       int i;
> -       unsigned int ui;
> -       memcpy(&ui, sha1, sizeof(unsigned int));
> -       i = ui % object_ix_hashsz;
> -       while (0 < object_ix[i]) {
> -               if (!hashcmp(sha1, objects[object_ix[i] - 1].idx.sha1))
> -                       return i;
> -               if (++i == object_ix_hashsz)
> -                       i = 0;
> -       }
> -       return -1 - i;
> -}

Classical chaining to handle collisions: very naive.  Deserves to be thrown out.

> -static void rehash_objects(void)
> -{
> -       uint32_t i;
> -       struct object_entry *oe;
> -
> -       object_ix_hashsz = nr_objects * 3;
> -       if (object_ix_hashsz < 1024)
> -               object_ix_hashsz = 1024;
> -       object_ix = xrealloc(object_ix, sizeof(int) * object_ix_hashsz);
> -       memset(object_ix, 0, sizeof(int) * object_ix_hashsz);
> -       for (i = 0, oe = objects; i < nr_objects; i++, oe++) {
> -               int ix = locate_object_entry_hash(oe->idx.sha1);
> -               if (0 <= ix)
> -                       continue;
> -               ix = -1 - ix;
> -               object_ix[ix] = i + 1;
> -       }
> -}

This is called when the hashtable runs out of space.  It didn't appear
in your profiler because it doesn't appear to be a bottleneck, right?
Growing aggressively to 3x times the number of objects probably
explains it.  Just for comparison, how does khash grow?

>  static struct object_entry *locate_object_entry(const unsigned char *sha1)
>  {
> -       int i;
> +       khiter_t pos = kh_get_sha1(packed_objects, sha1);
>
> -       if (!object_ix_hashsz)
> -               return NULL;
> +       if (pos < kh_end(packed_objects)) {

Wait, why is this required?  When will kh_get_sha1() return a position
beyond kh_end()?  What does that mean?

> +               return kh_value(packed_objects, pos);
> +       }
>
> -       i = locate_object_entry_hash(sha1);
> -       if (0 <= i)
> -               return &objects[object_ix[i]-1];
>         return NULL;
>  }

Overall, replaced call to locate_object_entry_hash() with a call to
kh_get_sha1().  Okay.

> -static int add_object_entry(const unsigned char *sha1, enum object_type type,
> -                           const char *name, int exclude)
> +static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
> +                           uint32_t hash, int exclude, struct packed_git *found_pack,
> +                               off_t found_offset)
>  {
>         struct object_entry *entry;
> -       struct packed_git *p, *found_pack = NULL;
> -       off_t found_offset = 0;
> -       int ix;
> -       unsigned hash = name_hash(name);
> +       struct packed_git *p;
> +       khiter_t ix;
> +       int hash_ret;
>
> -       ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
> -       if (ix >= 0) {
> +       ix = kh_put_sha1(packed_objects, sha1, &hash_ret);

You don't need to call locate_object_entry() to check for collisions
because kh_put_sha1() takes care of that?

> +       if (hash_ret == 0) {
>                 if (exclude) {
> -                       entry = objects + object_ix[ix] - 1;
> +                       entry = kh_value(packed_objects, ix);

Superficial change: using kh_value(), because we stripped out the
chaining logic.

> @@ -966,19 +965,30 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>                 entry->in_pack_offset = found_offset;
>         }
>
> -       if (object_ix_hashsz * 3 <= nr_objects * 4)
> -               rehash_objects();
> -       else
> -               object_ix[-1 - ix] = nr_objects;
> +       kh_value(packed_objects, ix) = entry;
> +       kh_key(packed_objects, ix) = entry->idx.sha1;
> +       objects[nr_objects++] = entry;

Wait, what?  Why didn't you use kh_put_sha1()?

I didn't look very carefully, but the patch seems to be okay overall.
On the issue of which hashtable replacement to use (why khash, and not
something else?), I briefly looked at linux.git's linux/hashtable.h
and git.git's hash.h; both of them are chaining hashes.  From a brief
look at khash.h, it seems to be somewhat less naive and sane: my only
concern is that it is written entirely in using CPP macros which is a
great for syntax/performance, but not-so-great for debugging.  I don't
know if there's a better off-the-shelf implementation out there, but I
haven't been looking for one either.  By the way, it's MIT license
authored by an anonymous person (sources at:
https://github.com/attractivechaos/klib/blob/master/khash.h), but I
don't know if that's a problem.

Thanks.
