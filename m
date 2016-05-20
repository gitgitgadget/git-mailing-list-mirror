From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/9] connect: call get_host_and_port() earlier
Date: Fri, 20 May 2016 13:58:26 -0700
Message-ID: <xmqqfutccuq5.fsf@gitster.mtv.corp.google.com>
References: <20160517013554.22578-1-mh@glandium.org>
	<20160517013554.22578-2-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri May 20 22:58:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3rVD-0002Qm-50
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 22:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbcETU6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 16:58:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836AbcETU6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 16:58:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CB7D1BE7D;
	Fri, 20 May 2016 16:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yneyq5nE36/+MA0bFyHqVdctcGc=; b=RKiYte
	kVlosxWEulRgg279vGQi1E72NOzXaaC/UnyiOeYkx9gHAdTMg+6W3skQwfcopyfP
	axtlTcv7ZTh7AW9xk0whiUMmXDrXkvgydQy8hnX/q98INwwObibw5gUxtfG6XpyT
	v2XCU45rjvHHXWLRbiVrFgKTDYta/oZKj8gp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ksToYuCQT19vsrwS/Teyofotg5O4nC1i
	dDemph4CBnVxi9+LY+I+N2L5vxy3n/MPwkFRVzkE7+BFb3Kfvn+6DwWFyM9f07BJ
	b3LTJ0xIcpbh13a3uamRzKt+6KNzWShqiOH0HhyR4xU2JA5CxPgnmB3h30yqrrWV
	1O4yxKehnqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 141B01BE7C;
	Fri, 20 May 2016 16:58:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BEE01BE7B;
	Fri, 20 May 2016 16:58:28 -0400 (EDT)
In-Reply-To: <20160517013554.22578-2-mh@glandium.org> (Mike Hommey's message
	of "Tue, 17 May 2016 10:35:46 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A37A992-1ECD-11E6-BA9D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295209>

Mike Hommey <mh@glandium.org> writes:

> Currently, get_host_and_port() is called in git_connect() for the ssh
> protocol, and in git_tcp_connect_sock() for the git protocol. Instead
> of doing this, just call it from a single place, right after
> parse_connect_url(), and pass the host and port separately to
> git_*_connect() functions.
>
> We however preserve hostandport, at least for now.
>
> Note that in git_tcp_connect_sock, the port was set to "<none>" in a
> case that never can happen, so that code path was removed.

Can never happen because?

  !*port means get_host_and_port() made the "port" pointer point at
  a NUL byte.  That does not happen because the only case port is
  moved by that function is to have it point at a byte after we
  found ':', and the "port" string is a decimal integer whose value
  is between 0 and 65535, so there is no way port points at an empty
  string.

OK.

>  struct child_process *git_connect(int fd[2], const char *url,
>  				  const char *prog, int flags)
> ...
> @@ -683,6 +681,8 @@ struct child_process *git_connect(int fd[2], const char *url,
>  	signal(SIGCHLD, SIG_DFL);
>  
>  	protocol = parse_connect_url(url, &hostandport, &path);
> +	host = xstrdup(hostandport);
> +	get_host_and_port(&host, &port);
>  	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
>  		printf("Diag: url=%s\n", url ? url : "NULL");
>  		printf("Diag: protocol=%s\n", prot_name(protocol));
> ...
> @@ -737,22 +737,20 @@ struct child_process *git_connect(int fd[2], const char *url,
>  		if (protocol == PROTO_SSH) {
>  			const char *ssh;
>  			int putty = 0, tortoiseplink = 0;
> -			char *ssh_host = hostandport;
> -			const char *port = NULL;
>  			transport_check_allowed("ssh");
> -			get_host_and_port(&ssh_host, &port);
>  
>  			if (!port)
> -				port = get_port(ssh_host);
> +				port = get_port(host);

This looks strange.  We asked get_host_and_port() to split
hostandport into host and port already, and learned that port is
empty, i.e. it wasn't <host>:<port> where <port> is a decimal
integer between 0 and 65535.  It could have been "<host>:" in which
case get_host_and_port() would have turned that colon into NUL.

Would there be a case where this get_port() call does anthing
useful?
