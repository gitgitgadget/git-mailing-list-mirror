From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 09:53:41 -0400
Message-ID: <CAPig+cRg0ovyutXmTggr5P++dWuVP3izf5JfcJEeEVZhHuVJiA@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 15:53:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXAV0-0003Am-Bf
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 15:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab3JRNxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 09:53:43 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:43883 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab3JRNxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 09:53:43 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so758800lab.32
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i3pkLs+RIctRLnLB0rC1gZC55s9cMCqIJcQ373QCVn8=;
        b=p+wKHF8BgT4e9V9XmY95sfJNKx6Z3IzGTnT+ix5B6d7Qe5jbotf0dvZAO4bQ/xXDmF
         6RyOyE0qBkK2Laeu8J7WXvoY3bYm0L5kdOBdhwJjkNXLdYqil43uxBBM8EJbh6sCQMnr
         x7oyZQzlsR1hyRvrqROTdzjPrVLTMGWCQqR121/L4qOr5rV1xeQntlfJexumlmE3Ow1r
         d8L7L1AR/Y0iqVecXpBr1MUDxYL1aP5AH/Aast+PVBdsudJvJerJwyd1/jDitwuqzFsj
         V3nRnyo7zSGtz6FBdNjGL7XjG0CJyNAc2tBtq1iNeW1Nb0zDtqlDyasyctz4gegdJCS1
         n4Qg==
X-Received: by 10.152.26.201 with SMTP id n9mr393598lag.52.1382104421659; Fri,
 18 Oct 2013 06:53:41 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Fri, 18 Oct 2013 06:53:41 -0700 (PDT)
In-Reply-To: <1382102267-18151-1-git-send-email-johan@herland.net>
X-Google-Sender-Auth: oA8AC4ewPG4bnixT5TTc9sT3j4Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236350>

On Fri, Oct 18, 2013 at 9:17 AM, Johan Herland <johan@herland.net> wrote:
> There are cases (e.g. when running concurrent fetches in a repo) where
> multiple Git processes concurrently attempt to create loose objects
> within the same objects/XX/ dir. The creation of the loose object files
> is (AFAICS) safe from races, but the creation of the objects/XX/ dir in
> which the loose objects reside is unsafe, for example:
>
> Two concurrent fetches - A and B. As part of its fetch, A needs to store
> 12aaaaa as a loose object. B, on the other hand, needs to store 12bbbbb
> as a loose object. The objects/12 directory does not already exist.
> Concurrently, both A and B determine that they need to create the
> objects/12 directory (because their first call to git_mkstemp_mode()
> within create_tmpfile() fails witn ENOENT). One of them - let's say A -
> executes the following mkdir() call before the other. This first call
> returns success, and A moves on. When B gets around to calling mkdir(),
> it fails with EEXIST, because A won the race. The mkdir() error causes B
> to return -1 from create_tmpfile(), which propagates all the way,
> resulting in the fetch failing with:
>
>   error: unable to create temporary file: File exists
>   fatal: failed to write object
>   fatal: unpack-objects failed
>
> Although it's hard to add a testcase reproducing this issue, it's easy
> to reproduce if we insert a sleep after the
>
>   if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
>       return -1;
>
> block, and then run two concurrent "git fetch"es against the same repo.
>
> The fix is to simply handle mkdir() setting errno = EEXIST as success.

Would it make sense for the commit message to explain what happens if
EEXIST is returned but the pathname is not a directory? (For instance,
in the same race window, another process had created a plain file or
pipe there.)

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  sha1_file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index f80bbe4..00ffffe 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2857,7 +2857,9 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
>                 /* Make sure the directory exists */
>                 memcpy(buffer, filename, dirlen);
>                 buffer[dirlen-1] = 0;
> -               if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
> +               if (mkdir(buffer, 0777) && errno != EEXIST)
> +                       return -1;
> +               if (adjust_shared_perm(buffer))
>                         return -1;
>
>                 /* Try again */
> --
> 1.8.4.653.g2df02b3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
