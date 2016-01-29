From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Fri, 29 Jan 2016 01:41:06 +0000
Message-ID: <20160129014106.GA8940@dcvr.yhbt.net>
References: <20160128115720.GA1827@dcvr.yhbt.net>
 <xmqqio2dl18i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 02:41:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOy3j-00032n-4j
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 02:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbcA2BlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 20:41:08 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53716 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcA2BlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 20:41:07 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEE01F736;
	Fri, 29 Jan 2016 01:41:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqio2dl18i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285051>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > getaddrinfo() may return multiple addresses, not all of which
> > are equally performant.  In some cases, a user behind a non-IPv6
> > capable network may get an IPv6 address which stalls connect().
> > Instead of waiting synchronously for a connect() to timeout, use
> > non-blocking connect() in parallel and take the first successful
> > connection.
> >
> > This may increase network traffic and server load slightly, but
> > makes the worst-case user experience more bearable when one
> > lacks permissions to edit /etc/gai.conf to favor IPv4 addresses.
> 
> Umm.  I am not sure what to think about this change--I generally do
> not like a selfish "I'll try to use whatever resource given to me
> to make my process go faster, screw the rest of the world" approach
> and I cannot decide if this falls into that category.
> 
> I'll wait for opinions from others.

No problem, I can also make it cheaper for servers to handle
aborted connections in git-daemon:

standalone:

  1) use recv with MSG_PEEK or FIONREAD to determine if there's
     readable data in the socket before forking (and avoid
     forking for zero-bytes-written connections)

  2) use TCP_DEFER_ACCEPT in Linux and dataready filter in FreeBSD
     for standalone git-daemon to delay accept()

inetd:

  3) suppress die("The remote end hung up unexpectedly")
     if no bytes are read at all

At some point in the future, I would love to have git-daemon implement
something like IDLE in IMAP (to avoid having clients poll for updates).
Perhaps the standalone changes above would make sense there, too.
