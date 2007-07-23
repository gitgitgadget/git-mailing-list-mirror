From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fast-import and core.autocrlf option
Date: Mon, 23 Jul 2007 00:01:33 -0400
Message-ID: <20070723040133.GD32566@spearce.org>
References: <a1bbc6950707221559m63fb1295jc26b1327e71687e3@mail.gmail.com> <Pine.LNX.4.64.0707230039560.14781@racer.site> <20070723034514.GZ32566@spearce.org> <7vwswrojzq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICp78-00007h-Oi
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 06:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbXGWEBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 00:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbXGWEBj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 00:01:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41181 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbXGWEBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 00:01:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICp6p-0007Fn-1m; Mon, 23 Jul 2007 00:01:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0416420FBAE; Mon, 23 Jul 2007 00:01:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vwswrojzq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53386>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Right, in fast-import we only process blobs as raw blobs.
> > Its rare that we have a file path associated with the blob data
> > at the time that we are actually processing the blob itself.  E.g.
> > applications can send us blobs up front, before they even start to
> > send us commits and path information.
> 
> Don't the front-ends usually have path information already when
> they feed you a blob data, especially most of them operate on
> per-file history?  If that is the case,...

Depends.  A frontend can feed huge streams of blobs and use marks
to make us remember their SHA-1s, then later feed us those marks
and connect them to paths.  Such a frontend may not have exact path
information available when it feeds the blobs to us.  Then again
maybe it does.  Depends on how the source information was organized.

> > So if we were to offer the CRLF->LF conversion feature in fast-import
> > it would need to be an option supplied at the time the 'data'
> > command issued, rather than based upon the gitattributes system
> > that is normally used for working tree operations.
> 
> ... the "option" could be "this came from such and such path"
> instead of "this is DOS data, please apply crlf".

How do we setup .gitattributes?  Should it be read from a branch
in memory, or the working directory?

If it should be read from a branch, which branch?  What if the
frontend does not want the .gitattributes file in the history
of the import?  Putting it into a branch just to cause CRLF->LF
translation during import would require filter-branch afterwards
to strip out the file.

I'd rather make things very explicit.  If the frontend wants us to
apply a filter to a data chunk before we work further on it then
the frontend should give us the .gitattributes rules to apply as
part of the data command.

-- 
Shawn.
