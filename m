From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Thu, 10 Sep 2015 13:04:33 -0700
Message-ID: <xmqqk2ry2g8e.fsf@gitster.mtv.corp.google.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za85I-00046V-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 22:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbbIJUEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 16:04:37 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36407 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbIJUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 16:04:35 -0400
Received: by padhk3 with SMTP id hk3so51733363pad.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LMXLaBd3LqTpHD7tufdh3eLbczvhWfE+PCLQqa4viyw=;
        b=xtqU59ptOxbFA4twQ3mBsIjBK2vkgVXw93IJqRXkuFy91Zq2Tj4vuzGu7lLKYctLKx
         6DaJJETUWSORM5PjRM9s5xUaHWR6zWm+F+N4g3+haCZPrGQlDtYs5RAMCkkjPI3ny8lg
         +nOo+jwSTsi7SeICca0A2Gj5c5nxZZEK/IClmAc9sUmnbzE9H+SRLGEHj3uY9du7jZNP
         OLrikh6PL0xT3JNM+BpiBonpB6XvAjp97BuYQeMyZFLOoBkpfertdY1ItXDqAvNLEpMG
         dVKk9Do+tnUuLP8azMYO1gL0PRnN2uVgpF+xVibNjTgmI0rTnoUfQVZp9JQMadQW3AK6
         0xqw==
X-Received: by 10.68.176.227 with SMTP id cl3mr49598674pbc.8.1441915475098;
        Thu, 10 Sep 2015 13:04:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id jf10sm5547287pbd.64.2015.09.10.13.04.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 13:04:34 -0700 (PDT)
In-Reply-To: <1441402769-35897-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 4 Sep 2015 17:39:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277629>

Michael Rappazzo <rappazzo@gmail.com> writes:

> Including functions to get the list of all worktrees, and to get
> a specific worktree (primary or linked).

Was this meant as a continuation of the sentence started on the
Subject line, or is s/Including/Include/ necessary?

> diff --git a/worktree.c b/worktree.c
> new file mode 100644
> index 0000000..33d2e57
> --- /dev/null
> +++ b/worktree.c
> @@ -0,0 +1,157 @@
> +#include "worktree.h"
> +#include "cache.h"
> +#include "git-compat-util.h"

The first header to be included must be "git-compat-util.h" or
"cache.h", the latter of which is so well known to include the
former as the first thing (so inclusion of "git-compat-util.h"
becomes unnecessary).

After that, include your own header as necessary.

> +#include "refs.h"
> +#include "strbuf.h"
> +
> +void worktree_release(struct worktree *worktree)
> +{
> +	if (worktree) {
> +		free(worktree->path);
> +		free(worktree->git_dir);
> +		if (!worktree->is_detached) {
> +			/* could be headless */
> +			free(worktree->head_ref);
> +		}

Unnecessary brace {} pair?  It is OK to keep them if later patches
in the series will make this a multi-statement block, though.

> +		free(worktree);
> +	}
> +}
> +
> +void worktree_list_release(struct worktree_list *worktree_list)
> +{
> +	while (worktree_list) {
> +		struct worktree_list *next = worktree_list->next;
> +		worktree_release(worktree_list->worktree);
> +		free (worktree_list);

No SP between function name and the parenthesis that introduces its
arguments.

> +		worktree_list = next;
> +	}
> +}
> +
> +/*
> + * read 'path_to_ref' into 'ref'.  Also set is_detached to 1 if the ref is detatched
> + *
> + * return 1 if the ref is not a proper ref, 0 otherwise (success)

These lines are overly long.

> + */
> +int _parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
> +{
> +	if (!strbuf_readlink(ref, path_to_ref, 0)) {
> +		if (!starts_with(ref->buf, "refs/") || check_refname_format(ref->buf, 0)) {

An overly long line.  Perhaps 

		if (!starts_with(ref->buf, "refs/") ||
		    check_refname_format(ref->buf, 0)) {

(I see many more "overly long line" after this point, which I won't mention).

> +			/* invalid ref - something is awry with this repo */
> +			return 1;
> +		}
> +	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
> +		if (starts_with(ref->buf, "ref:")) {
> +			strbuf_remove(ref, 0, strlen("ref:"));
> +			strbuf_trim(ref);

We don't do the same "starts_with() and format is sane" check?

> +		} else if (is_detached) {
> +			*is_detached = 1;
> +		}
> +	}

> +	return 0;
> +}
> +

> +struct worktree_list *get_worktree_list()

struct worktree_list *get_worktree_list(void)

> +{
> +	struct worktree_list *list = NULL;
> +	struct worktree_list *current_entry = NULL;
> +	struct worktree *current_worktree = NULL;
> +	struct strbuf path = STRBUF_INIT;
> +	DIR *dir;
> +	struct dirent *d;
> +
> +	current_worktree = get_worktree(NULL);
> +	if (current_worktree) {
> +		list = malloc(sizeof(struct worktree_list));

Always use x*alloc() family of functions.

> +		list->worktree = current_worktree;
> +		list->next = NULL;
> +		current_entry = list;
> +	}

If the above if() is not taken, current_entry is left as NULL

> +	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
> +	dir = opendir(path.buf);
> +	strbuf_release(&path);
> +	if (dir) {
> +		while ((d = readdir(dir)) != NULL) {
> +			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +				continue;
> +
> +			current_worktree = get_worktree(d->d_name);
> +			if (current_worktree) {
> +				current_entry->next = malloc(sizeof(struct worktree_list));

But this line assumes that current_entry is never NULL.

> +				current_entry = current_entry->next;
> +				current_entry->worktree = current_worktree;
> +				current_entry->next = NULL;
> +			}
> +		}
> +		closedir(dir);
> +	}

An idiomatic way to extend a singly-linked list at the end in our
codebase is to use a pointer to the pointer that has the element at
the end, instead of to use a pointer that points at the element at
the end or NULL (i.e. the pointer the above code calls current_entry
is "struct worktree_list **end_of_list").  Would it make the above
simpler if you followed that pattern?

> +
> +done:
> +
> +	return list;
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
> +	char *path;
> +	char *git_dir;
> +	char *head_ref;
> +	unsigned char head_sha1[20];
> +	int is_detached;
> +	int is_bare;
> +};
> +
> +struct worktree_list {
> +	struct worktree *worktree;
> +	struct worktree_list *next;
> +};
> +
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

extern struct worktree_list *get_worktree_list(void);

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
