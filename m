From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Sat, 30 Jan 2016 13:09:33 +0000
Message-ID: <20160130130933.GA26365@dcvr.yhbt.net>
References: <20160128115720.GA1827@dcvr.yhbt.net>
 <xmqqtwlxjdbx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 14:10:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPVIF-0006ks-8h
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 14:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbcA3NJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 08:09:36 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53588 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbcA3NJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 08:09:35 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48A11F736;
	Sat, 30 Jan 2016 13:09:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqtwlxjdbx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285109>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > getaddrinfo() may return multiple addresses, not all of which
> > are equally performant.  In some cases, a user behind a non-IPv6
> > capable network may get an IPv6 address which stalls connect().
> 
> I'd assume that you are not solving a hypothetical problem, but you
> may (at least sometimes) have to reach outside world from such a
> network environment.  I further assume that git_tcp_connect() is not
> the only activity you do from such a network, and other network
> activities are similarly affected.

Right.  I only recently started building kernels for this
netbook with IPv6 support.   Most of my traffic from this host
is git/ssh-tunneled and the host I ssh to does not have an AAAA
record.

> How do you work around the same issue for connections that do not go
> through git_tcp_connect()?  The same issue would affect Git traffic
> going over git-remote-curl, and also your usual Web browser traffic,
> no?

So this is a new issue for me, and I don't use a browser much.

I noticed the curl(1) tool didn't have the problem with http.

Looking at curl, it actually has limited parallelization
(see HAPPY_EYEBALLS_TIMEOUT timeout handling in lib/connect.c
of git://github.com/bagder/curl.git).  It starts a parallel
connection on a different family if the first address takes
longer than 200ms.  This does not seem true of our libcurl
usage, though...

I tried implementing what curl does in connect.c, but it was
complicated for me (or more likely, I'm easily confused :x).
It was much easier for me to start everything up in parallel
as I did in my original patch.

> What I am getting at is if it is saner to solve the issue like how
> curl(1) solves it with its -4/-6 command line options, e.g. by
> adding a pair of configuration variables "net.ipv[46] = true/false".

Yes, a -4/-6 patch is on the way for command-line switches.  I'm
not sure if a config file variable is a good idea since it could
be overlooked and cause non-obvious conflicts with /etc/gai.conf
settings.

Of course, I would rather have something transparent to the user
like curl(1)-style happy eyeballs parallelization if it could be
implemented in a straightforward way.
