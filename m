From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Add is_absolute_path() and make_absolute_path()
Date: Fri, 27 Jul 2007 13:51:19 -0700
Message-ID: <7vvec5y3i0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271955450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWmS-0001X5-FZ
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765713AbXG0UvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765681AbXG0UvW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:51:22 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63743 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765624AbXG0UvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:51:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727205120.HMQC1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 16:51:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UkrL1X0081kojtg0000000; Fri, 27 Jul 2007 16:51:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53964>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/path.c b/path.c
> index c4ce962..0f7012f 100644
> --- a/path.c
> +++ b/path.c
> @@ -292,3 +292,65 @@ int adjust_shared_perm(const char *path)
>  		return -2;
>  	return 0;
>  }
> +
> +/* We allow "recursive" symbolic links. Only within reason, though. */
> +#define MAXDEPTH 5
> +
> +const char *make_absolute_path(const char *path)
> +{
> +	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
> +	char cwd[1024] = "";
> +	int buf_index = 1, len;
> +
> +	int depth = MAXDEPTH;
> +	char *last_elem = NULL;
> +	struct stat st;
> +
> +	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
> +		die ("Too long path: %.*s", 60, path);
> +
> +	while (depth--) {
> +		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
> +			char *last_slash = strrchr(buf, '/');
> +			*last_slash = '\0';
> +			last_elem = xstrdup(last_slash + 1);

What happens when incoming path is just "abc"?  Does your test
script checks that case?
