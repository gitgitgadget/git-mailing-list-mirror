From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [RFH] Flush progress message buffer in display().
Date: Mon, 19 Nov 2007 20:48:58 +0100
Message-ID: <200711192048.58864.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 20:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuCcY-0005U3-9W
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 20:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXKSTtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbXKSTtF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 14:49:05 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:54701 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbXKSTtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 14:49:04 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id C51F79757A;
	Mon, 19 Nov 2007 20:49:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 721685A921;
	Mon, 19 Nov 2007 20:49:00 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65491>

There are cases where the stderr of the program that reports progress
is not connected to a terminal (e.g. pack-objects when invoked by
upload-pack). In this case, the output is buffered by stdio. Consequently,
a considerable amount of progress report is accumulated before it is
written (in the upload-pack case to the remote end). A fflush() after
each progress display gives a nice continuous progress.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

I need this patch on Windows because appearently progress output is buffered
by stdio. Why doesn't Linux/glibc's stdio buffer output that goes to a pipe?
If I inspect the data that upload-pack sends over the wire, then on Linux
it looks like this (the linebreaks don't appear on the wire):

0024^BCounting objects: 20946, done.
002c^BCompressing objects:   0% (1/15804)   ^M
002e^BCompressing objects:   1% (159/15804)   ^M
002e^BCompressing objects:   2% (317/15804)   ^M
002e^BCompressing objects:   3% (475/15804)   ^M
002e^BCompressing objects:   4% (633/15804)   ^M
002e^BCompressing objects:   5% (791/15804)   ^M

But on Windows it looks more like this:

0085^BCompressing objects:   0% (1/15804)   ^MCompressing objects:   1% (159/15804)   ^MCompressing objects:   2% (317/15804)   ^MCompr
0085^Bessing objects:   3% (475/15804)   ^MCompressing objects:   4% (633/15804)   ^MCompressing objects:   5% (791/15804)   ^MCompress
0085^Bing objects:   6% (990/16487)   ...

The 0085 is obviously the length of progress[128] in create_pack_file()
plus 5 bytes overhead. This happens because pack-objects buffers the
progress output and upload-pack reads it out in pieces of 128 bytes.

Why doesn't the same happen on Linux? What is flushing the progress
output?

BTW, to reproduce, use this in your favorite git repo:

#!/bin/sh
git upload-pack . <<EOF | less
0040want $(git rev-parse HEAD) side-band-64k
00000009done
0000
EOF

-- Hannes

 progress.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/progress.c b/progress.c
index 4bd650f..d19f80c 100644
--- a/progress.c
+++ b/progress.c
@@ -98,11 +98,13 @@ static int display(struct progress *progress, unsigned n, const char *done)
 			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
 				progress->title, percent, n,
 				progress->total, tp, eol);
+			fflush(stderr);
 			progress_update = 0;
 			return 1;
 		}
 	} else if (progress_update) {
 		fprintf(stderr, "%s: %u%s%s", progress->title, n, tp, eol);
+		fflush(stderr);
 		progress_update = 0;
 		return 1;
 	}
@@ -207,6 +209,7 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 	if (!progress) {
 		/* unlikely, but here's a good fallback */
 		fprintf(stderr, "%s...\n", title);
+		fflush(stderr);
 		return NULL;
 	}
 	progress->title = title;
-- 
1.5.3.5.739.gcac53
