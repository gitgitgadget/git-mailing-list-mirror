From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: git-svn has a _lot_ of metadata
Date: Tue, 16 Oct 2007 12:22:59 +0200
Message-ID: <20071016102259.GB5945@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihja3-0006wZ-LU
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760224AbXJPKXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 06:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759454AbXJPKXH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:23:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2953 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822AbXJPKXG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:23:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IhjZk-00021r-00; Tue, 16 Oct 2007 11:23:00 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61138>

I just imported an svn repository with about 120 tags and 140
branches, and with some repacking got the pack file down to a
comfortable 80 MB. However, .git is over 600 MB, owing to about 520 MB
of git-svn metadata. (This wasn't a problem when I only tracked a
handful of branches, since they're only a few megs apiece.)

There appears to be two kinds of metadata that takes up a significant
fraction of the space.

  * An index file is saved for each branch and tag. I presume this
    corresponds to the branch head, and is used to speed up importing
    of new revisions to that branch. However, recreating an index with
    git-read-tree is very fast, so I don't think these need to be
    saved between git-svn runs.

  * A "rev_db" file is saved for each branch and tag. This is a text
    file with one sha1 per line -- I seem to remember that line X of
    this file is the commit sha1 of svn revision X. For revisions that
    didn't touch this branch/tag, there's a line of 40 zeros. And
    since every revision touches just one branch, it's almost all
    zeros unless the number of branches is very small.

    This could probably be stored _much_ more efficiently. Just
    gzipping it with the standard options shrinks it by between a
    factor of 4 (for one of the busiest branches) and 300 (for a tag,
    which is written just once). But I understand that we need quick
    random access here?

The index files should be easy enough to erase between runs, if they
indeed just correspond to the branch head. The rev_db files are
trickier; exactly what kind of lookups are required? Could it perhaps
be done with just one file, instead of one per branch/tag?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
