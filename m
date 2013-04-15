From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 19:25:08 +1000
Message-ID: <CACsJy8Cx0QA_epns2WNWjBBSG6zpXVaTebybiTRuVt+OARupAg@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URffU-0001Dn-62
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601Ab3DOJZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:25:40 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:48501 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab3DOJZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:25:39 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so4117756oag.8
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 02:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BuLR+drwMfOj6g/JlAfGhoxIGjgzqRIuXU5xtVSAZn4=;
        b=yIABAJI7cvozE9+x8o5siIYAmRoV5j2GwrJ53UiCtAqnpjfueHAbD0+0QF1W1Reh5P
         zaNtS6tMR60P3GGt1gikSzERVV+gJX9S+J4V4H4eugIYiwanpUmBWpwj7GHLIsqpI+j9
         KAyRVVQnsEo5vTW+mFhhLrZuizEtMG21MswU3885EAfkAfe6PBdCCfvY0DcQ24ZxxZdG
         iu1cxEY2/Bw8su/lruvjBac6pKuBl1xcJQ3ZOBGWuQzthD76wTcSlRKaNUbEWtj7H/35
         A1hsK8Jr6k+h5MRMQPHSDr/aYji9D0x+hjwglu97B16asCUbikTwJA86hshhOWQKDrDP
         LDpw==
X-Received: by 10.182.204.5 with SMTP id ku5mr7305009obc.22.1366017939260;
 Mon, 15 Apr 2013 02:25:39 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Mon, 15 Apr 2013 02:25:08 -0700 (PDT)
In-Reply-To: <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221208>

On Mon, Apr 15, 2013 at 6:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> It doesn't make sense as a command-line option, because it is "magic"
> that kicks in only when git clone is executed inside an existing git
> worktree.  The point is that the user doesn't have to remember
> anything special: a normal git clone already does the right thing
> outside a git worktree; my proposal is to make it do the right thing
> inside a git worktree as well.  Although I'm not against allowing a
> user to create a "full clone" inside a git repository by overriding
> clone.submoduleGitDir via a command-line option, I really cannot see
> why this would be anything but rare.  Why would a user *want* a full
> clone inside a git worktree?

If a user is inside .git, I believe setup_git_directory() will also
find correct gitdir. In that case, we do not want magic (i.e. only do
your magic when you are inside worktree). Still I'd rather see no
magic (i.e. command line option) first. Let people try it out for a
while. If people like it and find it inconvenient, magic can come
later. I suspect you might want more magic in other places. Maybe if
you hold it back  until you see full picture, you'll only need a few
new config keys (instead of one per separate magic).

>  Unfortunately, this patch is in pathetic shape and is an RFC for
>  three reasons:
>
>  1. I've used setup_git_directory_gently() at the start of
>     builtin/clone.c to check if I'm inside a git directory.  This
>     breaks a lot of existing tests (I'm yet to understand these
>     failures fully).
>
>  2. setup_git_directory_gently() has the side-effect of changing the
>     current directory and calling set_git_work_tree(), both of which
>     must be done away with if we want the rest of clone.c to work.
>     I've hacked around the issue in a very dirty manner.  What is the
>     solution to this?

Just do what scripts do: spawn a process to run rev-parse so that it
does not mess up the main process. You might be able to introduce
"dry-run" mode for setup_git_directory(), but that won't be easy.
--
Duy
