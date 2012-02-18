From: Jonathan Nieder <jrnieder@gmail.com>
Subject: SIGPIPE handling (Re: [PATCH v3 0/3])
Date: Sat, 18 Feb 2012 04:06:07 -0600
Message-ID: <20120218100517.GA8998@burratino>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
 <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
 <20120218005148.GA1940@sigill.intra.peff.net>
 <7v8vk0r481.fsf@alter.siamese.dyndns.org>
 <20120218085221.GA13922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jehan Bing <jehan@orb.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 18 11:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyhBi-0007Hl-BP
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 11:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab2BRKGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 05:06:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57477 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2BRKGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 05:06:36 -0500
Received: by iacb35 with SMTP id b35so5434163iac.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 02:06:35 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.179.8 as permitted sender) client-ip=10.50.179.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.179.8 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.179.8])
        by 10.50.179.8 with SMTP id dc8mr2033410igc.19.1329559595948 (num_hops = 1);
        Sat, 18 Feb 2012 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Tefv4bkgR0PPuH9lnFKPcyL8x0Xn//0LFmG9iozW3Sc=;
        b=qwDhRbEvmS2NaEFVqgVFYgCwSE+gzWV1WTrLDCrQ4IncQx2r78yA7KjX9JpkkD/ZsG
         NeAbZj4YQMvVRNWj7dJXbthTK6vDoiGIfMNQzuqNYhgQvwCqCAkgOx4fApPWge5kuwnU
         ghvnT96WacQtpXZF5eIjk1nNodIdDIbXz5JkE=
Received: by 10.50.179.8 with SMTP id dc8mr1643128igc.19.1329559595898;
        Sat, 18 Feb 2012 02:06:35 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b6sm1257736igj.7.2012.02.18.02.06.34
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 02:06:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120218085221.GA13922@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191001>

Hi,

Jeff King wrote:

> Less robust than that is to just ignore SIGPIPE in most git programs
> (which don't benefit from it, and where it is only a liability), but
> then manually enable it for the few that care

This seems backwards.  Aren't the only places where it is just a
liability places where git is writing to a pipe that git has created?

We could keep the benefits of SIGPIPE (including simpler error
handling and lack of distracting EPIPE message) in most code, and only
switch to SIGPIPE-ignored semantics where the signal has a chance to
cause harm.  Maybe run_command should automatically ignore SIGPIPE
when creating a pipe for the launched command's standard input (with a
flag to ask not to), as a rough heuristic.

There's a subtlety I'm glossing over here, which is that for commands
that produce a lot of output (think: "git fetch --all"), output may
still not the primary goal.  I think even they should not block
SIGPIPE, to follow the principle of least surprise in the following
interaction:

	git fetch --all 2>&1 | less
	... one page later, get bored ...
	q (to quit)

Most Unix programs would be killed by SIGPIPE after such a sequence,
so I would expect git to be, too.

Just my two cents,
Jonathan
