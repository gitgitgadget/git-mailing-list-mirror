From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 05/11] branch: fix width computation
Date: Tue, 28 Jul 2015 23:46:59 +0530
Message-ID: <CAOLa=ZTsr3rFanRFwDW7YUE=VmcTgpaOHEKX2cJpfKOhW1FZGA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-5-git-send-email-Karthik.188@gmail.com>
 <vpq6154zk9o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:17:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9RX-0008AO-DE
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbbG1SRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:17:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35149 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbbG1SR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:17:29 -0400
Received: by obbop1 with SMTP id op1so90595862obb.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5vb4eHtTsPh+fxvl4IP4Dp9IrWMsgUyuVSBBCh+jWLo=;
        b=LRuaZ5SiILnsiZTI2YUIp4bFXzIBNuI/ejFbiOQ5Gg0eAgcAWjOWwTvzDA4t4Fj+JY
         ed+TdU3mG+Uvr7Rln+51GlEi7/Z4OG21QIgzRyCkt0mEwKgI3T1lsIXBSyoEuZoedgU9
         Txyq7xMFI31pHaw/KqcKCO7e/Du6PstrIxYuF+Z/KMwFOoouuDTBAPpEIefNY0fo25Lh
         GPHVcjsubx2qwbstjIObl4WWdyg81gL9a5tzn5mGmNc1dteBHGr6wvlhUOWfFtnon3eb
         xiy94G3i7+M6d032queLg58NezkzxBv/ACl+6C76zEdUjM0aJxlhehZkhcP13LzzJRDr
         8e0g==
X-Received: by 10.60.58.136 with SMTP id r8mr35476584oeq.30.1438107448353;
 Tue, 28 Jul 2015 11:17:28 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 11:16:59 -0700 (PDT)
In-Reply-To: <vpq6154zk9o.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274809>

On Tue, Jul 28, 2015 at 3:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>
> Why did send-email add this From: header? Strange, it has the same
> content as your actual From: field.
>

Not sure why, everything else came out fine. Idk what happened here.

>> Remove unnecessary variables from ref_list and ref_item
>> which were used for width computation. Make other changes
>> accordingly. This patch is a precursor for porting branch.c
>> to use ref-filter APIs.
>
> You can explain better why this is needed. I guess something like "we're
> making struct ref_item similar to ref-filter's ref_array_item", but the
> reader shouldn't have to guess.
>

Will explain like you suggested.

> You should adujst the subject like BTW, I don't think you are "fixing"
> anything.
>

I guess refactor would be a better word here.

> On a side note: on the "tag" series, see how explaining better and
> splitting patches led not only to a better history, but also to better
> final code, and to finding a actual bugs (the %(color) thing and the
> absence of reset on the state variable) even after sereval rounds of
> review? I'm being picky and demanding, but don't see that as a complain
> from me, just hints on getting even better ;-).
>

Haha, I look forward to reviews, they show things I usually miss out on,
and help me get better. so keep them coming, I'll keep improving :)
Thanks

>> @@ -386,15 +386,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
>>       newitem->name = xstrdup(refname);
>>       newitem->kind = kind;
>>       newitem->commit = commit;
>> -     newitem->width = utf8_strwidth(refname);
>>       newitem->dest = resolve_symref(orig_refname, prefix);
>>       newitem->ignore = 0;
>> -     /* adjust for "remotes/" */
>> -     if (newitem->kind == REF_REMOTE_BRANCH &&
>> -         ref_list->kinds != REF_REMOTE_BRANCH)
>> -             newitem->width += 8;
>> -     if (newitem->width > ref_list->maxwidth)
>> -             ref_list->maxwidth = newitem->width;
>>
>>       return 0;
>>  }
>
> OK, in the old code, the width computation is done when inserting the
> ref into the array. In the new code, you build the array and then do the
> width computation. You can explain this better in the commit message I
> think (instead of "Make other changes accordingly" which doesn't bring
> much).

Okay I guess will do, just didn't want to explain the whole thing in the commit
message.

>
>> @@ -505,11 +498,12 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
>>  }
>>
>>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>> -                        int abbrev, int current, char *prefix)
>> +                        int abbrev, int current, const char *remote_prefix)
>>  {
>>       char c;
>>       int color;
>>       struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
>> +     const char *prefix = "";
>>
>>       if (item->ignore)
>>               return;
>> @@ -520,6 +514,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>>               break;
>>       case REF_REMOTE_BRANCH:
>>               color = BRANCH_COLOR_REMOTE;
>> +             prefix = remote_prefix;
>>               break;
>
> Why do you need these two hunks? I did not investigate in details, but
> it seems you're calling print_ref_item either with prefix="" or with
> prefix=remote_prefix so it would seem that keeping "prefix" as argument
> would work. I guess I missed something.

This is needed as whenever we do "git branch", show_detached() calls
print_ref_item()
with remote_prefix="". But print_ref_list() calls print_ref_item()
with remote_prefix="remotes"
(only when `git branch -a` is called remote_prefix=""). But only
remote branches should be
given the remotes prefix.

>
>> -static int calc_maxwidth(struct ref_list *refs)
>> +static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
>>  {
>> -     int i, w = 0;
>> +     int i, max = 0;
>>       for (i = 0; i < refs->index; i++) {
>> +             struct ref_item *it = &refs->list[i];
>> +             int w = utf8_strwidth(it->name);
>> +
>>               if (refs->list[i].ignore)
>>                       continue;
>> -             if (refs->list[i].width > w)
>> -                     w = refs->list[i].width;
>> +             if (it->kind == REF_REMOTE_BRANCH)
>> +                     w += remote_bonus;
>> +             if (w > max)
>> +                     max = w;
>>       }
>> -     return w;
>> +     return max;
>>  }
>
> The old code was using 'w' for the max and no variable for the value at
> the current iteration. You're using 'max' for the max and 'w' at the
> current iteration. Using the same name 'w' for different things in the
> pre- and post-image of the patch distracts the reader.
>
> It may make sense to s/w/max/ in a separate preparatory patch. Or maybe
> it's overkill.
>

Since the change was minimal and easily understandable I think it's ok.
But if you still feel otherwise, I'll be happy to introduce a preparatory patch.

>> @@ -600,21 +600,18 @@ static char *get_head_description(void)
>>       return strbuf_detach(&desc, NULL);
>>  }
>>
>> -static void show_detached(struct ref_list *ref_list)
>> +static void show_detached(struct ref_list *ref_list, int maxwidth)
>>  {
>>       struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
>>
>>       if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
>>               struct ref_item item;
>>               item.name = get_head_description();
>> -             item.width = utf8_strwidth(item.name);
>>               item.kind = REF_LOCAL_BRANCH;
>>               item.dest = NULL;
>>               item.commit = head_commit;
>>               item.ignore = 0;
>> -             if (item.width > ref_list->maxwidth)
>> -                     ref_list->maxwidth = item.width;
>> -             print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
>> +             print_ref_item(&item, maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
>>               free(item.name);
>>       }
>>  }
> ...
>> +     int maxwidth = 0;
> ...
>> +     if (verbose)
>> +             maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>>
>>       qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>>
>>       detached = (detached && (kinds & REF_LOCAL_BRANCH));
>>       if (detached && match_patterns(pattern, "HEAD"))
>> -             show_detached(&ref_list);
>> +             show_detached(&ref_list, maxwidth);
>
> This hunks could ideally go in a preparatory patch that would just move
> the place where maxwidth is computed. This preparatory patch would just
> say
>
>         maxwidth = ref_list->maxwidth;
>
> and then you would do the actual change to
>
>         if (verbose)
>                 maxwidth = calc_maxwidth(...)
>
> without the distracting changes in the function's argument list.
>
> I won't insist on that, again it may be overkill. But reading the patch,
> I found it both rather trivial and hard to read, so there's room for
> improvement.
>

I find it too small to make a preparatory patch again, but if you really feel
so, like I said, I'll change :)

-- 
Regards,
Karthik Nayak
