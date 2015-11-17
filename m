From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 00:11:25 -0500
Message-ID: <CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>,
	Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 06:11:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyYYS-00088W-T1
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 06:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbbKQFL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 00:11:26 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35525 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbKQFLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 00:11:25 -0500
Received: by vkas68 with SMTP id s68so5511683vka.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 21:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m4dRP7aJrwON5dGCvKc8hhbfUy90Hdxa0EgquDRWczU=;
        b=LUqGCA9sJtmhmyjIixEFKiqMatkJ/Mi+pzPy8rU3OKXmR+yft0jAeP1jA1WNJHNigQ
         UzDMAnL5Sv70Dnq48MUriWeEYFeXitfTtnyV8yN0gesRwm8DKrN0jjklbOA8WEF6WpSP
         tWAxn+jez4yRRfzt3qZqtxCyoVBzHr9U1fZhf+nDvmDBjdHCl2VKaYR0MQSbCTqnwqjp
         2hxj+pLwMyMBWGWSBNeoWVRJnZh2kSmJxP1z3x6NsHLDIfXx4Q52Jk19spBSz5VCZPUC
         MfqNEP+WqbEmz6vGn7yBwwRfsx8ifMcCczeZHcTowqVWc0vUMurQ2zPdBQb9tF/10NW7
         gkcw==
X-Received: by 10.31.152.19 with SMTP id a19mr1687245vke.45.1447737085194;
 Mon, 16 Nov 2015 21:11:25 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 21:11:25 -0800 (PST)
In-Reply-To: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: SfpOlB01H7YAjxHYueLRySpEL2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281381>

On Mon, Nov 16, 2015 at 8:29 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> blame: avoid checking if a file exists on the working tree
> if a revision is provided

This subject is a bit long; try to keep it to about 72 characters or less.

More importantly, though, it doesn't give us a high level overview of
the purpose of the patch, which is that it is fixing blame to work on
a file at a given revision even if the file no longer exists in the
worktree.

> If a file has been deleted/renamed, blame refused to display

Imperative: s/refused/refuses/

> blame content even if the path provided does match an existing
> blob on said revision.

git-blame documentation does not advertise "blame <file> <rev>" as a
valid invocation. It does advertise "blame <rev> -- <file>", and this
case already works correctly even when <file> does not exist in the
worktree.

git-annotate documentation, on the other hand, does advertise
"annotate <file> <rev>", and it fails to work when <file> is absent
from the worktree, so perhaps you want to sell this patch as fixing
git-annotate instead?

> $ git status
> On branch hide
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>         deleted:    testfile1.txt
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> Before:
> $ git blame testfile1.txt
> fatal: cannot stat path 'testfile1.txt': No such file or directory
> $ git blame testfile1.txt HEAD
> fatal: cannot stat path 'testfile1.txt': No such file or directory
>
> After:
> $ git blame testfile1.txt
> fatal: Cannot lstat 'testfile1.txt': No such file or directory
> $ git blame testfile1.txt HEAD
> ^da1a96f testfile2.txt (Edmundo Carmona Antoranz 2015-11-10 17:52:00 -0600 1) testfile 2
> ^da1a96f testfile2.txt (Edmundo Carmona Antoranz 2015-11-10 17:52:00 -0600 2)
> ^da1a96f testfile2.txt (Edmundo Carmona Antoranz 2015-11-10 17:52:00 -0600 3) Some content

This example is certainly illustrative, but an even more common case
may be trying to blame/annotate a file which existed in an older
revision but doesn't exist anymore at HEAD, thus is absent from the
worktree. Such a case could likely be described in a sentence or two
without resorting to verbose examples (though, not a big deal if you
keep the example).

A new test or two would be welcome, possibly in t/annotate-tests.sh if
you consider this also fixing git-blame, or in t8001-annotate.sh if
you're selling it only as a fix for git-annotate.

> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -2683,12 +2683,13 @@ parse_done:
>                 argv[argc - 1] = "--";
>
>                 setup_work_tree();
> -               if (!file_exists(path))
> -                       die_errno("cannot stat path '%s'", path);
>         }
>
>         revs.disable_stdin = 1;
>         setup_revisions(argc, argv, &revs, NULL);
> +       if (!revs.pending.nr && !file_exists(path))
> +               die_errno("cannot stat path '%s'", path);
> +
>         memset(&sb, 0, sizeof(sb));
>
>         sb.revs = &revs;
> --
> 2.6.2
