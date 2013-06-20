From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] peel_onion(): add support for <rev>^{tag}
Date: Thu, 20 Jun 2013 22:44:27 +0530
Message-ID: <CALkWK0n5NMBFC_eE8V_Avy57RrBOgDuUs+V_VMvNY6VkBBZyBQ@mail.gmail.com>
References: <1371605946-32565-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 19:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpiS3-00015O-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 19:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276Ab3FTRPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 13:15:09 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64496 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965198Ab3FTRPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 13:15:08 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so16936181iea.39
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pqd6mUC+CnMFpK7iVRS1OPICn8S18T+DYU4gfPQJ+6U=;
        b=ylh9rNzNHXsSfv5yrJPEma4oi+G1A6ZJvPny6nijyXI4/V6zXMWhmMjD+qsmRQovag
         0AEgwvjfHnDePW/WZ+mN7TCb8RIU1n2ytmL7cD1Z3UXkSlPQiqb74Mb09wo22IUCPpqA
         qJo48p1mWsegsx6Wh2ya9t/trHp53sAxrU6FODHsyCijgYeG9bMKK/ALPRqX7OI/ux5y
         tZa7GTPV+8PX22DwatcKmkNWPYoOjmiTHXSvQA8baOIRI1AhPGuJvMWpiVx0TuQhLW3r
         SGSRnyq7BUYKgIVDYR6/swKXftfF1zOyIHH2bG0Eh2B9nf85RX1zEkOI9qHsjqAH3QzC
         LZBA==
X-Received: by 10.50.66.130 with SMTP id f2mr157520igt.55.1371748507913; Thu,
 20 Jun 2013 10:15:07 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 10:14:27 -0700 (PDT)
In-Reply-To: <1371605946-32565-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228514>

Richard Hansen wrote:
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -677,6 +677,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>         sp++; /* beginning of type name, or closing brace for empty */
>         if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
>                 expected_type = OBJ_COMMIT;
> +       else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
> +               expected_type = OBJ_TAG;

Interesting.

> gitrevisions(7) implies that <rev>^{tag} should work, but before now
> it did not:

The wording (especially of <rev>^{}) special-cases tags as "objects to
dereference".

>     $ git rev-parse --verify v1.8.3.1^{}^{object}
>     362de916c06521205276acb7f51c99f47db94727
>     $ git rev-parse --verify v1.8.3.1^{}^{tag}
>     error: v1.8.3.1^{}^{tag}: expected tag type, but the object dereferences to tree type
>     fatal: Needed a single revision

And the points out the problem: while ^{object} means "expect
OBJ_ANY", ^{} means "expect OBJ_NONE".  What does that even mean?  See
sha1_name.c:704 where this is handled sneakily: it just calls
deref_tag(), bypassing peel_to_type() altogether.  If anything, ^{} is
already a poor-man's version of your ^{tag}; the reason it's a
poor-man's version is precisely because it doesn't error out when
<rev> isn't a tag, while your ^{tag} does.  I would argue that ^{} is
very poorly done and must be deprecated in favor of your ^{tag}.  What
is the point of using ^{} if you can't even be sure that what you get
is a deref?  peel_to_type() already does the right thing by not using
deref_tag(), and explicitly checking.

Your commit message needs some tweaking, but I'm happy with your patch
otherwise.

Thanks.
