From: Jeff King <peff@peff.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 08:16:00 -0500
Message-ID: <20090210131600.GD17305@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:17:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsUU-0000K8-RY
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbZBJNQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbZBJNQE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:16:04 -0500
Received: from peff.net ([208.65.91.99]:49893 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbZBJNQD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:16:03 -0500
Received: (qmail 13743 invoked by uid 107); 10 Feb 2009 13:16:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 08:16:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 08:16:00 -0500
Content-Disposition: inline
In-Reply-To: <200902100158.46884.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109235>

On Tue, Feb 10, 2009 at 01:58:41AM -0600, Boyd Stephen Smith Jr. wrote:

> On Monday 09 February 2009 15:12:06 Johannes Schindelin wrote:
> > So I think it would be a sane plan to do the following when a commit note
> > is requested:
> 
> So, something like a Trie data structure?  I think that is a great way to 
> store fixed-length strings from a limited alphabet with arbitrary data 
> attached.

I don't think a Trie quite makes sense here. We still have to look
linearly through each git tree (an artifact of the tree implementation).

You could organize the tree into a deeper, more complex data structure
than just a simple fan-out. But remember that traditional data
structures are usually trying to save expensive comparisons, and
following a pointer is inexpensive. In the case of git trees, though,
following a pointer into a subtree is _very_ expensive, since you have
to lookup and decompress the object.

So what we do now is read the tree into an associative hash.
You could replace the hash with a trie, but it is not really the
performance-critical part here. The issue is that without fan-out you
have to read the _whole_ tree into the hash. With a constant-sized
fanout, you get to divide that work by a constant.

Or did you mean something else entirely?

-Peff
