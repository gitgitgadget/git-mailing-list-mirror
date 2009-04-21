From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 08/10] Scan for new packs if GIT_DIR/objects/pack
	has been modified
Date: Mon, 20 Apr 2009 18:39:11 -0700
Message-ID: <20090421013911.GZ23604@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org> <1240276872-17893-2-git-send-email-spearce@spearce.org> <1240276872-17893-3-git-send-email-spearce@spearce.org> <1240276872-17893-4-git-send-email-spearce@spearce.org> <1240276872-17893-5-git-send-email-spearce@spearce.org> <1240276872-17893-6-git-send-email-spearce@spearce.org> <1240276872-17893-7-git-send-email-spearce@spearce.org> <1240276872-17893-8-git-send-email-spearce@spearce.org> <1240276872-17893-9-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4yc-0005P7-8O
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZDUBjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZDUBjM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:39:12 -0400
Received: from george.spearce.org ([209.20.77.23]:36056 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZDUBjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:39:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 00ACB38211; Tue, 21 Apr 2009 01:39:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1240276872-17893-9-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117072>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> If GIT_DIR/objects/pack directory has changed then one or more packs
...
> +	@Override
> +	protected boolean tryAgain1() {
> +		final PackFile[] old = packList.get();
> +		if (packDirectoryLastModified <= packDirectory.lastModified()) {

Sadly we needed to use <= here to avoid racy-git cases.  Worse,
unlike with the DirCache we don't have another file system inode
we can use to compare timestamps against.

Consequently, I just realized my commit message isn't entirely
accurate.  In reality we rescan the #F*@!*! directory every time
we have a miss, because the time stamp hasn't changed.

I can't think of another method to use here.  I'd love to avoid
the rescan on a miss if the aren't any new packs in the directory,
but I just don't see how we can do that and avoid the racy-git case
at the same time.

We could try to fudge it by saying < here, but the test cases in
9/10 would then require a Thread.sleep(2) or something to force
enough time to pass for the directory modification time to advance.

I think in real applications, its "good enough" to allow this amount
of fudging.  We shouldn't see more than one repack per repository
per FS clock tick.  And if we do, the admin should be shot on sight.

git-repack is careful to ensure the new pack is linked into the
directory before the old packs are unlinked, so we really shouldn't
ever scan and miss a pack.

-- 
Shawn.
