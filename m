From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 20:57:27 -0700
Message-ID: <xmqqfv71ceoo.fsf@gitster.dls.corp.google.com>
References: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
	<1431481799-23560-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Wed May 13 05:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsNna-00067p-9c
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 05:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbbEMD5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 23:57:31 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35783 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbbEMD53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 23:57:29 -0400
Received: by igbyr2 with SMTP id yr2so127937626igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 20:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pRrcIWwYltg+q7VJJiU7S7PdGvczYHNbH4k8C4k5jqE=;
        b=j6h2wWlznjAQQLtYl9AH+3qg3SoVImwpgl7ZnlCQUSAJIIUjk6XAOUGEvBm7zm7Cws
         NIyDxdXYgpVPjD5ljobVjJ8AfDk9CLcyU1Tgn8oaXfoAMziS5Vi+UepwX4wtABU95UT9
         Uu0ptIZ3s7EtE/GmxJCNAyCraETbfsdiozJFjO9uzKKuIYdGzNkdxOAk5XMlLjHAI+Vv
         frPbY+m0uHv+I9EcI87QIoKJ8YmENRpHMYwHBzDrZhZHw11X1awmP8Y3aTknBECXXcip
         rR/wuCoXeiiJZz0ypPvTphL2xlVWe9Fanp/jsD19AQSOEavuAquSIIFrouXhP5VeemcT
         22BQ==
X-Received: by 10.43.6.65 with SMTP id oj1mr6544260icb.75.1431489448868;
        Tue, 12 May 2015 20:57:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id o21sm13401945ioo.31.2015.05.12.20.57.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 20:57:28 -0700 (PDT)
In-Reply-To: <1431481799-23560-4-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Tue, 12 May 2015 21:49:59
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268921>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> This wires the in-repo-symlink following code through to the cat-file
> builtin.  In the event of an out-of-repo link, cat-file will print
> the link in a new format.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

Thanks.

> +--follow-symlinks::
> +	With --batch or --batch-check, follow symlinks inside the
> +	repository when requesting objects with extended SHA-1
> +...
> +	printed.
> +[normal]
> +	This option does not (currently) work correctly when an

Nice; didn't realize that "[normal]" trick would work, but why not.

> +	object in the index is specified (e.g. `:link` instead of
> +	`HEAD:link`) rather than one in the tree.
> +[normal]
> +	This option cannot be used unless `--batch` or `--batch-check`
> +	is used, because it would be impossible to distinguish between
> +	the output for an out-of-repo symlink, and the contents of a
> +	blob.
> +
> +For example, consider a git repository containing:

... but I am not sure about this paragraph.  Does it align and look
to be at the same level as the first paragraph that begins with
"With `--batch` or `--batch-check`" (asking because I do not have an
access to a good environment to check the resulting HTML easily
right now)?

> +	result = get_sha1_with_context(obj_name, flags, data->sha1, &ctx);
> +	if (result != FOUND) {
> +		switch(result) {

	switch (result) {

> +		case MISSING_OBJECT:
> +			printf("%s missing\n", obj_name);
> +			break;
> +		case DANGLING_SYMLINK:
> +			printf("dangling %"PRIuMAX"\n%s\n", strlen(obj_name),
> +			       obj_name);
> +			break;
> +		case SYMLINK_LOOP:
> +			printf("loop %"PRIuMAX"\n%s\n", strlen(obj_name),
> +			       obj_name);
> +			break;
> +		case NOT_DIR:
> +			printf("notdir %"PRIuMAX"\n%s\n", strlen(obj_name),
> +			       obj_name);
> +			break;

Don't all these lengths need to be cast to uintmax_t, like the
"symlink" one below?

By the way, I noticed that my compiler is so stupid that it does not
realize this "switch (result)" is inside "if (result != FOUND)" and
missing "case FOUND:" is perfectly fine.  The remainder of the code
I have been compiling with -Wswitch, but this one makes me to drop
it.

> +		}
> +		fflush(stdout);
> +		return 0;
> +	}
> +
> +	if (ctx.mode == 0) {
> +		printf("symlink %"PRIuMAX"\n%s\n",
> +		       (uintmax_t)ctx.symlink_path.len,
> +		       ctx.symlink_path.buf);
>  		fflush(stdout);
>  		return 0;
