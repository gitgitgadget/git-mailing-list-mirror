From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Understanding version 4 packs
Date: Sat, 24 Mar 2007 21:23:56 +0100
Message-ID: <20070324202356.GA20734@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 21:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCmQ-0005ga-QK
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 21:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbXCXUX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbXCXUX7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 16:23:59 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:40066 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753471AbXCXUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 16:23:58 -0400
Received: (qmail 25818 invoked by uid 5842); 24 Mar 2007 21:23:56 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43016>

Hello Shawn (and Nicolas and other interested parties),

I have been reading the commits in the
git://repo.or.cz/git/fastimport.git/ repository (git makes it quite easy
to see what differs from mainline using "git log master..pack4"), and I
think, I have understood some of the details.

The easiest thing to get was the file name table, which is placed in the
beginning of the pack (after the header) using the format:

+------------+-------------------------------+
| NR_ENTRIES |  Compressed file name table   |
+------------+-------------------------------+
   4 bytes

The uncompressed file name table contains NR_ENTRIES entries,
and looks like this:

+------+--------------+------+------------------------+----
| MODE |  Full path 1 | MODE |   Full path 2          | ...
+------+--------------+------+------------------------+----
 2 bytes   n1 bytes    2 bytes     n2 bytes     

The table is sorted by path then mode for easy binary lookup, and so
that pointers into this table can be compared directly instead of
comparing the corresponding paths and modes.

There is a new tree type called OBJ_DICT_TREE, which looks something
like the following:

+-----------------+------------------------------------------------+----
|  Table offset   |  SHA-1 of the blob corresponding to the path.  | ...
+-----------------+------------------------------------------------+----
      6 bytes                     20 bytes

These new tree objects will remain uncompressed in the pack file, but
sorted with, and deltaed against other tree objects. All normal tree
objects are converted to OBJ_DICT_TREE when packing, and are converted
back on the fly to callers who need an ordinary OBJ_TREE.

The index (.idx) files are extended to have a 4 byte pointer to the
offset of this file name table in the pack file for easy lookup.

There is something similar with a table of common strings in commit
objects (e.g. author and timezone), and a new object OBJ_DICT_COMMIT,
but I have not understood that quite yet.

Is there something, I have gotten wrong with regards to my
understanding?

Regards,

Peter
