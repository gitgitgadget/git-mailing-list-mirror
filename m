From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/POC 3/7] setup.c: add split-repo support to .git files
Date: Sat, 14 Dec 2013 08:28:26 +0700
Message-ID: <CACsJy8DtPw7_OH+vH3zhrgaeir6GbHSNzbWYtD02ozOnAJYE+w@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1386771333-32574-4-git-send-email-pclouds@gmail.com> <xmqqiousr4bg.fsf@gitster.dls.corp.google.com>
 <20131213204348.GX2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 02:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vre2Q-0003Yf-Bz
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 02:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab3LNB25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 20:28:57 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:50747 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3LNB25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 20:28:57 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so2891536oag.21
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qr6MpzlBk/fyq19XnqxcOUKWzYanPEWKc26tJJBf13M=;
        b=EMMqnJQck4l/RG0gO+2vKpjkqzq7opYzHcKU+lBXufuXjtjXYAjQLDivSJ5hKN8lHp
         21/7S+3RqoeAUOEN01E6qjM+mRaATpeeOVsCrOT/kfXUaqAOp9njBmlj5EXbxbAAz5wm
         N/UN7ulHNT2jUOGOb8AuQdIVz1LczfuSZK0iMvSzvrJ6APOv69+2LKkY1L85YuUNS6m5
         xpWrmOw9tVVJl06pdFUivs0uOOZEO6+c3PWa2gWma76BPUNBnmQh6alRYN2wJwCKM+82
         pZlQYbOEi5/VPKgSHrdnz/nFY4NpSSCXsCSuVrSFErt45apQNOwGMOU0WA4kmOTwKXfe
         48Og==
X-Received: by 10.60.165.36 with SMTP id yv4mr3704055oeb.55.1386984536538;
 Fri, 13 Dec 2013 17:28:56 -0800 (PST)
Received: by 10.182.24.2 with HTTP; Fri, 13 Dec 2013 17:28:26 -0800 (PST)
In-Reply-To: <20131213204348.GX2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239272>

On Sat, Dec 14, 2013 at 3:43 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>
>>  - Do we want to record where the working tree directory is in
>>    $GIT_SUPER_DIR/repos/<id> somewhere?  Would it help to have such
>>    a record?
>
> That could be nice for the purpose of garbage collecting them.  I fear
> that for users it is too tempting to remove a worktree with "rm -rf"
> without considering the relationship from the parent repo that might
> be making walking through all reflogs slower or holding on to objects
> no one cares about any more.
>
> I imagine it would work like this:
>
>  1. At worktree creation time, full path to the working tree directory
>     is stored in $GIT_SUPER_DIR/repos/<id>.
>
>  2. "git gc" notices that the worktree is missing and writes a file
>     under $GIT_SUPER_DIR/repos/<id> with a timestamp, saying so.
>
>  3. If the worktree still hasn't existed for a month, "git gc" deletes
>     the corresponding $GIT_SUPER_DIR/repos/<id> directory.

I was thinking about doing something like this in "git prune" but
manually. Your idea sounds nicer.

> Problems:
>
>  * What if I move my worktree with "mv"?  Then I still need the
>    corresponding $GIT_SUPER_DIR/repos/<id> directory, and nobody told
>    the GIT_SUPER_DIR about it.

We could store $GIT_SUPER_DIR as relative path. That way if you move
it, you break it. When you fix it, hopefully you remember to fix the
link in repos/<id> too

Alternatively, the setup up code could be taught to verify that
$GIT_SUPER_DIR/repos/id/<backlink> actually points to the current
worktree. If not warn the user or something

>  * What if my worktree is on removable media (think "network
>    filesystem") and has just been temporarily unmounted instead of
>    deleted?

Or we keep update a timestamp in repos/<id> to note the last used time
of this worktree. "gc" or "prune" would warn about unused repos after
a certain amount of time, do not remove them automatically. This could
be iii. to your list below.

> So maybe it would be nicer to:
>
>   i. When the worktree is on the same filesystem, keep a *hard link* to
>      some file in the worktree (e.g., the .git file).  If the link count
>      goes down, it is safe to remove the $GIT_SUPER_DIR/repos/<id>
>      directory.

This can still break with updating by creating a new version, then
renaming it. Although I can't think why anybody (or anything) would
want to do that on .git file. This does not work on Windows though.

>  ii. When the worktree is on another filesystem, always keep
>      $GIT_SUPER_DIR/repos/<id> unless the user decides to manually
>      remove it.  Provide documentation or a command to list basic
>      information about $GIT_SUPER_DIR/repos directories (path to
>      worktree, what branch they're on, etc).

And on Windows, a new partition means a new drive, so it works there too.

>
> (i) doesn't require any futureproofing.  As soon as someone wants it,
> they can implement the check and fall back to (ii) for worktrees
> without the magic hard link.
>
> (ii) would benefit from recording the working tree directory as a
> possibly unreliable, human-friendly reminder.
>
>>  - How would this interact with core.worktree in .git/config of that
>>    "super" repository?
>
> Eek.

I'll see if I can ignore core.worktree when $GIT_SUPER_DIR is set. If
not, ban this use case :)
-- 
Duy
