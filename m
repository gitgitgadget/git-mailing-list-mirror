From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] fetch-pack: close output channel after sideband demultiplexer
 terminates
Date: Mon, 08 Jun 2009 10:51:22 +0200
Message-ID: <4A2CD10A.3000703@viscovery.net>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz> <4A28D2EF.8040704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: sam@vilain.net, git@vger.kernel.org,
	Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 10:51:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDaZo-00070z-MY
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 10:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZFHIvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 04:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZFHIvY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 04:51:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27031 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZFHIvX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 04:51:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MDaZa-000224-Rk; Mon, 08 Jun 2009 10:51:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8FBEBFCD2; Mon,  8 Jun 2009 10:51:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A28D2EF.8040704@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121048>

From: Johannes Sixt <j6t@kdbg.org>

fetch-pack runs the sideband demultiplexer using start_async(). This
facility requires that the asynchronously executed function closes the
output file descriptor (see Documentation/technical/api-run-command.txt).
But the sideband demultiplexer did not do that. This fixes it.

In certain error situations this could lock up a fetch operation on
Windows because the asynchronous function is run in a thread; by not
closing the output fd the reading end never got EOF and waited for more
data indefinitely. On Unix this is not a problem because the asynchronous
function is run in a separate process, which exits after the function ends
and so implicitly closes the output.

Since the pack that is sent over the wire encodes the number of objects in
the stream, during normal operation the reading end knows when the stream
ends and terminates by itself, and does not lock up.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---

 Johannes Sixt schrieb:
 > FYI, with this patch MinGW git hangs in t5530.8; the test-case exercises
 > the new code path.

 This fixes the lockup.

 -- Hannes

 builtin-fetch-pack.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 2eb7a22..b11d799 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -487,7 +487,9 @@ static int sideband_demux(int fd, void *data)
 {
 	int *xd = data;

-	return recv_sideband("fetch-pack", xd[0], fd);
+	int ret = recv_sideband("fetch-pack", xd[0], fd);
+	close(fd);
+	return ret;
 }

 static int get_pack(int xd[2], char **pack_lockfile)
-- 
1.6.3.1.1141.gcf6b0.dirty
