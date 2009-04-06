From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 07:48:29 -0700
Message-ID: <20090406144829.GF23604@spearce.org>
References: <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <20090405225954.GA18730@vidovic> <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm> <alpine.LFD.2.00.0904052326090.6741@xanadu.home> <7vab6ue520.fsf@gitster.siamese.dyndns.org> <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com> <alpine.LFD.2.00.0904060959250.6741@xanadu.home> <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	david@lang.hm, Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqq9D-0002eE-AE
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZDFOsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZDFOsb
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:48:31 -0400
Received: from george.spearce.org ([209.20.77.23]:53796 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZDFOsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:48:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3381638215; Mon,  6 Apr 2009 14:48:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115841>

Jon Smirl <jonsmirl@gmail.com> wrote:
> 
> How do you deal with dense history packs? These packs take many hours
> to make (on a server class machine) and can be half the size of a
> regular pack. Shouldn't there be a way to copy these packs intact on
> an initial clone? It's ok if these packs are specially marked as being
> ok to copy.

These should be copied as-is.

Basically, object enumeration lists every reachable object, which
should include every object in this pack if its a "dense history
pack".  We then start to write out each object.  As each object
is written we look to see if it already exists in a pack.  It does
(in your dense history pack), so we then look to see if its delta
base is also in the output list (it is), so we send the data as-is.


One of the bigger costs with such clones is building that huge list
of objects needed to send.  The primary cost appears to be unpacking
the trees from the "dense history pack", where delta chains are
usually quite long.  The GSoC 2009 pack caching project idea is
based on the theory that we should be able to save a list of objects
that are reachable from some fixed point (e.g. a very well known,
stable tag), and avoid needing to read these ancient trees.

But its just a theory.  Caching always costs you management
overheads.  And it may not save us that much time .  And most of
the theory here is based on JGit's performance during packing,
*not* git-core.

I came up with the object list caching idea because JGit's object
enumeration is just pitiful.  (Its Java, what do you want, if you
wanted fast, you'd use portable assembler... like git-core does.)
Whether or not its worth applying to git-core is another story
entirely.

-- 
Shawn.
