From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] upload-pack: squelch progress indicator if client does not request sideband
Date: Mon, 15 Jun 2009 23:24:43 +0200
Message-ID: <200906152324.43435.j6t@kdbg.org>
References: <200906142238.51725.j6t@kdbg.org> <20090615145716.GW16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:25:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJg7-0006lM-MB
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935409AbZFOVYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935406AbZFOVYq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:24:46 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:36118 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935399AbZFOVYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:24:45 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E3ACD10010;
	Mon, 15 Jun 2009 23:24:43 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 872B042599;
	Mon, 15 Jun 2009 23:24:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090615145716.GW16497@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121625>

upload-pack runs pack-objects, which generates progress indicator output
on its stderr. If the client requests a sideband, this indicator is sent
to the client; but if it did not, then the progress is written to
upload-pack's own stderr.

Since the previous patch git-daemon monitors stderr of the service program,
such as upload-pack, and copies it to the syslog. This would now also copy
the progress indicator to the syslog. We avoid this by calling pack-objects
without --progress if there is no sideband channel to the client.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
On Montag, 15. Juni 2009, Shawn O. Pearce wrote:
> IIRC only upload-pack produces progress (from pack-objects).
> It does so by using a pipe on fd 2, and either copying it down
> to the client via side-band, or discarding it.  So progress data
> shouldn't ever appear on upload-pack's own fd 2, which means you
> won't get it in this syslog thing.

Unfortunately, upload-pack *does* write the progress to fd 2,
and this fixes it.

-- Hannes

 upload-pack.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index edc7861..fef8be5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -521,6 +521,15 @@ static void receive_needs(void)
 	}
 	if (debug_fd)
 		write_in_full(debug_fd, "#E\n", 3);
+
+	/*
+	 * If upload-pack is run from the daemon and the client did not
+	 * request a sideband, the progress output produced by pack-objects
+	 * would go to the syslog. Squelch it.
+	 */
+	if (!use_sideband)
+		no_progress = 1;
+
 	if (depth == 0 && shallows.nr == 0)
 		return;
 	if (depth > 0) {
-- 
1.6.3.17.g1665f
