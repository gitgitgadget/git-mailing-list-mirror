From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/7] Handle peeling of loose refs.
Date: Tue, 11 Nov 2008 10:23:58 -0800
Message-ID: <20081111182357.GO2932@spearce.org>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzxvb-000306-S9
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbYKKSYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbYKKSYG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:24:06 -0500
Received: from george.spearce.org ([209.20.77.23]:58299 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYKKSYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:24:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0E54538200; Tue, 11 Nov 2008 18:23:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100666>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> @@ -238,10 +235,19 @@ public ObjectId getObjectId() {
>  	 *         refer to an annotated tag.
>  	 */
>  	public ObjectId getPeeledObjectId() {
> +		if (peeledObjectId == ObjectId.zeroId())
> +			return null;
>  		return peeledObjectId;
>  	}
>  
>  	/**
> +	 * @return whether the Ref represents a peeled tag
> +	 */
> +	public boolean isPeeled() {
> +		return peeledObjectId != null && peeledObjectId != ObjectId.zeroId();
> +	}

Huh.  So peeledObjectId == ObjectId.zeroId() means what, exactly?
That we tried to peel this but we cannot because its not a tag?

What does a packed-refs record which has no peel data but which
is in a packed-refs with-peeled file have for peeledObjectId?
null or ObjectId.zeroId()?

> @@ -288,6 +289,28 @@ private void readOneLooseRef(final Map<String, Ref> avail,
>  		}
>  	}
>  
> +	Ref peel(final Ref ref) {
> +		if (ref.isPeeled())
> +			return ref;

I think you mean something more like:

	if (ref.peeledObjectId != null)
		return ref;

as the ref is already peeled, or at least attempted.

> +		try {
> +			Object tt = db.mapObject(ref.getObjectId(), ref.getName());
> +			if (tt != null && tt instanceof Tag) {
> +				Tag t = (Tag)tt;
> +				while (t != null && t.getType().equals(Constants.TYPE_TAG))
> +					t = db.mapTag(t.getTag(), t.getObjId());
> +				if (t != null)
> +					ref.setPeeledObjectId(t.getObjId());
> +				else
> +					ref.setPeeledObjectId(null);
> +			} else
> +				ref.setPeeledObjectId(ref.getObjectId());
> +		} catch (IOException e) {
> +			// Serious error. Caller knows a ref should never be null
> +			ref.setPeeledObjectId(null);
> +		}
> +		return ref;

This whole block is simpler to write as:

	try {
		Object target = db.mapObject(ref.getObjectId(), ref.getName());
		while (target instanceof Tag) {
			final Tag tag = (Tag)target;
			ref.setPeeledObjectId(tag.getObjId());
			if (Constants.TYPE_TAG.equals(tag.getType()))
				target = db.mapObject(tag.getObjId(), ref.getName());
			else
				break;
		}
	} catch (IOException e) {
		// Ignore a read error.  Callers will also get the same error
		// if they try to use the result of getPeeledObjectId.
	}

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> index 26748e2..4d6e6fd 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -939,6 +939,19 @@ public String getBranch() throws IOException {
>  	}
>  
>  	/**
> +	 * Peel a possibly unpeeled ref and updates it. If the ref cannot be peeled
> +	 * the peeled id is set to {@link ObjectId#zeroId()}

But applications never see ObjectId.zeroId() because you earlier defined
getPeeledObjectId() to return null in that case.  So why is this part of
the documentation relevant? 

> +	 * 
> +	 * @param ref
> +	 *            The ref to peel
> +	 * @return The same, an updated ref with peeled info or a new instance with
> +	 *         more information
> +	 */
> +	public Ref peel(final Ref ref) {
> +		return refs.peel(ref);

Can we tighten this contract?  Are we always going to update the
current ref in-place, or are we going to return the caller a new
Ref instance?  I'd like it to be consistent one way or the other.

If we are updating in-place then the caller needs to realize there
may be some cache synchronization issues when using multiple threads
to access the same Ref instances and peeling them.  I.e. they may
need to go through their own synchornization barrier to ensure the
processor caches are coherent.

Given that almost everywhere else we treat the Ref as immutable
I'm tempted to say this should always return a new Ref object if we
peeled; but return the parameter if the parameter is already peeled
(or is known to be unpeelable, e.g. a branch head).

-- 
Shawn.
