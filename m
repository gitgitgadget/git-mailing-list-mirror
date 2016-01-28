From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Thu, 28 Jan 2016 15:42:53 -0800
Message-ID: <xmqqio2dl18i.fsf@gitster.mtv.corp.google.com>
References: <20160128115720.GA1827@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:43:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOwDb-0001aM-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbcA1Xm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 18:42:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbcA1Xm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 18:42:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F0463F0D5;
	Thu, 28 Jan 2016 18:42:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sLyMY5mOkNMQjRjDu5oPHbEKOio=; b=HzzRia
	WcW4Wx+uz1sL4hBwMvQFm10HA6+HWVu6vWoLBQOUCfhVMJmECc1Yry+PfKwOVEdc
	Z0//XuGOZ+9x1VZPROvaBuU7I15trkWK8OwZWqmNPcZkfLsoOz83QYvLTiN+ADlo
	c5A7+NNztenFyidKUSCIaNtA14DdT/zYtlejQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FUea1ZX7C7jgRZzmwZgWyrMtPywpovUm
	Q79xQmPpTYvaSVYo2xaEjXmsUzOVlY/TLqUfbOui9tgZ8+TrH249SOQnrA/xcvZB
	br7llYyCDVyK+E22W1+rPvEyK6Gvt2Py0zBYILCiKwl1aEw4uKsEL9DVkEh/46i+
	Jlblk2UcsZc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 957BD3F0D4;
	Thu, 28 Jan 2016 18:42:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 098C13F0D3;
	Thu, 28 Jan 2016 18:42:54 -0500 (EST)
In-Reply-To: <20160128115720.GA1827@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 28 Jan 2016 11:57:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA69D5F2-C618-11E5-B7A2-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285045>

Eric Wong <normalperson@yhbt.net> writes:

> getaddrinfo() may return multiple addresses, not all of which
> are equally performant.  In some cases, a user behind a non-IPv6
> capable network may get an IPv6 address which stalls connect().
> Instead of waiting synchronously for a connect() to timeout, use
> non-blocking connect() in parallel and take the first successful
> connection.
>
> This may increase network traffic and server load slightly, but
> makes the worst-case user experience more bearable when one
> lacks permissions to edit /etc/gai.conf to favor IPv4 addresses.

Umm.  I am not sure what to think about this change--I generally do
not like a selfish "I'll try to use whatever resource given to me
to make my process go faster, screw the rest of the world" approach
and I cannot decide if this falls into that category.

I'll wait for opinions from others.

Thanks.

> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  connect.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 104 insertions(+), 14 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index fd7ffe1..74d2bb5 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -14,6 +14,42 @@
>  static char *server_capabilities;
>  static const char *parse_feature_value(const char *, const char *, int *);
>  
> +#ifdef SOCK_NONBLOCK /* Linux-only flag */
> +#  define GIT_SOCK_NONBLOCK SOCK_NONBLOCK
> +#else
> +#  define GIT_SOCK_NONBLOCK 0
> +#endif
> +
> +static int socket_nb(int domain, int type, int protocol)
> +{
> +	static int flags = GIT_SOCK_NONBLOCK;
> +	int fd = socket(domain, type | flags, protocol);
> +
> +	/* new headers, old kernel? */
> +	if (fd < 0 && errno == EINVAL && flags != 0) {
> +		flags = 0;
> +		fd = socket(domain, type, protocol);
> +	}
> +
> +	/* couldn't use SOCK_NONBLOCK, set non-blocking the old way */
> +	if (flags == 0 && fd >= 0) {
> +		int fl = fcntl(fd, F_GETFL);
> +
> +		if (fcntl(fd, F_SETFL, fl | O_NONBLOCK) < 0)
> +			die_errno("failed to set nonblocking flag\n");
> +	}
> +
> +	return fd;
> +}
> +
> +static void set_blocking(int fd)
> +{
> +	int fl = fcntl(fd, F_GETFL);
> +
> +	if (fcntl(fd, F_SETFL, fl & ~O_NONBLOCK) < 0)
> +		die_errno("failed to clear nonblocking flag\n");
> +}
> +
>  static int check_ref(const char *name, unsigned int flags)
>  {
>  	if (!flags)
> @@ -351,6 +387,9 @@ static int git_tcp_connect_sock(char *host, int flags)
>  	struct addrinfo hints, *ai0, *ai;
>  	int gai;
>  	int cnt = 0;
> +	nfds_t n = 0, nfds = 0;
> +	struct pollfd *fds = NULL;
> +	struct addrinfo **inprogress = NULL;
>  
>  	get_host_and_port(&host, &port);
>  	if (!*port)
> @@ -371,20 +410,76 @@ static int git_tcp_connect_sock(char *host, int flags)
>  		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
>  
>  	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
> -		sockfd = socket(ai->ai_family,
> -				ai->ai_socktype, ai->ai_protocol);
> -		if ((sockfd < 0) ||
> -		    (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0)) {
> +		size_t cur;
> +		int fd = socket_nb(ai->ai_family, ai->ai_socktype,
> +					ai->ai_protocol);
> +		if (fd < 0) {
>  			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
>  				    host, cnt, ai_name(ai), strerror(errno));
> -			if (0 <= sockfd)
> -				close(sockfd);
> -			sockfd = -1;
>  			continue;
>  		}
> +
> +		if (connect(fd, ai->ai_addr, ai->ai_addrlen) < 0 &&
> +					errno != EINPROGRESS) {
> +			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
> +				host, cnt, ai_name(ai), strerror(errno));
> +			close(fd);
> +			continue;
> +		}
> +
>  		if (flags & CONNECT_VERBOSE)
> -			fprintf(stderr, "%s ", ai_name(ai));
> -		break;
> +			fprintf(stderr, "%s (started)\n", ai_name(ai));
> +
> +		nfds = n + 1;
> +		cur = n;
> +		ALLOC_GROW(fds, nfds, cur);
> +		cur = n;
> +		ALLOC_GROW(inprogress, nfds, cur);
> +		inprogress[n] = ai;
> +		fds[n].fd = fd;
> +		fds[n].events = POLLIN|POLLOUT;
> +		fds[n].revents = 0;
> +		n = nfds;
> +	}
> +
> +	/*
> +	 * nfds is tiny, no need to limit loop based on poll() retval,
> +	 * just do not let poll sleep forever if nfds is zero
> +	 */
> +	if (nfds > 0)
> +		poll(fds, nfds, -1);
> +
> +	for (n = 0; n < nfds && sockfd < 0; n++) {
> +		if (fds[n].revents & (POLLERR|POLLHUP))
> +			continue;
> +		if (fds[n].revents & POLLOUT) {
> +			int err;
> +			socklen_t len = (socklen_t)sizeof(err);
> +			int rc = getsockopt(fds[n].fd, SOL_SOCKET, SO_ERROR,
> +						&err, &len);
> +			if (rc != 0)
> +				die_errno("getsockopt errno=%s\n",
> +					strerror(errno));
> +			if (err == 0) { /* success! */
> +				sockfd = fds[n].fd;
> +				ai = inprogress[n];
> +			}
> +		}
> +	}
> +
> +	/* cleanup */
> +	for (n = 0; n < nfds; n++) {
> +		if (fds[n].fd != sockfd)
> +			close(fds[n].fd);
> +	}
> +	free(inprogress);
> +	free(fds);
> +
> +	if (sockfd >= 0) {
> +		enable_keepalive(sockfd);
> +		set_blocking(sockfd); /* the rest of git expects blocking */
> +		if (flags & CONNECT_VERBOSE)
> +			fprintf(stderr, "%s done.\n", ai_name(ai));
>  	}
>  
>  	freeaddrinfo(ai0);
> @@ -392,11 +487,6 @@ static int git_tcp_connect_sock(char *host, int flags)
>  	if (sockfd < 0)
>  		die("unable to connect to %s:\n%s", host, error_message.buf);
>  
> -	enable_keepalive(sockfd);
> -
> -	if (flags & CONNECT_VERBOSE)
> -		fprintf(stderr, "done.\n");
> -
>  	strbuf_release(&error_message);
>  
>  	return sockfd;
