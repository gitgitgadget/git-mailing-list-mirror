From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 18:09:33 -0500
Message-ID: <20151113230933.GA16173@sigill.intra.peff.net>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
 <20151113062534.GE32157@sigill.intra.peff.net>
 <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com>
 <20151113222748.GA14830@sigill.intra.peff.net>
 <CABA5-zmmKeeDDhSdan9sTppRVeDNuPiR8WX=P4Umdbq=ELafqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:10:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNTk-0003Mo-FS
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbbKMXJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:09:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:57306 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751071AbbKMXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:09:36 -0500
Received: (qmail 15359 invoked by uid 102); 13 Nov 2015 23:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:09:36 -0600
Received: (qmail 29491 invoked by uid 107); 13 Nov 2015 23:10:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:10:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 18:09:33 -0500
Content-Disposition: inline
In-Reply-To: <CABA5-zmmKeeDDhSdan9sTppRVeDNuPiR8WX=P4Umdbq=ELafqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281269>

On Fri, Nov 13, 2015 at 11:47:40PM +0100, Fredrik Medley wrote:

> > Hmm. Now I'm a bit puzzled. It sounds like the installed file does have
> > @SHELL_PATH@ set to /bin/sh, which is normal. And presumably the setting
> > containing space is coming from the $SHELL environment variable.
> I wrote the email on another computer. Checking the system where I reinstalled
> Git for Windows yesterday shows ${SHELL:-/bin/sh} and SHELL=/usr/bin/bash
> When running "git rebase --interactive HEAD^ --exec 'echo $SHELL'", I get
> mingw64/libexec/git-core/git-rebase--interactive: line 613:
> C:/Program: No such file or directory
> 
> Fixing the double quotes, "git rebase --interactive HEAD^ --exec 'echo
> $SHELL'" shows
> C:/Program Files/Git/usr/bin/bash

It looks like bash on your system may simply be filling in its absolute
path into the $SHELL variable. This seems like an interesting bash-ism:

  $ unset SHELL
  $ dash -c 'echo $SHELL'

  $ bash -c 'echo $SHELL'
  /bin/bash

If $SHELL is already set and exported, it will not override it, but in
your case $SHELL is probably local to each individual bash invocation.

So that at least kind-of makes sense. It's possible somebody could be
doing something clever with $SHELL, but I kind of doubt it. If they want
to do something clever, it is much easier to put it directly on the exec
line, and have the normal $SHELL run their clever thing.

-Peff
