From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 11:39:41 -0700
Message-ID: <7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>, Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 20:34:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmbxf-00055y-6l
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 20:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVFZSlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFZSlM
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 14:41:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10454 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261548AbVFZSjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 14:39:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050626183943.BQIG17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Jun 2005 14:39:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 26 Jun 2005 09:41:02 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I actually like this approach better than having delta-objects in the
LT> filesystem. Partly because the pack-file is self-contained, partly because
LT> it also solves the fs blocking issue, yet is still efficient to look up
LT> the results without having hardlinks etc to duplicate objects virtually.  
LT> And when you do the packing by hand as an "archival" mechanism, it also
LT> doesn't have any of the downsides that Chris' packing approach had.

After analyzing what is involved in making packed GIT integrated
into read_sha1_file() [*1*], I agree 100% with the above.  I
mean no disrespect to what Nico has done (and I myself have done
some code to work with Nico's deltified objects when I did diffs
and pull fixes), but it would help the code very much if we do
not have to worry about "delta" objects in GIT_OBJECT_DIRECTORY.

My preference is to do things in this order:

 (0) concatenate pack and idx files;

 (1) teach read_sha1_file() to read from packed GIT;

 (2) teach fsck-cache about packed GIT;

 (3) have people with deltified repositories convert them back
     to undeltified (I think git-pack-objects would barf on such
     repository);

 (4) drop "delta" objects from GIT_OBJECT_DIRECTORY; this means
     that git-deltafy-script and git-mkdelta have to go.

 (5) tell git-*-pull about packed GIT;


[Footnotes]

*1* Here is the analysis I did last night, still assuming that
we would support "delta" objects in GIT_OBJECT_DIRECTORY.  The
"trickier" map_sha1_file() users almost all involve "delta"
objects, and that is why I prefer dropping them.

 - Enhance GIT_ALTERNATE_OBJECT_DIRECTORIES mechanism so that
   its component can be either a directory or a packed file.

 - sha1_file.c::find_sha1_file() has to be enhanced to express
   not just path (in the current "individual object file"
   case) but a pointer to a structure that describes a packed
   file in the GIT_ALTERNATE_OBJECT_DIRECTORIES list with the
   offset for the entry.

 - The change necessary to sha1_file.c::has_sha1_file() is
   minimum.  find_sha1_file() updated along the above lines
   would say if the thing exists or not anyway, so it can just
   return true/false as it currently does pretty easily.

 - sha1_file.c::read_sha1_file() would be the primary piece to
   unpack from the packed representation.

 - sha1_file.c::map_sha1_file() is trickier.  It has handful
   callers outside sha1_file.c for valid reasons, so we will
   need to audit the callers and have them fall back on
   read_sha1_file() as appropriate.  Here is the result of my
   first pass:

   - (easy) sha1_delta_base() is used only when an object is
     delitified, and if true get to the base object.  We can
     just tell the caller our object is not deltified when it
     resides in a packed file.

   - (easy) sha1_file_size() is used by diffcore to measure the
     expanded blob size.  Although the implementation obviously
     has to be different, it would be trivial to find the size
     if the object resides in a packed file.

   - (easy) pack-objects.c::check_object() uses map_sha1_file() so that
     it can unpack small to get the type of the object.  We
     should be able to introduce a new interface (say,
     sha1_file.c::sha1_object_type()) for doing this sort of
     stuff.

   - (harder) mkdelta.c::get_buffer(), object.c::parse_object()
     and delta.c::process_delta() are trickier, because they
     want to treat "delta" as a raw object (otherwise we would
     have just done sha1_read_file() instead of
     map/unpack_sha1_file pair).

   - (harder) ssh-push.c::serve_object() also wants raw
     representation to directly ship to the other end.
