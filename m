From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()
Date: Thu, 20 Mar 2014 23:33:59 -0400
Message-ID: <CAPig+cTr9euE8=kMjVxRjvWPPVRQsF3i7TOevVPU+akSvCyJYg@mail.gmail.com>
References: <1395366886-16839-1-git-send-email-ajha.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ashwin Jha <ajha.dev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 04:34:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQqDe-0003pZ-O3
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 04:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbaCUDeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 23:34:00 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:60554 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146AbaCUDeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 23:34:00 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so1843346yha.17
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 20:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=788CTRKtTVvP12nQv745GBl5H5La65Rr8c5TS4jdSOE=;
        b=yWS5DfAIgdAVQ2Nbo3TgL59PPAwGrjljlRTll9R1xSBwtopxSy2DYZ4MOO2596Vqpp
         kRJkq9OwKDgyv9DY61r7pb0FN/7ob5AoK7iEpxECsl4BOC0Y5hAQ/oan0L9gKSzizre+
         8ZOeEXyv2W8r504F+W2hyBlvObyFg+oTxx3GppuM/QN8u39+z6uWvhm8EGxMy/S9bcKL
         bvQEx/pPrti06g11af04XKtX6h4cuyouoGTlJjKAaPLfZdDQ0HnES9cN7ll1JHdxzu2D
         M8Tlt8KdgnvcsyMIQOt9Qzj1GzVThAz3h6CMVUeN2g6F+D0b6qQyoRk7RDiJn51SViFG
         ZCxw==
X-Received: by 10.236.86.113 with SMTP id v77mr238510yhe.125.1395372839571;
 Thu, 20 Mar 2014 20:33:59 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 20:33:59 -0700 (PDT)
In-Reply-To: <1395366886-16839-1-git-send-email-ajha.dev@gmail.com>
X-Google-Sender-Auth: 9NFD_cZ1y92PV1Bhr92A8iW5qPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244631>

Thanks for the submission. Comments below to give you a feel for the
Git review process...

On Thu, Mar 20, 2014 at 9:54 PM, Ashwin Jha <ajha.dev@gmail.com> wrote:
> Subject: [PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()

The subject becomes part of the permanent Git history, but the fact
that this is a GSoC submission won't be meaningful to anyone months or
years from now. You can mention GSoC inside [...], however, as in
[PATCH GSoC], since that gets stripped off the subject automatically
when the patch is applied. Use the commentary section after the "---"
line just below your sign-off to explain that this is microproject 15.

The subject itself should concisely summarize the change. "Rewrite
fsck.c:fsck_commit()" doesn't say much. You might say instead:

    Subject: fsk_commit: replace memcmp() with starts_with()

> modified fsck.c:fsck_commit(). Replaced memcmp() with starts_with() function.

Capitalize start of sentence.

Use imperative mood: "modify" rather than "modified"; "Replace" rather
than "Replaced".

> starts_with() seems much more relevant than memcmp(). It uses one less argument
> and its return value makes more sense.

As a justification, "uses one less argument" falls flat, and really
has nothing to do with the decision to make the change. The bit about
the return value is a slightly better but is still weak. You might
instead justify the change by pointing out that the name starts_with()
does a better job of conveying the intention of the code, which is to
check the string for a prefix, than does memcmp().

> skip_prefix() is not used as it uses strcmp() internally which seems unnecessarily
> for current task. The current task can be easily done by providing offsets to the
> buffer pointer (the way it is implemented currently).

Not sure what this means. What is the "current task", and what is
implemented where currently?

> Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
> ---
>  fsck.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 64bf279..82e1640 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -6,6 +6,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "fsck.h"
> +#include "strbuf.h"
>
>  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>  {
> @@ -290,12 +291,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>         int parents = 0;
>         int err;
>
> -       if (memcmp(buffer, "tree ", 5))
> +       if (!starts_with(buffer, "tree "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>         if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')

One of the benefits of starts_with() and skip_prefix() is that they
allow you to eliminate magic numbers, such as 5 in the memcmp()
invocation. However, if you look a couple lines below, you see in the
expression 'buffer+5' that the magic number is still present. In fact,
the code becomes less clear with your change because the 5 in
'buffer+5' is much more mysterious without the preceding
memcmp(foo,"bar",5). It is possible to eliminate this magic number,
but starts_with() is not the answer.

>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
>         buffer += 46;
> -       while (!memcmp(buffer, "parent ", 7)) {
> +       while (starts_with(buffer, "parent ")) {
>                 if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')

Ditto here with magic number 7 in 'buffer+7'.

>                         return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
>                 buffer += 48;
> @@ -322,15 +323,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>                 if (p || parents)
>                         return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>         }
> -       if (memcmp(buffer, "author ", 7))
> +       if (!starts_with(buffer, "author "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
>         buffer += 7;

And again with 7.

>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> -       if (memcmp(buffer, "committer ", strlen("committer ")))
> +       if (!starts_with(buffer, "committer "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -       buffer += strlen("committer ");
> +       buffer += 10;

Again with 10 (newly introduced).

>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> --
> 1.7.9.5
