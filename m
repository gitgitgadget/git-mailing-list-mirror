From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [RFC/PATCH 0/3] teach --histogram to diff
Date: Tue, 12 Jul 2011 14:10:24 +0800
Message-ID: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:10:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWBK-0003gC-8R
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab1GLGKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:10:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64097 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab1GLGKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:10:34 -0400
Received: by gyh3 with SMTP id 3so1811102gyh.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XyhvhUKQNGF/Rm9e6PnzpX1fmCVUi2TQEEsbr9KQG5Q=;
        b=NmFL4mAUkV4j/aIInAzbFpVr1hIoJXC+GCtnEY7baXQ+5v6rskZIn8WqIXvFocS3l7
         c7yMhL72Ni1i7EC+Z3MDbd4VBWa3Sx8LBTeSMf+3cQezCPYWbcjYeenDhc+nC/J33ruU
         sH4i0At/fHD11+w2rO9JTTxe0g273DInnqCOY=
Received: by 10.150.69.30 with SMTP id r30mr4842019yba.342.1310451034329;
        Mon, 11 Jul 2011 23:10:34 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id y11sm2716633ybe.16.2011.07.11.23.10.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 23:10:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176921>

(Shawn, I was held up with the patch messages, sorry for the delay.)

Port JGit's HistogramDiff(Index) over to C. This algorithm extends the
patience algorithm to "support low-occurrence common elements" [1].

Rough numbers show that it is a faster alternative to its --patience
cousin, as well as to the default Meyers algorithm:

  $ time ./git log --histogram -p v1.0.0 >/dev/null
  
  real    0m12.998s
  user    0m11.506s
  sys     0m1.487s
  $ time ./git log -p v1.0.0 >/dev/null
  
  real    0m13.575s
  user    0m12.101s
  sys     0m1.468s
  $ time ./git log --patience -p v1.0.0 >/dev/null
  
  real    0m14.978s
  user    0m13.508s
  sys     0m1.464s

The first patch implements JGit's HistogramDiff(Index) proper. The
second and third patches aren't essential but yield performance gains.

Note: these patches must be applied on top of rc/histogram-diff in pu.

Contents:
[RFC/PATCH 1/3] teach --histogram to diff
[RFC/PATCH 2/3] xdiff/xprepare: skip classification
[RFC/PATCH 3/3] xdiff/xprepare: use a smaller sample size for histogram

 Makefile                  |    2 +-
 diff.c                    |    2 +
 merge-recursive.c         |    2 +
 t/t4048-diff-histogram.sh |   12 ++
 xdiff/xdiff.h             |    1 +
 xdiff/xdiffi.c            |    3 +
 xdiff/xdiffi.h            |    2 +
 xdiff/xhistogram.c        |  384 +++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xprepare.c          |   41 ++++--
 xdiff/xutils.c            |    8 +-
 xdiff/xutils.h            |    2 +-
 11 files changed, 440 insertions(+), 19 deletions(-)
 create mode 100755 t/t4048-diff-histogram.sh
 create mode 100644 xdiff/xhistogram.c

--
Footnotes:
[1] http://egit.eclipse.org/w/?p=jgit.git;a=blob;f=org.eclipse.jgit/src/org/eclipse/jgit/diff/HistogramDiff.java;hb=HEAD

-- 
1.7.3.4.681.gb718e
