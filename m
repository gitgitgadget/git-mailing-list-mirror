From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Tue, 7 Oct 2008 04:53:27 +0400
Message-ID: <20081007005327.GT21650@dpotapov.dyndns.org>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <48E9B634.6040909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 02:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn0qf-0002TE-1x
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 02:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397AbYJGAxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759345AbYJGAxh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 20:53:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50289 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758672AbYJGAxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 20:53:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2136776fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6ZGaAbWef0Gag0SESzeNHu6aEhoiQEjguQ9wTvPpO/w=;
        b=DA6sNfL9QPvhav6xqgtvdWeGe1G7NU/z4JfjbPSWUXYPYblxNYY897xA+I6y6eXtlX
         FzoUMTk+SHmR7NLyVbpbC/7QUp/XkL89kwhPs/vY1Rk9NPudK8OiPlg6WxjkUhu578Fd
         b4N76scRDOzr0rSiaQ2WacZqH4M1fTgPTj2To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IE8rt4/W6GPcZwCppTU5OjKmwD2P1xAFn8OodVx5Q8lf1jVjQR9fWC4Pii8T/pux5T
         C5ahjXH3NABQt0nC/ekkAvQcB/15wNEwCPMwgMr7zSZlz8ZuPQD8LfGzLgK583Csr6pA
         oBL1ABRpSrer2+XW6wWw+uyr7Wv5oj3EOKpmk=
Received: by 10.86.33.19 with SMTP id g19mr5213272fgg.13.1223340812544;
        Mon, 06 Oct 2008 17:53:32 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id 12sm12458900fgg.0.2008.10.06.17.53.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 17:53:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48E9B634.6040909@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97649>

On Mon, Oct 06, 2008 at 08:54:44AM +0200, Johannes Sixt wrote:
> 
> IIUC, verify_path() checks paths that were found in the database or the
> index.

It also checks paths that was given to git add and other commands to
prevent an invalid path to enter to the index. If I am not mistaken,
if invalid path has entered in the index then it will be committed to
the database without any further checks.

> As such, it checks for the integrity of the database. And paths
> with backslashes or colons certainly do not violate the database integrity.

No, it has nothing to do with the database. You can run git fsck --full
on a repository that contains '..' or '.' or '.git', and there will be
no error. Having those names does not violate the database integrity,
as the database is concerned all names are just bytes separated by '/',
so having name '.' is not a problem for it. However, names '.' and '..'
have special meaning for the filesystem, and paths starting with .git/
have special meaning for Git repository. If you work in a bare repo
then those names are not a problem, but once you have a working tree,
you want make sure that there is nothing wrong with it.

> 
> More precisely, the exchange of path names between the index and tree
> objects (both directions) should not do this new check, nor if a path is
> added to the index. The check is only meaningful[*] when a path is read
> from the index or a tree object and "applied" to the working directory.
> Unfortunately, I think there are lots of places where this happens.
> 
> [*] I say "meaningful" and not "necessary" because the situation is just
> like when you grab some random SoftwarePackage.tar.gz, and run ./configure
> without looking first what it is going to do.

When I grab any tar, I can look at its context without myself of any
risk that some files can be overwritten on my file system. And when
I want to look at some remote git repository, I usually do:

   git clone URL

If it can overwrite some files behind my back, it is security a hole.

BTW, it was the reason why the idea of allowing .gitconfig to be stored
in git repository (similar to .gitignore) was stroke down about a year ago
though it could help some clueless users...

On Linux (or other sane file systems), we have all required checks to
prevent that from happening, and they are places in verify_path, which
prevents malicious names entering into the index and thus to the file
system too. So, we should do all required checks on Windows too.

Now, I've realized that my checks were not sufficient (due to Windows
being case-insensitive), so I will add more checks and resend this
patch later.


Dmitry
