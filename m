From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git rebase -i failing due to phantom index.lock
Date: Thu, 17 Sep 2015 19:57:59 +0700
Message-ID: <CACsJy8CnxGSJT62FRsZP4cD7Az36XGDjJwr+Szddhz42P_hJDg@mail.gmail.com>
References: <CAOxFTcwTOJjRnA=7gR4GP2u0bsDCRv+j8PEw0c8Nv-nVVrynTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 14:58:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcYlv-0008Io-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 14:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbbIQM6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 08:58:37 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35740 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbbIQM63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 08:58:29 -0400
Received: by ioiz6 with SMTP id z6so20503344ioi.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6wW38GFPFD2q0vIVfme8ncHx/4IRHcLmjJPznMB8s4M=;
        b=l6K8v13UcKhp3IH4Cssr5XCWTC9CziV3Jl6biicwnsoiCZW8xG9lYO7kGZLv51E/rN
         nOFxVaSYrlRg5RSXGb3TsyGkFKpUCQL6VcMlFJJrrUbL6pHMxc9OD5X6Y+um05tWChUF
         UN8mqeDy3CSUGDUQfIkiZVFe/lZLbbWmZprfaxHKPUTh5UPLtfzor+3tGKGTE8UQaflf
         734q/50GcdYuHqMekPIU2HKG9XhyHPpSGZHmz+gXrhqdbK0yXszldk1QDDYOejkRXhu2
         ePp0t4x9AtC0L4gEdxZSoDmavbkfmsijthKcSJQ6quLAIBNGaCblstq+2cIPcpRdKpVL
         NYdQ==
X-Received: by 10.107.4.82 with SMTP id 79mr5900216ioe.10.1442494708504; Thu,
 17 Sep 2015 05:58:28 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Thu, 17 Sep 2015 05:57:59 -0700 (PDT)
In-Reply-To: <CAOxFTcwTOJjRnA=7gR4GP2u0bsDCRv+j8PEw0c8Nv-nVVrynTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278111>

On Thu, Sep 17, 2015 at 3:08 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Hello all,
>
> I've recently started to note an issue with git rebase -i failing with
> alarming frequency, especially on one of my repositories, claiming
> that index.lock could not be created because it exists, even though it
> doesn't and nothing else seems to be locking the index. The rebase
> bombs more usually during the initial checkout than during any other
> of the steps.
>
> The problem is somewhat randomly reproducible, as it doesn't happen
> 100% of the time. It also seems to happen more consistently with more
> recent git versions, or at least with my custom built git than with
> the distro-shipped one.
>
> A somewhat problematic git bisect has allowed me to identify commit
> 03b86647722f11ccc321cd7279aa49b811d17cc2 as the first bad commit.

That commit is mostly refactoring, but there's one extra lock added in
these hunks. Maybe you can revert it and see if it improves anything.

diff --git a/builtin/apply.c b/builtin/apply.c
index 87439fa..5e13444 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3644,7 +3644,7 @@ static void build_fake_ancestor(struct patch
*list, const char *filename)
 {
        struct patch *patch;
        struct index_state result = { NULL };
-       int fd;
+       static struct lock_file lock;

        /* Once we start supporting the reverse patch, it may be
         * worth showing the new sha1 prefix, but until then...
@@ -3682,8 +3682,8 @@ static void build_fake_ancestor(struct patch
*list, const char *filename)
                        die ("Could not add %s to temporary index", name);
        }

-       fd = open(filename, O_WRONLY | O_CREAT, 0666);
-       if (fd < 0 || write_index(&result, fd) || close(fd))
+       hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+       if (write_locked_index(&result, &lock, COMMIT_LOCK))
                die ("Could not write temporary index to %s", filename);

        discard_index(&result);

> The problem has all signs of a timing issue, which I'm having problems
> isolating, although simply providing a timeout on the index lock calls
> seems to fix it.

lockfile has received some updates lately. This commit caught my eyes,
044b6a9 (lockfile: allow file locking to be retried with a timeout -
2015-05-11), but this is just a shot in the dark..

> Making git stall instead of die on error allowed me
> to obtain this backtrace which I suspect will not be particularly
> useful:
>
> #0 0x00000000004c4666 in unable_to_lock_message
> (path=path@entry=0x1bad940 ".git/index", err=<optimized out>,
> buf=buf@entry=0x7ffd3b990900) at lockfile.c:158
> #1 0x00000000004c46c6 in unable_to_lock_die (path=path@entry=0x1bad940
> ".git/index", err=<optimized out>) at lockfile.c:167
> #2 0x00000000004c480b in hold_lock_file_for_update_timeout
> (lk=lk@entry=0x1bd7be0, path=0x1bad940 ".git/index", flags=<optimized
> out>, timeout_ms=timeout_ms@entry=0) at lockfile.c:177
> #3 0x00000000004e6e2a in hold_lock_file_for_update (flags=1,
> path=<optimized out>, lk=0x1bd7be0) at lockfile.h:165
> #4 hold_locked_index (lk=lk@entry=0x1bd7be0,
> die_on_error=die_on_error@entry=1) at read-cache.c:1411
> #5 0x0000000000420cb0 in merge_working_tree (old=0x7ffd3b990a20,
> old=0x7ffd3b990a20, new=0x7ffd3b990a00, new=0x7ffd3b990a00,
> writeout_error=0x7ffd3b9909c0, opts=0x7ffd3b992a31)
> at builtin/checkout.c:471

So it fails at "git checkout". That'll give me something to look in
git-rebase*.sh. Thanks.
-- 
Duy
