From: Toby White <tow21@cam.ac.uk>
Subject: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 10:31:46 +0000
Message-ID: <47440912.8010800@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 12:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IunNx-0007vh-EB
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbXKULEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 06:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbXKULEb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:04:31 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:59758 "EHLO
	ppsw-8.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbXKULEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 06:04:30 -0500
X-Greylist: delayed 1958 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2007 06:04:30 EST
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from sloth.niees.group.cam.ac.uk ([128.232.232.33]:52468)
	by ppsw-8.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
	with esmtp id 1Iums3-00037y-Q8 (Exim 4.67)
	(return-path <tow21@cam.ac.uk>); Wed, 21 Nov 2007 10:31:51 +0000
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65627>

Mac OS X bundles a rather nice graphical diff viewer (Filemerge.app)
with its developer tools.

While git-merge knows how to use this as a merge tool, I couldn't
find any way to easily use Filemerge as a viewer for the output
of git-diff.

(http://thread.gmane.org/gmane.comp.version-control.git/58702
discusses the problem, and recommends piping git-diff into kompare.
Filemerge unfortunately won't accept diff output on stdin)

So I wrote a quick script (below) which does what I need. Of all
the available git-diff flags, it only understands "--cached", and
up to two commit objects, and no paths, but that's enough for me.
Within those constraints, it has the same semantics as git-diff.

It's not very nice, but in case anyone else wants this:

#!/bin/sh
#
# Filemerge.app must not already be open before running
# this script, or opendiff below will return immediately,
# and the TMPDIRs deleted before it gets the chance to read
# them.

if test $# = 0; then
   OLD=`git-write-tree`
elif test "$1" = --cached; then
   OLD=HEAD
   NEW=`git-write-tree`
   shift
fi
if test $# -gt 0; then
   OLD="$1"; shift
fi
test $# -gt 0 && test -z "$CACHED" && NEW="$1"

TMPDIR1=`mktemp -d`
git-archive --format=tar $OLD | (cd $TMPDIR1; tar xf -)
if test -z "$NEW"; then
   TMPDIR2=$(git rev-parse --show-cdup)
   test -z "$cdup" && TMPDIR2=.
else
   TMPDIR2=`mktemp -d`
   git-archive --format=tar $NEW | (cd $TMPDIR2; tar xf -)
fi

opendiff $TMPDIR1 $TMPDIR2 | cat
rm -rf $TMPDIR1
test ! -z "$NEW" && rm -rf $TMPDIR2

-- 
Dr. Toby O. H. White
Dept. Earth Sciences,
Downing Street,
Cambridge CB2 3EQ
United Kingdom

Tel: +44 1223 333464
Fax: +44 1223 333450
Web: http://uszla.me.uk
