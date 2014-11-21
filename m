From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] prune_remote(): sort delete_refs_list references en masse
Date: Fri, 21 Nov 2014 08:44:40 -0800
Message-ID: <CAPc5daWubo+CSD-C+AH6Y-PKQ7h2MoUU=DbW+nYKO9uceogsAg@mail.gmail.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu> <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 21 17:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrrKY-0002JC-7Q
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 17:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759098AbaKUQpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 11:45:03 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50474 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759094AbaKUQpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 11:45:01 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so5254455pab.0
        for <git@vger.kernel.org>; Fri, 21 Nov 2014 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7G68sm3cOE9mvB3CKdGivmP0u8CNBk5p+vevWRiW3r4=;
        b=e0ND1rdFdESxlTQTcicDmEmY2dmYuTJY8pEif1gqa50Dl+HzltTVTC/uc5CSaXmIV/
         CRLau7NhKhU3nMV1bJf45SlsXuxZF8LuD6F/+fRbwhr9PUF4gwOxJJ07Yxa7Nz5QXDgK
         3Vw+D6GirX412FYGjL+L4EHQP+9a+v2aMPV1bwaZcsOuXiqnjpJ8JFGBOHGoqM9dhZnt
         RvA4kxH5JF/ACcrlC1M6Ezp+MdLBjoSmq0DdPJ9zggvLSjnjkvPRahqiAKkeYdyYBgRH
         dDb2NS4pUmWwpMLahiLnjHQtUvUrMlfdCUWcKEy8HmK3+hP3P+oNZ9mIz/gFKYWi+Jhl
         72vg==
X-Received: by 10.70.128.132 with SMTP id no4mr8718585pdb.125.1416588301046;
 Fri, 21 Nov 2014 08:45:01 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Fri, 21 Nov 2014 08:44:40 -0800 (PST)
In-Reply-To: <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: xOFWTsaBRAkbn4vuV7m0ftHI0o0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 21, 2014 at 6:09 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Inserting items into a list in sorted order is O(N^2) whereas
> appending them unsorted and then sorting the list all at once is
> O(N lg N).
>
> string_list_insert() also removes duplicates, and this change loses
> that functionality. But the strings in this list, which ultimately
> come from a for_each_ref() iteration, cannot contain duplicates.
>

A similar conversion in other places we may do in the future
might find a need for an equivalent to "-u" option of "sort" in the
string_list_sort() function, but the above nicely explains why
it is not necessary for this one.  Good.

Eh, why is that called sort_string_list()?  Perhaps it is a good
opening to introduce string_list_sort(list, flag) where flag would
be a bitmask that represents ignore-case, uniquify, etc., and
then either deprecate the current one or make it a thin wrapper
of the one that is more consistently named.


> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index d5a5a16..7d5c8d2 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1341,8 +1341,9 @@ static int prune_remote(const char *remote, int dry_run)
>                 const char *refname = states.stale.items[i].util;
>
>                 delete_refs[i] = refname;
> -               string_list_insert(&delete_refs_list, refname);
> +               string_list_append(&delete_refs_list, refname);
>         }
> +       sort_string_list(&delete_refs_list);
>
>         if (!dry_run) {
>                 struct strbuf err = STRBUF_INIT;
> --
> 2.1.3
>
