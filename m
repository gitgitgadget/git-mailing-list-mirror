From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Fri, 07 Apr 2006 01:15:47 -0700
Message-ID: <7vhd55ls24.fsf@assigned-by-dhcp.cox.net>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
	<Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
	<Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Apr 07 10:16:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRm8f-0005Cq-0C
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 10:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWDGIQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWDGIQF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 04:16:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:23240 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932364AbWDGIPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 04:15:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060407081548.DNIX17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Apr 2006 04:15:48 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18494>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 3 Apr 2006, Linus Torvalds wrote:
>> 
>> That said, I think git _does_ have problems with large pack-files. We have 
>> some 32-bit issues etc
>
> I should clarify that. git _itself_ shouldn't have any 32-bit issues, but 
> the packfile data structure does. The index has 32-bit offsets into 
> individual pack-files. 
>
> That's not hugely fundamental,...

Linus _does_ understand what he means, but let me clarify and
outline a possible future direction.

 * pack-*.pack file has the following format:

   - The header appears at the beginning and consists of the following:

     4-byte signature
     4-byte version number (network byte order)
     4-byte number of objects contained in the pack (network byte order)

     Observation: we cannot have more than 4G versions ;-) and
     more than 4G objects in a pack.

   - The header is followed by number of object entries, each of
     which looks like this:

     (undeltified representation)
     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
     compressed data

     (deltified representation)
     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
     20-byte base object name
     compressed delta data

     Observation: length of each object is encoded in a variable
     length format and is not constrained to 32-bit or anything.

  - The trailer records 20-byte SHA1 checksum of all of the above.

 * pack-*.idx file has the following format:

  - The header consists of 256 4-byte network byte order
    integers.  N-th entry of this table records the number of
    objects in the corresponding pack, the first byte of whose
    object name are smaller than N.

    Observation: we would need to extend this to an array of
    8-byte integers to go beyond 4G objects per pack, but it is
    not strictly necessary.

  - The header is followed by sorted 28-byte entries, one entry
    per object in the pack.  Each entry is:

    4-byte network byte order integer, recording where the
    object is stored in the packfile as the offset from the
    beginning.

    20-byte object name.

    Observation: we would definitely need to extend this to
    8-byte integer plus 20-byte object name to handle a packfile
    that is larger than 4GB.

  - The file is concluded with a trailer:

    A copy of the 20-byte SHA1 checksum at the end of
    corresponding packfile.

    20-byte SHA1-checksum of all of the above.

This is not fundamental, in that pack idx file is something we
can regenerate from a packfile.  The push/fetch transfer over
git native protocols does not even transfer pack idx file;
instead, the recipient uses git-index-pack to generate pack idx.
git-index-pack would need to be updated to update the necessary
fields to 8-byte integers, without breaking existing packfiles.

The code to read idx file currently has a sanity check logic to
make sure that the size of the idx file is consistent with
24-byte entries (the last entry in the header matches the number
of objects recorded in the pack).  So we could reliably tell
between the current 24-byte version and 28-byte "beyond 4GB"
version, and support both formats at the same time.

Even after we start supporting the 28-byte "beyond 4GB" format,
we can and we should continue writing the current 24-byte
version of pack idx file when the packfile offset can be
expressed with 32-bit.

Having said that, I have to warn that this is not for weak of
heart.  The necessary changes would be somewhat involved.


----------------------------------------------------------------

Pack idx file

	idx
	    +--------------------------------+
	    | fanout[0] = 2                  |-.
	    +--------------------------------+ |
	    | fanout[1]                      | |
	    +--------------------------------+ |
	    | fanout[2]                      | |
	    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |
	    | fanout[255]                    | |
	    +--------------------------------+ |
main	    | offset                         | |
index	    | object name 00XXXXXXXXXXXXXXXX | |
table	    +--------------------------------+ | 
	    | offset                         | |
	    | object name 00XXXXXXXXXXXXXXXX | |
	    +--------------------------------+ |
	  .-| offset                         |<+
	  | | object name 01XXXXXXXXXXXXXXXX |
	  | +--------------------------------+
	  | | offset                         |
	  | | object name 01XXXXXXXXXXXXXXXX |
	  | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	  | | offset                         |
	  | | object name FFXXXXXXXXXXXXXXXX |
	  | +--------------------------------+
trailer	  | | packfile checksum              |
	  | +--------------------------------+
	  | | idxfile checksum               |
	  | +--------------------------------+
          .-------.      
                  |
Pack file entry: <+

     packed object header:
	1-byte type (bit 4-6)
	       size0 (bit 0-3)
               end-of-length (bit 7)
        n-byte sizeN (as long as MSB is set, each 7-bit)
		size0..sizeN form 4+7+7+..+7 bit integer, size0
		is the most significant part.
     packed object data:
        If it is not DELTA, then deflated bytes (the size above
		is the size before compression).
	If it is DELTA, then
	  20-byte base object name SHA1 (the size above is the
	  	size of the delta data that follows).
          delta data, deflated.
