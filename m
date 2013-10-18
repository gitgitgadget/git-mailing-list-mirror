From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 20:55:06 +0700
Message-ID: <CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 15:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXAWk-0004JT-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 15:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab3JRNzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 09:55:38 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63918 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab3JRNzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 09:55:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so2712877oah.5
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QmwBEvHAU0HbGtDWLrhRpOJFL645YyS3wCgBsELmdr0=;
        b=wDn9r+WMM1K9tYH3Rdkmd5yUwMjoWrnqlsM3hftp98ugn4P76YQFDoEDzaDvXoZPUM
         H2XDCXoL/ZaKlnlf4v7xNPJIkQSbORLkRQDTkJkRxupceLY1dJnDs9NgxXHo6dMCUhRO
         AEjJwmIRebodKl8zEi3xwhkqk/X0WeE4+89J8hlL8Vees1AyqQFkw6bbq6awjezb8vmb
         TABZQilUv9tBLGKdmyWiC5Ovj1nkgTqGvxKNIdNrTgpOEDezAAdeC3ADwum8pcQXbdpR
         KxgBqD9lPsXoo8+BAxeawXwYkCHhcfacR8sdM35RrXt+aA3DhPX9hrXrmG5oTCC6RJmt
         b6TQ==
X-Received: by 10.182.75.201 with SMTP id e9mr4958093obw.28.1382104536498;
 Fri, 18 Oct 2013 06:55:36 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Fri, 18 Oct 2013 06:55:06 -0700 (PDT)
In-Reply-To: <1382102267-18151-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236351>

On Fri, Oct 18, 2013 at 8:17 PM, Johan Herland <johan@herland.net> wrote:
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

I was going to ask what if the created directory does not have
permission 0777. But adjust_shared_perm follows immediately after, so
we're good. It also answers the question why "mkdir(buffer, mode) &&
errno != EEXIST" should not be wrapped in xmkdir() or something to be
used in other places as well. Thanks.
-- 
Duy
