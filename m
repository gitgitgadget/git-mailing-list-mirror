From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Show URL in the "Getting <foo> list" http-fetch messages
Date: Mon, 14 Nov 2005 12:11:46 -0800
Message-ID: <7vveyvxa4d.fsf@assigned-by-dhcp.cox.net>
References: <20051112004958.21857.95728.stgit@machine.or.cz>
	<20051112005803.GZ30496@pasky.or.cz>
	<7vwtjeis09.fsf@assigned-by-dhcp.cox.net>
	<20051112172201.GF4051@reactrix.com>
	<20051114190225.GA3793@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 21:14:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbkgI-00055y-U9
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 21:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKNULt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 15:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVKNULt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 15:11:49 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43194 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932074AbVKNULs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 15:11:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114201039.UFTV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 15:10:39 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051114190225.GA3793@reactrix.com> (Nick Hengeveld's message of
	"Mon, 14 Nov 2005 11:02:26 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11843>

Nick Hengeveld <nickh@reactrix.com> writes:

> On Sat, Nov 12, 2005 at 09:22:02AM -0800, Nick Hengeveld wrote:
>
>> This should not be an issue with index requests because they are only
>> initiated from fetch().  The previous patch to load alternates on demand
>> added alternate handling to process_curl_messages() so that a 404 for an
>> object can be handled immediately rather than waiting for the fetch()
>> call for that object to notice.
>
> Seems like it might make sense to handle pack downloads immediately when
> an object is unavailable rather than waiting for the fetch() call.  It
> could prevent attempts to download any other objects inside that pack,
> although queued requests that activate while a pack is downloading
> would have to wait to see whether the download is successful.

I think that makes sense, and it probably is preferable to make
them wait than blindly go ahead.  Although we are issuing
requests in parallel, these simultaneous requests are asking for
related things (e.g. parent commit objects or the tree object of
the commit we just saw; blob objects contained in the tree we
just saw) and are more likely than not to be found in the pack
being requested.  Losing parallelism while a pack is in transit
would not be too much of a problem.
