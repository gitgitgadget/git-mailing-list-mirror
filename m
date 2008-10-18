From: Jeff King <peff@peff.net>
Subject: Re: Excluding files from git-diff
Date: Sat, 18 Oct 2008 11:59:13 -0400
Message-ID: <20081018155912.GA20387@coredump.intra.peff.net>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net> <48F8BDA7.50901@pflanze.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Erik Hahn <erik_hahn@gmx.de>, git@vger.kernel.org
To: Christian Jaeger <christian@pflanze.mine.nu>
X-From: git-owner@vger.kernel.org Sat Oct 18 18:00:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrEE9-0006jn-TK
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 18:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYJRP7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 11:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbYJRP7Q
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 11:59:16 -0400
Received: from peff.net ([208.65.91.99]:2203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbYJRP7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 11:59:15 -0400
Received: (qmail 2278 invoked by uid 111); 18 Oct 2008 15:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 18 Oct 2008 11:59:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2008 11:59:13 -0400
Content-Disposition: inline
In-Reply-To: <48F8BDA7.50901@pflanze.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98556>

On Fri, Oct 17, 2008 at 06:30:31PM +0200, Christian Jaeger wrote:

> For me, adding entries to that file does not make "git diff" or "gitk" or 
> even "git ls-files" ignore files matching the entries. Only "git ls-files 
> --others --exclude-from=.git/info/exclude" will exclude them. And "git 
> diff " and gitk don't seem to know the --exclude-from option.

What you are seeing is:

  - ls-files is plumbing, and does not do any exclusion by default. So
    you need to use the --exclude-from option, or more easily,
    --exclude-standard (which pulls in .git/info/excludes, .gitignore,
    and user-level excludes).

  - porcelain _does_ do exclusion. However, exclusion does not mean "if
    this file is tracked by git, don't include it in the diff." It
    merely means "if this file is untracked, pretend like it is not
    there." So a diff displayed by "git diff" isn't affected by
    exclusions anyway.

> Is there a way to really invert the patterns given to "git diff" or  
> alike? I.e. instead of saying "git diff -- * .somedotfile  
> .someothernongitignoredotfile" one could just say something like "git  
> diff --invert-matches -- .gitignore"? And even better, could one  
> configure some such so that it has effect on all tools by default?

No, I don't think there is a way to do that currently. I would probably
generate the file list with a shell snippet:

  git diff -- `git ls-files | grep -v .gitignore`

but obviously that is a lot more typing if this is something you are
doing frequently.

-Peff
