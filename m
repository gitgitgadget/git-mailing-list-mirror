From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Fix bunch of fd leaks in http-fetch
Date: Sat, 12 Nov 2005 19:37:13 -0800
Message-ID: <20051113033713.GC24546@reactrix.com>
References: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com> <20051111235516.GY30496@pasky.or.cz> <7vk6feiflx.fsf@assigned-by-dhcp.cox.net> <20051112173828.GG4051@reactrix.com> <20051112195513.GF30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 17:31:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhEG-00016C-J5
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVKNQak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVKNQaj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:30:39 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:26239 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751059AbVKNQaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:30:39 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAEGUWnK003911
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 08:30:32 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAEGUWrc003909
	for git@vger.kernel.org; Mon, 14 Nov 2005 08:30:32 -0800
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051112195513.GF30496@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11808>

On Sat, Nov 12, 2005 at 08:55:13PM +0100, Petr Baudis wrote:

> What about the rest of the leaks?
> 
> Specifically, the one around release_request(), and the one caused by
> re-open()ing local in start_request() when re-calling it on existing
> request.

There should be a close before calling start_request() with an
alternate - start doesn't currently check for an existing fd before it
opens a new one.  There should also be closes for the indexfile and packfile
fds.

So our patches combined should take care of those cases and report on
anything that may have been missed, which doesn't seem like a bad thing.
The extra close in fetch_object shouldn't cause any problems because
it only happens if there is still a valid fd in the request, which
should never happen...

I'm pretty sure that fds are either already closed or were never opened
prior to each call to release_request though.  release is called in the
following circumstances:

1) process_request_queue finds a WAITING request and the sha1 exists
   locally, no need to start() and the fd is never opened
2) fetch_object finds the sha1 exists locally, which means the object
   was already in the repo (same as #1) or prefetch got it loose
   and called finish
3) fetch_object finds an ABORTED request; requests abort when open fails
   or when the request didn't start (in which case the fd was closed
   after setting the request state)
4) fetch_object finds a request that isn't WAITING/ACTIVE/ABORTED
   (ie. COMPLETE);  finish is called when the request state is set
   to COMPLETE except in the aforementioned alternate restart case

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
