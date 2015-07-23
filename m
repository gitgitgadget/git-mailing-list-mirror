From: John Keeping <john@keeping.me.uk>
Subject: Re: unexplained behavior/issue with git archive?
Date: Thu, 23 Jul 2015 16:59:36 +0100
Message-ID: <20150723155936.GC14935@serenity.lan>
References: <55B10705.6090303@jvales.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Vales <jan@jvales.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 17:59:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIIuZ-0006So-GN
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 17:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbbGWP7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 11:59:51 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:37449 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbbGWP7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 11:59:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DB799CDA510;
	Thu, 23 Jul 2015 16:59:48 +0100 (BST)
X-Quarantine-ID: <n95B9houqjLm>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n95B9houqjLm; Thu, 23 Jul 2015 16:59:44 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4CAC3CDA564;
	Thu, 23 Jul 2015 16:59:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <55B10705.6090303@jvales.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274502>

On Thu, Jul 23, 2015 at 05:23:49PM +0200, Jan Vales wrote:
> i seem to trigger behavior i do not understand with git archive.
> 
> I have this little 3 liner (vmdiff.sh):
> #!/bin/bash
> git diff --name-status "$2" "$3" > "$1.files"
> git diff --name-only "$2" "$3" |xargs -d'\n' git archive -o "$1" "$3" --
> 
> 
> For testing purpose, lets assume this call:
> # ./vmdiff.sh latest.zip HEAD^1 HEAD
> 
> # cat latest.zip.files | wc -l
> 149021
> 
> # cat latest.zip.files | egrep "^D" | wc -l
> 159
> 
> # mkdir empty; cd empty; unzip latest.zip ; find * | wc -l
> 1090
> 
> My goal is to basically diff (parts of) filesystems against each other
> and create an archive with all changed files + a file list to know what
> files were deleted. (I currently do not care about the files
> permissions+ownership, and it doesnt really matter in the current
> problem. Also dont ask, why one would store a root-filesystem in git :)
> 
> What I do not understand: why does the zip file only contains 1090
> files+dirs if the wc -l shows like 150k files and only like 159 were
> deleted?
> There should be like 149k files in that archive.
> 
> Also only the few files are all from "var" and none from etc or srv
> where definitely files changed in too! (and show up in latest.zip.files)
> 
> Is there a limit of files git archive can process?

Not explicitly, but there is a limit on the size of command lines and
xargs will invoke the command multiple times if enough arguments are
given.

What happens if you do:

	git diff --name-only HEAD^ HEAD | xargs -d'\n' echo | wc -l

?

With a small number of items, there should only be one output line, but
if xargs invokes the command multiple times there will be multiple
lines.  For example (using -L2 to force a maximum of two arguments per
invocation):

	$ printf '%s\n' a b c | xargs -d'\n' echo | wc -l
	1
	$ printf '%s\n' a b c | xargs -d'\n' -L2 echo | wc -l
	2
