From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/17] strbuf: add strbuf_isspace()
Date: Thu, 30 Jan 2014 21:51:15 -0500
Message-ID: <CAPig+cTyAMimdvzbX8hCHQfdd-DPKt4N8LThfYmRbvjeDk6adg@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.74582.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 03:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W94Ck-0007qQ-50
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 03:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbaAaCvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 21:51:17 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:43838 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbaAaCvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 21:51:16 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so20769336ykq.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 18:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W8auEBjmlEgdaaaE23npoFKxfbvKvMFLIkAMxjT0pRw=;
        b=M8ZM82UQtbgNDFYDJAtQKfvcJgodO0GJed/ihzrR8k3PNAlvT0xaM/1BcdZGssd1+k
         tz9eGeqV2IdZ4dZGCN6aQGcUQIrVmxLjk1r6DH5kKWqFV+DCZQdFOkTPa7q3D1CvY2K3
         /tuvPCyZs5cs8PTnD2842XaD5PDavlzbshFtpQFPfVWynYQsDOcBNldZYYYM4eP0Zbyi
         sIneVKV3zYsx6vTV0MqTihceJUaxAD17yPGIzlss1WkTaPjdiYLZKfIJvJ+BbNIQerpL
         3Y0dwug37+tqi2E6U6MczOpNsrNDGwpAJkwla97XMIb2zADZjSDzk9VrRDQm2MaSQYLe
         oKvA==
X-Received: by 10.236.100.173 with SMTP id z33mr16921711yhf.9.1391136675814;
 Thu, 30 Jan 2014 18:51:15 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Thu, 30 Jan 2014 18:51:15 -0800 (PST)
In-Reply-To: <20140130064921.7504.74582.chriscool@tuxfamily.org>
X-Google-Sender-Auth: ARYA_MnDPQy95XO7gbedjvUMyJM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241289>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This helper function checks if a strbuf
> contains only space chars or not.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/strbuf.c b/strbuf.c
> index 83caf4a..2124bb8 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -124,6 +124,13 @@ void strbuf_ltrim(struct strbuf *sb)
>         sb->buf[sb->len] = '\0';
>  }
>
> +int strbuf_isspace(struct strbuf *sb)
> +{
> +       char *b;
> +       for (b = sb->buf; *b && isspace(*b); b++);

Quoting from the strbuf documentation:

    ... strbufs may have embedded NULs. An strbuf is NUL
    terminated for convenience, but no function in the
    strbuf API actually relies on the string being free of
    NULs.

So, the termination condition (*b) of this loop is questionable.
Looping from 0 to < sb->len makes more sense.

> +       return !*b;

Ditto for the return. This will incorrectly return 'true' if an
embedded NUL is encountered.

> +}
> +
>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>                                  int terminator, int max)
>  {
