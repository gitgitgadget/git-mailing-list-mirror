From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] diffcore-break optimizations
Date: Mon, 16 Nov 2009 10:53:32 -0500
Message-ID: <20091116155331.GA30719@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 16:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA3tp-00053P-LG
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 16:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbZKPPxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbZKPPxa
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 10:53:30 -0500
Received: from peff.net ([208.65.91.99]:54013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbZKPPxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 10:53:30 -0500
Received: (qmail 16939 invoked by uid 107); 16 Nov 2009 15:57:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Nov 2009 10:57:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2009 10:53:32 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133011>

On one of my more ridiculously gigantic repositories, I recently tried
to make a commit that ran git out of memory while trying to commit. The
repository has about 3 gigabytes of data, and I made a small-ish change
to every file. Pathological, yes, but I think we can do better than
chugging for 5 minutes and dying.

The culprit turned out to be memory usage in diffcore-break, which is on
by default for "git status" (and for the "git commit" template message).
It wants to have every changed blob in memory at once, which is just
silly.

The patches are:

  [1/2]: diffcore-break: free filespec data as we go

  This addresses the memory consumption issue. If you have enough
  memory, it doesn't actually yield a speed improvement, but nor does it
  show any slowdown for practical workloads.

  There is a theoretical slowdown when doing -B -M, because the rename
  phase has to re-fetch the blobs from the object store. However, I
  wasn't able to measure any slowdown for real-world cases (like "git
  log --summary -M -B >/dev/null" on git.git).

  I did manage to produce the slowdown on a pathological case: ten
  20-megabyte files, each copied with a slight modification to another
  file, and then replaced with totally different contents (so each one
  will be broken and then trigger an inexact rename). That diff went
  from 16s to 17s.

  But I improved that and more with the next optimization.

  [2/2]: diffcore-break: save cnt_data for other phases

  We already do this in rename detection, and since they use the same
  data format, there is little reason not to do so. My pathological case
  above went from 17s down to 12s. I wasn't able to detect any speedup
  or slowdown for sane cases.

  So I doubt anybody will even notice this, but I think since we can
  address pathological cases, we might as well (and as you will see, the
  code change is quite small).

All of that being said, I was able to do my commit, but I still had to
wait five minutes for it to chug through 3G of data. :) I am tempted to
add a "quick" mode to git-commit, but perhaps such a ridiculous case is
rare enough not to worry about. I worked around it by writing my commit
message separately and using "git commit -F".

-Peff
