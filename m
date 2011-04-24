From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC 1/2] send-pack --stateless-rpc: properly close the outgoing
 channel
Date: Sun, 24 Apr 2011 22:42:20 +0200
Message-ID: <4DB48B2C.2090904@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104142136.25778.j6t@kdbg.org> <20110414202110.GA6525@sigill.intra.peff.net> <201104142243.33522.j6t@kdbg.org> <20110414205113.GA7451@sigill.intra.peff.net> <7vsjtkfs10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 22:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE68Y-0002HP-D2
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708Ab1DXUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:42:28 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:3895 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757690Ab1DXUm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:42:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B7A3210021;
	Sun, 24 Apr 2011 22:42:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3D81E19F396;
	Sun, 24 Apr 2011 22:42:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <7vsjtkfs10.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171997>

In the non-stateless-rpc case, the writable end of the channel to the
remote repo is closed by the start_command() call that runs the
pack-objects process (after pack-objects inherited a copy). But in the
--stateless-rpc case, where send-pack takes care of writing data to the
channel, this was missed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 14.04.2011 23:21, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> I think I am leaning a bit towards (2a). It's simple, and it's not like
>> this is library code with a million unknown callers; fixing it simply
>> and cleanly with a nice commit message is probably sufficient.
> 
> This really sounds like a plan.  Even if we _might_ later want to go to
> 2b. or some other solution, we will know what pattern to grep for.

Here's a 2-patch series that implements this plan. The patches go on top of
38a81b4e (receive-pack: Wrap status reports inside side-band-64k) just like
Jeff's series (jk/maint-push-async-hang).

Warning: This patch is untested. Furthermore, it does not even fix a resource
leak because the fd that is now closed in pack_objects() would be closed
later in cmd_send_pack. However, without closing the fd earlier like this,
a --stateless-rpc invocation could theoretically dead-lock just like a regular
invocation in a NO_PTHREADS build. But I also don't know how to test-drive
send-pack --stateless-rpc to construct such a case. Any hints how to do that
would be appreciated.

-- Hannes

 builtin-send-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2478e18..089058b 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -97,6 +97,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		free(buf);
 		close(po.out);
 		po.out = -1;
+		close(fd);
 	}
 
 	if (finish_command(&po))
-- 
1.7.5.rc1.97.ge0653
