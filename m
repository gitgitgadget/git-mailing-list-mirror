From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/5] refs.c: make @ a pseudo-ref alias to HEAD
Date: Wed, 1 May 2013 13:20:38 -0500
Message-ID: <CAMP44s3nzuecoM+h+pNknV4A68R1gZ6DZpehp3uKcJhppXo+1w@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbe0-0003oa-KR
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab3EASUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:20:41 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35640 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3EASUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:20:40 -0400
Received: by mail-la0-f53.google.com with SMTP id eg20so1519050lab.26
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tWzW9rNWkIllbXHNjSn5YPqs7IL4vVTUcO5gnzyb/Zo=;
        b=VrnromUa8Zvd+IwEqI+OHaBZ3a3exPfeYP9fUMdTAfZlPJXYz9xXew4cODUNTfeinq
         RcCNL849x1MJ+8Cisqxa2avKw0xYyS4//OTFyWsLet6RXI2/xB/qLHauLKwNUg20k8pI
         s58/+c3JkZyxLQbaW3U88aNlT4+Ux45g9LssOXCp6N1DGYGMIMkGouUBWHJS0mrNs17j
         bjbxreELHCdHVOseCzf0FzXH46q0YnehjTbwSAC783Y8S38Z2elYFmgU8cgi+og0otk1
         MlUp1Iata31blcHR/Qr1qoh5DPmatFFUCiv0BD8EEoIi8F26xm3oNRnJV8SoP7uc/SO6
         8i2A==
X-Received: by 10.112.135.70 with SMTP id pq6mr1544797lbb.82.1367432438542;
 Wed, 01 May 2013 11:20:38 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 11:20:38 -0700 (PDT)
In-Reply-To: <1367425235-14998-6-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223110>

On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> First, make sure that check_refname_format() rejects the a refname
> beginning with a '@'.  Add a test to t1400 (update-ref) demonstrating
> that update-ref forbids the user from updating a ref named "@".
>
> Now, resolve_ref_unsafe() is built to resolve any refs that have a
> corresponding file inside $GITDIR.  Our "@" ref is a special
> pseudo-ref and does not have a filesystem counterpart.  So,
> hard-interpret "@" as "HEAD" and resolve .git/HEAD as usual.  This
> means that we can drop the 'git symbolic-ref @ HEAD' line in t1508
> (at-combinations), and everything will continue working as usual.
>
> If the user does manage to create a '.git/@' unsafely (via
> symbolic-ref or otherwise), it will be ignored.
>
> In practice, this means that you will now be able to do:
>
>     $ git show @~1
>     $ git log @^2
>
> Advertise these features in the tests and documentation.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-check-ref-format.txt |  2 ++
>  Documentation/revisions.txt            |  8 ++++++--
>  refs.c                                 | 12 ++++++++++--
>  t/t1400-update-ref.sh                  |  3 +++
>  t/t1508-at-combinations.sh             |  7 ++++---
>  5 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
> index ec1739a..3de9adc 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -52,6 +52,8 @@ Git imposes the following rules on how references are named:
>
>  . They cannot end with a dot `.`.
>
> +. They cannot be the single character `@`.
> +
>  . They cannot contain a sequence `@{`.
>
>  . They cannot contain a `\`.
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index d477b3f..9b2e653 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -27,6 +27,10 @@ blobs contained in a commit.
>    When ambiguous, a '<refname>' is disambiguated by taking the
>    first match in the following rules:
>
> +  . '@' is a special pseudo-ref that refers to HEAD.

Does the user really cares if it's a pseudo-ref or not? Also, what
does it mean that "refers" to HEAD?

> An '@' followed
> +    by '\{' has no relationship to this and means something entirely
> +    different (see below).

If the user cares about that, the user can see that below, otherwise
there's no point in mentioning that. Just like there's no point in
mentioning that @{-N} means something totally different from @{N},
because the user can see that. If it didn't mean something different,
this bullet point wouldn't exist.

Cheers.

-- 
Felipe Contreras
