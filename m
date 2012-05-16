From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] diff --no-index: reset temporary buffer lengths on directory
 iteration
Date: Wed, 16 May 2012 08:33:38 +0200
Message-ID: <4FB34A42.60300@lsrfire.ath.cx>
References: <1337141693-3515-1-git-send-email-bobbypowers@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bobby Powers <bobbypowers@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 08:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUXo9-0007zf-2C
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 08:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759169Ab2EPGdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 02:33:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:60692 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759160Ab2EPGdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 02:33:41 -0400
Received: from [192.168.2.105] (p4FFD98A9.dip.t-dialin.net [79.253.152.169])
	by india601.server4you.de (Postfix) with ESMTPSA id 09EB02F806F;
	Wed, 16 May 2012 08:33:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337141693-3515-1-git-send-email-bobbypowers@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197866>

Am 16.05.2012 06:14, schrieb Bobby Powers:
> Commit 875b91b3 introduced a regression when using diff --no-index
> with directories.  When iterating through a directory, the switch to
> strbuf from heap-allocated char arrays caused paths to form like
> 'dir/file1', 'dir/file1file2', rather than 'dir/file1', 'dir/file2' as
> expected.  By resetting the length on each iteration (but not
> buf.alloc), we avoid this.
>
> Signed-off-by: Bobby Powers <bobbypowers@gmail.com>
> ---
>  diff-no-index.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Nice catch!  Could you please also add a test case so that we can be 
sure a similar bug is not reintroduced later?

> diff --git a/diff-no-index.c b/diff-no-index.c
> index b44473e..bec3ea4 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -67,7 +67,7 @@ static int queue_diff(struct diff_options *o,
>  		struct strbuf buffer2 = STRBUF_INIT;
>  		struct string_list p1 = STRING_LIST_INIT_DUP;
>  		struct string_list p2 = STRING_LIST_INIT_DUP;
> -		int i1, i2, ret = 0;
> +		int len1 = 0, len2 = 0, i1, i2, ret = 0;
>
>  		if (name1 && read_directory(name1, &p1))
>  			return -1;
> @@ -80,18 +80,23 @@ static int queue_diff(struct diff_options *o,
>  			strbuf_addstr(&buffer1, name1);
>  			if (buffer1.len && buffer1.buf[buffer1.len - 1] != '/')
>  				strbuf_addch(&buffer1, '/');
> +			len1 = buffer1.len;
>  		}
>
>  		if (name2) {
>  			strbuf_addstr(&buffer2, name2);
>  			if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
>  				strbuf_addch(&buffer2, '/');
> +			len2 = buffer2.len;
>  		}
>
>  		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
>  			const char *n1, *n2;
>  			int comp;

If you declare len1 and len2 right here at the start of the loop and 
reset the strbufs at its end, you wouldn't have to initialize them to 
zero and they'd have the right scope for their task.

Using type size_t, the type used in struct strbuf, is more correct.

>
> +			buffer1.len = len1;
> +			buffer2.len = len2;

It's cleaner to use strbuf_setlen() instead of setting the len member 
directly.

Looking at the code, I think the strbufs are never freed and the 
strbuf_reset() calls after the loop should be replaced by ones to 
strbuf_release() in order to avoid leaking.  This is a different issue, 
but would be nice to squash as well.

> +
>  			if (i1 == p1.nr)
>  				comp = 1;
>  			else if (i2 == p2.nr)
> -- 1.7.10.2
>
