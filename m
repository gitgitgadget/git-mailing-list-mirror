From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --log-size to git log to print message size
Date: Fri, 20 Jul 2007 22:49:17 +0200
Message-ID: <e5bfff550707201349i52363837o739d27c6c4dc3ec8@mail.gmail.com>
References: <e5bfff550707201115v2531434erd9e10a2b816a59bf@mail.gmail.com>
	 <Pine.LNX.4.64.0707201939170.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 20 22:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBzPd-00036z-NA
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 22:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762761AbXGTUtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762616AbXGTUtS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 16:49:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:37007 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762323AbXGTUtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 16:49:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1125457wah
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 13:49:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kag2ScukrATjYjtEXTllFdnMZPwF3LXvd+BFKCGz+F/q9Qc3gDkqW81V51rD6w08jPTHARnHbLmNrifxv2XxpYvOs9PDAp8xbE5eoZt38dzmB4ckxS2Rapym1Px7tFJ1wuRkZ1sC2SPRB1xOf8H3iZ48KwxadK53PxuIdL8dTos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJBjKETq/p/e4pg+E/dP3m072okK4TfQ0fCT3XvVfOBVXQS+7s4oGPXxXUdLVAUyq5BNaPusJDZIRQNEKhYI6d6bJPtsNS+FoY5dUWjrI8GX6fGrnPvzz+JTUf8CcatO+d3BqGYehZAYSP1pHWGsr0bqFqodBOFdMe5Kjlg9KUU=
Received: by 10.114.37.1 with SMTP id k1mr850552wak.1184964557044;
        Fri, 20 Jul 2007 13:49:17 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Fri, 20 Jul 2007 13:49:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707201939170.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53120>

On 7/20/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 20 Jul 2007, Marco Costalba wrote:
>
> > This is take 3 of this patch. In this case has been clearly added that
> > diff content size is not included.
>
> Two concerns and a half:
>
> - if you do not include the diff content size, don't you need to parse the
>   output anyway?
>

First, dif content is included only when retrieving file history and
not to show revisions at startup that is the main use.

Second, also with diff content I don't parse the message because I
jump directly to the beginning of the diff and, yes, from there I
check for delimiting '\0', so I would say also in that case we have a
speedup, but it's not very important because we are talking of speed
up when you read thousands of revisions, few hundred (as typical in
file histories) are not a problem.

Also because with -p option git log becomes a real bottleneck.


> - what do you do if the underlying Git does not support --log-size? Exit?
>

If for "not support" you mean that underlying Git sets size at zero
(as allowed by specifications) this is of course handled: qgit falls
back on legacy '\0' search. BTW the currently  published version does
exactly that, it has already the shortcut logic, but falls back always
on zero search because the modified git is _currently_ only on my hard
disk.


Otherwise, if you mean that git version is too old, in this case this
is caught by the git version check done always at startup.

Indeed I plan to add this feature only to new qgit4, will not be back
ported to stable qgit-1.5.6

> - Would it not be much quicker to read the rev-list, and read messages
>   only on demand?
>

That's exactly what we are talking about ;-)

 All the output of git-log (no more git-rev-list) is stored in memory
as a raw big binary blob, for quick retrieval, i.e. to avoid calling
an external git command process, but messages are not parsed until are
used. So _this_ is exactly the point of all this patch.

If you mean using git-rev-list without --header options then , also
not considering that currently we use git-log, the speed up is very
small and when you have to show something to the user you always need
to run a git command.

Perhaps this could be accepted (perhaps not ;-) for mouse browsing
through revisions, but what about sub string searching as example on
author or log title fields? probably it would became super slow also
for lists of only few hundred revs.


> Ciao,
> Dscho

Ciao
Marco
