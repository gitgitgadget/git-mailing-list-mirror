From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] describe: rewrite name_rev() iteratively
Date: Tue, 8 Apr 2014 03:41:17 -0400
Message-ID: <CAPig+cR+gVSU+kthiZc3pwEjBDfeu_Do0NTD3Cw=xPtMUDY8Kw@mail.gmail.com>
References: <1396824434-31672-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Sylvestre Ledru <sylvestre@mozilla.com>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 09:44:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXQhM-0002HP-R9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 09:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382AbaDHHnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 03:43:55 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36519 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaDHHnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 03:43:52 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so478477ykt.18
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=41eCLXponNbkt2V9oK0Z/cPgw3w826uqCeH8GQTRYrc=;
        b=uWcGHLKNed5eEZBU9hVkulYNfcfyIz4gtjIWejaCUrjCXnF0qsnZJs3TcsojfwY8H9
         EohiO6SQDM+z7EMroxEI62GmS28yzRxJRc0/SLCdVHJ1URI355hA2HWspoMOq81nfQvX
         Ja0BTP6JewPxZi3cyJ4RFwyYyVBJdwZHlE8sHHLjkc99vR9IiN3WI+oP89gpOVH64v3B
         Um3tQpcWTEqc1LQEbDoQxgegG4VNl4WpQQzRr0RYi2ZRKEBhTIjzHKtTOz1n/Ur0XHG0
         DZ6GRGZR74UiL3YODN6wNUd9BrpDMDnWOwk4EdrjOPRBCg8yXXaQA6AcBAHa84tJvEkM
         tBYA==
X-Received: by 10.236.86.226 with SMTP id w62mr3266026yhe.94.1396942877672;
 Tue, 08 Apr 2014 00:41:17 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 8 Apr 2014 00:41:17 -0700 (PDT)
In-Reply-To: <1396824434-31672-1-git-send-email-dragos.foianu@gmail.com>
X-Google-Sender-Auth: gFFBGXVRd4WHxlxkaOek_FCNxqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245918>

[cc: Sylvestre Ledru <sylvestre@mozilla.com>]

On Sun, Apr 6, 2014 at 6:47 PM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
> The "git describe --contains" command uses the name_rev() function which
> is currently a recursive function. This causes a Stack Overflow when the
> history is large enough.

No need to capitalize "stack overflow".

It might be helpful if you provide a link to the original problem
report by Sylvestre [1] for context.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244430

> Rewrite name_rev iteratively using a stack on the heap. This slightly
> reduces performance due to the extra operations on the heap, but the
> function no longer overflows the stack.
>
> Reported-by: Sylvestre Ledru <sylvestre@mozilla.com>

It's a good idea to cc: the original reporter of the problem so that
he can test the fix. (And, generally speaking, it's good etiquette to
cc: people who commented on the issue.)

> Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
> ---
>  builtin/name-rev.c |  176 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 128 insertions(+), 48 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c824d4e..5848d81 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -19,66 +19,146 @@ static long cutoff = LONG_MAX;
>  /* How many generations are maximally preferred over _one_ merge traversal? */
>  #define MERGE_TRAVERSAL_WEIGHT 65535
>
> +typedef struct rev_data {

On this project, "typedef struct" is almost universally avoided. Just
say "struct rev_data" when needed.

> +       struct commit *commit;
> +       const char *tip_name;
> +       int generation;
> +       int distance;
> +       int deref;

'deref' may be true only for the initial call to name_rev(); all
recursive invocations unconditionally pass false, so including it in
the structure is superfluous and potentially confusing for readers.

More below.

> +} *rev_data;
> +
> +typedef struct rev_stack {
> +       struct rev_data *rev;
> +       struct rev_stack *next;
> +} *rev_stack;
> +
> +static void stack_push(rev_stack *stack, rev_data data) {
> +       rev_stack new_node = xmalloc(sizeof(*new_node));
> +
> +       new_node->rev = data;
> +       new_node->next = *stack;
> +       *stack = new_node;
> +}
> +
> +static void stack_push_end(rev_stack *stack, rev_data data) {
> +       rev_stack new_node = xmalloc(sizeof(*new_node));
> +
> +       while (*stack != NULL)
> +               stack = &(*stack)->next;
> +       new_node->rev = data;
> +       new_node->next = *stack;
> +       *stack = new_node;
> +}
> +
> +static rev_data stack_pop(rev_stack *stack) {
> +       rev_stack next = (*stack)->next;
> +       rev_data rev = (*stack)->rev;
> +       free(*stack);
> +
> +       *stack = next;
> +       return rev;
> +}
> +
> +static rev_data make_rev_data(struct commit *commit,
> +               const char* tip_name, int generation, int distance,
> +               int deref)
> +{
> +       rev_data data = xmalloc(sizeof(*data));
> +
> +       data->commit = commit;
> +       data->tip_name = tip_name;
> +       data->generation = generation;
> +       data->distance = distance;
> +       data->deref = deref;
> +
> +       return data;
> +}
> +
>  static void name_rev(struct commit *commit,
>                 const char *tip_name, int generation, int distance,
>                 int deref)
>  {
> -       struct rev_name *name = (struct rev_name *)commit->util;
> -       struct commit_list *parents;
> -       int parent_number = 1;
> +       rev_stack stack = NULL;
> +       rev_data data, next_rev;
>
> -       parse_commit(commit);
> +       data = make_rev_data(commit, tip_name, generation, distance, deref);
> +       stack_push(&stack, data);
>
> -       if (commit->date < cutoff)
> -               return;
> +       while (stack != NULL) {
> +               rev_data rev = stack_pop(&stack);
>
> -       if (deref) {
> -               char *new_name = xmalloc(strlen(tip_name)+3);
> -               strcpy(new_name, tip_name);
> -               strcat(new_name, "^0");
> -               tip_name = new_name;
> +               struct rev_name *name = (struct rev_name *) rev->commit->util;
> +               struct commit_list *parents;
> +               int parent_number = 1;
>
> -               if (generation)
> -                       die("generation: %d, but deref?", generation);
> -       }
> +               parse_commit(rev->commit);
> +
> +               if (rev->commit->date < cutoff)
> +                       continue;
> +
> +               if (rev->deref) {
> +                       char *new_name = xmalloc(strlen(rev->tip_name) + 3);
> +                       strcpy(new_name, rev->tip_name);
> +                       strcat(new_name, "^0");
> +                       rev->tip_name = new_name;

As mentioned above, 'deref' may be true only upon the first call;
recursive invocations always set it to false, so the entire 'if
(deref)' conditional can be promoted out of your 'while (stack !=
NULL)' loop.

(In fact, this deref processing could be promoted out of this function
altogether since its only ever done for the first commit visited, but
such a change is likely fodder for a separate cleanup patch.)

More below.

> -       if (name == NULL) {
> -               name = xmalloc(sizeof(rev_name));
> -               commit->util = name;
> -               goto copy_data;
> -       } else if (name->distance > distance) {
> +                       if (rev->generation)
> +                               die("generation: %d, but deref?",
> +                                       rev->generation);
> +               }
> +
> +               if (name == NULL) {
> +                       name = xmalloc(sizeof(rev_name));
> +                       rev->commit->util = name;
> +                       goto copy_data;
> +               } else if (name->distance > rev->distance) {
>  copy_data:
> -               name->tip_name = tip_name;
> -               name->generation = generation;
> -               name->distance = distance;
> -       } else
> -               return;
> -
> -       for (parents = commit->parents;
> -                       parents;
> -                       parents = parents->next, parent_number++) {
> -               if (parent_number > 1) {
> -                       int len = strlen(tip_name);
> -                       char *new_name = xmalloc(len +
> -                               1 + decimal_length(generation) +  /* ~<n> */
> -                               1 + 2 +                           /* ^NN */
> -                               1);
> -
> -                       if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
> -                               len -= 2;
> -                       if (generation > 0)
> -                               sprintf(new_name, "%.*s~%d^%d", len, tip_name,
> -                                               generation, parent_number);
> -                       else
> -                               sprintf(new_name, "%.*s^%d", len, tip_name,
> -                                               parent_number);
> +                       name->tip_name = rev->tip_name;
> +                       name->generation = rev->generation;
> +                       name->distance = rev->distance;
> +               } else
> +                       continue;
>
> -                       name_rev(parents->item, new_name, 0,
> -                               distance + MERGE_TRAVERSAL_WEIGHT, 0);
> -               } else {
> -                       name_rev(parents->item, tip_name, generation + 1,
> -                               distance + 1, 0);
> +               for (parents = rev->commit->parents;
> +                               parents;
> +                               parents = parents->next, parent_number++) {
> +                       if (parent_number > 1) {
> +                               int len = strlen(rev->tip_name);
> +                               char *new_name = xmalloc(len +
> +                                       /* ~<n> */
> +                                       1 + decimal_length(rev->generation) +
> +                                       /* ^NN */
> +                                       1 + 2 +
> +                                       1);
> +
> +                               if (len > 2 &&
> +                                       !strcmp(rev->tip_name + len - 2, "^0"))
> +                                       len -= 2;
> +
> +                               if (rev->generation > 0)
> +                                       sprintf(new_name, "%.*s~%d^%d", len,
> +                                               rev->tip_name, rev->generation,
> +                                               parent_number);
> +                               else
> +                                       sprintf(new_name, "%.*s^%d", len,
> +                                               rev->tip_name, parent_number);
> +
> +                               next_rev = make_rev_data(parents->item,
> +                                       new_name, 0,
> +                                       rev->distance + MERGE_TRAVERSAL_WEIGHT,
> +                                       0);
> +
> +                               stack_push_end(&stack, next_rev);
> +                       } else {
> +                               next_rev = make_rev_data(parents->item,
> +                                       rev->tip_name, rev->generation + 1,
> +                                       rev->distance + 1, 0);
> +
> +                               stack_push(&stack, next_rev);
> +                       }

This logic changes the order in which the commits are visited. Given a
history, such as:

    --D--B---A
    --E-/   /
    --F--C-/
    --G-/

where A's parents are (B,C), B's parents are (D,E), and C's parents
are (F,G), the original code traverses commits in this order:

    A B D E C F G

but, with your patch, they are traversed in this order:

    A B D C F E G

>                 }
> +
> +               free(rev);
>         }
>  }
>
> --
> 1.7.10.4
