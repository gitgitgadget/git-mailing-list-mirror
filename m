From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git rebase -i failing due to phantom index.lock
Date: Mon, 21 Sep 2015 18:48:32 +0200
Message-ID: <CAOxFTcx4SsCSbnZ=mv2s7GyDX29gBrZa+uijtbrUTMWjVXXCKg@mail.gmail.com>
References: <CAOxFTcwTOJjRnA=7gR4GP2u0bsDCRv+j8PEw0c8Nv-nVVrynTQ@mail.gmail.com>
 <CACsJy8CnxGSJT62FRsZP4cD7Az36XGDjJwr+Szddhz42P_hJDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:49:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4H1-0003rD-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 18:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbbIUQs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 12:48:56 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33152 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbbIUQsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 12:48:53 -0400
Received: by wiclk2 with SMTP id lk2so155917361wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=73NDEB6SIhGy4Mtf6G4qcoT3ajej6/eZpHNDM34rSCI=;
        b=VAmkPH75AFs478nLiaYQ6pRopeB4ZNhWn0wVzD80jxPGgJ89BXXjzlwOQpK3L1GPr0
         pp6J08bufXbp/hhwPTR2fX4cDnCcA2xsNASX9fzHJEjuDQReiR3AAXPNp5uPC625V1Cr
         373URvnXSFifg5rB7Djae5MfzUNxHOdmrBtqrfouxtWEh6UM4zvB+2m76ZLFYQIU1P02
         YIlF3PShvj8Tm0EV5jJw9yAaFWAWVmO4qDVugGHV0pB6lCz/z4S4Q2nWkKrPdlR9gYgn
         I46JfolAEuyHigd/ikhE8/Ns0otjOAPM+SIxjwErj97j0wAlRQvk6k0jpS72/KPeKtw7
         wF8A==
X-Received: by 10.180.107.164 with SMTP id hd4mr15314280wib.94.1442854132033;
 Mon, 21 Sep 2015 09:48:52 -0700 (PDT)
Received: by 10.194.101.100 with HTTP; Mon, 21 Sep 2015 09:48:32 -0700 (PDT)
In-Reply-To: <CACsJy8CnxGSJT62FRsZP4cD7Az36XGDjJwr+Szddhz42P_hJDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278308>

Hello,

On Thu, Sep 17, 2015 at 2:57 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Sep 17, 2015 at 3:08 AM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>
>> A somewhat problematic git bisect has allowed me to identify commit
>> 03b86647722f11ccc321cd7279aa49b811d17cc2 as the first bad commit.
>
> That commit is mostly refactoring, but there's one extra lock added in
> these hunks. Maybe you can revert it and see if it improves anything.
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 87439fa..5e13444 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3644,7 +3644,7 @@ static void build_fake_ancestor(struct patch
> *list, const char *filename)
>  {
>         struct patch *patch;
>         struct index_state result = { NULL };
> -       int fd;
> +       static struct lock_file lock;
>
>         /* Once we start supporting the reverse patch, it may be
>          * worth showing the new sha1 prefix, but until then...
> @@ -3682,8 +3682,8 @@ static void build_fake_ancestor(struct patch
> *list, const char *filename)
>                         die ("Could not add %s to temporary index", name);
>         }
>
> -       fd = open(filename, O_WRONLY | O_CREAT, 0666);
> -       if (fd < 0 || write_index(&result, fd) || close(fd))
> +       hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
> +       if (write_locked_index(&result, &lock, COMMIT_LOCK))
>                 die ("Could not write temporary index to %s", filename);
>
>         discard_index(&result);

This is not trivial to revert because write_index isn't available
anymore. I'm not sure what I should replace it with.

>> The problem has all signs of a timing issue, which I'm having problems
>> isolating, although simply providing a timeout on the index lock calls
>> seems to fix it.
>
> lockfile has received some updates lately. This commit caught my eyes,
> 044b6a9 (lockfile: allow file locking to be retried with a timeout -
> 2015-05-11), but this is just a shot in the dark..

The point is that, if I add a timeout to the checkout lock, it works.
It works as if something locks it earlier, and the unlock doesn't
register quickly enough, so waiting a few tens of milliseconds makes
it work.

> So it fails at "git checkout". That'll give me something to look in
> git-rebase*.sh. Thanks.


For what it's worth, the problem seems easier to replicate with a very
long list of commits than with a short one.

Best regards,


-- 
Giuseppe "Oblomov" Bilotta
