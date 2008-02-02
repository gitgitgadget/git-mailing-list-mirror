From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sat, 2 Feb 2008 15:56:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802021550130.7372@racer.site>
References: <1201948579-11807-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 16:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLKk6-0006u0-Um
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 16:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbYBBP4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 10:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758621AbYBBP4u
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 10:56:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:33407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757996AbYBBP4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 10:56:49 -0500
Received: (qmail invoked by alias); 02 Feb 2008 15:56:47 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 02 Feb 2008 16:56:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nBSZI6ixnUWdBK09Z6VIClCBSaUg8bv/xwC8KmL
	XkCQxzWQJOZgua
X-X-Sender: gene099@racer.site
In-Reply-To: <1201948579-11807-1-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72282>

Hi,

On Sat, 2 Feb 2008, Lars Hjemli wrote:

> This patch allows .git to be a regular textfile containing the path of 
> the real git directory (formatted like "GITDIR: <path>\n"), which is 
> useful on platforms lacking support for real symlinks.

Wow, that looks easier than I thought...

> +static const char *read_gitfile_gently(const char *path)
> +{
> +	static char buf[PATH_MAX + 10];  /* "GITDIR: " + "\n" + "\0" */

Why say "GITDIR:"?  Do you want to be able to set other things there, too, 
like GITWORKDIR?

> +	struct stat st;
> +	FILE *f;
> +	size_t len;
> +
> +	if (stat(path, &st))
> +		return NULL;
> +	if (!S_ISREG(st.st_mode) || st.st_size > PATH_MAX + 9)

Why make it complicated? You could just test for st.st_size >= 
sizeof(buf).

> +		return NULL;
> +	f = fopen(path, "r");
> +	if (!f)
> +		return NULL;
> +	len = fread(buf, 1, st.st_size, f);
> +	fclose(f);
> +	if (len != st.st_size)
> +		return NULL;

Should this not rather use read_in_full()?

> +	if (len < 10 || buf[len - 1] != '\n' || strncmp(buf, "GITDIR: ", 8))
> +		return NULL;
> +	buf[len - 1] = '\0';
> +	if (!is_git_directory(buf + 8))
> +		return NULL;
> +	return buf + 8;
> +}

Should this not make the git directory absolute, just in case?

Thanks,
Dscho
