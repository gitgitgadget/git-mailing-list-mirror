From: Jeff King <peff@peff.net>
Subject: Re: Inexplicable merge conflict produced when when lines next to
 each other are changed
Date: Tue, 28 Apr 2015 22:35:10 -0400
Message-ID: <20150429023509.GB438@peff.net>
References: <loom.20150428T093059-405@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anuradha Dissanayake <falconne@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 04:35:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnHqI-0003o8-IY
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 04:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031457AbbD2CfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 22:35:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:51493 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031333AbbD2CfN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 22:35:13 -0400
Received: (qmail 4124 invoked by uid 102); 29 Apr 2015 02:35:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 21:35:13 -0500
Received: (qmail 23343 invoked by uid 107); 29 Apr 2015 02:35:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 22:35:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 22:35:10 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150428T093059-405@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267954>

On Tue, Apr 28, 2015 at 07:34:30AM +0000, Anuradha Dissanayake wrote:

> Let's say I have a file with this content in master:
> 
> _____
> Line 1
> Line 2
> Line 3
> Line 4 
> _____
> 
> Now say I create and checkout a new branch called Test. In this branch I 
> change the file to this:
> 
> _____
> Line 1
> Line 2
> Line 3 Modified
> Line 4 
> _____
> 
> and I commit this and switch back to master. In master I change the file 
> to:
> 
> _____
> Line 1
> Line 2
> Line 3
> Line 4 Modified 
> _____
> 
> and I commit. Now if I merge branch Test into master, I get a conflict.
> 
> Why can't git auto resolve this, as those are two entirely independent 
> lines?

The content-level merge in git looks for overlapping diff hunks. It does
have a "level" setting which will try with varying degrees of effort to
shrink the conflict section, but I do not think there is a setting that
will resolve this cleanly. Short of teaching a new level to the libxdiff
merge code, I think the best you can do is to specify your own
content-level merge driver for these files, and feed the data to another
program which does the merge differently (whether it is simply more
aggressive at finding conflicts, or it might even know something about
the semantics of the file). See the "three-way merge" section in "git
help attributes".

> If I tell git to edit conflicts using BeyondCompare as the 
> difftool, BeyondCompare autoresolves this without even telling the user, 
> since this isn't a real conflict (other merge tools we use at our 
> company do so also). Is there a way to get git to autoresolve these? 
> I've tried the recursive and resolve merge strategies but neither do it.

I don't think a change of merge strategy will help; they all end up
doing the content-level merge with the same libxdiff code.

-Peff

PS I'm answering your "how to" questions directly without considering
   whether what you are asking for is a good idea. But you may want
   to think about whether there is a case that matches the above pattern
   that you would _not_ want to auto-resolve (i.e., even though there is
   not strictly a textual conflict, there is a good chance there is a
   semantic conflict because the lines are so close together).
