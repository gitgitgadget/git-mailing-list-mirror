From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree
	merge strategy
Date: Mon, 19 Jan 2009 09:42:54 -0800
Message-ID: <20090119174254.GC14053@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org> <1223932217-4771-9-git-send-email-spearce@spearce.org> <200810232314.29867.robin.rosenberg@dewire.com> <200901152205.00600.robin.rosenberg@dewire.com> <20090115210936.GI10179@spearce.org> <f299b4f30901171116y216835c9jc11df2d424ee0377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Mon Jan 19 18:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOyAe-0007r2-MX
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbZASRm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZASRm4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:42:56 -0500
Received: from george.spearce.org ([209.20.77.23]:35461 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZASRmz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:42:55 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C79B238210; Mon, 19 Jan 2009 17:42:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <f299b4f30901171116y216835c9jc11df2d424ee0377@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106373>

Tomi Pakarinen <tomi.pakarinen@gmail.com> wrote:
> testTrivialTwoWay_disjointhistories() failed because merge strategy
> didn't handle missing base
> version. Am'i right?

I don't think so.
 
> @@ -119,13 +120,26 @@ protected boolean mergeImpl() throws IOException {
>  				}
> 
>  				final int modeB = tw.getRawMode(T_BASE);

Under a missing base condition modeB == 0.  So,

> -				if (modeB == modeO && tw.idEqual(T_BASE, T_OURS))
> -					add(T_THEIRS, DirCacheEntry.STAGE_0);

If modeB == 0 and modeO == 0 its not in the base and its not in ours.
Both SHA-1s will be 0{40} and are thus idEqual, so we should enter
this add(T_THEIRS) block.  Which is what you tried to write below in
your else block, isn't it?.

> -				else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
> -					add(T_OURS, DirCacheEntry.STAGE_0);

Again, if modeB == 0 and modeT == 0 both SHA-1s will be 0{40} and
are idEqual, so we should enter this add(T_OURS) block if both base
and theirs are missing.  Which again is what you tried to write in
your else block.

If that isn't coming out right then perhaps tw.idEqual() is busted
for when FileMode is FileMode.MISSING (aka 0).  Granted, doing
idEqual on FileMode.MISSING is pointless and just wastes clock
cycles, but it shouldn't harm the algorithm's correctness.

> -				else {
> -					conflict();
> -					hasConflict = true;
> +				if (!FileMode.MISSING.equals(modeB)) {
> +					if (modeB == modeO && tw.idEqual(T_BASE, T_OURS))
> +						add(T_THEIRS, DirCacheEntry.STAGE_0);
> +					else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
> +						add(T_OURS, DirCacheEntry.STAGE_0);
> +					else {
> +						conflict();
> +						hasConflict = true;
> +					}
> +				} else {
> +					if (!FileMode.MISSING.equals(modeO)
> +							&& FileMode.MISSING.equals(modeT))
> +						add(T_OURS, DirCacheEntry.STAGE_0);
> +					else if (FileMode.MISSING.equals(modeO)
> +							&& !FileMode.MISSING.equals(modeT))
> +						add(T_THEIRS, DirCacheEntry.STAGE_0);
> +					else {
> +						conflict();
> +						hasConflict = true;
> +					}
>  				}
>  			}
>  			builder.finish();
> -- 
> 1.6.0.4

-- 
Shawn.
