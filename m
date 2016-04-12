From: Eric Wong <normalperson@yhbt.net>
Subject: Re: clone hang prevention / timeout?
Date: Tue, 12 Apr 2016 08:01:49 +0000
Message-ID: <20160412080149.GA9087@dcvr.yhbt.net>
References: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Vas Dias <jason.vas.dias@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 10:01:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aptGl-0006nF-Id
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 10:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbcDLIBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 04:01:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34427 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbcDLIBv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 04:01:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160B420300;
	Tue, 12 Apr 2016 08:01:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291250>

Jason Vas Dias <jason.vas.dias@gmail.com> wrote:
> It appears GIT has no way of specifying a timeout for a clone operation -
> if the server decides not to complete a get request, the clone can
> hang forever -
> is this correct ?

git uses SO_KEEPALIVE for all connections it makes, so whatever
your kernel TCP keepalive knobs are set at.

By default, it's very long (around 2 hours), but you can change them
using the tcp_keepalive_* knobs in /proc/sys/net/ipv4/ under Linux.

I suppose we can do shorter timeouts (at least under Linux) via
setsockopt(.. TCP_KEEP*) knobs, or we can call poll() ourselves
to timeout connections.  However, git packing operations on the
server can take a long time; so it might be bad to timeout
manually unless we know the connection is really dead.

> This appears to be what I am seeing, in a script that is attempting to do many
> successive clone operations, eg. of
> git://anongit.freedesktop.org/xorg/* , the script
> occasionally hangs in a clone - I can see with netstat + strace that the TCP
> connection is open and GIT is trying to read .
> Is there any option I can specify to get the clone to timeout, or do I manually
> have to strace the git process and send it a signal after a hang is detected?

I added git:// support for SO_KEEPALIVE in commit e47a8583a202
("enable SO_KEEPALIVE for connected TCP sockets")
back in 2011 (v1.7.10),
and http:// support later in 2013 (v1.8.5) with
commit a15d069a1986 ("http: enable keepalive on TCP sockets")
