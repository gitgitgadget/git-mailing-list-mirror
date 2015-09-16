From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Wed, 16 Sep 2015 16:49:27 -0400
Message-ID: <CANoM8SWV0r9sHUTk3Rfu=psZLKmnjD19Dn_atCuDmc=41420-w@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-2-git-send-email-rappazzo@gmail.com> <CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
 <CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com> <CAPig+cRPbFw8oTQ63rPtp1cyKms9zi0QkZNvkOWZoxb+mnpZrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:49:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJeK-000263-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbIPUts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:49:48 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34118 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbbIPUts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:49:48 -0400
Received: by vkhf67 with SMTP id f67so109686717vkh.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BG970AltT9TKezDfC3xOA3w3youot+scvTYgVkZBrZ8=;
        b=yIPeSXPTmlR/5nQ6WbMhXjyPs1PIJfEYcV2BPDQ00Z1KFXUdw2Z63NiuBZ6Zh4PLoL
         HaLG/7fikWCzDCaKQQDhHgaxUiRoY4rT3yc8jWSl8t2p+qUo/GxysL7tL2KxgrvFKJs7
         GzWtPDx8g0Z9Bxk4UM6NYy8x582TjOkhBHwJT3/KPgIG3yGvZS1r6GPHDDCTJ0IQTeLK
         UKVIR09d5u6SHz9rJ2VfelSUHdgUFESvP/DysNNPiE8hxoRFnWqVk0gUkD7fxj40Pj9o
         r9nAlrRK4enjCzD1OJtYNDHL+m8tsbCF7eqOuONz7hmUx8EZtYarBZXSmBb7pwucO1WB
         zriQ==
X-Received: by 10.31.182.215 with SMTP id g206mr32103223vkf.8.1442436586857;
 Wed, 16 Sep 2015 13:49:46 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Wed, 16 Sep 2015 13:49:27 -0700 (PDT)
In-Reply-To: <CAPig+cRPbFw8oTQ63rPtp1cyKms9zi0QkZNvkOWZoxb+mnpZrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278067>

On Wed, Sep 16, 2015 at 4:32 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Sep 14, 2015 at 8:20 AM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>> On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> +struct worktree {
>>>> +       char *path;
>>>> +       char *git_dir;
>>>> +       char *head_ref;
>>>> +       unsigned char head_sha1[20];
>>>> +       int is_detached;
>>>> +       int is_bare;
>>>> +};
>>>> +
>>>> +struct worktree_list {
>>>> +       struct worktree *worktree;
>>>> +       struct worktree_list *next;
>>>> +};
>>>
>>> I don't care too strongly, but an alternate approach (which I probably
>>> would have taken) would be to have get_worktrees() simply return an
>>> array of 'struct worktree' objects, hence no need for the additional
>>> 'struct worktree_list'. The slight complication with this approach,
>>> though, is that get_worktrees() either also needs to return the length
>>> of the array, or the array should end with some sort of end-of-array
>>> sentinel. An obvious sentinel would be path==NULL or git_dir==NULL or
>>> all of the above.
>>>
>>> Client iteration is just about the same with the array approach as
>>> with the linked-list approach.
>>
>> I can't see what benefit this would provide.  I would sooner change
>> the returned list into
>> an array-backed list struct.  Alternatively, I think adding a
>> list_head pointer to this structure
>> could benefit client code.
>
> The benefit is a reduction in complexity, which is an important goal.
> Linked lists are inherently more complex than arrays, requiring extra
> effort, and especially extra care, to manage the head, each "next"
> pointer (and possibly a tail pointer). Arrays are used often in Git,
> thus are familiar in this code-base, and Git has decent support for
> making their management relatively painless. Your suggestions of
> changing into "an array-backed list structure" or "adding list_head
> pointer" increase complexity, rather than reduce it.
>
> Aside from the complexity issue, arrays allow random access, whereas
> linked lists allow only sequential access. While this limitation may
> not impact your current, planned use of get_worktrees(), it places a
> potentially unnecessary restriction on future clients.
>
> And, as noted, client iteration is at least as convenient with arrays,
> if not moreso, due to the reduction in noise ("p++" rather than "p =
> p->next").
>
>     struct worktree *p;
>     for (p = get_worktrees(); p->path; p++)
>         blarp(p);
>
> There are cases where linked lists are an obvious win, but this
> doesn't seem to be such a case. On the other hand, there are obvious
> benefits to making this an array, such as reduced complexity and
> removal of the sequential-access-only restriction.

What you are suggesting makes sense, but I feel it falls short when it
comes to the "sentinel".  Would the last element in the list be a
dummy worktree?  I would sooner add a NULL to the end.  Would that be
an acceptable implementation?

I have re-coded it to put the next pointer in the worktree structure
as Junio has suggested, but I am open to changing it to use the array
approach.
