Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1CD1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 06:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfFGGVW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 02:21:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45190 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfFGGVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 02:21:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so858490wre.12
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 23:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zwwrVtD57UKtTwEHfZwBqv9XndO8LuWYb3rt0VF0xU=;
        b=Zg+fktE3mNbUYX4OsQuPILShEv3d3Ggd6lhXzyMxOQq0kcxcQiQP9udmp/Soul8JNp
         lucwfWZKyFGATzWuxQWTC0R5n5CXLOEBHzfmgNjU35LlUcFu7iG8tSO2o0tN0YT1JP9e
         7LL4qfqDcgEBejRgUXx9N/VGGmyZJbOWncRE0z8vRbvlZvma74tpyv6fjwaGJOxctOql
         h+clQ9e37H8DacQgSF1UJay6MaIay5QXZQBD/hEggk9H4i0ZLakXBJhrYcvTzKLPUAdf
         dBA4M4/Y2Knlgh/cdL5PvxlV3MgAzMz53kkGQ2rhYrE2gPubdoXIetgHHgASPzpePWXn
         84Iw==
X-Gm-Message-State: APjAAAXkcCJEb3tUNxKedvyqJja/YnD8N0rbM7ykfj20fC/3THQHCQuZ
        /lHwnXdWm7wMIzokzM8laPciFMuSE90ELpo4K4w=
X-Google-Smtp-Source: APXvYqzcX06/S1FYxnsjgx05BVfcedIrZBPAR2jUTVjYbpFaBNeo40KtLljg4Tq0Ksvk4/q2q/x2ZoI/0TXjRnwrVtw=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr30354211wra.278.1559888479547;
 Thu, 06 Jun 2019 23:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com>
In-Reply-To: <20190607010708.46654-1-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Jun 2019 02:21:07 -0400
Message-ID: <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com>
Subject: Re: [PATCH] documentation: add tutorial for revision walking
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 6, 2019 at 9:08 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> [...]
> The tutorial covers a basic overview of the structs involved during
> revision walk, setting up a basic commit walk, setting up a basic
> all-object walk, and adding some configuration changes to both walk
> types. It intentionally does not cover how to create new commands or
> search for options from the command line or gitconfigs.
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> @@ -12,6 +12,7 @@ cmds-*.txt
>  SubmittingPatches.txt
> +MyFirstRevWalk.txt

The new file itself is named Documentation/MyFirstRevWalk.txt, so why
add it to .gitignore?

> diff --git a/Documentation/MyFirstRevWalk.txt b/Documentation/MyFirstRevWalk.txt
> @@ -0,0 +1,826 @@
> +== What's a Revision Walk?
> +
> +The revision walk is a key concept in Git - this is the process that underpins
> +operations like `git log`, `git blame`, and `git reflog`. Beginning at HEAD, the
> +list of objects is found by walking parent relationships between objects. The
> +revision walk can also be usedto determine whether or not a given object is

s/usedto/used to/

> +reachable from the current HEAD pointer.
> +
> +We'll put our fiddling into a new command. For fun, let's name it `git walken`.
> +Open up a new file `builtin/walken.c` and set up the command handler:
> +
> +----
> +/*
> + * "git walken"
> + *
> + * Part of the "My First Revision Walk" tutorial.
> + */
> +
> +#include <stdio.h>
> +#include "builtin.h"

Git source files must always include cache.h or git-compat-util.h (or,
for builtins, builtin.h) as the very first header since those headers
take care of differences which might crop up as problems with system
headers on various platforms. System headers are included after Git
headers. So, stdio.h should be included after builtin.h. In this case,
however, stdio.h will get pulled in by git-compat-util.h anyhow, so
you need not include it here.

> +Add usage text and `-h` handling, in order to pass the test suite:
> +
> +----
> +static const char * const walken_usage[] = {
> +       N_("git walken"),
> +       NULL,
> +}

Unless you plan on referencing this from functions other than
cmd_walken(), it need not be global.

> +int cmd_walken(int argc, const char **argv, const char *prefix)
> +{
> +       struct option options[] = {
> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
> +
> +       ...

Perhaps comment out the "..." or remove it altogether to avoid having
the compiler barf when the below instructions tell the reader to build
the command.

> +}
> +
> +Also add the relevant line in builtin.h near `cmd_whatchanged()`:

s/builtin.h/`&`/

> +Build and test out your command, without forgetting to ensure the `DEVELOPER`
> +flag is set:
> +
> +----
> +echo DEVELOPER=1 >config.mak

This will blast existing content of 'config.mak' which could be
dangerous. It might be better to suggest >> instead.

> +`name` is the SHA-1 of the object - a 40-digit hex string you may be familiar
> +with from using Git to organize your source in the past. Check the tutorial
> +mentioned above towards the top for a discussion of where the SHA-1 can come
> +from.

With all the recent work to move away from SHA-1 and to support other
hash functions, perhaps just call this "object ID" rather than SHA-1,
and drop mention of it being exactly 40 digits. Instead, perhaps say
something like "...is the hexadecimal representation of the object
ID...".

> +== Basic Commit Walk
> +
> +First, let's see if we can replicate the output of `git log --oneline`. We'll
> +refer back to the implementation frequently to discover norms when performing
> +a revision walk of our own.
> +
> +We'll need all the commits, in order, which preceded our current commit. We will
> +also need to know the name and subject.

This paragraph confused me. I read it as these being prerequisites I
would somehow have to provide in order to write the code. Perhaps it
can be rephrased to state that this is what the code will be doing.
Maybe: "To do this, we will find all the commits, in order, which
precede the current commit, and extract from them the name and subject
[of the commit message]" or something.

> +=== Setting Up
> +
> +Preparing for your revision walk has some distinct stages.
> +
> +1. Perform default setup for this mode, and others which may be invoked.
> +2. Check configuration files for relevant settings.
> +3. Set up the rev_info struct.
> +4. Tweak the initialized rev_info to suit the current walk.
> +5. Prepare the rev_info for the walk.

s/rev_info/`&`/ in the above three lines.

> +==== Default Setups
> +
> +Before you begin to examine user configuration for your revision walk, it's
> +common practice for you to initialize to default any switches that your command
> +may have, as well as ask any other components you may invoke to initialize as
> +well. `git log` does this in `init_log_defaults()`; in that case, one global
> +`decoration_style` is initialized, as well as the grep and diff-UI components.
> +
> +For our purposes, within `git walken`, for the first example we do we don't

"we do we don't"?

> +intend to invoke anything, and we don't have any configuration to do. However,

"invoke anything" is pretty nebulous, as is the earlier "components
you may invoke". A newcomer is unlikely to know what this means, so
perhaps it needs an example (even if just a short parenthetical
comment).

> +we may want to add some later, so for now, we can add an empty placeholder.
> +Create a new function in `builtin/walken.c`:
> +
> +----
> +static void init_walken_defaults(void)
> +{
> +       /* We don't actually need the same components `git log` does; leave this
> +        * empty for now.
> +        */
> +}

/*
 * Git multi-line comments
 * are formatted like this.
 */

> +Add a new function to `builtin/walken.c`:
> +
> +----
> +static int git_walken_config(const char *var, const char *value, void *cb)
> +{
> +       /* For now, let's not bother with anything. */
> +       return git_default_config(var, value, cb);
> +}

Comment is somewhat confusing. Perhaps say instead "We don't currently
have custom configuration, so fall back to git_default_config()" or
something.

> +==== Setting Up `rev_info`
> +
> +Now that we've gathered external configuration and options, it's time to
> +initialize the `rev_info` object which we will use to perform the walk. This is
> +typically done by calling `repo_init_revisions()` with the repository you intend
> +to target, as well as the prefix and your `rev_info` struct.

Maybe: s/the prefix/the `&` argument of `cmd_walken`/

> +Add the `struct rev_info` and the `repo_init_revisions()` call:
> +----
> +int cmd_walken(int argc, const char **argv, const char *prefix)
> +{
> +       /* This can go wherever you like in your declarations.*/
> +       struct rev_info rev;
> +       ...

A less verbose way to indicate the same without using a /* comment */:

    ...
    struct rev_info rev;
    ...

> +       /* This should go after the git_config() call. */
> +       repo_init_revisions(the_repository, &rev, prefix);
> +}
> +----
> +static void final_rev_info_setup(struct rev_info *rev)
> +{
> +       /* We want to mimick the appearance of `git log --oneline`, so let's
> +        * force oneline format. */

s/mimick/mimic/

/*
 * Multi-line
 * comment.
 */

> +==== Preparing `rev_info` For the Walk
> +
> +Now that `rev` is all initialized and configured, we've got one more setup step
> +before we get rolling. We can do this in a helper, which will both prepare the
> +`rev_info` for the walk, and perform the walk itself. Let's start the helper
> +with the call to `prepare_revision_walk()`.
> +
> +----
> +static int walken_commit_walk(struct rev_info *rev)
> +{
> +       /* prepare_revision_walk() gets the final steps ready for a revision
> +        * walk. We check the return value for errors. */

Not at all sure what this comment is trying to say. Also, the second
sentence adds no value to what the code itself already says clearly by
actually checking the return value.

> +       if (prepare_revision_walk(rev))
> +               die(_("revision walk setup failed"));
> +}
> +==== Performing the Walk!
> +
> +Finally! We are ready to begin the walk itself. Now we can see that `rev_info`
> +can also be used as an iterator; we move to the next item in the walk by using
> +`get_revision()` repeatedly. Add the listed variable declarations at the top and
> +the walk loop below the `prepare_revision_walk()` call within your
> +`walken_commit_walk()`:
> +
> +----
> +static int walken_commit_walk(struct rev_info *rev)
> +{
> +       struct commit *commit;
> +       struct strbuf prettybuf;
> +       strbuf_init(&prettybuf, 0);

More idiomatic:

    struct strbuf prettybuf = STRBUF_INIT;

> +       while ((commit = get_revision(rev)) != NULL) {
> +               if (commit == NULL)
> +                       continue;

Idiomatic Git code doesn't mention NULL explicitly in conditionals, so:

    while ((commit = get_revision(rev))) {
        if (!commit)
            continue;

> +               strbuf_reset(&prettybuf);
> +               pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);

Earlier, you talked about calling get_commit_format("oneline",...) to
get "oneline" output, so what is the purpose of CMIT_FMT_ONELINE here?
The text should explain more clearly what these two different
"online"-related bits mean.

> +               printf(_("%s\n"), prettybuf.buf);

There is nothing here to localize, so drop _(...):

    printf("%s\n", prettybuf.buf);

or perhaps just:

    puts(prettybuf.buf);

> +       }
> +
> +       return 0;
> +}

What does the return value signify?

> +=== Adding a Filter
> +
> +Next, we can modify the `grep_filter`. This is done with convenience functions
> +found in `grep.h`. For fun, we're filtering to only commits from folks using a
> +gmail.com email address - a not-very-precise guess at who may be working on Git

Perhaps? s/gmail.com/`&`/

> +=== Changing the Order
> +
> +Let's see what happens when we run with `REV_SORT_BY_COMMIT_DATE` as opposed to
> +`REV_SORT_BY_AUTHOR_DATE`. Add the following:
> +
> +static void final_rev_info_setup(int argc, const char **argv,
> +                const char *prefix, struct rev_info *rev)
> +{
> +       ...
> +
> +       rev->topo_order = 1;
> +       rev->sort_order = REV_SORT_BY_COMMIT_DATE;

The assignment to rev->sort_order is obvious enough, but the
rev->topo_order assignment is quite mysterious to someone coming to
this tutorial to learn about revision walking, thus some commentary
explaining 'topo_order' would be a good idea.

> +Finally, compare the two. This is a little less helpful without object names or
> +dates, but hopefully we get the idea.
> +
> +----
> +$ diff -u commit-date.txt author-date.txt
> +----
> +
> +This display is an indicator for the latency between publishing a commit for
> +review the first time, and getting it actually merged into master.

Perhaps: s/master/`&`/

Even as a long-time contributor to the project, I had to pause over
this statement for several seconds before figuring out what it was
talking about. Without a long-winded explanation of how topics
progress from submission through 'pu' through 'next' through 'master'
and finally into a release, the above statement is likely to be
mystifying to a newcomer. Perhaps it should be dropped.

> +Let's try one more reordering of commits. `rev_info` exposes a `reverse` flag.
> +However, it needs to be applied after `add_head_to_pending()` is called. Find

This leaves the reader hanging, wondering why 'reverse' needs to be
assigned after add_head_to_pending().

> +== Basic Object Walk
> +
> +static void walken_show_commit(struct commit *cmt, void *buf)
> +{
> +        commit_count++;
> +}
> +----
> +
> +Since we have the `struct commit` object, we can look at all the same parts that
> +we looked at in our earlier commit-only walk. For the sake of this tutorial,
> +though, we'll just increment the commit counter and move on.

This leaves the reader wondering what 'buf' is and what it's used for.
Presumably this is the 'show_data' context mentioned earlier? If so,
perhaps name this 'ctxt' or 'context' or something and, because this
is a tutorial trying to teach revision walking, say a quick word about
how it might be used.

> +static void walken_show_object(struct object *obj, const char *str, void *buf)
> +{
> +        switch (obj->type) {
> +        [...]
> +        case OBJ_COMMIT:
> +                printf(_("Unexpectedly encountered a commit in "
> +                         "walken_show_object!\n"));
> +                commit_count++;
> +                break;
> +        default:
> +                printf(_("Unexpected object type %s!\n"),
> +                       type_name(obj->type));
> +                break;
> +        }
> +}

Modern practice in this project is to start error messages with
lowercase and to not punctuate the end (no need for "!").

Also, same complaint about the mysterious 'str' argument to the
callback as for 'buf' mentioned above.

> +To help assure us that we aren't double-counting commits, we'll include some
> +complaining if a commit object is routed through our non-commit callback; we'll
> +also complain if we see an invalid object type.

 Are these two error cases "impossible" conditions or can they
actually arise in practice? If the former, use die() instead and drop
use of _(...) so as to avoid confusing the reader into thinking that
the behavior is indeterminate.

> +Our main object walk implementation is substantially different from our commit
> +walk implementation, so let's make a new function to perform the object walk. We
> +can perform setup which is applicable to all objects here, too, to keep separate
> +from setup which is applicable to commit-only walks.
> +
> +----
> +static int walken_object_walk(struct rev_info *rev)
> +{
> +}
> +----

This skeleton function definition is populated immediately below, so
it's not clear why it needs to be shown here.

> +We'll start by enabling all types of objects in the `struct rev_info`, and
> +asking to have our trees and blobs shown in commit order. We'll also exclude
> +promisors as the walk becomes more complicated with those types of objects. When
> +our settings are ready, we'll perform the normal revision walk setup and
> +initialize our tracking variables.
> +
> +----
> +static int walken_object_walk(struct rev_info *rev)
> +{
> +        rev->tree_objects = 1;
> +        rev->blob_objects = 1;
> +        rev->tag_objects = 1;
> +        rev->tree_blobs_in_commit_order = 1;
> +        rev->exclude_promisor_objects = 1;
> +        [...]
> +----
> +
> +Unless you cloned or fetched your repository earlier with a filter,
> +`exclude_promisor_objects` is unlikely to make a difference, but we'll turn it
> +on just to make sure our lives are simple.  We'll also turn on
> +`tree_blobs_in_commit_order`, which means that we will walk a commit's tree and
> +everything it points to immediately after we find each commit, as opposed to
> +waiting for the end and walking through all trees after the commit history has
> +been discovered.

This paragraph is repeating much of the information in the paragraph
just above the code snippet. One or the other should be dropped or
thinned to avoid the duplication.

> +Let's start by calling just the unfiltered walk and reporting our counts.
> +Complete your implementation of `walken_object_walk()`:
> +
> +----
> +       traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
> +
> +       printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
> +                "and %d trees.\n"), commit_count, blob_count, tag_count,
> +              tree_count);

Or make the output more useful by having it be machine-parseable (and
not localized):

    printf("commits %d\nblobs %d\ntags %d\ntrees %d\n",
        commit_count, blob_count, tag_cont, tree_count);

> +       return 0;
> +}

What does the return value signify?

> +Now we can try to run our command! It should take noticeably longer than the
> +commit walk, but an examination of the output will give you an idea why - for
> +example:
> +
> +----
> +Object walk completed. Found 55733 commits, 100274 blobs, 0 tags, and 104210 trees.
> +----
> +
> +This makes sense. We have more trees than commits because the Git project has
> +lots of subdirectories which can change, plus at least one tree per commit. We
> +have no tags because we started on a commit (`HEAD`) and while tags can point to
> +commits, commits can't point to tags.
> +
> +NOTE: You will have different counts when you run this yourself! The number of
> +objects grows along with the Git project.

Not sure if this NOTE is useful; after all, you introduced the output
by saying "for example".

> +=== Adding a Filter
> +
> +There are a handful of filters that we can apply to the object walk laid out in
> +`Documentation/rev-list-options.txt`. These filters are typically useful for
> +operations such as creating packfiles or performing a partial or shallow clone.
> +They are defined in `list-objects-filter-options.h`. For the purposes of this
> +tutorial we will use the "tree:1" filter, which causes the walk to omit all
> +trees and blobs which are not directly referenced by commits reachable from the
> +commit in `pending` when the walk begins. (In our case, that means we omit trees
> +and blobs not directly referenced by HEAD or HEAD's history.)

Need some explanation of what 'pending' is, as it's just mysterious as written.

> +First, we'll need to `#include "list-objects-filter-options.h`". Then, we can
> +set up the `struct list_objects_filter_options` and `struct oidset` at the top
> +of `walken_object_walk()`:
> +
> +----
> +static int walken_object_walk(struct rev_info *rev)
> +{
> +        struct list_objects_filter_options filter_options = {};
> +        struct oidset omitted;
> +        oidset_init(&omitted, 0);
> +       ...

This 'omitted' is so far removed from the description of the 'omitted'
argument to traverse_commit_list_filtered() way earlier in the
tutorial that a reader is likely to have forgotten what it's about
(indeed, I did). Some explanation, even if superficial, is likely
warranted here or at least mention that it is explained in more detail
below (as I discovered).

> +After we run `traverse_commit_list_filtered()` we would also be able to examine
> +`omitted`, which is a linked-list of all objects we did not include in our walk.
> +Since all omitted objects are included, the performance of
> +`traverse_commit_list_filtered()` with a non-null `omitted` arument is equitable

s/arument/argument/

> +with the performance of `traverse_commit_list()`; so for our purposes, we leave
> +it null. It's easy to provide one and iterate over it, though - check `oidset.h`
> +for the declaration of the accessor methods for `oidset`.

I'm confused. What are we leaving NULL here?

> +=== Changing the Order
> +
> +Finally, let's demonstrate that you can also reorder walks of all objects, not
> +just walks of commits. First, we'll make our handlers chattier - modify
> +`walken_show_commit()` and `walken_show_object` to print the object as they go:

s/walken_show_object/&()/

> +static void walken_show_commit(struct commit *cmt, void *buf)
> +{
> +        printf(_("commit: %s\n"), oid_to_hex(&cmt->object.oid));
> +        commit_count++;
> +}

Is there a bunch of trailing whitespace on these lines of the code
sample (and in some lines below)?

> +static void walken_show_object(struct object *obj, const char *str, void *buf)
> +{
> +        printf(_("%s: %s\n"), type_name(obj->type), oid_to_hex(&obj->oid));

Localizing "%s: %s\n" via _(...) probably doesn't add value, which
implies that you might not want to be localizing "commit" above
either.

> +(Try to leave the counter increment logic in place in `walken_show_object()`.)
> +
> +With only that change, run again (but save yourself some scrollback):
> +
> +----
> +$ ./bin-wrappers/git walken | head -n 10
> +----
> +
> +Take a look at the top commit with `git show` and the OID you printed; it should
> +be the same as the output of `git show HEAD`.

I think this is the first use of "OID", which might be mysterious and
confusing to a newcomer. Earlier, you used SHA-1 and I suggested
"object ID" instead. Perhaps use the same here, or define OID earlier
in the document in place of SHA-1.

> +Next, let's change a setting on our `struct rev_info` within
> +`walken_object_walk()`. Find where you're changing the other settings on `rev`,
> +such as `rev->tree_objects` and `rev->tree_blobs_in_commit_order`, and add
> +another setting at the bottom:

Instead of nebulous "another setting", mentioning 'reverse' explicitly
would make this clearer.

> +        rev->tree_objects = 1;
> +        rev->blob_objects = 1;
> +        rev->tag_objects = 1;
> +        rev->tree_blobs_in_commit_order = 1;
> +        rev->exclude_promisor_objects = 1;
> +        rev->reverse = 1;
