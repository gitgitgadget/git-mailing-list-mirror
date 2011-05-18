From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Windows: add a wrapper for the shutdown() system call
Date: Wed, 18 May 2011 22:24:37 +0200
Message-ID: <4DD42B05.9050000@kdbg.org>
References: <20110516063944.GB25731@sigill.intra.peff.net> <20110516065257.GC19078@sigill.intra.peff.net> <4DD182C8.50308@kdbg.org> <20110517055605.GE10048@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 22:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMnIX-0005ar-64
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 22:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1ERUYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 16:24:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:49600 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752316Ab1ERUYn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 16:24:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F2AEB2C4004;
	Wed, 18 May 2011 22:24:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D3A0119F334;
	Wed, 18 May 2011 22:24:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <20110517055605.GE10048@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173902>

Even though Windows's socket functions look like their POSIX counter parts,
they do not operate on file descriptors, but on "socket objects". To bring
the functions in line with POSIX, we have proxy functions that wrap and
unwrap the socket objects in file descriptors using open_osfhandle and
get_osfhandle. But shutdown() was not proxied, yet. Fix this.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 17.05.2011 07:56, schrieb Jeff King:
> On Mon, May 16, 2011 at 10:02:16PM +0200, Johannes Sixt wrote:
> 
>>> +			if (git_connection_is_socket(conn))
>>> +				shutdown(fd[0], SHUT_WR);
>>
>> We probably need a wrapper for shutdown() on Windows. I'll look into
>> this tomorrow.

We have a shutdown() on Windows, but it does not work out of the box.
Making it work is not a big deal, but it is an academic excercise if it
were only for this topic: On Windows, send-pack hangs when network
connections are involved for unknown reasons as long as side-band-64k
is enabled. If it is not enabled, the deadlock that you fixed does not
happen in the first place and it is irrelevant whether shutdown works.

> FWIW, we already make an identical call in transport-helper.c (I was
> tempted even to use "1" instead of SHUT_WR for portability, but it seems
> nobody has complained so far about the use in transport-helper).

Yes, and for the reasons mentioned above, this patch is intended for
the 1.7.4 series, where transport-helper.c went public. (But it should
apply cleanly to current master as well.) We do not have tests that
exercise the code in transport-helper.c, but I did test that this
shutdown implementation does something reasonable when it is merged
with your send-pack deadlock topic branch.

 compat/mingw.c |    7 +++++++
 compat/mingw.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bee6054..1cbc9e8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1219,6 +1219,13 @@ int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen)
 	return setsockopt(s, lvl, optname, (const char*)optval, optlen);
 }
 
+#undef shutdown
+int mingw_shutdown(int sockfd, int how)
+{
+	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
+	return shutdown(s, how);
+}
+
 #undef listen
 int mingw_listen(int sockfd, int backlog)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 14211c6..3b20fa9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -219,6 +219,9 @@ int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz);
 int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen);
 #define setsockopt mingw_setsockopt
 
+int mingw_shutdown(int sockfd, int how);
+#define shutdown mingw_shutdown
+
 int mingw_listen(int sockfd, int backlog);
 #define listen mingw_listen
 
-- 
1.7.5.rc1.97.ge0653
