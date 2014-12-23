From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v3 2/4] rev-list: add an option to mark fewer edges as uninteresting
Date: Tue, 23 Dec 2014 12:55:48 -0500
Message-ID: <CAO2U3Qjbmz+fP-SLSeq1S+BDi4PSTSLf_TdqW-ik8GLV7=nUmA@mail.gmail.com>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net> <1419336082-283091-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Tgt-00010s-Tw
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268AbaLWR4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:56:11 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43110 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbaLWR4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:56:09 -0500
Received: by mail-ob0-f174.google.com with SMTP id nt9so29083199obb.5
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aYLHJwQRBAxQDOpIe5YV7qTCCDqd1Yd8r0/GxgektZ8=;
        b=PfNRelXdBoRBUWoASI+ixhLIwTtyj5JDGbcZMQ8e95LTnvt6vzi9o0axX8fh1VEJzy
         51ZEJBpqwUUr+5zdCEDI6rH2nAu2B63LJHwDkcv/949+FsmgQtiy2T6Ijp7oKOVPBGbf
         CIAk27N0iw07MrDm0CNQEwvnYhdUF3BvC0UJaaA2h3uCknuzBfS5B309KHc0ZpbxXoMh
         mzjSi5rr41FqpwMtHRh/d83YKhbyJCxhD/JERzwDaDsOe7zrzz6Xcn9mcwX4Kf+2drmC
         IGDQm2cyZcZ0USce+3ClzCBMsukmQ7Mk2jmB9URuJwvrsHcvXzfBgUewf4mXGQrLmZSu
         /Ajw==
X-Received: by 10.202.71.212 with SMTP id u203mr16149530oia.54.1419357368896;
 Tue, 23 Dec 2014 09:56:08 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Tue, 23 Dec 2014 09:55:48 -0800 (PST)
In-Reply-To: <1419336082-283091-3-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261751>

This patch causes an error on my mac, test 5500 fetch-pack errors on
part 44 - fetch creating new shallow root. It looks for "remote: Total
1" in the fetch output and gets 3 instead.

On Tue, Dec 23, 2014 at 7:01 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In commit fbd4a70 (list-objects: mark more commits as edges in
> mark_edges_uninteresting - 2013-08-16), we marked an increasing number
> of edges uninteresting.  This change, and the subsequent change to make
> this conditional on --objects-edge, are used by --thin to make much
> smaller packs for shallow clones.
>
> Unfortunately, they cause a significant performance regression when
> pushing non-shallow clones with lots of refs (23.322 seconds vs.
> 4.785 seconds with 22400 refs).  Add an option to git rev-list,
> --objects-edge-aggressive, that preserves this more aggressive behavior,
> while leaving --objects-edge to provide more performant behavior.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-rev-list.txt     | 3 ++-
>  Documentation/rev-list-options.txt | 4 ++++
>  list-objects.c                     | 4 ++--
>  revision.c                         | 6 ++++++
>  revision.h                         | 1 +
>  5 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index fd7f8b5..5b11922 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -46,7 +46,8 @@ SYNOPSIS
>              [ \--extended-regexp | -E ]
>              [ \--fixed-strings | -F ]
>              [ \--date=(local|relative|default|iso|iso-strict|rfc|short) ]
> -            [ [\--objects | \--objects-edge] [ \--unpacked ] ]
> +            [ [ \--objects | \--objects-edge | \--objects-edge-aggressive ]
> +              [ \--unpacked ] ]
>              [ \--pretty | \--header ]
>              [ \--bisect ]
>              [ \--bisect-vars ]
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 2277fcb..8cb6f92 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -657,6 +657,10 @@ These options are mostly targeted for packing of Git repositories.
>         objects in deltified form based on objects contained in these
>         excluded commits to reduce network traffic.
>
> +--objects-edge-aggressive::
> +       Similar to `--objects-edge`, but it tries harder to find excluded
> +       commits at the cost of increased time.
> +
>  --unpacked::
>         Only useful with `--objects`; print the object IDs that are not
>         in packs.
> diff --git a/list-objects.c b/list-objects.c
> index 2910bec..2a139b6 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -157,7 +157,7 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
>
>                 if (commit->object.flags & UNINTERESTING) {
>                         mark_tree_uninteresting(commit->tree);
> -                       if (revs->edge_hint && !(commit->object.flags & SHOWN)) {
> +                       if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
>                                 commit->object.flags |= SHOWN;
>                                 show_edge(commit);
>                         }
> @@ -165,7 +165,7 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
>                 }
>                 mark_edge_parents_uninteresting(commit, revs, show_edge);
>         }
> -       if (revs->edge_hint) {
> +       if (revs->edge_hint_aggressive) {
>                 for (i = 0; i < revs->cmdline.nr; i++) {
>                         struct object *obj = revs->cmdline.rev[i].item;
>                         struct commit *commit = (struct commit *)obj;
> diff --git a/revision.c b/revision.c
> index 75dda92..753dd2f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1853,6 +1853,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>                 revs->tree_objects = 1;
>                 revs->blob_objects = 1;
>                 revs->edge_hint = 1;
> +       } else if (!strcmp(arg, "--objects-edge-aggressive")) {
> +               revs->tag_objects = 1;
> +               revs->tree_objects = 1;
> +               revs->blob_objects = 1;
> +               revs->edge_hint = 1;
> +               revs->edge_hint_aggressive = 1;
>         } else if (!strcmp(arg, "--verify-objects")) {
>                 revs->tag_objects = 1;
>                 revs->tree_objects = 1;
> diff --git a/revision.h b/revision.h
> index 9cb5adc..033a244 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -93,6 +93,7 @@ struct rev_info {
>                         blob_objects:1,
>                         verify_objects:1,
>                         edge_hint:1,
> +                       edge_hint_aggressive:1,
>                         limited:1,
>                         unpacked:1,
>                         boundary:2,
> --
> 2.2.1.209.g41e5f3a
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
