From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3] notes: Allow committish expressions as notes ref
Date: Fri, 10 Jul 2015 03:03:15 +0200
Message-ID: <CALKQrgd_eB2ZUwUz54vW9OFOuZshvGGe9dx+suvd0=WA0OmOFQ@mail.gmail.com>
References: <1436350876-8274-1-git-send-email-mh@glandium.org>
	<1436410125-4957-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 03:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDMj1-0007u7-WA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 03:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbGJBDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 21:03:30 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64816 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbbGJBD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 21:03:28 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZDMip-00017y-Ui
	for git@vger.kernel.org; Fri, 10 Jul 2015 03:03:24 +0200
Received: by ykee186 with SMTP id e186so50990050yke.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 18:03:15 -0700 (PDT)
X-Received: by 10.170.139.135 with SMTP id g129mr19527376ykc.75.1436490195837;
 Thu, 09 Jul 2015 18:03:15 -0700 (PDT)
Received: by 10.37.92.2 with HTTP; Thu, 9 Jul 2015 18:03:15 -0700 (PDT)
In-Reply-To: <1436410125-4957-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273795>

On Thu, Jul 9, 2015 at 4:48 AM, Mike Hommey <mh@glandium.org> wrote:
> init_notes() is the main point of entry to the notes API. It is an arbitrary
> restriction that all it allows as input is a strict ref name, when callers
> may want to give an arbitrary committish.
>
> However, some operations that require updating the notes tree require a
> strict ref name, because they wouldn't be able to update e.g. foo@{1}.
>
> So we allow committish expressions to be used in the case the notes tree
> is going to be used without write "permissions", and to distinguish whether
> the notes tree is intended to be used for reads only, or will be updated,
> a flag is added.
>
> This has the side effect of enabling the use of committish as notes refs
> in commands allowing them, e.g. git log --notes=foo@{1}.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>

Reviewed-by: Johan Herland <johan@herland.net>

...modulo some comments below.

> ---
>  builtin/notes.c | 29 ++++++++++++++++-------------
>  notes-cache.c   | 11 ++++++-----
>  notes-utils.c   |  6 +++---
>  notes.c         | 11 +++++++----
>  notes.h         | 10 +++++++++-
>  5 files changed, 41 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 63f95fc..0fc6e7a 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -285,7 +285,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>                 if (!c)
>                         return 0;
>         } else {
> -               init_notes(NULL, NULL, NULL, 0);
> +               init_notes(NULL, NULL, NULL, NOTES_INIT_WRITABLE);
>                 t = &default_notes_tree;
>         }
>
> @@ -328,15 +328,18 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>         return ret;
>  }
>
> -static struct notes_tree *init_notes_check(const char *subcommand)
> +static struct notes_tree *init_notes_check(const char *subcommand,
> +                                          int flags)
>  {
>         struct notes_tree *t;
> -       init_notes(NULL, NULL, NULL, 0);
> +       const char *ref;
> +       init_notes(NULL, NULL, NULL, flags);
>         t = &default_notes_tree;
>
> -       if (!starts_with(t->ref, "refs/notes/"))
> +       ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;

Hmm, AFAICS from the code in notes.c, when NOTES_INIT_WRITABLE is set,
then t->ref == t->update_ref, which means the above line is redundant,
and t->ref will work just as well. That said, it's also bad to depend on
that fact from here, as the notes code might at some point change to
make t->ref != t->update_ref (e.g. if we want to allow a notes tree
which reads from one ref, but writes to another), so I guess the current
code is good.

> +       if (!starts_with(ref, "refs/notes/"))
>                 die("Refusing to %s notes in %s (outside of refs/notes/)",
> -                   subcommand, t->ref);
> +                   subcommand, ref);
>         return t;
>  }
>
[...]
> diff --git a/notes.c b/notes.c
> index df08209..84f8a47 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1007,13 +1007,16 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>         t->first_non_note = NULL;
>         t->prev_non_note = NULL;
>         t->ref = xstrdup_or_null(notes_ref);
> +       t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;

This is the only place in notes.c that references t->update_ref. Which
points to a latent design flaw in the notes API: struct notes_tree keeps
track of the notes ref (previously t->ref, but now also t->update_ref),
but it is actually never used by the core notes implementation (except
for display purposes in format_note() and an error message in
load_subtree()). I guess a better design would be to either

 (a) move the ref out of the API entirely, leaving notes.h/.c to only
     worry about reading and writing notes tree objects, and letting
     the caller deal with resolving and updatiung notes refs and
     commit objects.

 (b) move the ref handling _into_ the API, basically moving
     commit_notes() from notes-utils.h/.c into notes.h/.c

Of these, I believe (a) is better, escpecially if we also provide a
wrapper API (in notes-utils.h/.c?) around the inner/core API to deal
with the commit/ref details.

However, this is largely independent of your current effort, and
belongs in a different patch (series).

>         t->combine_notes = combine_notes;
>         t->initialized = 1;
>         t->dirty = 0;
>
>         if (flags & NOTES_INIT_EMPTY || !notes_ref ||
> -           read_ref(notes_ref, object_sha1))
> +           get_sha1_committish(notes_ref, object_sha1))

I believe this should be get_sha1_treeish() instead. The only place we use
the result (object_sha1) is when calling get_tree_entry() below, which
will peel to a tree object anyway, so there's no need to place the
stricter commitish requirement on the caller (in the read-only case).

As a bonus, you can also s/commitish/treeish/ in the commit subject line.

Also, I do not immediately remember whether we support notes refs that
point directly at tree objects (bypassing the commit object entirely),
but if we do, the get_sha1_committish() would break that use case...

>                 return;
> +       if (flags & NOTES_INIT_WRITABLE &&  read_ref(notes_ref, object_sha1))

Drop the extra space after &&.

[....]
> diff --git a/notes.h b/notes.h
> index 2a3f923..aa9960c 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -44,6 +44,7 @@ extern struct notes_tree {
>         struct int_node *root;
>         struct non_note *first_non_note, *prev_non_note;
>         char *ref;
> +       char *update_ref;
>         combine_notes_fn combine_notes;
>         int initialized;
>         int dirty;
> @@ -72,6 +73,13 @@ const char *default_notes_ref(void);
>  #define NOTES_INIT_EMPTY 1
>
>  /*
> + * By default, the notes tree is only readable, and the notes ref can be
> + * any committish. The notes tree can however be made writable with this

s/commitish/treeish/


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
