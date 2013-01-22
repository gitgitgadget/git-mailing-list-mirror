From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Mon, 21 Jan 2013 23:54:13 -0800
Message-ID: <20130122075413.GB6085@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxYgq-0005w5-8O
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 08:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab3AVHyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 02:54:20 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50271 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab3AVHyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 02:54:19 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so3163563pbc.12
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 23:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mlE9HfbIm1MnoANdwUSN8/qpvpO4l/S77QikuCcZ0Ec=;
        b=a83Vrfe06ybA1y8JEFpi3Hn7reVb2rquwG7c0nIouJqO+KaxD3+Nvn8Q6Skkg0k0rm
         ETMh+lYmfNCLAYX2oy71dupvUCIKWQ/bnoNA/oWalTRCtIeXC6o8VIDWBNmhhIMRQuEJ
         QZkBN291CAGePXuEbQkFhq7KHiIW5fKxm2wuTSis+UUjDWIl9DyM4xKvzk0k2pdbbT6t
         27Nuj1AKgL+pIDZIoZaxNok2FL7ucYIJ2tmPF4COQDfdfyH0jmheLq8Yv7vEE8NRqXWv
         h/TrQorzPef4At0IFjpBiSUCHvKoNlcyiOksa2HU0knWt0KYGwsv6S426r/PHlRtD5TA
         p7kQ==
X-Received: by 10.66.76.198 with SMTP id m6mr54061342paw.32.1358841258840;
        Mon, 21 Jan 2013 23:54:18 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qt3sm10278195pbb.32.2013.01.21.23.54.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 23:54:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-2-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214211>

Hi,

Brandon Casey wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
[...]
> @@ -1042,13 +1041,8 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)

Git is checking if (sb->buf) ends with a "Signed-off-by:" style
line.  If it doesn't, it will need to add an extra blank line
before adding a new sign-off.

First (snipped), it seeks back two newlines from the end and then
forward to the next non-newline character, so (buf + i) is at the
start of the last line of (the interesting part of) sb.  Now:

> 	for (; i < len; i = k) {
> 		for (k = i; k < len && buf[k] != '\n'; k++)
>  			; /* do nothing */
>  		k++;

(buf + k) points to the end of this line.

> -		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
> -			continue;

This is always the first line examined, so this "continue" never
triggers.

> -
> -		first = 0;
> -
>  		for (j = 0; i + j < len; j++) {

If the line matches /^[[:alnum:]-]*:/, it passes and git moves on to
the (nonexistent) next line.  Otherwise, it fails.

Do I understand correctly?  If so, this patch should be a no-op, which
is good, I guess.

But in that case, couldn't this function be made much simpler?  As far
as I can tell, all the function needs to do is the following:

	1. Find the last line.
	2. Check if it is blank or matches /^[[:alnum:]-]*:/
	3. There is no step 3.  That's it.

In other words, something like:

	const char *eol, *p;

	/* End of line */
	eol = memrchr(sb->buf, '\n', sb->len - ignore_footer);
	if (!eol)
		eol = sb->buf;

	/* Start of line */
	p = memrchr(sb->buf, '\n', eol - sb->buf);
	if (p)
		p++;
	else
		p = sb->buf;

	if (p == eol)	/* Blank line? */
		return 1;

	/* "Signed-off-by"-style field */
	while ((isalnum(*p) || *p == '-') && p < eol)
		p++;
	return *p == ':';

where memrchr is defined roughly as follows[1]:

	#ifdef __GLIBC_PREREQ
	#if __GLIBC_PREREQ(2, 2)
	#define HAVE_MEMRCHR
	#endif
	#endif

	#ifndef HAVE_MEMRCHR
	#define memrchr gitmemrchr
	static inline void *gitmemrchr(const void *s, int c, size_t n)
	{
		const unsigned char *p = s;
		p += n;
		while (p != s)
			if (*--p == (unsigned char) c)
				return p;
		return NULL;
	}
	#endif

Does that look right?

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/159081/focus=159121
