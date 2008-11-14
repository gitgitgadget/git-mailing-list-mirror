From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 4/7] Handle peeling of loose refs.
Date: Fri, 14 Nov 2008 01:38:52 +0100
Message-ID: <200811140138.52362.robin.rosenberg.lists@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com> <20081111182357.GO2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mjL-0004Q8-Ll
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbYKNAi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYKNAi4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:38:56 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:52088 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752668AbYKNAiz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 19:38:55 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A9795004B3D505; Fri, 14 Nov 2008 01:38:53 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081111182357.GO2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100938>

tisdag 11 november 2008 19:23:58 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > @@ -238,10 +235,19 @@ public ObjectId getObjectId() {
> >  	 *         refer to an annotated tag.
> >  	 */
> >  	public ObjectId getPeeledObjectId() {
> > +		if (peeledObjectId == ObjectId.zeroId())
> > +			return null;
> >  		return peeledObjectId;
> >  	}
> >  
> >  	/**
> > +	 * @return whether the Ref represents a peeled tag
> > +	 */
> > +	public boolean isPeeled() {
> > +		return peeledObjectId != null && peeledObjectId != ObjectId.zeroId();
> > +	}
> 
> Huh.  So peeledObjectId == ObjectId.zeroId() means what, exactly?
> That we tried to peel this but we cannot because its not a tag?
Means we haven't tried to peel it yet. I could use an extra flags instead. We may
have thousands of refs but perhaps not zillions.

> 
> What does a packed-refs record which has no peel data but which
> is in a packed-refs with-peeled file have for peeledObjectId?
> null or ObjectId.zeroId()?
> 
> > @@ -288,6 +289,28 @@ private void readOneLooseRef(final Map<String, Ref> avail,
> >  		}
> >  	}
> >  
> > +	Ref peel(final Ref ref) {
> > +		if (ref.isPeeled())
> > +			return ref;
> 
> I think you mean something more like:
> 
> 	if (ref.peeledObjectId != null)
> 		return ref;
> 
> as the ref is already peeled, or at least attempted.
No, if it is a loose ref we did not yet attempt to peel it. null means we have tried
zeroId means we haven't tried (see above).

> 
> > +		try {
> > +			Object tt = db.mapObject(ref.getObjectId(), ref.getName());
> > +			if (tt != null && tt instanceof Tag) {
> > +				Tag t = (Tag)tt;
> > +				while (t != null && t.getType().equals(Constants.TYPE_TAG))
> > +					t = db.mapTag(t.getTag(), t.getObjId());
> > +				if (t != null)
> > +					ref.setPeeledObjectId(t.getObjId());
> > +				else
> > +					ref.setPeeledObjectId(null);
> > +			} else
> > +				ref.setPeeledObjectId(ref.getObjectId());
> > +		} catch (IOException e) {
> > +			// Serious error. Caller knows a ref should never be null
> > +			ref.setPeeledObjectId(null);
> > +		}
> > +		return ref;
> 
> This whole block is simpler to write as:
ok..
>         try {
>                 Object target = db.mapObject(ref.getObjectId(), ref.getName());
>                 while (target instanceof Tag) {
>                         final Tag tag = (Tag)target;
>                         ref.setPeeledObjectId(tag.getObjId());
>                         if (Constants.TYPE_TAG.equals(tag.getType()))
>                                 target = db.mapObject(tag.getObjId(), ref.getName());
>                         else
>                                 break;
>                 }
>         } catch (IOException e) {
>                 // Ignore a read error.  Callers will also get the same error
>                 // if they try to use the result of getPeeledObjectId.
>         }
> 
That gives a different behavior, but which is also ok...

> >  	/**
> > +	 * Peel a possibly unpeeled ref and updates it. If the ref cannot be peeled
> > +	 * the peeled id is set to {@link ObjectId#zeroId()}
> 
> But applications never see ObjectId.zeroId() because you earlier defined
> getPeeledObjectId() to return null in that case.  So why is this part of
> the documentation relevant? 
...it's wrong, and thus irrelevant.

> > +	 * 
> > +	 * @param ref
> > +	 *            The ref to peel
> > +	 * @return The same, an updated ref with peeled info or a new instance with
> > +	 *         more information
> > +	 */
> > +	public Ref peel(final Ref ref) {
> > +		return refs.peel(ref);
> 
> Can we tighten this contract?  Are we always going to update the
> current ref in-place, or are we going to return the caller a new
> Ref instance?  I'd like it to be consistent one way or the other.
Ack. 
> 
> If we are updating in-place then the caller needs to realize there
> may be some cache synchronization issues when using multiple threads
> to access the same Ref instances and peeling them.  I.e. they may
> need to go through their own synchornization barrier to ensure the
> processor caches are coherent.
> 
> Given that almost everywhere else we treat the Ref as immutable
> I'm tempted to say this should always return a new Ref object if we
> peeled; but return the parameter if the parameter is already peeled
> (or is known to be unpeelable, e.g. a branch head).

I pick the copy.

-- robin
