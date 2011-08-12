From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/3] fix data corruption in fast-import
Date: Fri, 12 Aug 2011 16:32:47 +0600
Message-ID: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 12:32:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrp2b-0007lB-Er
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 12:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab1HLKcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 06:32:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1HLKcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 06:32:31 -0400
Received: by bke11 with SMTP id 11so1552656bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kXquLXcSDmgDZKn5CKYtWfUKIXIsHgyD9x9LZul9Ulg=;
        b=BK8DqfDbK06qCXM605Qx8sK2SF4kiB963KbGVMVDGYwefMjMNB+KYL9dqtuQpvCZQj
         Ty23zJQpEl/DpR5L6mKorLyY1NkVilmXkmLz15b3nUjz/c9IN6tNx8vU8jAM+X87qbIW
         e65sFFcHmzZrMRiEMJmRo62aOVbyPiVKUsur8=
Received: by 10.204.33.194 with SMTP id i2mr292833bkd.230.1313145149885;
        Fri, 12 Aug 2011 03:32:29 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id i14sm763298bkd.6.2011.08.12.03.32.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 03:32:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179223>

Finally the bug reported first in [1] is solved and has a small testcase.
Preliminary attempts can be found in [2] for curious.
And the actual "3/3: fix" comes from [3].

Brief introduction. While testing huge imports produced by svn-fe I've found
a "failed to unpack delta" error in fast-import, which is actually caused by
"sha1 mismatch" error in a packfile, and this one is caused by a bug of producing
wrong deltas for tree objects in fast-import. 

Looks like that only 'M 040000 sha1_or_mark path' commands could trigger it. 
They were introduced in tags/v1.7.3-rc0~75^2
(30 Jun 2010  334fba65.. Teach fast-import to import subtrees named by tree id)
This series should resolve the bug for any copy/rename/set/delete trees scenario
anyway.

I've tested it on a gcc svn repository import - went fine, trees match the gcc
git mirror on github. One more test is ~700k commits from kde repository - fine
too.

1/3 just extracts a sha1 calculation function for 2/3
2/3 adds a die() for "corrupted" delta data and a testcase that triggers it
3/3 is the fix

[1] http://thread.gmane.org/gmane.comp.version-control.git/176753
[2] http://thread.gmane.org/gmane.comp.version-control.git/178007
[3] http://thread.gmane.org/gmane.comp.version-control.git/176753/focus=178053

Dmitry Ivankov (3):
  fast-import: extract object preparation function
  fast-import: add a check for tree delta base sha1
  fast-import: prevent producing bad delta

 fast-import.c          |   85 +++++++++++++++++++++++++++++++++++++++---------
 t/t9300-fast-import.sh |   38 +++++++++++++++++++++
 2 files changed, 107 insertions(+), 16 deletions(-)

-- 
1.7.3.4
