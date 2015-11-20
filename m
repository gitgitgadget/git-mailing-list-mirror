From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Thu, 19 Nov 2015 23:38:18 -0500
Message-ID: <CAPig+cTaOTfwzodKSabdy9HFbF66RuEXwmvjZ8QuQVFMaVpA7w@mail.gmail.com>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
	<20151117224809.GE27862@sigill.intra.peff.net>
	<CAPig+cQcmtZJmm_FGMNL4OCTgdFZGyLjVrwbfCCp+0kwBeFuRQ@mail.gmail.com>
	<20151117232237.GA29014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 05:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzdSq-0008MW-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 05:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbbKTEiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 23:38:20 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36859 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934103AbbKTEiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 23:38:19 -0500
Received: by ykdr82 with SMTP id r82so143357350ykd.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 20:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UhZyjDkHyGwrX+N7rEEKK+QTr7LJkfspY5O9+CGBcts=;
        b=k9naw2C7UMMszIW9Ay/TlFNNkerrY/r2873VHSxvjJCmiyu9x+sBNDGxngmOrcyuLI
         Kmuz56KrMU2+O7lVK9SLTpSR43czUsWS9RlyFJbqAmroK3FhrtZCWk+OzYVpVAijcRlt
         M/mVT4GkGVK7uX+S03qb8CKaEWOUfBlL2iD/lhsxWKIVW47oPfrLlhNiyLn7tC7ibKZV
         ZauzQNE2mZfVBPPa0DNYZK63naex06AAbwMFnS6WegLqS3OjbAwJ5pTJg4j9Cki8zzcN
         IXKxW36AZGL1DmrREAcJl+8OO0x6w+1tC72w4P5M5GNNDu+kiUE+6nMpjyZbSy52HFUQ
         h6WQ==
X-Received: by 10.13.234.140 with SMTP id t134mr244513ywe.110.1447994298405;
 Thu, 19 Nov 2015 20:38:18 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Thu, 19 Nov 2015 20:38:18 -0800 (PST)
In-Reply-To: <20151117232237.GA29014@sigill.intra.peff.net>
X-Google-Sender-Auth: FdlQRIsXohk6WctrOeW7cK7GOUo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281497>

On Tue, Nov 17, 2015 at 6:22 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 17, 2015 at 06:01:25PM -0500, Eric Sunshine wrote:
>> On Tue, Nov 17, 2015 at 5:48 PM, Jeff King <peff@peff.net> wrote:
>> > Hmm. Out of curiosity I tried:
>> >
>> >   git blame v2.4.0 -- t/t6031-merge-recursive.sh
>> >
>> > and it segfaults. This bisects to Max's recent 1b0d400 (blame: extract
>> > find_single_final, 2015-10-30), but I do not see anything obviously
>> > wrong with it from a quick glance.
>>
>> In the original code, sb->final received was assigned value of obj,
>> which may have gone through deref_tag(), however, after 1b0d400,
>> sb->final is unconditionally assigned the original value of obj, not
>> the (potentially) deref'd value.
>
> Good eye. I fed it a tag, find_single_final knows that points to a
> commit, then prepare_final casts the tag object to a commit. Whoops.
>
> The patch below fixes it for me. It probably needs a test, but I have to
> run for the moment.

Sorry for the late response. This patch mirrors my thoughts on fixing
the bug, and appears correct. For what it's worth:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> -- >8 --
> Subject: [PATCH] blame: fix object casting regression
>
> Commit 1b0d400 refactored the prepare_final() function so
> that it could be reused in multiple places. Originally, the
> loop had two outputs: a commit to stuff into sb->final, and
> the name of the commit from the rev->pending array.
>
> After the refactor, that loop is put in its own function
> with a single return value: the object_array_entry from the
> rev->pending array. This contains both the name and the object,
> but with one important difference: the object is the
> _original_ object found by the revision parser, not the
> dereferenced commit. If one feeds a tag to "git blame", we
> end up casting the tag object to a "struct commit", which
> causes a segfault.
>
> Instead, let's return the commit (properly casted) directly
> from the function, and take the "name" as an optional
> out-parameter. This does the right thing, and actually
> simplifies the callers, who no longer need to cast or
> dereference the object_array_entry themselves.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/blame.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index ac36738..2184e39 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2403,10 +2403,12 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>         return commit;
>  }
>
> -static struct object_array_entry *find_single_final(struct rev_info *revs)
> +static struct commit *find_single_final(struct rev_info *revs,
> +                                       const char **name_p)
>  {
>         int i;
> -       struct object_array_entry *found = NULL;
> +       struct commit *found = NULL;
> +       const char *name = NULL;
>
>         for (i = 0; i < revs->pending.nr; i++) {
>                 struct object *obj = revs->pending.objects[i].item;
> @@ -2418,22 +2420,20 @@ static struct object_array_entry *find_single_final(struct rev_info *revs)
>                         die("Non commit %s?", revs->pending.objects[i].name);
>                 if (found)
>                         die("More than one commit to dig from %s and %s?",
> -                           revs->pending.objects[i].name,
> -                           found->name);
> -               found = &(revs->pending.objects[i]);
> +                           revs->pending.objects[i].name, name);
> +               found = (struct commit *)obj;
> +               name = revs->pending.objects[i].name;
>         }
> +       if (name_p)
> +               *name_p = name;
>         return found;
>  }
>
>  static char *prepare_final(struct scoreboard *sb)
>  {
> -       struct object_array_entry *found = find_single_final(sb->revs);
> -       if (found) {
> -               sb->final = (struct commit *) found->item;
> -               return xstrdup(found->name);
> -       } else {
> -               return NULL;
> -       }
> +       const char *name;
> +       sb->final = find_single_final(sb->revs, &name);
> +       return xstrdup_or_null(name);
>  }
>
>  static char *prepare_initial(struct scoreboard *sb)
> @@ -2721,11 +2721,9 @@ parse_done:
>                 die("Cannot use --contents with final commit object name");
>
>         if (reverse && revs.first_parent_only) {
> -               struct object_array_entry *entry = find_single_final(sb.revs);
> -               if (!entry)
> +               final_commit = find_single_final(sb.revs, NULL);
> +               if (!final_commit)
>                         die("--reverse and --first-parent together require specified latest commit");
> -               else
> -                       final_commit = (struct commit*) entry->item;
>         }
>
>         /*
> --
> 2.6.3.636.g1460207
>
