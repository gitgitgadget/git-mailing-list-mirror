From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 10:35:39 -0800
Message-ID: <7vocxam96s.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
 <20090210121833.GC15491@coredump.intra.peff.net>
 <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de>
 <20090210131029.GC17305@coredump.intra.peff.net>
 <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de>
 <20090210165610.GP30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWxTw-0002RG-6H
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 19:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbZBJSfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 13:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZBJSfs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 13:35:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbZBJSfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 13:35:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1BC12ADA5;
	Tue, 10 Feb 2009 13:35:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C7FC72ADA4; Tue,
 10 Feb 2009 13:35:40 -0500 (EST)
In-Reply-To: <20090210165610.GP30949@spearce.org> (Shawn O. Pearce's message
 of "Tue, 10 Feb 2009 08:56:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A144EBBA-F7A1-11DD-A157-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109289>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Tue, 10 Feb 2009, Junio C Hamano wrote:
>> > 
>> > I could do a revert on 'master' if it is really needed, but I found that
>> > the above reasoning is a bit troublesome.  The thing is, if a tree to hold
>> > the notes would be huge to be unmanageable, then it would still be huge to
>> > be unmanageable if you split it into 256 pieces.
>> 
>> The thing is, a tree object of 17 megabyte is unmanagably large if you 
>> have to read it whenever you access even a single node.  Having 256 trees 
>> instead, each of which is about 68 kilobyte is much nicer.
>
> See my other email on this thread; we'd probably need to unpack
> all 256 subtrees *anyway* due to the distribution of SHA-1 names
> for commits.

I wonder if we can solve this by introducing a local cache that is a flat
file that looks like:

    magic number for /usr/bin/file
    tree object SHA-1 the file caches
    Number of entries in this file
    256 fan-out offsets into this file
    N entries of <SHA-1, SHA-1>, sorted
    Checksum of the file itself

and use it when availble (otherwise optionally create it upon the first
lookup).  The file can be used by mmaping it and then doing a newton
raphson or binary search similar to the way patch-ids.c does.

The top-level API for such a hash-map would perhaps look like:

    /*
     * take the object name a tree object that is a hash map,
     * return an opaque struct.
     */
    struct hashmap *hashmap_open(const unsigned char *);

    /*
     * find the value given the key and return 0, or return negative
     * if not found.
     */
    int hashmap_lookup(struct hashmap *map, const unsigned char *key,
    		       unsigned char *val);

    /* discard the thing */
    void hashmap_close(struct hashmap *map);

We should be able to use these in "git log" and friends where Dscho added
the hook in his git-notes topic.

I am hoping that I could eventually rewrite rerere to use something like
this, so that rerere database can be shared, just like the way notes can
be shared, across repositories.
