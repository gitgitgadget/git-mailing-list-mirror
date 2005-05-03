From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: adding xdelta compression to git
Date: Mon, 2 May 2005 21:52:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
References: <200505030657.38309.alonz@nolaviz.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:45:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSpHP-0002FR-7x
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVECEvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVECEvO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:51:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:14033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261389AbVECEvA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:51:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j434ofs4008892
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 21:50:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j434oeT3008361;
	Mon, 2 May 2005 21:50:40 -0700
To: Alon Ziv <alonz@nolaviz.org>
In-Reply-To: <200505030657.38309.alonz@nolaviz.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Alon Ziv wrote:
> 
> 1. Add a git-deltify command, which will take two trees and replace the second 
> tree's blobs with delta-blobs referring to the first tree.

If you do something like this, you want such a delta-blob to be named by 
the sha1 of the result, so that things that refer to it can transparently 
see either the original blob _or_ the "deltified" one, and will never 
care.

It seems that is your plan:

> from the outside it looks like any other blob, but internally it
> contains another blob reference + an xdelta.

Yes. git doesn't much care, as long as the objects unpack to the right 
format. That's all hidden away.

> The only function which would need to understand the new format would be
> unpack_sha1_file.

Yes. EXCEPT for one thing. fsck. I'd _really_ like fsck to be able to know
something about any xdelta objects, if only because if/when things go
wrong, it's really nasty to suddenly see a million "blob" objects not work
any more, with no indication of _why_ they don't work. The core reason may
be that one original object (that just got used as a base for tons of
other objects through deltas) is corrupt or missing. And then you want to
show that _one_ object.

> Cons:
> * Changes the repository format.

It wouldn't necessarily. You should be able to do this with _zero_ changes 
to existing objects what-so-ever.

What you do is introduce an "xdelta" object, which has a reference to a 
blob object and the delta. The git object model already names all objects 
by a simple ascii name, so adding a new object type in _no_ way changes 
any existing objects.

So you can just make "unpack_sha1_file()" notice that it unpacked a xdelta 
object, and then do the proper delta application, and nobody will ever be 
the wiser.

> * Some performance impact (probably quite small).

If you limit the depth of deltas, probably not too bad.

> * Same blob may have different representation in two repositories (one 
> compressed, on deltified). [I am not sure this is really a bad thing...]

THIS, I think, is the real issue. fsck-cache and pull etc, that needs to
know about references to other objects, would have to be able to see the
xdelta object, so that they can build up the reference graph. So you'd
need to basically make a "raw_unpack_sha1_file()" interface (the current
regular unpack_sha1_file()) for that.

Also, the fact is, since git saves things as separate files, you'd not win
as much as you would with some other backing store. So the second step is
to start packing the objects etc. I think there is actually a very steep
complexity edge here - not because any of the individual steps necessarily
add a whole lot, but because they all lead to the "next step".

I personally clearly feel that simplicity (and the resulting robustness)
is worth a _lot_ of disk-space.

So I think that what you suggest is likely to actually be pretty easy, but 
I'm not entirely convinced it's worth the slide into complexity.

		Linus
