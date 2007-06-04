From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show html help with git-help --html
Date: Mon, 04 Jun 2007 01:10:35 -0700
Message-ID: <7vps4cjg1w.fsf@assigned-by-dhcp.cox.net>
References: <20070602015341.GA26520@localhost.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7eZ-0003ZP-Eu
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbXFDIKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbXFDIKl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:10:41 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62098 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbXFDIKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:10:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070604081037.SUP7952.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Jun 2007 04:10:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7LAd1X0051kojtg0000000; Mon, 04 Jun 2007 04:10:37 -0400
In-Reply-To: <20070602015341.GA26520@localhost.myhome.westell.com>
 (=?utf-8?B?Tmd1eeG7hW4JVGjDoWkgTmfhu41j?= Duy's message of "Fri, 1 Jun 2007
 21:53:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49080>

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3d8f03d..2ec8545 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -261,6 +261,18 @@ core.excludeFile::
> ...
> +core.htmlprogram::
> +	Specify the program used to open html help files when 'git-help'
> +	is called with option --html or core.help is other than 'man'.
> +	By default, xdg-open will be used.

Is the program's calling convention something that needs to be
customizable for this to be useful?

> diff --git a/Makefile b/Makefile
> index cac0a4a..43e0d15 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -145,6 +145,7 @@ prefix = $(HOME)
>  bindir = $(prefix)/bin
>  gitexecdir = $(bindir)
>  sharedir = $(prefix)/share/
> +htmldir = $(sharedir)/html/
>  template_dir = $(sharedir)/git-core/templates/
>  ifeq ($(prefix),/usr)
>  sysconfdir = /etc

Is it customary to have HTMLized documentation material for
different packages all together in a single .../share/html/
directory, like manpages are placed in share/man/man1/
directory?  I somehow had an impression that a layout to have
html directory per package (i.e. share/doc/$pkg/html/) was more
common.  I dunno.

> diff --git a/help.c b/help.c
> index 6a9af4d..e3e705b 100644
> --- a/help.c
> +++ b/help.c
> @@ -183,6 +187,36 @@ static void show_man_page(const char *git_cmd)
>  	execlp("man", "man", page, NULL);
>  }
>  
> +static void show_html_page(const char *git_cmd)
> +{
> +	const char *html_dir;
> +	int i,len,ret;
> +	char *p;
> +
> +	html_dir = HTML_DIR;
> +	if (!html_help_program)
> +		html_help_program = "xdg-open";
> +
> +	/* html_help_program space html_dir git- git_cmd .html */
> +	len = strlen(html_help_program) + 1 + strlen(html_dir) + 4 + strlen(git_cmd) + 5;
> +	p = xmalloc(len + 1);
> +
> +	strcpy(p, html_help_program);
> +	strcat(p," ");
> +	strcat(p,html_dir);
> +	if (prefixcmp(git_cmd, "git"))
> +		strcat(p,"git-");
> +	strcat(p,git_cmd);
> +	strcat(p,".html");
> +
> +	ret = system(p);

This is sloppy in the presense of potentially unsafe characters...
