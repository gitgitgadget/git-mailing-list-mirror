Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7705120966
	for <e@80x24.org>; Fri,  7 Apr 2017 14:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934018AbdDGOxf (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 10:53:35 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:58902 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933650AbdDGOxd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 10:53:33 -0400
X-Greylist: delayed 1889 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Apr 2017 10:53:33 EDT
Received: from mail-qk0-f182.google.com ([209.85.220.182])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1cwUm2-0006N6-Ha
        for git@vger.kernel.org; Fri, 07 Apr 2017 16:22:02 +0200
Received: by mail-qk0-f182.google.com with SMTP id p22so63898661qka.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 07:22:02 -0700 (PDT)
X-Gm-Message-State: AN3rC/6CPSunK+b+HNSxMhcRtB8NI3A1dc8xDXClXlCfGMYEuiWYp/biBPonWml/JdpERJSeQsvY2KZZpQ1HDA==
X-Received: by 10.55.166.213 with SMTP id p204mr6477385qke.22.1491574916361;
 Fri, 07 Apr 2017 07:21:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.137.3 with HTTP; Fri, 7 Apr 2017 07:21:55 -0700 (PDT)
In-Reply-To: <20170326015212.11578-1-mh@glandium.org>
References: <20170326015212.11578-1-mh@glandium.org>
From:   Johan Herland <johan@herland.net>
Date:   Fri, 7 Apr 2017 16:21:55 +0200
X-Gmail-Original-Message-ID: <CALKQrgfH-hHFrMz=t=-XKkZFvhGDRquw8Pnbgz0kJtnb-tB+Ag@mail.gmail.com>
Message-ID: <CALKQrgfH-hHFrMz=t=-XKkZFvhGDRquw8Pnbgz0kJtnb-tB+Ag@mail.gmail.com>
Subject: Re: [PATCH] notes: Fix note_tree_consolidate not to break the
 note_tree structure
To:     Mike Hommey <mh@glandium.org>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 3:52 AM, Mike Hommey <mh@glandium.org> wrote:
> After a note is removed, note_tree_consolidate is called to eliminate
> some useless nodes. The typical case is that if you had an int_node
> with 2 PTR_TYPE_NOTEs in it, and remove one of them, then the
> PTR_TYPE_INTERNAL pointer in the parent tree can be replaced with the
> remaining PTR_TYPE_NOTE.
>
> This works fine when PTR_TYPE_NOTEs are involved, but falls flat when
> other types are involved.
>
> To put things in more practical terms, let's say we start from an empty
> notes tree, and add 3 notes:
> - one for a sha1 that starts with 424
> - one for a sha1 that starts with 428
> - one for a sha1 that starts with 4c
>
> To keep track of this, note_tree.root will have a PTR_TYPE_INTERNAL at
> a[4], pointing to an int_node*.
> In turn, that int_node* will have a PTR_TYPE_NOTE at a[0xc], pointing to
> the leaf_node* with the key and value, and a PTR_TYPE_INTERNAL at a[2],
> pointing to another int_node*.
> That other int_node* will have 2 PTR_TYPE_NOTE, one at a[4] and the
> other at a[8].
>
> When looking for the note for the sha1 starting with 428, get_note() will
> recurse through (simplified) root.a[4].a[2].a[8].
>
> Now, if we remove the note for the sha1 that starts with 4c, we're left
> with a int_node* with only one PTR_TYPE_INTERNAL entry in it. After
> note_tree_consolidate runs, root.a[4] now points to what used to be
> pointed at by root.a[4].a[2].
>
> Which means looking up for the note for the sha1 starting with 428 now
> fails because there is nothing at root.a[4].a[2] anymore: there is only
> root.a[4].a[4] and root.a[4].a[8], which don't match the expected
> structure for the lookup.
>
> So if all there is left in an int_node* is a PTR_TYPE_INTERNAL pointer,
> we can't safely remove it.

Correct.

> I think the same applies for PTR_TYPE_SUBTREE pointers.

I disagree. The subtree nodes contain the entire key prefix for that subtree
in their .key_sha1, and before descending into a subtree (causing it to be
unpacked), we always prefix-compare the key we're looking for against the
subtree's .key_sha1. This behavior, as well as the subtree's .key_sha1 is
unaffected by which level of the notes tree hold the subtree node (provided
- obviously - that the location is along the prefix path).

Adding a variation to your example: Assume that the 424 and 428 nodes are
packed inside a subtree node. We then have: root.a[4] points to an int_node
whose .a[2] points to a subtree node, and .a[0xc] points to a note node. The
subtree node at root.a[4].a[2] represents a key-prefix of "42" (i.e.
its .key_sha1
equals [0x42, 0x0, ..., 0x0, 0x2]).

Now, after removing the 4c note, we consider consolidating the int_node at
root.a[4]. At this point, its only member is the single subtree entry at a[2].
By removing the int_node and moving the subtree node to root.a[4], we
have simply reorganized from

  root.a[4].a[2] -> subtree("42")

to

  root.a[4] -> subtree("42")

AFAICS, this layout is equally valid (and more optimal) than before we
consolidated. We will still always perform the complete prefix-compare
against "42" before descending into the subtree.

In summary, the bug that really needs fixing is the relocation of existing
int_nodes. Otherwise, leaf_nodes (whether they be PTR_TYPE_NOTE or
PTR_TYPE_SUBTREE) can be freely relocated within the tree as long as the
path leading to them (root.a[x].a[y].a[z]) prefix-matches their .key_sha1.

> IOW, only PTR_TYPE_NOTEs are safe to be moved to the parent
> int_node*.

This holds for both PTR_TYPE_NOTEs and PTR_TYPE_SUBTREEs, IMHO.

>
> This doesn't have a practical effect on git because all that happens
> after a remove_note is a write_notes_tree, which just iterates the entire
> note tree, but this affects anything using libgit.a that would try to do
> lookups after removing notes.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>

Regardless of the PTR_TYPE_SUBTREE optimization discussed above,
I believe your patch is safe, and can be used as-is.

> ---
>  notes.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 2bab961ac..542563b28 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -153,8 +153,8 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
>   * How to consolidate an int_node:
>   * If there are > 1 non-NULL entries, give up and return non-zero.
>   * Otherwise replace the int_node at the given index in the given parent node
> - * with the only entry (or a NULL entry if no entries) from the given tree,
> - * and return 0.
> + * with the only NOTE entry (or a NULL entry if no entries) from the given
> + * tree, and return 0.
>   */
>  static int note_tree_consolidate(struct int_node *tree,
>         struct int_node *parent, unsigned char index)
> @@ -173,6 +173,8 @@ static int note_tree_consolidate(struct int_node *tree,
>                 }
>         }
>
> +       if (p && (GET_PTR_TYPE(p) != PTR_TYPE_NOTE))
> +               return -2;

Based on the above discussion, I believe this can be rewritten to:

+       if (p && (GET_PTR_TYPE(p) == PTR_TYPE_INTERNAL))
+               return -2; /* Cannot move int_nodes within the tree. */

for a more optimal handling of subtree nodes in this scenario.


Have fun! :)

...Johan


>         /* replace tree with p in parent[index] */
>         parent->a[index] = p;
>         free(tree);
> --
> 2.12.1.dirty
>



-- 
Johan Herland, <johan@herland.net>
www.herland.net
