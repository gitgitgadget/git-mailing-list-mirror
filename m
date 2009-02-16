From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] 1/2: Externalizable items
Date: Mon, 16 Feb 2009 10:16:59 -0800
Message-ID: <20090216181659.GF18525@spearce.org>
References: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com> <20090216172025.GE18525@spearce.org> <320075ff0902161009s1454e1feu5b3543f898112406@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ833-0007bv-Ah
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbZBPSRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbZBPSRB
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:17:01 -0500
Received: from george.spearce.org ([209.20.77.23]:40638 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZBPSRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:17:00 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C688A381FF; Mon, 16 Feb 2009 18:16:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320075ff0902161009s1454e1feu5b3543f898112406@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110224>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> > Yikes.  Do we really need a public no-arg constructor for
> > Externalizable?  If we do, maybe we should use Serializable instead
> > so we can hide this constructor.  I don't like the idea of people
> > creating ObjectId.zeroId() by new ObjectId().  That's not a pattern
> > we should encourage.
> >
> 
> Yes, you have to have a public no-args constructor for Externalizable.
> 
>  I agree, it's hideous. But I thought that was known as you explicitly
> asked for Externalizable rather than Serializable with readObject /
> writeObject... :-/

I forgot/didn't remember that Externalizable has this hideous
requirement.  I'd rather not introduce a public no-arg constructor
just for Java serialization.  So yea, if you needed to add a
constructor than we should instead use Serializable and define an
explicit serialVersionUID.  Sorry.
 
> More than happy to re-roll with Serializable instead - do you want
> this for all 4? (RemoteConfig also gained a no-args constructor
> because of Externalizable..)

Yea, at least for ObjectId and RemoteConfig.
 
> > +             Map<String, Collection<String>> map = new HashMap<String,
> > Collection<String>>();
> > +             for (int i = 0; i < items; i++) {
> > +                     String key = in.readUTF();
> > +                     String value = in.readUTF();
> >Why not just serialize the Map in the stream?
> 
> Sure - if you're happy with that representation - it's not " a map of
> keys/values as it appears in the config " though as it's a map to a
> list because of the multi-values that are available for things like
> URL and Fetch.

Right.

The format of HashMap and ArrayList is pretty stable on the wire,
so we can depend on them not changing on us.  We might as well
just serialize with those and save ourselves some code in the JGit
library.  I don't see a compelling reason here to use our own map
format on the wire.  Especially not if we are doing this conversion
to a java.util.Map<String,java.util.List> just to dump to the wire.

On the other hand, you could modify the read and write code to do
direct writing of string pairs, and direct reading of string pairs,
that would save allocs in each direction and make RemoteConfig
that much easier to write out.  Of course to do that you can't use
a count header, but instead would want a sential marker to break
the reader out of its loop, like an empty key string.

-- 
Shawn.
