From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Modify fsck_commit. Replace memcmp by skip_prefix
Date: Sun, 23 Mar 2014 04:40:17 -0400
Message-ID: <CAPig+cRL3zFWtBq_yJQqwGa7Wc6GsdBqA_jrGm8p5ZMJVmr-yw@mail.gmail.com>
References: <1395501132-12894-1-git-send-email-ajha.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ashwin Jha <ajha.dev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 09:40:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRdxO-0000i6-FV
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 09:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbaCWIkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 04:40:25 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:62615 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaCWIkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 04:40:18 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so11310090ykp.1
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3f6QfwVMDca2BBTCBmGzLX7lyZInFZFqebjzeoA0E5w=;
        b=Or4s7TRndUoq0Z6tqJLEMu/zUDIEI+Lira+Hcc9qFlTTqFq7YDi89VloGL1QlNCmde
         79tZWJeJrhjqS40+GQfApbeXZRJl49OnSV+OcZEM2qIK5rVSiihmP+7Fvnps94v4TT59
         UkvFswu/pyhgDK8FZqF9gK22FnPpQmxBHTCvtaXS8mcT12/Fd2jRox8GrFbgtprQtALC
         a9xYuPAHWWRgtkXpQp8GJxCJ9S9+Bjfieie/H8S8pKurhmdKr0r6lvGs4hJjh09a5iTy
         xSFkY/b/Z/WznMht4y5De/FdurJ34oFfY+hnQFWn6JadINt93g0Zl0vNo3BONHvltDr0
         WtqA==
X-Received: by 10.236.20.39 with SMTP id o27mr56398901yho.79.1395564017704;
 Sun, 23 Mar 2014 01:40:17 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 23 Mar 2014 01:40:17 -0700 (PDT)
In-Reply-To: <1395501132-12894-1-git-send-email-ajha.dev@gmail.com>
X-Google-Sender-Auth: rZLa6p-jdJu3eZQ_lETuJLOfT20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244790>

Thanks for the resubmission. Comments below...

On Sat, Mar 22, 2014 at 11:12 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
> Subject: [PATCH] Modify fsck_commit. Replace memcmp by skip_prefix

In his review, Tanay already mentioned indicating a resubmission via
[PATCH vN]. Additionally, specify the module or function being
modified, followed by a colon and space. On this project, it is
customary to forego capitalization in the subject (and only the
subject). So, you might write:

    Subject: [PATCH v2] fsck_commit: replace memcmp() by skip_prefix()

> Replace memcmp by skip_prefix as it serves the dual
> purpose of checking the string for a prefix as well
> as skipping that prefix.

Good.

> Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
> ---

Tanay mentioned this already: Below the "---" line under your sign-off
is where you should, as a courtesy to reviewers, explain what changed
since the previous attempt. Also, provide a link to the previous
version, like this [1].

[1]: http://git.661346.n2.nabble.com/PATCH-GSoC-Miniproject-15-Rewrite-fsck-c-fsck-commit-td7606180.html

>  fsck.c |   25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 64bf279..021b3fc 100644
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
> @@ -284,21 +285,23 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
>
>  static int fsck_commit(struct commit *commit, fsck_error error_func)
>  {
> -       char *buffer = commit->buffer;
> +       char *next_parent, *buffer = commit->buffer;

The name 'next_parent' doesn't seem correct. After invoking
skip_prefix(), this variable will point at the hex representation of
the parent's SHA1, so a better name might be 'parent_id'.

>         unsigned char tree_sha1[20], sha1[20];
>         struct commit_graft *graft;
>         int parents = 0;
>         int err;
>
> -       if (memcmp(buffer, "tree ", 5))
> +       buffer = (char *)skip_prefix(buffer, "tree ");

These casts are ugly. It should be possible to get rid of all of them.
Hint: Does this function modify the memory referenced by 'buffer'?
(The answer is very slightly involved, though not difficult. A proper
fix would involve turning this submission into a 2-patch series: one a
preparatory patch, and the other this patch without the casts.)

> +       if (buffer == NULL)

On this project, it is customary to say !buffer. Ditto for the
remaining instances.

>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
> -       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
> +       if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
> -       buffer += 46;
> -       while (!memcmp(buffer, "parent ", 7)) {
> -               if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
> +       buffer += 41;
> +       while ((next_parent = (char *)skip_prefix(buffer, "parent ")) != NULL) {

Likewise, on this project, it is customary to omit the '!= NULL'.

> +               buffer = next_parent;
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
> +       buffer = (char *)skip_prefix(buffer, "author ");
> +       if (buffer == NULL)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
> -       buffer += 7;
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> -       if (memcmp(buffer, "committer ", strlen("committer ")))
> +       buffer = (char *)skip_prefix(buffer, "committer ");
> +       if (buffer == NULL)
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -       buffer += strlen("committer ");
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;

Other than the minor points mentioned above, the patch looks good. Thanks.

> --
> 1.7.9.5
