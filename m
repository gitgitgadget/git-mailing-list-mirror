From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Errors cloning large repo
Date: Mon, 12 Mar 2007 10:24:51 -0400
Message-ID: <20070312142451.GC15150@spearce.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <esu11i$m54$1@sea.gmane.org> <20070311020013.GD10343@spearce.org> <200703121209.35052.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 15:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQlSN-0005mZ-Gr
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 15:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965887AbXCLOY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 10:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965890AbXCLOY4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 10:24:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43313 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965887AbXCLOYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 10:24:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQlSB-0006Jg-PI; Mon, 12 Mar 2007 10:24:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DAAB220FBAE; Mon, 12 Mar 2007 10:24:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200703121209.35052.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42031>

Jakub Narebski <jnareb@gmail.com> wrote:
> But what would happen if server supporting concatenated packfiles
> sends such stream to the old client? So I think some kind of protocol
> extension, or at least new request / new feature is needed for that.

No, a protocol extension is not required.  The packfile format
is: 12 byte header, objects, 20 byte SHA-1 footer.  When sending
concatenated packfiles to a client the server just needs to:

  - figure out how many objects total will be sent;
  - send its own (new) header with that count;
  - initialize a SHA-1 context and update it with the header;
  - for each packfile to be sent:
    - strip the first 12 bytes of the packfile;
    - send the remaining bytes, except the last 20;
    - update the SHA-1 context with the packfile data;
  - send its own footer with the SHA-1 context.

Very simple.  Even the oldest Git clients (pre multi-ack extension)
would understand that.  That's what's great about the way the
packfile protocol and disk format is organized.  ;-)
 
> Wouldn't it be better to pack loose objects into separate pack
> (and perhaps save it, if some threshold is crossed, and we have
> writing rights to repo), by the way?

Perhaps.  Interesting food for thought, something nobody has tried
to experiment with.  Currently servers pack to update the fetching
client.  That means they may be sending a mixture of already-packed
(older) objects and loose (newer) objects.  But with the new kept
pack thing in receive-pack its more likely that things are already
packed on the server, and not loose.  (I suspect most public open
source users are pushing >100 objects when they do push to their
server.)
 
> > The client could easily segment that into multiple packfiles
> > locally using two rules:
> > 
> >   - if the last object was not a OBJ_COMMIT and this object is
> >   an OBJ_COMMIT, start a new packfile with this object.
...
> 
> Without first rule, wouldn't client end with strange packfile?
> Or would it have to rewrite a pack?

Nope.  We don't care about the order of the objects in a packfile.
Never have.  Never will.  Even in pack v4 where we have special
object types that should only appear once in a packfile, they can
appear at any position within the packfile.  MUCH simpler code.

-- 
Shawn.
