From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects error
Date: Wed, 13 Apr 2011 21:53:06 +0200
Message-ID: <201104132153.06429.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110331184443.GD16906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:53:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA67r-0003DT-IA
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331Ab1DMTxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 15:53:14 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:26773 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758248Ab1DMTxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:53:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EBA1613005D;
	Wed, 13 Apr 2011 21:53:06 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 838DD19F5E9;
	Wed, 13 Apr 2011 21:53:06 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110331184443.GD16906@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171482>

On Donnerstag, 31. M=C3=A4rz 2011, Jeff King wrote:
> If pack-objects dies prematurely (for example, because there
> is some repo corruption), we are careful to clean up the
> sideband demuxer (if it is being used) with finish_async.
> However, for an async implementation which forks (i.e., not
> Windows), that means we will waitpid() for the async
> process.
>
> Meanwhile, the async sideband demuxer will continue trying
> to stream data from the remote repo until it gets EOF.
> Depending on what data pack-objects actually sent, the
> remote repo may not actually send anything (e.g., if we sent
> nothing and it is simply waiting for the pack). This leads
> to deadlock cycle in which send-pack waits on the demuxer,
> the demuxer waits on the remote receive-pack, and the remote
> receive-pack waits on send-pack to send the pack data.

This is an indication that a writable end of the pipe between send-pack=
 and=20
receive-pack is still open. This fixes the deadlock for me without havi=
ng to=20
kill the demuxer explicitly:

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 5e772c7..db32ded 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -229,6 +229,9 @@ static void print_helper_status(struct ref *ref)
 static int sideband_demux(int in, int out, void *data)
 {
 	int *fd =3D data;
+#ifdef NO_PTHREADS
+	close(fd[1]);
+#endif
 	int ret =3D recv_sideband("send-pack", fd[0], out);
 	close(out);
 	return ret;

If only I had a brilliant idea how to forge this into a re-usable patte=
rn...

-- Hannes
