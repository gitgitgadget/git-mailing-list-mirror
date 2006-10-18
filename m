From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 13:08:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181302080.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
 <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
 <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 22:09:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaHjH-0000fQ-Cb
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 22:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWJRUJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWJRUJG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 16:09:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422804AbWJRUJE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 16:09:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IK8waX013010
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 13:08:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IK8wgu016023;
	Wed, 18 Oct 2006 13:08:58 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061018185907.GV20017@pasky.or.cz>
X-Spam-Status: No, hits=-0.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29261>



On Wed, 18 Oct 2006, Petr Baudis wrote:
> 
> By the way, originally I just wanted to index and save the pack, but
> when trying to feed it to git-index-pack, I kept getting
> 
> 	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas
> 
> while feeding it to git-unpack-objects works fine. Any idea what's wrong?

Since you created a "thin" pack (that's what the "--objects-edge" means), 
the pack actually contains deltas to objects that are _not_ in the pack. 

In other words, it's not a valid stand-alone pack, it's only a valid thin 
pack, useful to transfer data to the other end (and the other end had 
better have the objects that the deltas are against already).

As a result, index-file refuses to index it: it cannot be used as a 
stand-alone pack, it's _only_ useful as a transfer medium.

So don't even _try_ to use it as a standalone pack-file. It won't work.

(If you want somethign that actually works as a stand-alone pack-file, 
change the "--objects-edge" flag to just "--objects" - that makes the 
pack-file self-sufficient, and doesn't try to delta against "edge" 
objects).

> (BTW, I got the id by sha1summing the pack file; is there an existing
> way to name a pack properly if I have it lying around, unnamed? sha1sum
> seems to be specific to a fairly new GNU coreutils version.)

A properly named _standalone_ pack gets named not by its actual contents, 
but by the SHA1-sum of the sorted list of objects it contains. That's so 
that a pack-file will be named the same thing regardless of how the 
contents are actually packed.

A thin pack cannot be named that way at all, for the same reason you 
cannot index it: it has a set of objects it enumerates (so you could name 
it by them), but it _also_ has a set of objects outside of it that it 
depends on. 

That said, even a thin pack internally has a SHA1 checksum of its 
contents: the last 20 bytes should be the SHA1-sum of all preceding bytes. 
So if you just want _some_ kind of name, you can use the last 20 bytes of 
a pack, which is just its internal integrity-checksum (but that is 
_different_ from the "pack-xxxxxx.idx"/"pack-xxxxxx.pack" naming).

			Linus
