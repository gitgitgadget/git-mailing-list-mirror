From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Sat, 2 Jan 2016 16:06:23 -0800
Message-ID: <20160103000623.GB14424@gmail.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 01:06:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFWCC-000228-97
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jan 2016 01:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbcACAGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 19:06:31 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35866 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcACAGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 19:06:30 -0500
Received: by mail-ob0-f172.google.com with SMTP id ba1so226294136obb.3
        for <git@vger.kernel.org>; Sat, 02 Jan 2016 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2hHKPEKm2TED6I31RCii1ckGQgiEOv/8aXXfHf5+S0k=;
        b=zgaYnE5TSq9qnRwMb+Mj64Ex5qXWf31iAhRONboQsNgoqzLc/DUowO/gB+kpXpYxcX
         iwfJsGtESJ9gC5Ln0mVKf1ffVumLZ2B/cQRsf+ioE6FPHIEieQN8QILVUzk3HH8tTQua
         /omHOP+FF/x8yr3DVEjDmC+9ehwagfU6MqVwFA2kvpNzKUK7ZtjP4GmF+Fw4Z2pK1Nnj
         fHYOwtP5OEjuxnvkXGiGbSkqMZ7ZPcnBxUHjr9PBemSie3aofWeUlmInDCCvxmBtHTME
         K0alJGGLer+lRGB4Zs2qBHuk9d0oGB67bHFsVclBt5lnRSAtph4Tqw8JrtoBTF8A0XLA
         3fRQ==
X-Received: by 10.60.63.138 with SMTP id g10mr44980193oes.58.1451779589425;
        Sat, 02 Jan 2016 16:06:29 -0800 (PST)
Received: from gmail.com ([32.150.217.149])
        by smtp.gmail.com with ESMTPSA id k1sm10583978obz.22.2016.01.02.16.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jan 2016 16:06:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449102921-7707-4-git-send-email-dturner@twopensource.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283271>

Apologies for the late review, and this review should probably
go on patch 01 or 02 but I don't have it in my mbox atm...

On Wed, Dec 02, 2015 at 07:35:08PM -0500, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
>  refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
>  3 files changed, 112 insertions(+), 12 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 9562325..b9b0244 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1150,3 +1150,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
>  {
>  	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
>  }
> +
> +int head_ref(each_ref_fn fn, void *cb_data)
> +{
> +	return the_refs_backend->head_ref(fn, cb_data);
> +}

My only comment is that it seems like having a single static global
the_refs_backend seems like it should be avoided.

It seems like the intention was to keep the existing interface
as-is, which explains why this is using globals, but it seems
like the refs backend should be part of some "application
context" struct on the stack or allocated during main().  It can
then be passed around in the API so that we do not need to have
a global.

That way the code will not be tied to a specific single
the_refs_backend and could in theory have multiple backends
working at the same time.  If submodule were ever rewritten in C
then this could potentially be a useful feature.

That said, the refs backend is not the only global static data
in git that would need to be factored out, but it wouldn't hurt
to make this part a little more tidy.

Thoughts?
-- 
David
