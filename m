From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] lookup_commit_reference_gently: do not read non-{tag,commit}
Date: Fri, 31 May 2013 12:13:00 +0530
Message-ID: <CALkWK0nL4hPio74Hm+ctObNNFg9+=9brKXFK2ymGB=sPTAk1Hg@mail.gmail.com>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
 <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 31 08:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJ3x-0005zT-O4
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab3EaGnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:43:42 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58800 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3EaGnl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:43:41 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so3078945iea.3
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8Kgjo/hxDPWNYiinxFSE3OqBHhvXm0rfBDgO/bo74k8=;
        b=gDr6zpiy71E+SJuy50GiBgfDAPVAQztk6LSvZ4Z5GiKPJvRjxW/IaRH/MJgp6FWe/Q
         UduqBLb53P3UyvPKSb5zrzD11yLlfIbytQbcdppQLKxaCJUw1TkslcYSx74tluKyLfUD
         L5ciNz8wYZ1I8+8SqL1KcGsDyUeR8J6XDfLAYmIrkyPYoGaUfcHUJ/Td65las7mdq3ao
         sYcvgrzadS2ul4rKQG87o1BKcm8Y3Bm0CKmNDjdxrHbOjc2RqC6rGUotDT/xR37BgcAJ
         UAtfm50Ha0wF9lxPQ9e3VEmtohSSa1WCDDG+U6n2tlXp5RkJIUZKF+hprAe4TU2uTH1q
         ko7Q==
X-Received: by 10.50.153.6 with SMTP id vc6mr1015000igb.57.1369982620605; Thu,
 30 May 2013 23:43:40 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Thu, 30 May 2013 23:43:00 -0700 (PDT)
In-Reply-To: <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226049>

Thomas Rast wrote:
> diff --git a/commit.c b/commit.c
> index 888e02a..00e8d4a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -31,8 +31,12 @@ static struct commit *check_commit(struct object *obj,
>  struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
>                                               int quiet)
>  {
> -       struct object *obj = deref_tag(parse_object(sha1), NULL, 0);
> -
> +       struct object *obj;
> +       int type = sha1_object_info(sha1, NULL);
> +       /* If it's neither tag nor commit, parsing the object is wasted effort */
> +       if (type != OBJ_TAG && type != OBJ_COMMIT)
> +               return NULL;
> +       obj = deref_tag(parse_object(sha1), NULL, 0);
>         if (!obj)
>                 return NULL;
>         return check_commit(obj, sha1, quiet);

As Jeff points out, you've introduced an extra sha1_object_info() call
in the common case of tag (which derefs into a commit anyway) and
commit slowing things down.

So, my main doubt centres around how sha1_object_info() determines the
type of the object without actually parsing it.  You have to open up
the file and look at the fields near the top, no? (or fallback to blob
failing that).  I am reading it:

1. It calls sha1_loose_object_info() or sha1_packed_object_info(),
depending on whether the particular file is in-pack or not.  Lets see
what is common between them.

2. The loose counterpart seems to call unpack_sha1_header() after
mmap'ing the file.  This ultimately ends up calling
unpack_object_header_buffer(), which is also what the packed
counterpart calls.

3. I didn't understand what unpack_object_header_buffer() is doing.
And'ing with some magic 0x80 and shifting by 4 bits iteratively? type
= (c >> 4) & 7?

In contrast, parse_object() first calls lookup_object() to look it up
in some hashtable to get the type -- the packfile idx, presumably?
Why don't you also do that instead of sha1_object_info()?  Or, why
don't you wrap parse_object() in an API that doesn't go beyond the
first blob check (and not execute parse_object_buffer())?

Also, does this patch fix the bug Alex reported?

Apologies if I've misunderstood something horribly (which does seem to
be the case).

Thanks.
