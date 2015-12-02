From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Make error message after failing commit_lock_file() less confusing
Date: Tue, 1 Dec 2015 23:28:09 -0500
Message-ID: <CAPig+cROdVgf=EL3jKyyPpLiRA_JyHD8P336-YDCWhK8nGSQaQ@mail.gmail.com>
References: <1448883653-9140-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 05:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3z1b-0006H7-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 05:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbbLBE2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 23:28:11 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36393 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbLBE2K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2015 23:28:10 -0500
Received: by vkay187 with SMTP id y187so17694542vka.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 20:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=jnhfGl8EfzPq2nF6UgeuHjSRWLSF5pm9Qe6BB3/+HxI=;
        b=LyzhP+sXk/20rbsXi5rVpj+itglQQD2WmjMQ1V5wKwN0mjJ8HqMW6SJwBQM/G66YW+
         Q8Sk2gn7Sse6v6c8cEuNqna0WY8yb/OJRHG/b5ZPfhap7o5U2FZgVBN7kwonPjIE31BG
         5kyT3svoi1DRZAYooJpYc6kptj48H9VkZTAtFUq15If9w8fU5OjLKlSfcMBAUVLR5JUM
         zyuWY7//cpqnLY7EMlQm8y7mGlr742QoRHHSpPpBcvJqTsFRLo7B0+3EmJtnaRoJ7zkz
         Q0DBg+PapojlDQSWdtNOa1s8vBktl8rLglOUugekhzWtTtd6reqYzifjdt+JVIWsxjlD
         t7jQ==
X-Received: by 10.31.56.18 with SMTP id f18mr559443vka.19.1449030489433; Tue,
 01 Dec 2015 20:28:09 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Dec 2015 20:28:09 -0800 (PST)
In-Reply-To: <1448883653-9140-1-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: x-ESIAObAMR6hWc0uiQfYS9Cklw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281879>

On Mon, Nov 30, 2015 at 6:40 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> The error message after a failing commit_lock_file() call sometimes
> looks like this, causing confusion:
>
>   $ git remote add remote git@server.com/repo.git
>   error: could not commit config file .git/config
>   # Huh?!
>   # I didn't want to commit anything, especially not my config file!
>
> While in the narrow context of the lockfile module using the verb
> 'commit' in the error message makes perfect sense, in the broader
> context of git the word 'commit' already has a very specific meaning,
> hence the confusion.
>
> Reword these error messages to say "could not write" instead of "coul=
d
> not commit".
>
> While at it, include strerror in the error messages after writing the
> config file or the credential store fails to provide some information
> about the cause of the failure, and update the style of the error
> message after writing the reflog fails to match surrounding error
> messages (i.e. no '' around the pathname and no () around the error
> description).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
> diff --git a/config.c b/config.c
> @@ -64,7 +64,8 @@ static void rewrite_credential_file(const char *fn,=
 struct credential *c,
>                 print_line(extra);
>         parse_credential_file(fn, c, NULL, print_line);
>         if (commit_lock_file(&credential_lock) < 0)
> -               die_errno("unable to commit credential store");
> +               die_errno("unable to write credential store: %s",
> +                         strerror(errno));

Hmm, this is already calling die_errno(), so adding another strerror()
to the mix seems superfluous.

>  }
>
>  static void store_credential_file(const char *fn, struct credential =
*c)
> diff --git a/fast-import.c b/fast-import.c
> @@ -1824,7 +1824,7 @@ static void dump_marks(void)
>
>         dump_marks_helper(f, 0, marks);
>         if (commit_lock_file(&mark_lock)) {
> -               failure |=3D error("Unable to commit marks file %s: %=
s",
> +               failure |=3D error("Unable to write file %s: %s",
>                         export_marks_file, strerror(errno));

Since you're already doing some normalization of the error messages
with this patch, do you want to drop capitalization on this one?

>                 return;
>         }
