From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] send-pack: avoid deadlock when pack-object dies early
Date: Mon, 25 Apr 2011 23:04:10 +0200
Message-ID: <4DB5E1CA.8000105@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104142136.25778.j6t@kdbg.org> <20110414202110.GA6525@sigill.intra.peff.net> <201104142243.33522.j6t@kdbg.org> <20110414205113.GA7451@sigill.intra.peff.net> <7vsjtkfs10.fsf@alter.siamese.dyndns.org> <4DB48B2C.2090904@kdbg.org> <4DB48CCD.40304@kdbg.org> <20110425165007.GB1589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QESxW-0008A3-H7
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab1DYVEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 17:04:20 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47111 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755357Ab1DYVEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 17:04:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C64CEA7EEB;
	Mon, 25 Apr 2011 23:01:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 10C6219F396;
	Mon, 25 Apr 2011 23:04:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <20110425165007.GB1589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172045>

Send-pack deadlocks in two ways when pack-object dies early (for example,
because there is some repo corruption).

The first deadlock happens with the smart push protocol (--stateless-rpc).
After the initial rev-exchange, the remote is waiting for the pack data
to arrive, and the sideband demuxer at the local side continues trying to
stream data from the remote repository until it gets EOF. Meanwhile,
send-pack (in function pack_objects()) has noticed that pack-objects did
not produce output and died. Back in send_pack(), it now tries to clean
up the sideband demuxer using finish_async(). The demuxer, however, waits
for the remote end to close down, the remote waits for pack data, and
the reason that it still waits is that send-pack forgot to close the
outgoing channel. Add the missing close() in pack_objects().

The second deadlock happens in a similar constellation when the sideband
demuxer runs in a forked process (rather than in a thread). Again, the
remote end waits for pack data to arrive, the sideband demuxer waits for
the remote to shut down, and send-pack (in the regular clean-up) waits for
the demuxer to terminate. This time, the send-pack parent process closes
the writable end of the outgoing channel (in start_command() that spawned
pack-objects) so that after the death of the pack-objects process all
writable ends should have been closed and the remote repo should see EOF.
This does not happen, however, because when the sideband demuxer was forked
earlier, it also inherited a writable end; it remains open and keeps the
remote repo from seeing EOF. To break this deadlock, close the writable end
in the demuxer.

Analyzed-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 25.04.2011 18:50, schrieb Jeff King:
> In the comments for 1/2, you said this goes directly on 38a81b4e. But in
> that commit, we use #ifndef WIN32 to decide whether or not to fork for
> async code. So shouldn't this use the same test (I don't even see
> ASYNC_AS_THREAD defined anywhere else)?

Here's the fixed patch. I squashed both earlier patches into a single patch
because they are about the same topic, as you showed with your tests of
git-push via smart http.

Again, this should go on top of 38a81b4e. When it is merged to f6b60983 or
later, the '#ifndef WIN32' must be changed to '#ifdef NO_PTHREADS'.

-- Hannes

 builtin-send-pack.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2478e18..6516288 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -97,6 +97,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		free(buf);
 		close(po.out);
 		po.out = -1;
+		close(fd);
 	}
 
 	if (finish_command(&po))
@@ -375,6 +376,9 @@ static void print_helper_status(struct ref *ref)
 static int sideband_demux(int in, int out, void *data)
 {
 	int *fd = data;
+#ifndef WIN32
+	close(fd[1]);
+#endif
 	int ret = recv_sideband("send-pack", fd[0], out);
 	close(out);
 	return ret;
-- 
1.7.5.rc1.97.ge0653
