From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for
 doing custom path transformations
Date: Thu, 12 Mar 2009 12:29:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
References: <49B7DFA1.4030409@viscovery.net> <1236852820-12980-1-git-send-email-johan@johansorensen.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-952247600-1236857375=:10279"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhj6K-0007aV-TO
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbZCLL14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 07:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZCLL1z
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:27:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:48121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753344AbZCLL1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 07:27:54 -0400
Received: (qmail invoked by alias); 12 Mar 2009 11:27:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 12 Mar 2009 12:27:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ktud+QnKkHu9+nHNPA1cGeNByZNsmpallxwZgY9
	X7aaHgkaYSjcOi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1236852820-12980-1-git-send-email-johan@johansorensen.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113043>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-952247600-1236857375=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to
answer with insults to the comments I offer, please stop reading this mail
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying
that I appreciate your work.

On Thu, 12 Mar 2009, Johan Sørensen wrote:

> The parameter for filter-path is an executable that will receive the 
> service name, the client hostname and path to the repos the client 
> requests as as arguments. It is then the responsibility of the script to 
> return a zero terminated string on its stdout with the real path of the 
> target repository.
> ---

A sign-off is missing...

More importantly, you might want to point out the security concerns of 
running a script with the full permissions of git-daemon.  (AFAICT from 
your patch you are not dropping any privileges at any point.)

Which brings me to another idea: we have quite a few places in Git where 
we use regular expressions.  Would they not be enough for your use case?

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 36f00ae..efd1687 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -71,6 +72,18 @@ OPTIONS
>  	After interpolation, the path is validated against the directory
>  	whitelist.
>  
> +--path-filter=executable::
> +	To support a more flexible directory layout a path filter script 
> +	can be used. The executable will receive the service name (upload-pack, 
> +	upload-archive or receive-pack), the client hostname and the request git 
> +	directory as arguments. The executable must return a zero-terminated string
> +	on stdout which is the real path 'git-daemon' should serve. This is useful
> +	when --interpolated-path doesn't buy you enough flexibility. You could for
> +	instance keep support for old clone urls if you rename your repository, or
> +	fetch a custom url-mapping from a third-party repo manager application, or
> +	map deeply nested repository directories to a more sensible layout for the 
> +	outside world.

Please keep the lines shorter than 81 characters.

> diff --git a/daemon.c b/daemon.c
> index d93cf96..e6777c6 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -287,6 +293,37 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
>  	return 0;
>  }
>  
> +static char *run_path_filter_script(struct daemon_service *s, char *host, char *dir) {

Again, pretty long line.  (I will refrain from saying that for every long 
line, but please cooperate by pretending I did ;-)

But there is more: what about concurrent accesses?

> +	char result[256]; /* arbitary */

Why not PATH_MAX?

> +	char *real_path;
> +	struct child_process filter_cmd;
> +	const char *args[] = { path_filter_script, s->name, host, dir, NULL };
> +
> +	loginfo("Executing path filter script: '%s %s'", path_filter_script, dir);
> +	memset(&filter_cmd, 0, sizeof(filter_cmd));
> +	filter_cmd.argv = args;
> +	filter_cmd.out = -1;
> +	
> +	if (start_command(&filter_cmd)) {
> +		logerror("path filter: unable to fork path_filter_script");
> +		return NULL;
> +	}
> +	
> +	read(filter_cmd.out, result, sizeof(result) - 1);

No error checking?

BTW we do have strbuf_read(), which would solve your "static char *" 
problem nicely.

> +	close(filter_cmd.out);
> +	if (finish_command(&filter_cmd)) {
> +		logerror("path filter died with strange error");
> +		return NULL;
> +	}
> +
> +	if (result) {
> +		real_path = result;
> +		return real_path;
> +	}
> +	return NULL;

What would be the difference if you wrote

	return result;

instead?

> @@ -495,6 +532,7 @@ static void parse_extra_args(char *extra_args, int buflen)
>  static int execute(struct sockaddr *addr)
>  {
>  	static char line[1000];
> +	char *path;

Is it not rather "const char *"?  But that point would be moot should you 
decide to use strbufs.

> @@ -553,11 +591,20 @@ static int execute(struct sockaddr *addr)
>  		if (!prefixcmp(line, "git-") &&
>  		    !strncmp(s->name, line + 4, namelen) &&
>  		    line[namelen + 4] == ' ') {
> +			path = line + namelen + 5;
> +			if (path_filter_script) {
> +				loginfo("path_filter_script %s for path %s", path_filter_script, path);
> +				char *tdir;

Declaration after a call to a function.

> +				if ((tdir = run_path_filter_script(s, hostname, path))) {
> +					path = tdir;
> +				}

Unnecessary curly brackets.

And your code would be even easier to read if your 
run_path_filter_script() would never return NULL, but the unchanged path 
instead.

Ciao,
Dscho

--8323328-952247600-1236857375=:10279--
