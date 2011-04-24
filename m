From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] send-pack: avoid deadlock when pack-object dies early
Date: Sun, 24 Apr 2011 22:49:17 +0200
Message-ID: <4DB48CCD.40304@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104142136.25778.j6t@kdbg.org> <20110414202110.GA6525@sigill.intra.peff.net> <201104142243.33522.j6t@kdbg.org> <20110414205113.GA7451@sigill.intra.peff.net> <7vsjtkfs10.fsf@alter.siamese.dyndns.org> <4DB48B2C.2090904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 22:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6FO-0005u1-QN
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752Ab1DXUtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:49:22 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:5175 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757701Ab1DXUtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:49:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BE63F13004D;
	Sun, 24 Apr 2011 22:49:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9CCDD19F396;
	Sun, 24 Apr 2011 22:49:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <4DB48B2C.2090904@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171998>

When pack-objects dies prematurely (for example, because there is some
repo corruption), we are careful to clean up the sideband demuxer (if it
is being used) with finish_async. For an async implementation which forks
(i.e., not Windows), that means we will waitpid() for the async process.

Meanwhile, the async sideband demuxer will continue trying to stream data
from the remote repo until it gets EOF. Depending on what data
pack-objects actually sent, the remote repo may not actually send
anything, in particular, after the initial rev-exchange it is waiting for
the pack data to arrive.

The send-pack parent process closes the writable end of the channel so
that after the death of the pack-objects process all writable ends should
have been closed and the remote repo should see EOF. This does not
happen, however, because when the sideband demuxer was forked earlier, it
also inherited a writable end; it remains open and keeps the remote repo
from seeing EOF. This leads to a deadlock cycle in which send-pack waits
on the demuxer, the demuxer waits on the remote receive-pack, and the
remote receive-pack waits on send-pack to send the pack data.

To break this, we close the writable end in the demuxer, but only when
it runs in a forked async process.

Analyzed-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
This is the replacement of the series that Jeff proposed earlier. It
should also be merged into f6b60983 (Enable threaded async procedures
whenever pthreads is available). To keep bisectability, the merge commit
should replace '#ifndef ASYNC_AS_THREAD' by '#ifdef NO_PTHREADS'.

-- Hannes

 builtin-send-pack.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 089058b..b371c79 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -376,6 +376,9 @@ static void print_helper_status(struct ref *ref)
 static int sideband_demux(int in, int out, void *data)
 {
 	int *fd = data;
+#ifndef ASYNC_AS_THREAD
+	close(fd[1]);
+#endif
 	int ret = recv_sideband("send-pack", fd[0], out);
 	close(out);
 	return ret;
-- 
1.7.5.rc1.97.ge0653
