From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] lock_ref_sha1_basic: simplify errno handling
Date: Tue, 18 Nov 2014 17:54:52 -0800
Message-ID: <20141119015452.GQ6527@google.com>
References: <20141119013532.GA861@peff.net>
 <20141119013730.GB2135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:54:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquTw-0006fR-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbaKSByw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:54:52 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:47153 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbaKSByu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:54:50 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so2120219igb.13
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 17:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xekME9VT8rYkNPi1hiWf1WYT0MdNN93J6sKHtXwcaH0=;
        b=ykqWOJi4zktNO6cAhEONy7e+oFuL5ww4rAfFDjMK7jNNVHiL655GX6zP378qgaaqD5
         HV3rIjwOmHXuhW6Lx59VObKGpsurbgxojbHAuGnvKSqJ6vI0/9C9kFEHUGScHpQ/G1ye
         KBX7IUEuWqdogLsTglO6HzOLwOfYHP7ccGDsbTaLMVC0Xk9hAuBXKtCMieplt5y4GeSm
         5Kfv6Ugdsr72+O7z29204uxMP7gUKJVegV5WNuEBhrshB8J/GLchmy/NHRerD6CmtPe/
         9g+aRHfJo/fqaOqc0QnmMzNvURisV0vK1ukrA2ptwrrOhgA9Bq1zXLHzH8xBSF97G3Vx
         EboQ==
X-Received: by 10.42.159.131 with SMTP id l3mr13091icx.65.1416362089937;
        Tue, 18 Nov 2014 17:54:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id i3sm143753iod.19.2014.11.18.17.54.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 17:54:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119013730.GB2135@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Now that error() does not clobber errno, we do not have to
> take pains to save it ourselves.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 5ff457e..169a46d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2232,7 +2232,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,

All the caller to lock_ref_sha1_basic cares about is whether errno ==
ENOTDIR, since in that case we can print a message suggesting running
"git remote prune".

Longer term, I suspect the caller (transaction_commit) should call
is_refname_available to check for conflicting refs and return early to
give "git fetch" a chance to print its advice.

If a conflicting ref appears after that point, then just printing a
reasonable error message is enough --- it is not so useful to give the
'remote prune' advice when people are doing funny things like running
fetch in one terminal and a ref update creating a D/F conflict against
that fetch in another terminal.[*]

By the way, Stefan was mentioning the other day that it might make
sense for transaction_commit to prevent a conflicting ref from
appearing mid-transaction by locking 'refs/heads' in addition to
'refs/heads/master'.

Anyway, in the meantime this is a nice cleanup.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[*] If we want to handle that, the 'struct strbuf *err' could be
replaced with a larger struct with room for structured data, like
Junio was hinting at in another thread.
