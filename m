From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Sat, 12 Sep 2015 22:39:26 -0400
Message-ID: <CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 04:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaxCX-0003ZL-O3
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 04:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbbIMCj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 22:39:28 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35901 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbbIMCj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 22:39:27 -0400
Received: by ykdt18 with SMTP id t18so105083520ykd.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 19:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0dRhDq18O8MKG/2eCPbxODK2nxGVIoUgXgShJwQ3j/U=;
        b=ai20ZsE3L3AyWyMNBB4XT5ACXUMatLGWuCYcuUDteFQiH7AQDjzIvi9rNEGNlM72hs
         ieneO4TloFJQhBAA9hcaht4IQGGa5nNIh5ArFa/PJjgQBXbynye/sd61IXeUKSxmfjiI
         vGdlA7jrRtkv6cSeJMWLPbt82WRdeDd3eJzrXdkS6rTZajnykVGpj7P4/t9RY4qJ7m4z
         BDdSZ9tqCkJqDKgT44PUjH5NAB36l8HUN8QG2+Kzwjzz98sI3/0MVkNRK95cfieiole2
         BH7IakpTudvnAljmfPqU4fCikEGFZrm+9cUus1uKaVoZ6GY7ofdp7uS3yQDTf4kUa8Rb
         fqDw==
X-Received: by 10.170.138.214 with SMTP id f205mr6811412ykc.84.1442111966919;
 Sat, 12 Sep 2015 19:39:26 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sat, 12 Sep 2015 19:39:26 -0700 (PDT)
In-Reply-To: <1441402769-35897-2-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: r3tmefmLGr-a8Q2Hrsp-cm9YyJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277754>

On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> Including functions to get the list of all worktrees, and to get
> a specific worktree (primary or linked).

Some comments below in addition to those by Junio...

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> new file mode 100644
> index 0000000..33d2e57
> --- /dev/null
> +++ b/worktree.c
> @@ -0,0 +1,157 @@
> +#include "worktree.h"
> +#include "cache.h"
> +#include "git-compat-util.h"
> +#include "refs.h"
> +#include "strbuf.h"
> +
> +void worktree_release(struct worktree *worktree)
> +{
> +       if (worktree) {
> +               free(worktree->path);
> +               free(worktree->git_dir);
> +               if (!worktree->is_detached) {
> +                       /* could be headless */
> +                       free(worktree->head_ref);

It's safe to invoke free() on NULL, so as long as worktree->head_ref
holds NULL in the detached case, then there's no need for the
conditional at all (or the comment).

> +               }
> +               free(worktree);
> +       }
> +}
> +
> +void worktree_list_release(struct worktree_list *worktree_list)
> +{
> +       while (worktree_list) {
> +               struct worktree_list *next = worktree_list->next;
> +               worktree_release(worktree_list->worktree);
> +               free (worktree_list);
> +               worktree_list = next;
> +       }
> +}
> +
> +/*
> + * read 'path_to_ref' into 'ref'.  Also set is_detached to 1 if the ref is detatched
> + *
> + * return 1 if the ref is not a proper ref, 0 otherwise (success)
> + */
> +int _parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)

Mentioned already by Junio in his review of patch 2: Make this
function static and drop the leading underscore from the name.

> +{
> +       if (!strbuf_readlink(ref, path_to_ref, 0)) {
> +               if (!starts_with(ref->buf, "refs/") || check_refname_format(ref->buf, 0)) {
> +                       /* invalid ref - something is awry with this repo */
> +                       return 1;

In this codebase, it's common to return -1 on error. You could also
probably drop the unnecessary braces (here and a few other places).

> +               }
> +       } else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
> +               if (starts_with(ref->buf, "ref:")) {
> +                       strbuf_remove(ref, 0, strlen("ref:"));
> +                       strbuf_trim(ref);
> +               } else if (is_detached) {
> +                       *is_detached = 1;

The code allows the caller to pass in NULL for is_detached if not
interested in this information, however, the comment block documenting
the function doesn't mention this.

Also, don't you need to clear *is_detached when not detached since you
don't know what garbage value *is_detached holds upon entry?

I find the placement of the detached detection logic here a bit
strange. The only case for which it might trigger is the so-called
"main worktree", yet having it in this general purpose parse function
seems to imply misleadingly that any worktree could be detached. Also,
given the current world order[1], wouldn't missing "ref:" indicate an
error for any worktree other than the main one? Consequently, this
detection probably ought to be done only for the main worktree
(outside of this function, probably).

[1]: Though, this might not hold true in a future world order
involving merging of notes, if I correctly understood that discussion,
since notes merging wouldn't require a "worktree", per se.

> +               }
> +       }
> +       return 0;
> +}
> +
> +struct worktree *get_worktree(const char *id)
> +{
> +       struct worktree *worktree = NULL;
> +       struct strbuf path = STRBUF_INIT;
> +       struct strbuf worktree_path = STRBUF_INIT;
> +       struct strbuf git_dir = STRBUF_INIT;
> +       struct strbuf head_ref = STRBUF_INIT;
> +       int is_bare = 0;
> +       int is_detached = 0;
> +
> +       if (id) {
> +               strbuf_addf(&git_dir, "%s/worktrees/%s", absolute_path(get_git_common_dir()), id);
> +               strbuf_addf(&path, "%s/gitdir", git_dir.buf);
> +               if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0) {
> +                       /* invalid git_dir file */
> +                       goto done;
> +               }
> +               strbuf_rtrim(&worktree_path);
> +               if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
> +                       strbuf_reset(&worktree_path);
> +                       strbuf_addstr(&worktree_path, absolute_path("."));
> +                       strbuf_strip_suffix(&worktree_path, "/.");
> +               }
> +
> +               strbuf_reset(&path);
> +               strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
> +       } else {
> +               strbuf_addf(&git_dir, "%s", absolute_path(get_git_common_dir()));
> +               strbuf_addf(&worktree_path, "%s", absolute_path(get_git_common_dir()));
> +               is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> +               if (is_bare)
> +                       strbuf_strip_suffix(&worktree_path, "/.");
> +
> +               strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> +       }

I realize that this is modeled closely after existing code in
branch.c, but, with the exception of parsing the ref file and
constructing a worktree structure, the main worktree case (id == NULL)
is entirely disjoint from the linked worktree case (id != NULL). This
suggests strongly that get_worktree() should be split into two
functions, one for the main worktree and one for linked worktrees,
which would make the code easier to understand. You might call the
functions get_main_worktree() and get_linked_worktree(id) (or perhaps
drop "linked" from the latter name).

> +       /*
> +        * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so for linked worktrees,
> +        * `resolve_ref_unsafe()` won't work (it uses git_path). Parse the ref ourselves.
> +        */

This comment probably belongs inside _parse_ref() as it's explaining
its internal workings, rather than here at the call-site.

> +       if (_parse_ref(path.buf, &head_ref, &is_detached))
> +               goto done;
> +
> +       worktree = malloc(sizeof(struct worktree));
> +       worktree->path = strbuf_detach(&worktree_path, NULL);
> +       worktree->git_dir = strbuf_detach(&git_dir, NULL);
> +       worktree->is_bare = is_bare;
> +       worktree->head_ref = NULL;
> +       worktree->is_detached = is_detached;
> +       if (strlen(head_ref.buf) > 0) {

More idiomatic:

    if (head_ref.len) {

> +               if (!is_detached) {
> +                       resolve_ref_unsafe(head_ref.buf, 0, worktree->head_sha1, NULL);
> +                       worktree->head_ref = strbuf_detach(&head_ref, NULL);
> +               } else {
> +                       get_sha1_hex(head_ref.buf, worktree->head_sha1);
> +               }
> +       }
> +done:
> +       strbuf_release(&path);
> +       strbuf_release(&git_dir);
> +       strbuf_release(&head_ref);
> +       strbuf_release(&worktree_path);
> +       return worktree;
> +}
> +
> +struct worktree_list *get_worktree_list()

Can we be more concise and call this get_worktrees()?

> +{
> +       struct worktree_list *list = NULL;
> +       struct worktree_list *current_entry = NULL;
> +       struct worktree *current_worktree = NULL;
> +       struct strbuf path = STRBUF_INIT;
> +       DIR *dir;
> +       struct dirent *d;
> +
> +       current_worktree = get_worktree(NULL);
> +       if (current_worktree) {
> +               list = malloc(sizeof(struct worktree_list));
> +               list->worktree = current_worktree;
> +               list->next = NULL;
> +               current_entry = list;
> +       }
> +       strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
> +       dir = opendir(path.buf);
> +       strbuf_release(&path);
> +       if (dir) {
> +               while ((d = readdir(dir)) != NULL) {
> +                       if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +                               continue;
> +
> +                       current_worktree = get_worktree(d->d_name);
> +                       if (current_worktree) {
> +                               current_entry->next = malloc(sizeof(struct worktree_list));
> +                               current_entry = current_entry->next;
> +                               current_entry->worktree = current_worktree;
> +                               current_entry->next = NULL;
> +                       }
> +               }
> +               closedir(dir);
> +       }
> +
> +done:

What is this label for? It doesn't seem to have any corresponding goto's.

> +
> +       return list;
> +}
> +
> diff --git a/worktree.h b/worktree.h
> new file mode 100644
> index 0000000..2bc0ab8
> --- /dev/null
> +++ b/worktree.h
> @@ -0,0 +1,48 @@
> +#ifndef WORKTREE_H
> +#define WORKTREE_H
> +
> +struct worktree {
> +       char *path;
> +       char *git_dir;
> +       char *head_ref;
> +       unsigned char head_sha1[20];
> +       int is_detached;
> +       int is_bare;
> +};
> +
> +struct worktree_list {
> +       struct worktree *worktree;
> +       struct worktree_list *next;
> +};

I don't care too strongly, but an alternate approach (which I probably
would have taken) would be to have get_worktrees() simply return an
array of 'struct worktree' objects, hence no need for the additional
'struct worktree_list'. The slight complication with this approach,
though, is that get_worktrees() either also needs to return the length
of the array, or the array should end with some sort of end-of-array
sentinel. An obvious sentinel would be path==NULL or git_dir==NULL or
all of the above.

Client iteration is just about the same with the array approach as
with the linked-list approach.

> +/* Functions for acting on the information about worktrees. */
> +
> +/*
> + * Get the list of all worktrees.  The primary worktree will always be
> + * the first in the list followed by any other (linked) worktrees created
> + * by `git worktree add`.  No specific ordering is done on the linked
> + * worktrees.
> + *
> + * The caller is responsible for freeing the memory from the returned list.
> + * (See worktree_list_release for this purpose).
> + */
> +extern struct worktree_list *get_worktree_list();
> +
> +/*
> + * generic method to get a worktree
> + *   - if 'id' is NULL, get the from $GIT_COMMON_DIR
> + *   - if 'id' is not NULL, get the worktree found in $GIT_COMMON_DIR/worktrees/id if
> + *     such a worktree exists
> + *
> + * The caller is responsible for freeing the memory from the returned
> + * worktree.  (See worktree_release for this purpose)
> + */
> +struct worktree *get_worktree(const char *id);
> +
> +/*
> + * Free up the memory for a worktree_list/worktree
> + */
> +extern void worktree_list_release(struct worktree_list *);
> +extern void worktree_release(struct worktree *);
> +
> +#endif
> --
> 2.5.0
