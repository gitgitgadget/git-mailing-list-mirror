From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Wed, 16 Sep 2015 16:32:40 -0400
Message-ID: <CAPig+cRPbFw8oTQ63rPtp1cyKms9zi0QkZNvkOWZoxb+mnpZrA@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
	<CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJNn-0007Ed-0n
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbbIPUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:32:42 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36776 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbbIPUcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:32:41 -0400
Received: by vkfp126 with SMTP id p126so109009107vkf.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1G4GsM7zI5dyDf7PJncy11e/knFlNZxTefDgI1F2MUY=;
        b=Zke4eBJgKjZNG9/MiewC1OQ9en599KCKB+UxSK4itQUE4aKp4+aIxqhKF8Xv7CDbrh
         eJW0ufM6LBAY7QpYBzXZ68aHLTTsIaprJYfpmVIXRZ03m8c9wcYtrXplx6+oUWsNqxWP
         Za5SGuSXhI7QvD9bR0DrNOGWjeMHS/glBieNgz8B23r2aB9YADshoJSo4b9GeJ32M1cR
         n9U/mP9OaRYTSS5XZdUqx0CWwEK6jwS6Ctn2Z37malw0LmfcQZ3DGwHiT7HjxglLF7H4
         1HM2ynh9cbYhfdX0ASA1iQCmp2FE2YlFYqrW1pW3T6elMFpkjzPA7Myfzjlj0+ZEpCmI
         6H2A==
X-Received: by 10.31.6.20 with SMTP id 20mr31468664vkg.151.1442435560956; Wed,
 16 Sep 2015 13:32:40 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Wed, 16 Sep 2015 13:32:40 -0700 (PDT)
In-Reply-To: <CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
X-Google-Sender-Auth: leG_PkarNm6xrD9FBo9c2PYrngY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278063>

On Mon, Sep 14, 2015 at 8:20 AM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +struct worktree {
>>> +       char *path;
>>> +       char *git_dir;
>>> +       char *head_ref;
>>> +       unsigned char head_sha1[20];
>>> +       int is_detached;
>>> +       int is_bare;
>>> +};
>>> +
>>> +struct worktree_list {
>>> +       struct worktree *worktree;
>>> +       struct worktree_list *next;
>>> +};
>>
>> I don't care too strongly, but an alternate approach (which I probably
>> would have taken) would be to have get_worktrees() simply return an
>> array of 'struct worktree' objects, hence no need for the additional
>> 'struct worktree_list'. The slight complication with this approach,
>> though, is that get_worktrees() either also needs to return the length
>> of the array, or the array should end with some sort of end-of-array
>> sentinel. An obvious sentinel would be path==NULL or git_dir==NULL or
>> all of the above.
>>
>> Client iteration is just about the same with the array approach as
>> with the linked-list approach.
>
> I can't see what benefit this would provide.  I would sooner change
> the returned list into
> an array-backed list struct.  Alternatively, I think adding a
> list_head pointer to this structure
> could benefit client code.

The benefit is a reduction in complexity, which is an important goal.
Linked lists are inherently more complex than arrays, requiring extra
effort, and especially extra care, to manage the head, each "next"
pointer (and possibly a tail pointer). Arrays are used often in Git,
thus are familiar in this code-base, and Git has decent support for
making their management relatively painless. Your suggestions of
changing into "an array-backed list structure" or "adding list_head
pointer" increase complexity, rather than reduce it.

Aside from the complexity issue, arrays allow random access, whereas
linked lists allow only sequential access. While this limitation may
not impact your current, planned use of get_worktrees(), it places a
potentially unnecessary restriction on future clients.

And, as noted, client iteration is at least as convenient with arrays,
if not moreso, due to the reduction in noise ("p++" rather than "p =
p->next").

    struct worktree *p;
    for (p = get_worktrees(); p->path; p++)
        blarp(p);

There are cases where linked lists are an obvious win, but this
doesn't seem to be such a case. On the other hand, there are obvious
benefits to making this an array, such as reduced complexity and
removal of the sequential-access-only restriction.
