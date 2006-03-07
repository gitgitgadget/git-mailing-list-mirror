From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] zlib gurus out there?
Date: Tue, 07 Mar 2006 15:48:17 -0800
Message-ID: <7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
	<7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
	<20060224174422.GA13367@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
	<20060224183554.GA31247@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
	<20060224192354.GC387@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
	<7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 08 00:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGlug-0000IY-J8
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 00:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWCGXsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 18:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWCGXsT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 18:48:19 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40683 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751633AbWCGXsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 18:48:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307234527.ZJAN17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 18:45:27 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
	(Nicolas Pitre's message of "Sat, 25 Feb 2006 00:35:26 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17355>

I've been staring at reusing existing data while packing, and
this occurred to me...

During packing, suppose that we chose to store an object in
base form, undeltified.  And also suppose we have that object
loose in .git/objects/??/ directory.  We already have it in
deflated form, but with its own header.  I started wondering if
we can somehow reuse this.

A short object format brush-up lesson is in order here.  

* An undeltified object in a pack is represented like this:

 (1) the header is a dense variable size binary data, that
     encodes type and inflated length;
 (2) deflated data immediately follows the header.

* On the other hand, a loose object is represented like this:

 (1) the header looks like sprintf("%s %lu%c", type, len, 0);
 (2) concatenate the data to the header;
 (3) SHA1 checksum of the above becomes the object name.
 (4) deflate the header and data using the same z_stream, in two
     steps, like this (sha1_file.c::write_sha1_file):

	/* Compress it */
	stream.next_out = compressed;
	stream.avail_out = size;

	/* First header.. */
	stream.next_in = hdr;
	stream.avail_in = hdrlen;
	while (deflate(&stream, 0) == Z_OK)
		/* nothing */;

	/* Then the data itself.. */
	stream.next_in = buf;
	stream.avail_in = len;
	while (deflate(&stream, Z_FINISH) == Z_OK)
		/* nothing */;
	deflateEnd(&stream);
	size = stream.total_out;

So I thought... if we cause a full flush after the header part,
I can find the flush boundaries from a loose object file and
copy the rest into a packfile I am generating, after placing the
binary encoded header.  If this works, we do not have to inflate
loose object to read it and deflate it to store that in the
pack.  We will get a better packing as well, since we deflate
loose objects with Z_BEST_COMPRESSION, while packs are done with
Z_DEFAULT_COMPRESSION.  While pack-objects read from a loose
object, if we can detect that there is no full flush after the
header, we would do the traditional inflate-deflate cycle, so
this would be backward compatible.

However, I am stuck with the first step, which is to do a full
flush after the header.  An obvious change to the code quoted
above writes out a corrupt object:

	/* First header.. */
	stream.next_in = hdr;
	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
+	while (deflate(&stream, Z_FULL_FLUSH) == Z_OK)
		/* nothing */;

git-fsck-objects complains that sha1 does not match.  It appears
that the sha1_file.c::unpack_sha1_rest() somehow barfs upon
seeing the full flush, but I haven't dug into it yet.

Would anybody with more experience with zlib want to help?
