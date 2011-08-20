From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/2] fast-import: improve deltas for blobs
Date: Sun, 21 Aug 2011 01:04:10 +0600
Message-ID: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 21:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqob-0007dG-U4
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab1HTTC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:02:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34260 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab1HTTC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:02:28 -0400
Received: by bke11 with SMTP id 11so2884431bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=pdpoP/gq3Ey2U9ZwSjw49HXDuqD3Gun0CR3aefPfSho=;
        b=L+NjiSxnQztCrKYYBzm+2KLlOlfYGN8aUdp5e1G8GFa/RA2Jrm+mLovBKnjfSw7ddO
         mXdqEP3/jkkMv06QmtvDqz/QEomO878qsUM87q3r/ChuHYH3IWG4tEKSosIEyuUitr3n
         Xhg1Uyyzq01s0rpZsvQHdRF4bMlqIIcvn7AMM=
Received: by 10.204.137.77 with SMTP id v13mr254795bkt.344.1313866947342;
        Sat, 20 Aug 2011 12:02:27 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id z7sm1402615bkt.6.2011.08.20.12.02.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 12:02:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179774>

Currently delta base for blob objects is just a previous blob object
written. This way we just keep the last one in memory and it's cheap
(not too smart though and gains no pack size reduction most of the time).
If we also keep as last blob a response to cat-blob (whose main purpose
is to provide delta bases for a importer), svn-fe imports become faster
and packs produced become smaller.

1/2 adds a diff_delta attemps count as a related and interesting number
2/2 gives a nice performance improvement for svn-fe produced imports

Dmitry Ivankov (2):
  fast-import: count and report # of calls to diff_delta in stats
  fast-import: treat cat-blob as a delta base hint for next blob

 fast-import.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

-- 
1.7.3.4
