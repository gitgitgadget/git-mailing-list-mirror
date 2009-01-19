From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree
	merge strategy
Date: Mon, 19 Jan 2009 09:51:54 -0800
Message-ID: <20090119175154.GD14053@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org> <1223932217-4771-9-git-send-email-spearce@spearce.org> <200810232314.29867.robin.rosenberg@dewire.com> <200901152205.00600.robin.rosenberg@dewire.com> <20090115210936.GI10179@spearce.org> <f299b4f30901171116y216835c9jc11df2d424ee0377@mail.gmail.com> <20090119174254.GC14053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Mon Jan 19 18:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOyJN-0002kc-0a
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbZASRv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZASRv4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:51:56 -0500
Received: from george.spearce.org ([209.20.77.23]:51341 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbZASRvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:51:55 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id F19B738210; Mon, 19 Jan 2009 17:51:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090119174254.GC14053@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106375>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Tomi Pakarinen <tomi.pakarinen@gmail.com> wrote:
> > testTrivialTwoWay_disjointhistories() failed because merge strategy
> > didn't handle missing base
> > version. Am'i right?
> 
> If that isn't coming out right then perhaps tw.idEqual() is busted

Yup, that's what it is, idEqual is busted.

The definition of TreeWalk.idEqual is:

	public boolean idEqual(final int nthA, final int nthB) {
		final AbstractTreeIterator ch = currentHead;
		final AbstractTreeIterator a = trees[nthA];
		final AbstractTreeIterator b = trees[nthB];
		return a.matches == ch && b.matches == ch && a.idEqual(b);
	}

The problem is this method always returns false if the name isn't
defined in either path.  I think this is the definition we want
instead:

		if (a.matches == ch && b.matches == ch)
			return a.idEqual(b);
		if (a.matches != ch && b.matches != ch) {
			// If neither tree matches the current path node then neither
			// tree has this entry. In such case the ObjectId is zero(),
			// and zero() is always equal to zero().
			//
			return true;
		}
		return false;

Patch to follow.

-- 
Shawn.
