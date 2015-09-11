From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Fri, 11 Sep 2015 06:33:12 -0400
Message-ID: <CANoM8SUA+vk8bbqUaX1H4XQ4LiAVmVwgQdWLE4rO+MMGkS0F7Q@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-2-git-send-email-rappazzo@gmail.com> <xmqqk2ry2g8e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 12:33:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaLeK-0005vO-JA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 12:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbIKKde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 06:33:34 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35494 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbbIKKdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 06:33:33 -0400
Received: by vkao3 with SMTP id o3so11918665vka.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w+YTGjYer+UoyGbHJL7qjvi1ArqH810g6zIyWJP2Rxw=;
        b=t/BODU1q0TMXJgwIIIXy+Qc6JhH/IaGJTxNFOxUx5phCaEqLMS2jdadSfTivrCCvjQ
         2wUwmx2Cbt1Af3QPAsmVHW+ohAZMyX8ZyTMxkUmyd6QJZ5Z9kmV14cUSukEbIIDCAdYe
         BMblR93vWKaFtY1imXPkhYIXZw9crLaN9tM4KFrjeoLOKqTSrAx8VawcqAooArQRs/xc
         aKNC33d73ToAZTwphjko4opgDYRLR+5gtBgDjmHGwZU1HpSqv1f6wIhnigvd0jwQYNZP
         KuQdKFSLXdYNPXVUdNnhLi/nhplE5RYxf18+hd07wQbtj2wrmjcMf+FU55oNF4Get04S
         TQ7Q==
X-Received: by 10.31.158.145 with SMTP id h139mr3834435vke.11.1441967612275;
 Fri, 11 Sep 2015 03:33:32 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Fri, 11 Sep 2015 03:33:12 -0700 (PDT)
In-Reply-To: <xmqqk2ry2g8e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277657>

On Thu, Sep 10, 2015 at 4:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> Including functions to get the list of all worktrees, and to get
>> a specific worktree (primary or linked).
>
> Was this meant as a continuation of the sentence started on the
> Subject line, or is s/Including/Include/ necessary?

I think I was continuing the subject line.  I will make it nicer.

>
>> +             worktree_list = next;
>> +     }
>> +}
>> +
>> +/*
>> + * read 'path_to_ref' into 'ref'.  Also set is_detached to 1 if the ref is detatched
>> + *
>> + * return 1 if the ref is not a proper ref, 0 otherwise (success)
>
> These lines are overly long.
>
>> + */
>> +int _parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
>> +{
>> +     if (!strbuf_readlink(ref, path_to_ref, 0)) {
>> +             if (!starts_with(ref->buf, "refs/") || check_refname_format(ref->buf, 0)) {
>
> An overly long line.  Perhaps
>
>                 if (!starts_with(ref->buf, "refs/") ||
>                     check_refname_format(ref->buf, 0)) {
>
> (I see many more "overly long line" after this point, which I won't mention).


Is the limit 80 characters?

>
>> +                     /* invalid ref - something is awry with this repo */
>> +                     return 1;
>> +             }
>> +     } else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
>> +             if (starts_with(ref->buf, "ref:")) {
>> +                     strbuf_remove(ref, 0, strlen("ref:"));
>> +                     strbuf_trim(ref);
>
> We don't do the same "starts_with() and format is sane" check?

The code from this snippet was mostly ripped from branch.c (see the
second commit).
I will add the sanity check.

>
>
> An idiomatic way to extend a singly-linked list at the end in our
> codebase is to use a pointer to the pointer that has the element at
> the end, instead of to use a pointer that points at the element at
> the end or NULL (i.e. the pointer the above code calls current_entry
> is "struct worktree_list **end_of_list").  Would it make the above
> simpler if you followed that pattern?
>

I think I follow what you are saying here.  I will explore this route.
I am also unhappy about
having to separately maintain a point to the head of the list when
using it.  Would it be
"normal" to add a head pointer to the list structure?
