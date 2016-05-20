From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v6 1/9] connect: call get_host_and_port() earlier
Date: Sat, 21 May 2016 07:14:30 +0900
Message-ID: <20160520221430.GA28273@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
 <20160517013554.22578-2-mh@glandium.org>
 <xmqqfutccuq5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 00:14:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3sgt-0001gt-1p
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcETWOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:14:39 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56288 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbcETWOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:14:39 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b3sgg-0001uo-Qj; Sat, 21 May 2016 07:14:30 +0900
Content-Disposition: inline
In-Reply-To: <xmqqfutccuq5.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295214>

On Fri, May 20, 2016 at 01:58:26PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Currently, get_host_and_port() is called in git_connect() for the ssh
> > protocol, and in git_tcp_connect_sock() for the git protocol. Instead
> > of doing this, just call it from a single place, right after
> > parse_connect_url(), and pass the host and port separately to
> > git_*_connect() functions.
> >
> > We however preserve hostandport, at least for now.
> >
> > Note that in git_tcp_connect_sock, the port was set to "<none>" in a
> > case that never can happen, so that code path was removed.
> 
> Can never happen because?
> 
>   !*port means get_host_and_port() made the "port" pointer point at
>   a NUL byte.  That does not happen because the only case port is
>   moved by that function is to have it point at a byte after we
>   found ':', and the "port" string is a decimal integer whose value
>   is between 0 and 65535, so there is no way port points at an empty
>   string.
> 
> OK.

Do you want me to add this to the commit message in a possible v7?

> >  struct child_process *git_connect(int fd[2], const char *url,
> >  				  const char *prog, int flags)
> > ...
> > @@ -683,6 +681,8 @@ struct child_process *git_connect(int fd[2], const char *url,
> >  	signal(SIGCHLD, SIG_DFL);
> >  
> >  	protocol = parse_connect_url(url, &hostandport, &path);
> > +	host = xstrdup(hostandport);
> > +	get_host_and_port(&host, &port);
> >  	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
> >  		printf("Diag: url=%s\n", url ? url : "NULL");
> >  		printf("Diag: protocol=%s\n", prot_name(protocol));
> > ...
> > @@ -737,22 +737,20 @@ struct child_process *git_connect(int fd[2], const char *url,
> >  		if (protocol == PROTO_SSH) {
> >  			const char *ssh;
> >  			int putty = 0, tortoiseplink = 0;
> > -			char *ssh_host = hostandport;
> > -			const char *port = NULL;
> >  			transport_check_allowed("ssh");
> > -			get_host_and_port(&ssh_host, &port);
> >  
> >  			if (!port)
> > -				port = get_port(ssh_host);
> > +				port = get_port(host);
> 
> This looks strange.  We asked get_host_and_port() to split
> hostandport into host and port already, and learned that port is
> empty, i.e. it wasn't <host>:<port> where <port> is a decimal
> integer between 0 and 65535.  It could have been "<host>:" in which
> case get_host_and_port() would have turned that colon into NUL.
> 
> Would there be a case where this get_port() call does anthing
> useful?

v3 of this series did remove this get_port(), and broke the
'[host:port]:path' syntax as a consequence. The reason this happens is
that get_host_and_port, in that case, is called with [host:port], sees
the square brackets, and searches the port *after* the closing bracket,
because the usual case where square brackets appear is ipv6 addresses,
which contain colons, and the brackets in that case are used to separate
the host and the port.

In that case, get_host_and_port returns "host:port" and null.

Mike
