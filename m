From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: git locate
Date: Wed, 02 Jun 2010 11:23:32 +0100
Message-ID: <80y6ex3f8b.fsf@tiny.isode.net>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
            <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
            <m3zl49bk0o.fsf@localhost.localdomain>
            <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
            <4B579BA8.8050000@gmail.com>
            <fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
            <AANLkTim6cLkr5BFTRTh2nZGwsfVgHZi3M-b9IER8dHf3@mail.gmail.com>
            <AANLkTil38OLw3J6ZPvv2wNu98QuTXJKtNwRZP0NDZPWn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 12:23:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJl6p-00030H-1d
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 12:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425Ab0FBKXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 06:23:36 -0400
Received: from rufus.isode.com ([62.3.217.251]:34619 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932419Ab0FBKXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 06:23:33 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <TAYxIgBeGays@rufus.isode.com>; Wed, 2 Jun 2010 11:23:30 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 02 Jun 2010 11:23:34 +0100
X-Hashcash: 1:20:100602:git@vger.kernel.org::hEXN6YhXGUs9blnz:0000000000000000000000000000000000000000004hsF
X-Hashcash: 1:20:100602:johnflux@gmail.com::GD3HypoFEzetBEhV:0000000000000000000000000000000000000000000DRgo
In-Reply-To: <AANLkTil38OLw3J6ZPvv2wNu98QuTXJKtNwRZP0NDZPWn@mail.gmail.com>
	(John Tapsell's message of "Wed, 2 Jun 2010 19:02:00 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148242>

John Tapsell <johnflux@gmail.com> writes:

[...]

> Actually could someone help me with this.. the trouble is that this
> returns paths relative to the root.
>
> Can I get it to find all the files, but relative to where I am now?

Something like this is probably part of the answer, which allows an
alias like this to work:

	locate = !cd $GIT_CWD && sh -c 'git ls-files "*$1*"' -

That doesn't give you all the files (just those below where you are).

diff --git a/git.c b/git.c
index 99f0363..81c877b 100644
--- a/git.c
+++ b/git.c
@@ -178,6 +178,10 @@ static int handle_alias(int *argcp, const char ***argv)
                        }
                        trace_printf("trace: alias to shell cmd: %s => %s\n",
                                     alias_command, alias_string + 1);
+                       if (!subdir || !*subdir)
+                         setenv("GIT_CWD", "./", 1);
+                       else
+                         setenv("GIT_CWD", subdir, 1);
                        ret = system(alias_string + 1);
                        if (ret >= 0 && WIFEXITED(ret) &&
                            WEXITSTATUS(ret) != 127)
