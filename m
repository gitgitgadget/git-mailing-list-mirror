From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage
 warnings
Date: Fri, 3 Dec 2010 13:00:50 -0600
Message-ID: <20101203190050.GB14049@burratino>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POasa-00074b-Mp
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab0LCTBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:01:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38570 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab0LCTBG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:01:06 -0500
Received: by vws16 with SMTP id 16so1922106vws.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=y0TJuCWORVsayGaf70dIgnaytl+WHlVUtJQHxFlNdVc=;
        b=N1ncGBQ4h9POBETn9+loLqFHgRT9jCGKWeTPFyy9CfXerFKbjJrWLeGQkzdNGDkjy8
         48oLzaA0ctDbtGJSVgWP8M5wxHijT8LgmIKHbheyLRsi13vH1pxLlqjl9Nbbm0bA4W4/
         WdHzCzLUWU2DoB7mlRKad3+PCSpyer8qvmSyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C7xJEj3Dm2FqUHTG0cY0f1XAb3od66PCIK5diQrztJaJkuHkdIqMIEN7SphDF11ttl
         ioB/5duvymkn7uBjj9dV5ClZmmAp7SxLVl3YouoqJBnS9CacvbstBloUy+IRiUOOHsPX
         PelXUoprsnWwf1JqMpRaS3nO3ctfmN3WGY/HY=
Received: by 10.220.187.195 with SMTP id cx3mr494454vcb.67.1291402865312;
        Fri, 03 Dec 2010 11:01:05 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id r11sm741806vbx.11.2010.12.03.11.01.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:01:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162826>

Sverre Rabbelier wrote:

> $ git pull --rebase
> usage: git merge-base [-a|--all] [--octopus] <commit> <commit>...
[...]
> [... many more snipped ...]
>
> You are not currently on a branch, so I cannot use any
> 'branch.<branchname>.merge' in your configuration file.
> Please specify which remote branch you want to use on the command
> line and try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details.
>
>
> There are 127 helpful messages in total.

Does the following take care of it?

cc-ing Santi, author of the very nice v1.6.4.1~6^2 (pull: support
rebased upstream + fetch + pull --rebase, 2009-07-19).  Maybe we
should make merge-base more tolerant.

diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..bbc369d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -212,7 +212,7 @@ test true = "$rebase" && {
 	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
 	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
 	do
-		if test "$reflog" = "$(git merge-base $reflog $curr_branch)"
+		if test "$reflog" = "$(git show-branch --merge-base $reflog $curr_branch)"
 		then
 			oldremoteref="$reflog"
 			break
