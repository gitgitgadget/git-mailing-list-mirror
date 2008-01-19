From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 19:25:03 -0800
Message-ID: <7vwsq6a44w.fsf@gitster.siamese.dyndns.org>
References: <20080118035700.GA3458@spearce.org>
	<alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org>
	<20080118084201.GA14763@hashpling.org>
	<alpine.LFD.1.00.0801180842350.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 04:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG4L9-0008Kg-JU
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 04:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760501AbYASDZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 22:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760932AbYASDZP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 22:25:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759158AbYASDZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 22:25:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED4A7D58;
	Fri, 18 Jan 2008 22:25:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1567D55;
	Fri, 18 Jan 2008 22:25:05 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801180842350.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 18 Jan 2008 09:08:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71076>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Btw, even with Shawn's patch, I wonder if the index_data usage is correct.

Hmph.

gfi uses data in a "pack" in two quite different ways.

A new object is written to an unfinalized pack.  Such a pack
already has "struct packed_git" allocated for it and a pointer
to it is held in pack_data.  As far as the core part of git
(that is, sha1_file.c) is concerned, however, this pack does not
even exist.  It is still not part of packed_git list in
sha1_file.c, and read_sha1_file() will not see objects in it, as
no idx into the packfile exists yet.  gfi has a table of objects
in this pack and uses gfi_unpack_entry() function to retrieve
data from it.

A packfile is finalized in end_packfile().  The pack header and
footer is recomputed, an idx file is written, and the pack is
finally registered.  Before that time p->index_data is not even
used for that pack (it is initialized with NULL).

So I do not think "index_data usage" can be incorrect, as there
won't be any index_data usage with unfinalized pack, and the
core part of git would not even have any mmap(2) (nor open fd)
into its idx file before it is finalized.

By the way, I was quite puzzled how the gfi_unpack_entry()
function manages to work correctly when it has to read an object
it deltified based on another object it wrote into the same
unfinalized pack earlier.  It knows where in the unfinalized
pack it wrote the object, so it can find from its own "struct
object_entry" the offset for the object, and calls
unpack_entry() defined in the core to do the rest.

However, most of the core does not really know about the other
objects in this half-built pack.  If the object is a delta,
unpack_delta_entry() needs to find the delta base.  And it needs
to do that without having the idx.

The trick (the code really needs a bit more documentation) is
that gfi never writes anything but OFS_DELTA.  So the core, even
though it does not have the corresponding idx file, does not
have to look up the object (in fact it does not even know what
object to look up for the base, it only knows the offset).
