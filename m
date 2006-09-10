From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-upload-archive: add config option to allow only specified formats
Date: Sun, 10 Sep 2006 11:00:31 -0700
Message-ID: <7vpse3sitc.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
	<20060910155837.GA15974@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 20:00:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMTb1-0003tX-Pl
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 19:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWIJR7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWIJR7w
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 13:59:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6869 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932340AbWIJR7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 13:59:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910175949.SPXM26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 Sep 2006 13:59:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Lhzg1V0081kojtg0000000
	Sun, 10 Sep 2006 13:59:40 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060910155837.GA15974@lsrfire.ath.cx> (Rene Scharfe's message
	of "Sun, 10 Sep 2006 17:58:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26802>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>  Documentation/config.txt |    5 +++++
>  builtin-upload-archive.c |   39 +++++++++++++++++++++++++++++++++++++++
>  daemon.c                 |    2 ++
>  3 files changed, 46 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ce722a2..5c3c6c7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -236,6 +236,11 @@ tar.umask::
>  	the same permissions as gitlink:git-checkout[1] would use. The default
>  	value remains 0, which means world read-write.
>  
> +uploadarchive.daemonformats::
> +	A comma-separated list of the git-archive formats allowed for upload
> +	via git-daemon.  If this parameter is missing all formats are allowed
> +	for upload.
> +

Fine -- do we have any other "list-ish" configuration variable,
by the way?  I am just wondering if we earlier established a
convention to use some delimiter to list out things and if we do
have such a convention if delimiter is a comma or not.

> diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
> index 96f96bd..6a5245a 100644
> --- a/builtin-upload-archive.c
> +++ b/builtin-upload-archive.c
> @@ -16,6 +16,37 @@ static const char upload_archive_usage[]
>  static const char deadchild[] =
>  "git-upload-archive: archiver died with error";
>  
> +static char *daemon_formats;
> +
> +static int upload_format_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "uploadarchive.daemonformats"))
> +		daemon_formats = xstrdup(value);
> +	return 0;
> +}

This let's the repository owner to decide what can be used.

> +static int upload_format_allowed(const char *fmt)
> +{
> +	if (getenv("GIT_DAEMON"))
> +		return daemon_formats ? is_in(fmt, daemon_formats, " \t,") : 1;
> +	return 1;
> +}

And limits the allowed format when the environment set to the
value the repository owner decided.

>  static int run_upload_archive(int argc, const char **argv, const char *prefix)
>  {
> @@ -67,6 +100,12 @@ static int run_upload_archive(int argc, 
>  	/* parse all options sent by the client */
>  	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar);
>  
> +	if (!upload_format_allowed(ar.name)) {
> +		free(daemon_formats);
> +		die("upload of %s format forbidden\n", ar.name);
> +	}
> +	free(daemon_formats);
> +

So we could enhance "--remote --list" to show what are supported
(both codewise and policywise) on the remote end, with a bit of
code restructuring?

> diff --git a/daemon.c b/daemon.c
> index a2954a0..2d58abe 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -304,6 +304,8 @@ static int run_service(char *dir, struct
>  		return -1;
>  	}
>  
> +	setenv("GIT_DAEMON", "I am your father.", 1);

I suspect "upload_format_allowed()" can be taught to see what is
in this environment variable and sometimes take that as
daemon_format without letting the repository to override it, so
that the site administrator can limit the formats that can be
used further, just like daemon service mechanism lets them be in
control.
