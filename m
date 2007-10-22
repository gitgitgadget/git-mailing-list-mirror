From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Mon, 22 Oct 2007 21:01:02 +0200
Message-ID: <20071022190102.GA23714@steel.home>
References: <20071022170148.GB29642@srparish.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik2Wn-0006To-P1
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbXJVTBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbXJVTBK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:01:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:25967 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbXJVTBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 15:01:09 -0400
Received: from tigra.home (Fab70.f.strato-dslnet.de [195.4.171.112])
	by post.webmailer.de (klopstock mo51) (RZmta 13.6)
	with ESMTP id a003f0j9MHKRn7 ; Mon, 22 Oct 2007 21:01:03 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8BA82277AE;
	Mon, 22 Oct 2007 21:01:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CCCDE56D22; Mon, 22 Oct 2007 21:01:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071022170148.GB29642@srparish.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKf+sU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62035>

Scott R Parish, Mon, Oct 22, 2007 19:01:48 +0200:
> +static void add_path(struct strbuf *out, const char *path)
> +{
> +	if (path && strlen(path)) {
> +		if (is_absolute_path(path))
> +			strbuf_addstr(out, path);
> +		else
> +			strbuf_addstr(out, make_absolute_path(path));
> +
> +		strbuf_addch(out, ':');

Shouldn't it break MingW32 native port?

> +	}
> +}
> +
> +void setup_path(const char *cmd_path)
> +{
> +	const char *old_path = getenv("PATH");
> +	struct strbuf new_path;
> +
> +	strbuf_init(&new_path, 0);
> +
> +	add_path(&new_path, argv_exec_path);
> +	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
> +	add_path(&new_path, builtin_exec_path);
> +	add_path(&new_path, cmd_path);
> +		

trailing space

> +	if (old_path)
> +		strbuf_addstr(&new_path, old_path);
> +	else 
> +		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");

the default PATH is platform-dependent. Git is multi-platform.
You should consider putting the path list somewhere in Makefile,
config.mak or configure.

> +
> +	setenv("PATH", new_path.buf, 1);
