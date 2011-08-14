From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 0/2] fix data corruption in fast-import
Date: Mon, 15 Aug 2011 00:32:22 +0600
Message-ID: <1313346744-30340-1-git-send-email-divanorama@gmail.com>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 20:31:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsfTW-00054q-CK
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 20:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab1HNSbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 14:31:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab1HNSbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 14:31:43 -0400
Received: by bke11 with SMTP id 11so2601545bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PAh6eyOLMwgLHvz/vTXjylt40gVNGt1wL3pKxkfqirY=;
        b=MKUVusQ6HHd4+8Emj8LZzkYCRl4H/WouSwx4Ci789tE+HvcyjEe35jNtIba38kYva2
         X7dcf/3xMvcjd0riQWPhVHWSwXbWpF9tudP2Y29YAHajUH57MI/NlN1Cjg+tObzy3LnY
         lPGkKFZmXSrJhyZjmT15ujjhvC949xDbhfH7Q=
Received: by 10.204.232.141 with SMTP id ju13mr404435bkb.252.1313346702307;
        Sun, 14 Aug 2011 11:31:42 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n11sm1334281bkd.47.2011.08.14.11.31.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 11:31:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179339>

It turns out the bug is older than "M 040000.." command.
Managed to reproduce with just "C .." command from tags/v1.5.3-rc2~6^2
b6f3481b.. Teach fast-import to recursively copy files/directories (Jul 15 2007)

And even better, there is no need to add a explicit check for sha1 mismatch (we
may still want to have this, but it can go separately).

Basically the test does:
Fill two distinct directories old/a, old/b
Commit them 
(necessary to make trees have sha1 computed and thus become potential delta bases)
C old new
C old/a new/b
M ... new/b/new_file

new/b is stored as a delta against old/a, but with delta base pointing to old/b.
And so ls-tree new/b fails, fsck fails both with "failed to apply delta".

Dmitry Ivankov (2):
  fast-import: add a test for tree delta base corruption
  fast-import: prevent producing bad delta

 fast-import.c          |   35 ++++++++++++++++++++++++++++++-----
 t/t9300-fast-import.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 5 deletions(-)

-- 
1.7.3.4
