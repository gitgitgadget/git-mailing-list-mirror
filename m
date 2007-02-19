From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Mon, 19 Feb 2007 02:56:54 -0500
Message-ID: <20070219075654.GB30030@spearce.org>
References: <1171838852534-git-send-email-mdl123@verizon.net> <Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 08:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ3OT-0003UM-1G
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 08:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXBSH5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 02:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbXBSH5A
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 02:57:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53263 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXBSH47 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 02:56:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJ3OK-000254-4d; Mon, 19 Feb 2007 02:56:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1996820FBAE; Mon, 19 Feb 2007 02:56:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40102>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 18 Feb 2007, Mark Levedahl wrote:
> > +    gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1
> 
> Here, you rely again on the refs not containing spaces.

They cannot.  OK, they can if you avoid any of the Git code:

  git rev-parse HEAD >".git/refs/heads/ref with space"

but a lot of things downstream may get annoyed by doing this.
Spaces are not permitted in ref names.
 
> > +    # create refs and pack
> > +    tmp="$GIT_DIR/bundle_tmp$$"
> 
> Should we really rely on $GIT_DIR being writable? For unbundling, yes, but 
> for bundling? Given the great confusion with git-status trying to write 
> into $GIT_DIR, and people _demanding_ that it does not do so, I recommend 
> against that.

I agree.  For an application like bundle creation, $GIT_DIR should be
strictly read-only.  There is no reason for this application to need
to create temporary files, as the bundle can be streamed to stdout
(or optionally to a file supplied by the user on the command line).

> > +    git-rev-list --objects $fullrevargs | cut -b-40 |
> > +        git pack-objects --all-progress --stdout > "$pack" &&
> 
> pack-objects can take rev-list arguments itself these days, using "--revs" 
> and being piped the rev-list arguments.

Uh, actually it can't.  I thought it could too.  It doesn't.
It can only take a ref name or --not.  I'm actually not sure why
we limited it like that, but we did...  It may be a good idea to
change that restriction to not exist.
 
-- 
Shawn.
