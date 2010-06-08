From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 01:29:30 -0400
Message-ID: <20100608052929.GA15156@coredump.intra.peff.net>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jrnieder@uchicago.edu, git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 07:29:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLrNd-0001sp-Fp
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 07:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0FHF3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 01:29:36 -0400
Received: from peff.net ([208.65.91.99]:47917 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab0FHF3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 01:29:35 -0400
Received: (qmail 1467 invoked by uid 107); 8 Jun 2010 05:29:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Jun 2010 01:29:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jun 2010 01:29:30 -0400
Content-Disposition: inline
In-Reply-To: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148642>

On Mon, Jun 07, 2010 at 08:58:08PM -0300, Dario Rodriguez wrote:

> Default pager was 'less' even when some systems such AIX and other basic
> or old systems do NOT have 'less' installed. In such case, git just
> does not display anything in pager-enabled functionalities such as 'git log'
> or 'git show', exiting with status 0.
> 
> With this patch, git will not use DEFAULT_PAGER macro anymore, instead,
> git will look for 'less' and 'more' in the most common paths.
> If there is no pager, returns NULL as if it's 'cat'.

Run-time pager detection seems like a reasonable goal, I guess, but...

> -const char *git_pager(int stdout_is_tty)
> +static int is_executable(const char *name)
> +{
> +	struct stat st;
> +
> +	if (stat(name, &st) ||
> +	    !S_ISREG(st.st_mode))
> +		return 0;
> +
> +#ifdef WIN32
> +{	/* cannot trust the executable bit, peek into the file instead */
> +	char buf[3] = { 0 };
> +	int n;
> +	int fd = open(name, O_RDONLY);
> +	st.st_mode &= ~S_IXUSR;
> +	if (fd >= 0) {
> +		n = read(fd, buf, 2);
> +		if (n == 2)
> +			/* DOS executables start with "MZ" */
> +			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
> +				st.st_mode |= S_IXUSR;
> +		close(fd);
> +	}
> +}
> +#endif
> +	return st.st_mode & S_IXUSR;
> +}
> +
> +const char *git_pager(int stdout_is_tty) 
>  {
> +	static const char *pager_bins[] =
> +		{ "less", "more", NULL };
> +	static const char *common_binary_paths[] =
> +		{ "/bin/","/usr/bin/","/usr/local/bin/",NULL };

...must we really add code with such ugliness as magic PATHs and DOS
magic numbers?

Right now we fall back to just exec-ing "less". Could we instead just
try to exec "less", if that fails then "more", and then finally "cat"?

That would have almost the same effect and would be much simpler,
wouldn't it? The exceptions I can think of are:

  - we would actually run "cat" in the final case, instead of optimizing
    it out.

  - "git var GIT_PAGER" wouldn't handle this automatically

-Peff
