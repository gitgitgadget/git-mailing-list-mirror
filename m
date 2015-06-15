From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/12] delete_refs(): improve error message
Date: Mon, 15 Jun 2015 11:29:00 -0700
Message-ID: <xmqq7fr4akr7.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<64949bba1031b19abf86629267b8bc40666a4631.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Z89-0002QC-6y
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbbFOS3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:29:05 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38861 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbbFOS3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:29:03 -0400
Received: by igblz2 with SMTP id lz2so56900816igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UuehloRqYSYG0alW3KtVTohCxRgukq2MPn2jCW2HyCU=;
        b=yW2csLp+odO3Sg5s+BwHrfU6QqNkiRXMGUwC61XmxJQXKoGYn5pB/J+D9+Uo7EK8Pj
         xQDApfJTOlNnUStHxhpj4bHQYYwlDd2f1Kfm3fmsKy3MIDp7s9+eln2/X/RAI0N1Ywo7
         fZAkJB/xSUbzMZu9HrwLrjqX/PBvBAZeXev6giuF1yqYA0wntz/CK7FI5c2QAcv2uvGq
         mSlQ7iz0HONxYHRfiHkZV4tRUcILJ4fhCUsQeV82plub0iETPUh24tuxoaUH4wK7zwIq
         hM6RQx3pVtnacarO45TqGblNxOVqIatC9WPKGVh2yiOW0z7AW9l6rarUFt1fz2FBSx9q
         exHw==
X-Received: by 10.107.152.14 with SMTP id a14mr35013565ioe.92.1434392942244;
        Mon, 15 Jun 2015 11:29:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id f15sm9377016iof.36.2015.06.15.11.29.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:29:01 -0700 (PDT)
In-Reply-To: <64949bba1031b19abf86629267b8bc40666a4631.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271700>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Subject: Re: [PATCH v2 05/12] delete_refs(): improve error message

I'd call this "make error message more generic".

> Change the error message from
>
>     Could not remove branch %s
>
> to
>
>     could not remove reference %s
>
> * s/branch/reference/. This change makes sense even for the existing
>   caller, which uses the function to delete remote-tracking
>   branches.

and replace this bullet with something like:

* Originally 'branch -d' was the only caller of this, but as part
  of the refs API, we will allow it to be called on refs that is not
  a branch or a remote-tracking branch.

as calling a remote-tracking branch a 'branch' is not incorrect
per-se.  What would count as true improvement is ...

> * Convert it to lower case, as per our usual convention.

... this one.  If somebody eventually chooses to make the message
finer grained by switching on the prefix refs/{what}, so that the
user can differentiate between branches, remote-tracking branches,
tags, etc., that would also count as improvement as well.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 6f62bd1..5386077 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2831,7 +2831,7 @@ int delete_refs(struct string_list *refnames)
>  		const char *refname = refnames->items[i].string;
>  
>  		if (delete_ref(refname, NULL, 0))
> -			result |= error(_("Could not remove branch %s"), refname);
> +			result |= error(_("could not remove reference %s"), refname);
>  	}
>  
>  	return result;
