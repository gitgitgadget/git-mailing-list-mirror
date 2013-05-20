From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 16/17] object_array_entry: copy name before storing in name field
Date: Mon, 20 May 2013 12:33:06 +0200
Message-ID: <CALKQrgeZ3yOogZhumQ6sQ=7B4XoEUDxPNt6Lj7ZAs13oJTOeUA@mail.gmail.com>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 20 12:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeNP3-0004ll-2H
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 12:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3ETKdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 06:33:13 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:60650 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3ETKdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 06:33:12 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeNOw-00094n-Km
	for git@vger.kernel.org; Mon, 20 May 2013 12:33:10 +0200
Received: from mail-ob0-f177.google.com ([209.85.214.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeKrv-00073Y-8C
	for git@vger.kernel.org; Mon, 20 May 2013 09:50:55 +0200
Received: by mail-ob0-f177.google.com with SMTP id wn6so6709557obc.36
        for <git@vger.kernel.org>; Mon, 20 May 2013 03:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gRiStQKQ2ZF5jpsb4+VdEmM6Zbg1Gnj+LukJKcdtgaQ=;
        b=pgwauWmLC1WmHgBH0pQZwAuvEm29hzMkPAWi/Sy57Un46SZtlH5N/q8Il42FWZUoNR
         YpxCJniwix1iKVt8r2WepmoVbkRDj3vgjceEN0OqzAqPLLQAHpKJoYDNfVHjbU6Lk0v8
         KcC0rI2hyANZUCie6iCqhtvlKXF2R/YQMJrl/UjFkR4dX7O/NJJbJCxwJGDpqG9tsM0i
         +kYaKc8vOsDDtB7k0O2Ggh+H1gITJxUULcihweur4z0A9F3psslvQlTcOPW2shm6oXfr
         h4Sq+pdP+effNNofEnwuPs1csnOGoHj/DKHtUfjVHqJPTmqO6pELlU0KqFonB4LBShX2
         vV/Q==
X-Received: by 10.182.16.170 with SMTP id h10mr8493687obd.17.1369045986884;
 Mon, 20 May 2013 03:33:06 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 03:33:06 -0700 (PDT)
In-Reply-To: <1368995232-11042-17-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224954>

On Sun, May 19, 2013 at 10:27 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is the culmination of the last few commits.  Since some callers
> want to store refnames in the name field of object_array elements, but
> we don't want those callers to assume that the refnames that they got
> from for_each_ref() have infinite lifetime, the easiest thing to do is
> have object_array make a copy of the names before writing them in the
> entries, and to free the names for entries that are no longer in use.
> This change fixes the problem, but has some disadvantages:
>
> * It requires extra copies to be made of strings that are already
>   copies, for example when the results of path_name(path, name) are
>   used as a name in revision.c:add_object().  This might be rare
>   enough that it can be ignored (though the original result of
>   path_name() would have to be freed, which this patch doesn't do so
>   there is a memory leak).
>
> * Many callers store the empty string ("") as the name; for example,
>   most of the entries created during a run of rev-list have "" as
>   their name.  This means that lots of needless copies of "" are being
>   made.  I think that the best solution to this problem would be to
>   store NULL rather than "" for such entries, but I haven't figured
>   out all of the places where the name is used.

Use strbufs?

No allocation (except for the strbuf object itself) is needed for
empty strings, and string ownership and be transferred to and from it
to prevent extra copies.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
