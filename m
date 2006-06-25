From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git-commit: filter out log message lines only when editor was run.
Date: Sun, 25 Jun 2006 09:08:02 +0200
Message-ID: <e5bfff550606250008k702acfadm8860e9b672bced56@mail.gmail.com>
References: <20060624094217.GB7851@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 09:08:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuOjA-0003S9-Lp
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 09:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWFYHIE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 03:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWFYHIE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 03:08:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:33977 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751413AbWFYHID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 03:08:03 -0400
Received: by py-out-1112.google.com with SMTP id w49so1044402pyg
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 00:08:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PxpF1PgZD55IBaiQppUe5PB4RyqMn+JGUVZThjJ/pHWeE205+PMUQFuFR151NKkxcOs6mIKG1AIWlg7afoBrBNcq0bnuQ+1wVFssTtdE3Iacd5t4OPbR054alVVdmd7wXyNO+SCS+qLEd/He8pF0RhTtX2WLo3WhG/Wec1h9uno=
Received: by 10.35.101.9 with SMTP id d9mr4406231pym;
        Sun, 25 Jun 2006 00:08:03 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sun, 25 Jun 2006 00:08:02 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060624094217.GB7851@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22591>

On 6/24/06, Yann Dirson <ydirson@altern.org> wrote:
> Junio wrote:
> > I agree with this in principle but we would need to make sure
> > that our own scripts do not expect that the message is cleaned
> > up when feeding a commit log message via stdin, -m or -F, and if
> > they do fix them before applying this patch.
>
> The only tools in git.git I could identify as using git-commit rather
> than commit-tree are:
>
> git-revert.sh: OK
> git-rebase.sh: only uses -C
>
> cogito, stgit, and pg also use commit-tree.  Only qgit seems to be
> using git-commit, and probably makes use of this (mis)feature.
>

Yes, qgit uses git-commit, but issue is different.

qgit uses the output of git status as a 'default text' used in the
commit dialog. When commit button is pressed, after some message
editing by the user,  the comment lines are stripped _before_ to save
the content of commit message in a temporary file to be used by
git-commit with -F option.

The comment stripping is done by this code:

	msg = textEditMsg->text();
	msg.remove(QRegExp("\\n\\s*#[^\\n]*")); // strip comments
	msg.replace(QRegExp("[ \\t\\r\\f\\v]+\\n"), "\n"); // strip line trailing cruft
	msg = msg.stripWhiteSpace();

as you see it rely on the  '#' character.

So conclusions are:

1) It's ok to let git-comit do not strip comment lines, it's already
done by qgit.

2) Please don't change git status output to use another symbol to mark
comment lines because it will break line stripping code.

        Marco
