From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/6] Peel annotated tags when getting all refs
Date: Mon, 6 Oct 2008 00:43:03 -0700
Message-ID: <20081006074303.GB27516@spearce.org>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 09:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmklX-00032S-8e
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 09:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYJFHnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 03:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbYJFHnH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 03:43:07 -0400
Received: from george.spearce.org ([209.20.77.23]:59270 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbYJFHnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 03:43:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C06773835F; Mon,  6 Oct 2008 07:43:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97571>

FWIW I'm still going through the series.  But this jumped out at me.

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> For packed refs we got this automatically from packed-refs,
> but for loose tags we have to follow the tags and get the leaf
> object in order to comply with the documentation.
...
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> index 5a1b85f..1ee70d9 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> @@ -271,7 +271,16 @@ private void readOneLooseRef(final Map<String, Ref> avail,
>  					return;
>  				}
>  
> -				ref = new Ref(Ref.Storage.LOOSE, origName, refName, id);
> +				Object tt = db.mapObject(id, refName);
> +				if (tt != null && tt instanceof Tag) {
> +					Tag t = (Tag)tt;

Owwww.

I don't want to be doing peeling of loose annotated tags anytime
we loop through the loose objects.  That is just painful and very
expensive.  I'd rather the peeling be caused on demand by callers
who need it, but if its done through a method on Repository then
we can push the peeled ObjectId back into the RefDatabase cache.

I'm thinking more like:

	Repository db = ...;
	...
	ObjectId p = ref.getPeeledObjectId()
	if (p == null)
		p = db.peel(ref)

-- 
Shawn.
