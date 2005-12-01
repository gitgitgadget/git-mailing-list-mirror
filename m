From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: minor problems in git.c
Date: Thu, 1 Dec 2005 15:02:16 +0100
Message-ID: <81b0412b0512010602l63ecev1ba03fb90d06e071@mail.gmail.com>
References: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
	 <81b0412b0512010448u7fcdddacnd7de5df217ab3ca@mail.gmail.com>
	 <20051201135113.GW8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Watson <robert.oo.watson@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 15:05:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehp13-0007Dv-Lp
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 15:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVLAOCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 09:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVLAOCS
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 09:02:18 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:31422 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbVLAOCS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 09:02:18 -0500
Received: by nproxy.gmail.com with SMTP id x4so89333nfb
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 06:02:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Htj4JAr+l3rVgVdFIi3vLTDHSiF4NUJqmA52ORT02IN7FHqFbg2qvfSDPuAVB7wV/SU66E7uK58XYVG7J7ZQvP6pXi5yfUDGUBfHTYhEOnJNC0wRDOxF+p1UgQbGd2xiEJTYxBJB2UyCGAxr6dKDhJrr0AR3cQuaGLyhw1fzFLg=
Received: by 10.49.43.13 with SMTP id v13mr278050nfj;
        Thu, 01 Dec 2005 06:02:16 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 1 Dec 2005 06:02:16 -0800 (PST)
To: skimo@liacs.nl
In-Reply-To: <20051201135113.GW8383MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13059>

On 12/1/05, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Thu, Dec 01, 2005 at 01:48:35PM +0100, Alex Riesen wrote:
> > @@ -283,16 +283,15 @@ int main(int argc, char **argv, char **e
> >       len = strlen(git_command);
> >       prepend_to_path(git_command, len);
> >
> > -     strncat(&git_command[len], "/git-", sizeof(git_command) - len);
> > -     len += 5;
> > -     strncat(&git_command[len], argv[i], sizeof(git_command) - len);
> > +     snprintf(git_command + len, sizeof(git_command) - len, "/git-%s",
> > +              argv[i]);
>
> Shouldn't you check the return value of snprintf

Probably. For the case where length of a git-command-name +
--exec-prefix together are longer than PATH_MAX.

> >       if (access(git_command, X_OK))
> >               usage(exec_path, "'%s' is not a git-command", argv[i]);
>
> or use the (possibly) truncated version of the command in the error message ?

argv[i] is the command name, already as truncated as it can possibly
be: ls-files, ls-tree, etc. Besides, the second path removes this
access check altogether:

-	if (access(git_command, X_OK))
-		usage(exec_path, "'%s' is not a git-command", argv[i]);
-
 	/* execve() can only ever return if it fails */
 	execve(git_command, &argv[i], envp);
-	fprintf(stderr, "git: '%s': %s\n", git_command, strerror(errno));
+        if ( ENOENT == errno )
+		usage(exec_path, "'%s' is not a git-command", argv[i]);
+        else
+		fprintf(stderr, "git: '%s': %s\n", git_command, strerror(errno));


It still has the call to usage, though.
