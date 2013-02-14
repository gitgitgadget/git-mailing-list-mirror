From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Thu, 14 Feb 2013 16:16:24 +0100
Message-ID: <CACBZZX6BVuQWtrLuTVXZo+77sT4yZQ3pvN=_fMma24-zd0NNqA@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 16:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U60Yg-0002qM-IS
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 16:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377Ab3BNPQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 10:16:47 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41707 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007Ab3BNPQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 10:16:46 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so2582636oag.23
        for <git@vger.kernel.org>; Thu, 14 Feb 2013 07:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vh79mwBNcKEq/DIGanIpqSed4YaaYonpmQ0kB3ZgDE0=;
        b=F3GttklITsoED1yp7K5XK2sMi8HxcHD/lQ+2/padg6mUk3qt+XS0Mk0ZjUt0VHTDT0
         PPTn1rZb3+zpi8LB4C5mt2Wkv0oCc9Kt/08eMBTwqLTTnjv1D06U186R6p55tgDdDins
         uY7v5jTS/os3ZpcVAg9WfBqqRzwRZLK3D8J1F5zfIlWVOnlAq2f1xVjK26jUoqrxvwkb
         l0j8dQaF5gcXgrcJ5oaGcFmk/QEPgDfMauS/FZsX+8NygRZ0zyiMxX/zpS7rTqXLokI/
         G8Az0/SLmYj7KAahaEwnMu3O3lsGuUWTSvWMY5sdkApjCmTMt+USbd4jF0X9Sbaubyst
         UrHA==
X-Received: by 10.182.69.71 with SMTP id c7mr19408228obu.92.1360855005741;
 Thu, 14 Feb 2013 07:16:45 -0800 (PST)
Received: by 10.76.86.6 with HTTP; Thu, 14 Feb 2013 07:16:24 -0800 (PST)
In-Reply-To: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216309>

On Fri, Feb 8, 2013 at 10:10 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> For large repositories, many simple git commands like `git status`
> take a while to respond.  I understand that this is because of large
> number of stat() calls to figure out which files were changed.  I
> overheard that Mercurial wants to solve this problem using itnotify,
> but the idea bothers me because it's not portable.  Will Git ever
> consider using inotify on Linux?  What is the downside?

There's one relatively easy sub-task of this that I haven't seen
mentioned: Improving the speed of interactive rebase on large (as in
lots of checked out files) repositories.

That's the single biggest thing that bothers me when I use Git with
large repos, not the speed of "git status". When you "git rebase -i
HEAD~100" re-arrange some patches and save the TODO list it takes say
0.5-1s for each patch to be applied, but at least 10x less than that
on a small repository. E.g. try this on linux-2.6.git v.s. some small
project with a few dozen files.

I looked into this a long while ago and remembered that rebase was
doing something like a git status for every commit that it made to
check the dirtyness.

This could be vastly improved by having an unsafe option to git-rebase
where it just assumes that the starting state + whatever it wrote out
is the current state, i.e. it would break if someone stuck up on your
checkout during an interactive rebase and changed a file, but the
common case of the user having exclusive access to the repo and
waiting for the rebase would be much faster.
