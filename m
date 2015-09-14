From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Mon, 14 Sep 2015 13:44:15 -0400
Message-ID: <CANoM8SVJr_B83vU43MFmDiL8phRcTqG3=5krk9iquuH3w5dN_Q@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-3-git-send-email-rappazzo@gmail.com> <CAPig+cT6JLzPPpJKPxAZGGduEQTRzwa57pHtGOJjPYPxCwJV=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXo1-0001ZI-B1
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbbINRoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:44:37 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34333 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbbINRog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:44:36 -0400
Received: by vkhf67 with SMTP id f67so64017476vkh.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5LWW1CFAeEcFPIqmdZNlpngkAnQ1dHV28Qqxh+lyO1U=;
        b=b/7+Q1kOF/SYwbnY17fnFKHDMgxTil+9jWcm8c6GrrersDXiD4i3jXDHU8SWmkRRdj
         QOe69a0/qksU6mgbGTSx2pzWOX1bx/8r9rBqAcHdYTVgI6KQpWXrzJcGvr0B2TVtdJdA
         ITbZs/9nb+lw84Wm0H8X/xLNWq9TMNjg2D4JMpymL82sga48OAO1l1oLa+UHTxwGiusH
         N18fErsVclxQXh/5g2bHgMkbLQw47+dd2bRJ/8xtLhR95JWa2ZwrDzCj3QjRyZOmiVTG
         qRitECFtfCYpVC5liXoporOpddl2hkf9ZO3xSvkZnw9xsjmIOcHnh0TZk/ByA3WF8soE
         T+pA==
X-Received: by 10.31.47.210 with SMTP id v201mr14340960vkv.126.1442252674946;
 Mon, 14 Sep 2015 10:44:34 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Mon, 14 Sep 2015 10:44:15 -0700 (PDT)
In-Reply-To: <CAPig+cT6JLzPPpJKPxAZGGduEQTRzwa57pHtGOJjPYPxCwJV=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277851>

On Sat, Sep 12, 2015 at 11:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>> The code formerly in branch.c was largely the basis of the
>> get_worktree_list implementation is now moved to worktree.c,
>> and the find_shared_symref implementation has been refactored
>> to use get_worktree_list
>
> Some comments below in addition to those by Junio...
>
>> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
>> ---
>> diff --git a/branch.h b/branch.h
>> index d3446ed..58aa45f 100644
>> --- a/branch.h
>> +++ b/branch.h
>> @@ -59,12 +59,4 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>>   */
>>  extern void die_if_checked_out(const char *branch);
>>
>> -/*
>> - * Check if a per-worktree symref points to a ref in the main worktree
>> - * or any linked worktree, and return the path to the exising worktree
>> - * if it is.  Returns NULL if there is no existing ref.  The caller is
>> - * responsible for freeing the returned path.
>> - */
>> -extern char *find_shared_symref(const char *symref, const char *target);
>> -
>>  #endif
>> diff --git a/worktree.c b/worktree.c
>> index 33d2e57..e45b651 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -155,3 +155,43 @@ done:
>>         return list;
>>  }
>>
>> +char *find_shared_symref(const char *symref, const char *target)
>> +{
>> +       char *existing = NULL;
>> +       struct strbuf path = STRBUF_INIT;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       struct worktree_list *worktree_list = get_worktree_list();
>> +       struct worktree_list *orig_list = worktree_list;
>> +       struct worktree *matched = NULL;
>> +
>> +       while (!matched && worktree_list) {
>> +               if (strcmp("HEAD", symref)) {
>
> The result of strcmp() never changes, so this (expensive) check could
> be lifted out of the 'while' loop, however...
>
>> +                       strbuf_reset(&path);
>> +                       strbuf_reset(&sb);
>> +                       strbuf_addf(&path, "%s/%s", worktree_list->worktree->git_dir, symref);
>> +
>> +                       if (_parse_ref(path.buf, &sb, NULL)) {
>> +                               continue;
>> +                       }
>> +
>> +                       if (!strcmp(sb.buf, target))
>> +                               matched = worktree_list->worktree;
>
> The original code in branch.c, which this patch removes, did not need
> to make a special case of HEAD, so it's not immediately clear why this
> replacement code does so. This is the sort of issue which argues in
> favor of mutating the existing code (slowly) over the course of
> several patches into the final form, rather than having the final form
> come into existence out of thin air. When the changes are made
> incrementally, it is easier for reviewers to understand why such
> modifications are needed, which (hopefully) should lead to fewer
> questions such as this one.
>

I reversed the the check here; it is intended to check if the symref
is _not_ the head, since the head
ref has already been parsed.  This is used in notes.c to find
"NOTES_MERGE_REF".  I will move the
check out of the loop as you suggest above.

>> +               } else {
>> +                       if (worktree_list->worktree->head_ref && !strcmp(worktree_list->worktree->head_ref, target))
>> +                               matched = worktree_list->worktree;
>> +               }
>> +               worktree_list = worktree_list->next ? worktree_list->next : NULL;
>> +       }
>> +
>> +       if (matched) {
>> +               existing = malloc(strlen(matched->path) + 1);
>> +               strcpy(existing, matched->path);
>
> A couple issues:
>
> This can be done more concisely and safely with xstrdup().
>
> In this codebase, it probably would be more idiomatic to use goto to
> drop out of the loop rather than setting 'matched' and then having to
> check 'matched' in the loop condition. So, for instance, each place
> which sets 'matched' could instead say:
>
>     existing = xstrdup(...);
>     goto done;
>
>> +       }
>> +
>> +done:
>
> This label doesn't have any matching goto's.
>
>> +       strbuf_release(&path);
>> +       strbuf_release(&sb);
>> +       worktree_list_release(orig_list);
>> +
>> +       return existing;
>> +}
>> diff --git a/worktree.h b/worktree.h
>> index 2bc0ab8..320f17e 100644
>> --- a/worktree.h
>> +++ b/worktree.h
>> @@ -45,4 +45,11 @@ struct worktree *get_worktree(const char *id);
>>  extern void worktree_list_release(struct worktree_list *);
>>  extern void worktree_release(struct worktree *);
>>
>> +/*
>> + * Look for a symref in any worktree, and return the path to the first
>> + * worktree found or NULL if not found.  The caller is responsible for
>> + * freeing the returned path.
>> + */
>
> For some reason, this comment differs a fair bit from the original in
> branch.h which was removed by this patch, however, the original
> comment was a bit more explanatory (I think).
>
> As a general rule, it's better to do code movement and code changes in
> separate patches since it's hard for reviewers to detect and
> comprehend differences in code which has been both moved and changed
> at the same time.
>

I have rebased the history a bit for the reroll, and hopefully it will
show the changes a little
more clearly.

>> +extern char *find_shared_symref(const char *symref, const char *target);
>> +
>>  #endif
>> --
>> 2.5.0
