From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/5] Fix verify_lock() to report errors via strbuf
Date: Fri, 22 May 2015 17:15:21 -0700
Message-ID: <CAGZ79kYa7hcb1xejp+aS3cELh4RBbm9+Um_r_4UvEu9C1yyPhw@mail.gmail.com>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat May 23 02:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvx67-00050u-Db
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 02:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbbEWAPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 20:15:23 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33283 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbbEWAPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 20:15:22 -0400
Received: by qgfa63 with SMTP id a63so18215361qgf.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 17:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pkaBwR+Th5QzDwzYIY/ZZNl1gju9f3vmtKjLJbAJB6U=;
        b=o7qH27KlUKjc8tMjQCQmal+7gDYgRh2vPyvzmnnAJvE6cdz9wapEXhgU1kbILgoM7+
         L33G8lH/ly/HBV4/muAxQRbM8LdCER0xsZAXuDxCv+PdnJ9dX/1BNB8puz7TcT+N7eJU
         /LxovEMQ9MpULA/IY8HrwA7btIdICaFiU0+ubGeQlhzY6bXu5okOaDNI5aR6YMiHkHNt
         IaXWWryWusqm/HSuhT2w6qPidMH8174uDaFjPJ7TTvdhpYC1gkBBZr6VO726Y8EUcQg5
         qxYcJXlRYSNjTWii2aaM2gf28WJFy6SpL6BDMSxJFKaNMSwBLNMUe5myPrbFOIgPzsqr
         zVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pkaBwR+Th5QzDwzYIY/ZZNl1gju9f3vmtKjLJbAJB6U=;
        b=PngQhwwRYmEH9h+B4HuYuG4O2/VvBh/dFKgPxJF24yhA7TDI15sMd5oo2wZVXoB/KQ
         Yee92rS3o/68PxQVcauh3xy8Sy/CqR569TvhlQ0caQ33SH6azSzFH00KuCn/rlbXKhM+
         +n6S1YHIZCPUvlmH3AosT5pJ/nuQk/ZHv6H3fdLwfvXBVOcg6OAmWRn17YnO1vpdzTDb
         dA/beNR1YOVs2RRBPaKfYoTElmv91HCZDZwOFFgYCg2xciKkQO8+KeOqcA0bRp+rE6Iv
         Jn+HtslxSeBGZfRF3EycX7Y0MqviODPZUEe1yIyEL468V8tFJor4fLSqmQW8r5IKDFcf
         tWPQ==
X-Gm-Message-State: ALoCoQmdxeNs7eu8IHRBqcyXkggb8/I1Sz0+jx/k6VUpSNbkIXGlK205M65zgF8rZJHG/8Rha+uO
X-Received: by 10.140.89.200 with SMTP id v66mr14023525qgd.50.1432340121585;
 Fri, 22 May 2015 17:15:21 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 17:15:21 -0700 (PDT)
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269782>

On Fri, May 22, 2015 at 4:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> verify_lock() is a helper function called while committing reference
> transactions. But when it fails, instead of recording its error
> message in a strbuf to be passed back to the caller of
> ref_transaction_commit(), the error message was being written directly
> to stderr.
>
> Instead, report the errors via a strbuf so that they make it back to
> the caller of ref_transaction_commit().
>
> The last two patches remove the capitalization of some error messages,
> to be consistent with our usual practice. These are a slight backwards
> incompatibility; if any scripts are trying to grep for these error
> message strings, they might have to be adjusted. So feel free to drop
> them if you think consistency across time is more important than
> consistency across commands.
>
> This is the patch series that I mentioned here [1]. It applies on top
> of mh/ref-directory-file [2] and is thematically a continuation of
> that series in the sense that it further cleans up the error handling
> within reference transactions. It would be easy to rebase to master if
> that is preferred.

I was confused at first as I only looked at the patches and the corresponding
line numbers did not match with the files as currently open in my editor.
(they are roughly origin/master)

Now that I read the cover letter I can explain the line number being slightly
different. :)

The series looks good to me.

>
> These patches are also available on my GitHub account [3] as branch
> "verify-lock-strbuf-err".
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/269006
> [2] http://thread.gmane.org/gmane.comp.version-control.git/268778
> [3] https://github.com/mhagger/git
>
> Michael Haggerty (5):
>   verify_lock(): return 0/-1 rather than struct ref_lock *
>   verify_lock(): on errors, let the caller unlock the lock
>   verify_lock(): report errors via a strbuf
>   verify_lock(): do not capitalize error messages
>   ref_transaction_commit(): do not capitalize error messages
>
>  refs.c                | 40 ++++++++++++++++++++++++++--------------
>  t/t1400-update-ref.sh | 14 +++++++-------
>  2 files changed, 33 insertions(+), 21 deletions(-)
>
> --
> 2.1.4
>
