From: Junio C Hamano <junkio@cox.net>
Subject: [FYI] pack idx format
Date: Wed, 15 Feb 2006 00:39:23 -0800
Message-ID: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 09:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9IC7-0000bE-Rf
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 09:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWBOIjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 03:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWBOIjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 03:39:25 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21415 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1422666AbWBOIjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 03:39:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215083600.GONO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 03:36:00 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16223>

This is still WIP but if anybody is interested...  Once done, it
should become Documentation/technical/pack-format.txt.

The reason I started doing this is to prototype this one:

	<7v4q3453qu.fsf@assigned-by-dhcp.cox.net>

-- >8 --

Idx file:

The idx file is to map object name SHA1 to offset into the
corresponding pack file.  There is the 'first-level fan-out'
table at the beginning, and then the main part of the index
follows.  This is a table whose entries are sorted by their
object name SHA1.  The file ends with some trailer information.

The main part is a table of 24-byte entries, and each entry is:

	offset : 4-byte network byte order integer.
	SHA1   : 20-byte object name SHA1.

The data for the named object begins at byte offset "offset" in
the corresponding pack file.

Before this main table, at the beginning of the idx file, there
is a table of 256 4-byte network byte order integers.  This is
called "first-level fan-out".  N-th entry of this table records
the offset into the main index for the first object whose object
name SHA1 starts with N+1.  fanout[255] points at the end of
main index.  The offset is expressed in 24-bytes unit.

Example:

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
	1-byte type (upper 4-bit)
	       size0 (lower 4-bit) 
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
