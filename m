From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 3/4] Cap the number of open files in the WindowCache
Date: Wed, 18 Mar 2009 01:09:39 +0100
Message-ID: <200903180109.40074.robin.rosenberg.lists@dewire.com>
References: <1237252570-8596-1-git-send-email-spearce@spearce.org> <200903172359.32595.robin.rosenberg.lists@dewire.com> <20090317230803.GA23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 01:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjjNO-0007tE-DA
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbZCRAJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZCRAJt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:09:49 -0400
Received: from mail.dewire.com ([83.140.172.130]:19150 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbZCRAJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:09:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 490E8138AD50;
	Wed, 18 Mar 2009 01:09:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEF73mbRC4Us; Wed, 18 Mar 2009 01:09:41 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4266D80289C;
	Wed, 18 Mar 2009 01:09:41 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090317230803.GA23521@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113540>

onsdag 18 mars 2009 00:08:03 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > tisdag 17 mars 2009 02:16:09 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > 
> > > If we detect a file open failure while opening a pack we halve
> > > the number of permitted open files and try again, [...]
> > 
> > The output of getMessage isn't that simple to interpret. Here it is filename+" (Too many files open)",
> > and on other platforms it is probably something else. This goes for the message part of most exceptions
> > thrown from platform specific code like file i/o socket i/o etc. The type of exception is a FileNotFoundException,
> > btw.
> > 
> > I wonder whether  your code works on any platform.
> 
> Arrrgh.
>  
> OK.  Maybe scrap that part of the patch then?
Yes, I think so, inless you want to try something as ugly as getMessage().toLower().indexof("(too many")? Not
sure what it looks like in Windows or OSX. We know from the JDK source it's filename + "(" + reason +")" and
the problem here is the reason part.

> Its too bad they don't have a specific type of exception for this,
FileNotFoundException is a little more specific. Maybe in combinatikon with a file.exists() and file.canRead test...
(thinking loud now)

> nor do they have a way to hold onto file descriptors under a type
> like a SoftReference where the runtime can whack them if you have
> too many.

The problem is that it's not connected to file descriptors but to memory. Doing a GC on filenotfoundexception
(here) could help here if one uses soft reference, or one could prune the cache manually. The parameter
could also be a 

> 
> I guess that's why Hadoop HBase just tells you to up your fd ulimit
> to 32767.  :-)

Yeah, with gigabytes of memory that might not consume too much resources anyway.

-- robin
