From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 01:14:37 -0400
Message-ID: <20070723051437.GE32566@spearce.org>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222223460.14781@racer.site> <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222255010.14781@racer.site> <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org> <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICqG3-0003HC-Ef
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 07:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903AbXGWFOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 01:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757905AbXGWFOs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 01:14:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42637 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820AbXGWFOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 01:14:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICqFj-0002CY-Rg; Mon, 23 Jul 2007 01:14:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02CE620FBAE; Mon, 23 Jul 2007 01:14:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53391>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I live by new-workdir.  I do everything with it.  And today I just
> > spent over an hour sorting out cases where my many, many workdirs
> > have different refs than their base repositories, because their
> > packed-refs files are different.  Grrrrrrrrrrrrrrrrrr.
> >
> > So we really need to make anyone that edits packed-refs (and
> > maybe also config) resolve the symlink and do the edit in the
> > target directory.  Then we can consider adding this workdir thing
> > to core git.
> 
> This is actually not limited to packed-refs file, but applies to
> other things as well.

Yes, but most other things aren't symlinks, they are in symlinked
directories.  But better to cover it in a single location and have
it Just Work(tm) then to special case things.
 
> diff --git a/lockfile.c b/lockfile.c
> index fb8f13b..7fc71d9 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -28,6 +28,17 @@ static void remove_lock_file_on_signal(int signo)
>  static int lock_file(struct lock_file *lk, const char *path)
>  {
>  	int fd;
> +	struct stat st;
> +
> +	if ((!lstat(path, &st)) && S_ISLNK(st.st_mode)) {
> +		ssize_t sz;
> +		static char target[PATH_MAX];
> +		sz = readlink(path, target, sizeof(target));
> +		if (sz < 0)
> +			warning("Cannot readlink %s", path);
> +		else
> +			path = target;
> +	}
>  	sprintf(lk->filename, "%s.lock", path);
>  	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
>  	if (0 <= fd) {

Right.  But don't you have to resolve target relative to path?
If the symlink is an absolute path its fine as-is, but if it was
relative its relative to path, not pwd.

-- 
Shawn.
