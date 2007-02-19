From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-export ?
Date: Mon, 19 Feb 2007 03:25:26 -0500
Message-ID: <20070219082525.GD30030@spearce.org>
References: <eqoaf7$loq$1@sea.gmane.org> <20070212011401.GK31488@spearce.org> <45D84A6B.3060402@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 19 09:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ3q2-0007Fv-De
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 09:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbXBSIZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 03:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXBSIZa
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 03:25:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54102 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbXBSIZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 03:25:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJ3pv-0003AP-5U; Mon, 19 Feb 2007 03:25:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67C0B20FBAE; Mon, 19 Feb 2007 03:25:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45D84A6B.3060402@xs4all.nl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40104>

Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> Wouldn't it make sense to build a git-fast-export, which 
> can be used to interrogate a git-repository: a GIT tool 
> could run a single git command, 
> 
> this would make interfacing with Git from scripts more ergonomical, 
> less dependent on changes in the UI of porcelains, and in some cases
> more efficient.

Maybe.

But without knowing what the UI program wants, its hard to say what
should be implemented there.  I'm not going to create something on
a hunch that it will be useful someday - that's just not a practical
use of my time.

Worse, most scripting level languages have a hard time working
with a bidirectional pipe to a process.  What you want here is
stdin and stdout pipes, so you can send a command and then receive
the response.  This can be a challenge in something like Tcl,
maybe not fully portable in Perl, etc.

Even worse, some parts of Git are not reentrant.  They are currently
built to run once and have the UNIX process terminate quickly
afterwards.  Keeping it running to answer more queries from the
UI may cause the Git process to leak memory over a longer term,
cause it to crash after a couple of successive repack/prune/gc, etc.

There are a number of interesting operations within Git that a UI
would want to query, but that may not be a good idea to expose from
a within a long running UNIX process, for those reasons.  fast-import
doesn't do these, so its reasonable to keep up for extended periods,
but even fast-import assumes it will terminate at some point as it
hangs onto its object table for the entire lifespan of the process.

-- 
Shawn.
