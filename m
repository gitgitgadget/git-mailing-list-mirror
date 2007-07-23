From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 01:22:24 -0400
Message-ID: <20070723052224.GF32566@spearce.org>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222223460.14781@racer.site> <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222255010.14781@racer.site> <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org> <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <20070723051437.GE32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICqNQ-0004fj-6H
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 07:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbXGWFWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 01:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbXGWFWe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 01:22:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42742 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbXGWFW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 01:22:29 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICqNF-0002KY-PR; Mon, 23 Jul 2007 01:22:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6A7CA20FBAE; Mon, 23 Jul 2007 01:22:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070723051437.GE32566@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53393>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> >  static int lock_file(struct lock_file *lk, const char *path)
> >  {
> >  	int fd;
> > +	struct stat st;
> > +
> > +	if ((!lstat(path, &st)) && S_ISLNK(st.st_mode)) {
> > +		ssize_t sz;
> > +		static char target[PATH_MAX];
> > +		sz = readlink(path, target, sizeof(target));
> > +		if (sz < 0)
> > +			warning("Cannot readlink %s", path);
> > +		else
> > +			path = target;
> > +	}
> >  	sprintf(lk->filename, "%s.lock", path);
> >  	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
> >  	if (0 <= fd) {
> 
> Right.  But don't you have to resolve target relative to path?
> If the symlink is an absolute path its fine as-is, but if it was
> relative its relative to path, not pwd.

It might just be OK to refuse to lock a symlink that isn't absolute.
git-new-workdir already uses absolute paths to setup the symlinks.

-- 
Shawn.
