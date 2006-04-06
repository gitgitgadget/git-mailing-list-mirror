From: linux@horizon.com
Subject: Re: Cygwin can't handle huge packfiles?
Date: 6 Apr 2006 16:57:24 -0400
Message-ID: <20060406205724.12216.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Apr 06 22:57:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRbXv-0005LF-6i
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 22:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWDFU5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 16:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWDFU5g
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 16:57:36 -0400
Received: from science.horizon.com ([192.35.100.1]:30276 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751210AbWDFU5g
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 16:57:36 -0400
Received: (qmail 12217 invoked by uid 1000); 6 Apr 2006 16:57:25 -0400
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18481>

> Right now we LRU the pack files and evict older ones when we
> mmap too many, but the unit of eviction is the whole file, so it
> would not help the case like yours at all.  It might be possible
> to mmap only part of a packfile, but it would involve fairly
> major surgery to sha1_file.c.

The simplest solution seems to be to limit pack file size to a reasonable
fraction of a 32-bit address space.  Say, 0.5 G.

That should be a fairly straightforward hack to git-pack-objects.
It already emits two files; just make it emit more.

You can tweak the heurisitics to try to find a good break point: start
thinking about splitting the pack when you get to one size, but don't
force a break until you hit a harder limit as long as the deltas are
working well.

This can all be adjustable with a command line and/or config file option
to allow for the eventual demise of 32-bit systems.
