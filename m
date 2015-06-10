From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] tempfile: a new module for handling temporary files
Date: Wed, 10 Jun 2015 10:36:33 -0700
Message-ID: <xmqqy4jrlb32.fsf@gitster.dls.corp.google.com>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
	<f7681cfc8ee4f1f5eba50f315f8e0ed0fed883a8.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2jvc-0006js-US
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbbFJRgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:36:37 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34138 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbFJRgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:36:35 -0400
Received: by iebmu5 with SMTP id mu5so39297258ieb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xPgELW6NR+ZTQFvAEMiU9zunwRDvxXs7x/dOLSHLfdE=;
        b=St/kC90/r/kq0GxLpDVSAwlPOV5jKYNKfkYjm/i7JGgxW52tXG/DRbod32/9ml7ep1
         e8SsydT7ua6i/a839TTzyX3zwOuHxNk1okI9f6bjZSHKbVyvGLHo1ZdZ19lrBVQ4KfCq
         XDnP6ZJuGnltagGo5LvSnkISOZpWTsutYEzjHyPz6YlG1yq9dSv7JQ6QwTNV+LreQylX
         9DJTRxSn/lvUaY63/3tMCK1M0Dj4dpfLr9KYq9KtlmwCAgG3wrWy/QfhZRtXzZtUZNwC
         oeJ9vIpO9hjtOe/Vk7xC0G/27FIfUg6KqSOmYl7L5W0RFZ7UeBABQqcZOnoY5jtut9PN
         v4jQ==
X-Received: by 10.107.152.14 with SMTP id a14mr5652140ioe.92.1433957794572;
        Wed, 10 Jun 2015 10:36:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id k81sm6413119iod.31.2015.06.10.10.36.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 10:36:34 -0700 (PDT)
In-Reply-To: <f7681cfc8ee4f1f5eba50f315f8e0ed0fed883a8.1433751986.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 8 Jun 2015 11:07:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271331>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> diff --git a/builtin/add.c b/builtin/add.c
> index df5135b..aaa9ce4 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -5,6 +5,7 @@
>   */
>  #include "cache.h"
>  #include "builtin.h"
> +#include "tempfile.h"
>  #include "lockfile.h"
>  #include "dir.h"
>  #include "pathspec.h"

It is a bit sad that all users of lockfile.h has to include
tempfile.h; even when trying to find out something as basic as the
name of the file on which the lock is held, they need to look at
lk->tempfile.filename and that requires inclusion of tempfile.h

It is a good idea to have tempfile as a separate module, as it
allows new callers to use the same "clean-on-exit" infrastructure on
things that are not locks, i.e. they can include tempfile.h without
having to include lockfile.h, but I have to wonder if it is better
to include tempfile.h from inside lockfile.h (which is alrady done)
and allow users of lockfile API to assume that inclusion will always
stay there.  After all, if they are taking locks, they already know
lk->tempfile is the mechanism through which they need to learn about
various aspects of the underlying files.

> @@ -101,60 +72,17 @@ static void resolve_symlink(struct strbuf *path)
>  /* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
> ...
> +	int fd;
> +	struct strbuf filename = STRBUF_INIT;
>  
> -	if (flags & LOCK_NO_DEREF) {
> -		strbuf_add_absolute_path(&lk->filename, path);
> -	} else {
> -		struct strbuf resolved_path = STRBUF_INIT;
> +	strbuf_addstr(&filename, path);
> +	if (!(flags & LOCK_NO_DEREF))
> +		resolve_symlink(&filename);
>  
> -		strbuf_add(&resolved_path, path, pathlen);
> -		resolve_symlink(&resolved_path);
> -		strbuf_add_absolute_path(&lk->filename, resolved_path.buf);
> -		strbuf_release(&resolved_path);
> -	}
> ...
> -	return lk->fd;
> +	strbuf_addstr(&filename, LOCK_SUFFIX);
> +	fd = create_tempfile(&lk->tempfile, filename.buf);
> +	strbuf_release(&filename);
> +	return fd;
>  }

This was the only part of this entire patch that needed more than
cursory reading ;-) and it looks correct.

Thanks.
