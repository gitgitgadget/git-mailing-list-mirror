From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 12/19] fsck: Disallow demoting grave fsck errors to warnings
Date: Fri, 19 Jun 2015 13:21:18 -0700
Message-ID: <xmqqa8vv78ld.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<c87d71326fc75773f137eee0ef6a8964645f0b74.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:21:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62mz-0002zb-Br
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbbFSUVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:21:22 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33242 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbFSUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:21:20 -0400
Received: by igbqq3 with SMTP id qq3so24502387igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=v0c1cbYZM4JsxFPalOln0RUWEcAtPJDCTZhLy9QUBWw=;
        b=npLwZz3c3Z3NervXc65L2RpHDe1BMV9C7qt5P4aOA+Z1txaOiqkjOSmZGF+Cu7hTGb
         Dwww22BJbOlSBC7kmwchTZvJN9rABKseGvA0Gl68gU2dOIpH3ui5/mLtYkfj9Lk5eLK7
         8BYcKjYyRHJm2kCuvaVaskGyqIpJsE/BUENQGvo3zB7lgRNiTOLRuDnTD3ybobanDdP1
         fNIWCuldjglUm8YHbqrutD6gziU7C9rueTQttL5k+wxojK0Br6xtxQMv6bJ07jyD0Eqs
         kLxRfi2no/1vPMudagy5sGbB6ov1ZgNkM4uUSlS2647jkroqpyfuNo6ZIcvBDmShoS4w
         mJig==
X-Received: by 10.107.138.201 with SMTP id c70mr24676302ioj.24.1434745279720;
        Fri, 19 Jun 2015 13:21:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id d4sm2375831igl.1.2015.06.19.13.21.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:21:19 -0700 (PDT)
In-Reply-To: <c87d71326fc75773f137eee0ef6a8964645f0b74.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:34:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272196>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Some kinds of errors are intrinsically unrecoverable (e.g. errors while
> uncompressing objects). It does not make sense to allow demoting them to
> mere warnings.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c                          | 14 ++++++++++++--
>  t/t5504-fetch-receive-strict.sh | 11 +++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 21e3052..a4fbce3 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -9,7 +9,12 @@
>  #include "refs.h"
>  #include "utf8.h"
>  
> +#define FSCK_FATAL -1
> +
>  #define FOREACH_MSG_ID(FUNC) \
> +	/* fatal errors */ \
> +	FUNC(NUL_IN_HEADER, FATAL) \
> +	FUNC(UNTERMINATED_HEADER, FATAL) \
>  	/* errors */ \
>  	FUNC(BAD_DATE, ERROR) \
>  	FUNC(BAD_DATE_OVERFLOW, ERROR) \
> @@ -39,11 +44,9 @@
>  	FUNC(MISSING_TYPE, ERROR) \
>  	FUNC(MISSING_TYPE_ENTRY, ERROR) \
>  	FUNC(MULTIPLE_AUTHORS, ERROR) \
> -	FUNC(NUL_IN_HEADER, ERROR) \
>  	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
>  	FUNC(TREE_NOT_SORTED, ERROR) \
>  	FUNC(UNKNOWN_TYPE, ERROR) \
> -	FUNC(UNTERMINATED_HEADER, ERROR) \

I think the end result very much makes a good sense, but why didn't
this list enumerate the errors in the above "final" order from the
beginning in 02/19?
