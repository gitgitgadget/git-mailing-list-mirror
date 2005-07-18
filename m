From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 18:06:33 -0600
Message-ID: <m1hdetnfjq.fsf@ebiederm.dsl.xmission.com>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
	<m1psthomf0.fsf@ebiederm.dsl.xmission.com>
	<7voe91jmc6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 02:07:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuJ9t-0003jD-2L
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVGRAGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVGRAGw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 20:06:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:236 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261448AbVGRAGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 20:06:51 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6I06Yqb002410;
	Sun, 17 Jul 2005 18:06:34 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6I06XaW002409;
	Sun, 17 Jul 2005 18:06:33 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe91jmc6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 17 Jul 2005 11:53:29 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> What we care about are the tag objects, those are the only kind
>> that are verifiable and usable remotely.  
>>
>> Now that I know we do not pull tags currently with any of the
>> optimized transports, I would suggest taking the list of commit
>> objects we are transporting and for each commit look in the
>> remote repo/refs/tags and transferring every tag object we can find
>> that refers to that commit.
>
> I do not think it is particularly a good idea to fetch a tag
> that refers to a commit when the user asks only for that commit
> (e.g. the user said "the head of this remote branch I am
> tracking", and the head happened to have been tagged).  Yes, it
> may be convenient, but retrieving the commit chain and
> retrieving tags are conceptually separate issues.  A tag does
> not necessarily refer to a commit, so your reverse index does
> not make sense for a tag pointing at a blob, for example.

After thinking it through I have to agree but not for your reasons.
The killer argument for me is that tags can be made at any time.
Which means that any incremental scheme that links pulling of tags
to the pulling of the objects they refer to will fail when
the tag is made after you have pulled the object.

So at the very least the computation of which tags to pull needs
to be separate from the computation of which object to pull.

> I think if we have discovery mechanism of remote tags/heads, we
> do not need anything else.  You _could_ say something like:
>
>     $ git-list-remote --tags linux-2.6
>     9e734775f7c22d2f89943ad6c745571f1930105f	v2.6.12-rc2
>     26791a8bcf0e6d33f43aef7682bdb555236d56de	v2.6.12
>     ...
>     a339981ec18d304f9efeb9ccf01b1f04302edf32	v2.6.13-rc3
>     $ git-list-remote --tags linux-2.6 |
>       while read sha1 tag;
>       do
>           git fetch linux-2.6 tag $tag
>       done
>
> and you are done.  We did not use the reverse index, nor we used
> the --all-tags flag to git-fetch-script.  You do not even need
> git-list-remote if you are willing to wget a=summary output from
> gitweb and parse the bottom of the page ;-).

I agree that anything we do will need to look roughly like the
above.  Beyond a simple index of what tags are present
in the objects directory I can't think of anything that would
be a cost savings, except possibly ordering the tags by creation
date.

There are a couple pieces of your example that disturb me.
- The tag names are forced to be the same between trees.
- You don't verify the tags before installing them.
- I view tags as history and by having tag fetching totally
  separate it becomes easy to loose that history.

I do like the fact that when you fetch a tag you are certain
to fetch all of the objects and it refers to.

I don't know what the solution is but we seem to be getting closer.

Eric
