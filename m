From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 04/10] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Sun, 27 Jan 2013 17:24:19 -0800
Message-ID: <20130128012419.GC8206@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-5-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 02:24:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdSq-0001RW-4W
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab3A1BY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:24:27 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40321 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab3A1BY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:24:26 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1193817pad.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FBmd6tiKjVqwdJM1KTtp+Ftf5yTfcuy+4BFjbUFHwEA=;
        b=Sm/2f1BmJkYA8QRsVk8MUmq7ixZ5tfRG6AKmwi0OEUJXih2PrEeZx2H1GKIriv5P2q
         q65QpnI5g0LDXa56+iggtq1ZnPyV8L84207b0GbHBx29oOtOKQY7lIv4Jmaw+K+YAU6d
         eK9Jw+lzRB2JNd6QPGCdAgzPYFmJ4LDiZsHxsVkSK/f7opkDqk2gVwg9cYw1zzLqE2nL
         meJunkkuZdTIw48pgZqwDKjH61OytbURQw4uzKVcxG0qEC843Y1DTKyIM6kPuJR7AN0k
         q1zAB43c7C0ovjCBCsx8POlXmkF2bcVCQGMm2unF+4QCZLubBhBbjvkEN1WPwa1gqJ5g
         LFOA==
X-Received: by 10.68.225.42 with SMTP id rh10mr33485148pbc.145.1359336265525;
        Sun, 27 Jan 2013 17:24:25 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ux4sm5228067pbc.25.2013.01.27.17.24.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:24:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-5-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214780>

Hi,

Brandon Casey wrote:

> Let's detect "(cherry picked from...)" as part of the footer so that we
> will produce this:
>
>    Signed-off-by: A U Thor <author@example.com>
>    (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>    Signed-off-by: C O Mmitter <committer@example.com>
>
> instead of this:
>
>    Signed-off-by: A U Thor <author@example.com>
>    (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>
>    Signed-off-by: C O Mmitter <committer@example.com>

My last review was based on a misunderstanding of
ends_rfc2822_footer().  This time I can unreservedly say I like this.

[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -18,6 +18,7 @@
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
>  const char sign_off_header[] = "Signed-off-by: ";
> +static const char cherry_picked_prefix[] = "(cherry picked from commit ";

The static/nonstatic mismatch looks strange.  Not about this patch,
but probably rest_is_empty() from builtin-commit.c should move here
some day.

[...]
> @@ -1021,11 +1022,36 @@ int sequencer_pick_revisions(struct replay_opts *opts)
[...]
> +static int is_cherry_picked_from_line(const char *buf, int len)
> +{
> +	/*
> +	 * We only care that it looks roughly like (cherry picked from ...)
> +	 */
> +	return !prefixcmp(buf, cherry_picked_prefix) &&
> +		(buf[len - 1] == ')' ||
> +		 (buf[len - 1] == '\n' && buf[len - 2] == ')'));

These two cases are based on whether the commit message ended with
a '(cherry picked from' with no trailing newline, I guess?

I wonder if switching the convention for 'k' would make this simpler:

	const char *line, *eol;

	line = buf + i;
	eol = memchr(buf, '\n', len - i);
	if (!eol)
		eol = buf + len;

	if (!is_rfc2822_field(line, eol - line) &&
	    !is_cherry_picked_from_line(line, eol - line))
		return 0;

I notice you just sent a new version of the series.  I'll try this out
on top of that.

Thanks,
Jonathan
