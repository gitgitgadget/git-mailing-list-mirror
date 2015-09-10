From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 08/14] ref-filter: add support for %(contents:lines=X)
Date: Thu, 10 Sep 2015 10:14:24 -0700
Message-ID: <xmqqtwr242of.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:14:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5Qd-0004sY-Nh
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbbIJRO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:14:28 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36075 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbIJRO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:14:27 -0400
Received: by padhk3 with SMTP id hk3so48160495pad.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vxwH3+BSbRXPwOp7Rq+a/ENOM3x0WQ64n8SgqJg1fbw=;
        b=L6KBKNikXcy+zFeuQ1elZ305SxD2kE871wLeUK9cWZWNTjYT+FOVV6M7UkBTq2rZ1/
         vQ41lszUMfYmWgub7bJBLJ3x9RWGkHXbSJHjVABXZQ1F4/1T7CZr8hedZo4Huzakfob7
         3YwrWSueUP9pAPOr2O5L43Mkb0l9iAJ7jlgKU/XGakxCfC7UxsC4JSE+IlZpq0hvE09V
         4p5HCW+WkP8IzIl1BK03SM36KRDdXEpoOGL5iy5NDDnecNnWsTE5Pis7HIspjRM1xt7r
         cT/6EWIAnrssRyp6T5+4pVM7fukP/OuckcmqzBQ/Sg2Ferk1Mw6w8OE3QMl7EGj7hgrj
         j1QQ==
X-Received: by 10.66.164.98 with SMTP id yp2mr74547635pab.58.1441905266312;
        Thu, 10 Sep 2015 10:14:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id sl7sm13077087pbc.54.2015.09.10.10.14.25
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 10 Sep 2015 10:14:25 -0700 (PDT)
In-Reply-To: <1441900110-4015-9-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:18:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277608>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index 7d2732a..b098b16 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -56,6 +56,7 @@ static struct {
>  	{ "color" },
>  	{ "align" },
>  	{ "end" },
> +	{ "contents:lines" },

Do we even need "contents:lines" and existing other "contents:blah"
in this list in the first place?  If they are needed, group them
together, not append at the end.

I wonder how this code sensibly can parse "%(contents:lines=6)".
After splitting the format string at %( and closing ), the code
calls parse_ref_filter_atom() and the rule that helper function uses
to figure out the atom-name proper (which is to be checked against
the valid_atom[] array) is to find the first colon, so

    %(contents:lines=6)

would cause "contents:lines=6" to be fed parse_ref_filter_atom(),
it cheks if "contents" is in the valid_atom[] array (it is), and
stores the whole thing in used_atom[].

So in that sense, match_atom_name() would do the right thing, but
that would make any reader of this code realize that she never saw
"contents:lines" entry in valid_atom[] array being used during this
process.
