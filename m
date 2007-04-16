From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git push over http is very dangerous
Date: Mon, 16 Apr 2007 13:20:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161303580.5473@woody.linux-foundation.org>
References: <462394AC.303@beronet.com> <Pine.LNX.4.64.0704161212140.5473@woody.linux-foundation.org>
 <7vk5wcrt5m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian <crich-ml@beronet.com>, git@vger.kernel.org,
	Nick Hengeveld <nickh@reactrix.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdXhY-0004Xp-LK
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 22:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030957AbXDPUU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 16:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030958AbXDPUU5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 16:20:57 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48889 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030957AbXDPUU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 16:20:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GKKlIs002215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 13:20:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GKKkEV011069;
	Mon, 16 Apr 2007 13:20:47 -0700
In-Reply-To: <7vk5wcrt5m.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44694>



On Mon, 16 Apr 2007, Junio C Hamano wrote:
> 
> Just for the record, I do not think anybody during that #git
> discussion actually proved that http-push was the culprit.  It
> is a very plausible working conjecture, though.

I looked at http-push.c once more, and there is a very marked lack of any 
error testing. It actually tries to be pretty careful, ie it seems that 
every PUT request is always to a temp-file, and then it does a MOVE 
request after that, and things seem to properly abort on most errors, but 
the actual data integrity is obviously impossible to check on the remote, 
and a quick grep showed that not all errors even set "aborted", which 
would seem to imply that certain error conditions can happen without the 
http-push then aborting the ref update.

For example, if "start_active_slot()" fails, aborted isn't generally set. 
I don't know if that is ever a problem (it can only trigger with 
USE_CURL_MULTI), but it's an example of what looks pretty fragile.

So we can fix up some of these kinds of things, but considering that we 
can't really validate the end result on the remote, I'd still personally 
be quite leery of pushing by http..

> I think the fetch side does the right thing, more or less, by
> downloading to a temporary file and using move_temp_to_file()
> after validating the SHA-1 matches.

Yeah, on the pulling side we are simply much better off, because we can 
validate things after the operation has finished. On the pushing side, we 
could obviously try to re-download the objects or something, but basically 
validation would literally have to involve doubling the network usage, and 
even then we might get screwed by some caching layer!

		Linus
