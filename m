From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] fsck.c:fsck_commit replace memcmp by skip_prefix
Date: Tue, 25 Mar 2014 03:02:30 -0400
Message-ID: <CAPig+cSBNQcpKE1_va6ZNCWzEg5FEHN0zoDdncPvpk4ECQ4FpA@mail.gmail.com>
References: <1395662959-10660-1-git-send-email-ajha.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ashwin Jha <ajha.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:02:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSLNb-0007Bc-MD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 08:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbaCYHCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 03:02:32 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:57446 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaCYHCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 03:02:31 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so33487yho.29
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=l0VD+BZCM7iQ/7d0SCZZ1GMEv/WSfBL56r3gvHly2vs=;
        b=B+A54VQfpayBvSNOkZFOdYtBCYZUExHaDZQDeLYC8/tD8MeVBhF6O3Quz+O0uyG6zp
         WkSwQEagBMCAR8D2DmPaWP+O8/XMRQIknZm8wIBrqTMI/8MZ4qKkSoKkq+NxHelZGmcR
         mbRN7DkMP5mtZyt2iT2gxVXEeJhqgm9Vu1M4XDS9MPaihFG4z7v83/X1/+7IAqQHhFqy
         ZdruGjQMLl3CFWsXqGcss2+UuGfxKxSmc7SOo/bHXj0hSx+rCix3sX9YqjWnTJzE3lQN
         PNNyhCIB4ajnqYA6yK7v4vqHi1tSaUmSlUvNxcEHyZnrHHcWOO7cOfICOJIwdGHDNbiQ
         PUCw==
X-Received: by 10.236.111.164 with SMTP id w24mr44109749yhg.17.1395730950263;
 Tue, 25 Mar 2014 00:02:30 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 25 Mar 2014 00:02:30 -0700 (PDT)
In-Reply-To: <1395662959-10660-1-git-send-email-ajha.dev@gmail.com>
X-Google-Sender-Auth: 8Uzop0nanyislU0qX4PtLnNfvvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244908>

On Mon, Mar 24, 2014 at 8:09 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
> Replace memcmp by skip_prefix as it serves the dual
> purpose of checking the string for a prefix as well
> as skipping that prefix.
>
> Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
> ---
>
> fsck_commit(): After the first patch in this series, it is now safe to replace
> memcmp() with skip_prefix().

The above commentary might be a bit easer to understand if written
instead something like this:

    Changes since v2:

    New patch 1/2 adds missing 'const's, so this patch no longer
    needs to cast-away the constness of the result of skip_prefix().

The patch itself looks fine.

You probably don't need to resend. My comments on these two patches
can serve as inspiration (or not) for patches you may send in the
future. What's important is that you have had a taste of the Git
review process, and the GSoC mentors have had a chance to observe your
abilities and reviewer interaction skills.

> Previous versions can be found at [v1] and [v2]:
> [v1]: http://git.661346.n2.nabble.com/PATCH-GSoC-Miniproject-15-Rewrite-fsck-c-fsck-commit-td7606180.html
> [v2]: http://git.661346.n2.nabble.com/PATCH-Modify-fsck-commit-Replace-memcmp-by-skip-prefix-td7606321.html
>
>  fsck.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index b5f017f..2232ce3 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -6,6 +6,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "fsck.h"
> +#include "git-compat-util.h"
>
>  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>  {
> @@ -284,21 +285,23 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
>
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -       const char *buffer = commit->buffer;
> +       const char *parent_id, *buffer = commit->buffer;
>         unsigned char tree_sha1[20], sha1[20];
>         struct commit_graft *graft;
>         int parents = 0;
>         int err;
>
> -       if (memcmp(buffer, "tree ", 5))
> +       buffer = skip_prefix(buffer, "tree ");
> +       if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
> -       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
> +       if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
> -       buffer += 46;
> -       while (!memcmp(buffer, "parent ", 7)) {
> -               if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
> +       buffer += 41;
> +       while ((parent_id = skip_prefix(buffer, "parent "))) {
> +               buffer = parent_id;
> +               if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
>                         return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
> -               buffer += 48;
> +               buffer += 41;
>                 parents++;
>         }
>         graft = lookup_commit_graft(commit->object.sha1);
> @@ -322,15 +325,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>                 if (p || parents)
>                         return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>         }
> -       if (memcmp(buffer, "author ", 7))
> +       buffer = skip_prefix(buffer, "author ");
> +       if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
> -       buffer += 7;
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> -       if (memcmp(buffer, "committer ", strlen("committer ")))
> +       buffer = skip_prefix(buffer, "committer ");
> +       if (!buffer)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -       buffer += strlen("committer ");
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> --
> 1.9.1
