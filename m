From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/2] git-credential-cache--daemon on Cygwin
Date: Sat, 22 Oct 2011 18:23:25 +0100
Message-ID: <4EA2FC0D.5060404@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 19:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHfOe-0002Kp-O8
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 19:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab1JVRaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 13:30:05 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:43822 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754133Ab1JVRaE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2011 13:30:04 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RHfOT-0001Mv-YQ; Sat, 22 Oct 2011 17:30:02 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184103>

Hi Jeff,

When the 'jk/http-auth-keyring' branch was in next (and later back
in pu), I noticed that the t0300-credentials.sh test failing on cygwin.

I had a quick look, and found that unix_stream_listen() was failing to
bind() to a stale unix socket. The code looked OK to me, and should have
handled this just fine, but didn't ...

On a hunch, I found that the following "belt-n-braces" approach fixed the
the test for me:

-- >8 --
diff --git a/unix-socket.c b/unix-socket.c
index cf9890f..d974e01 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -42,7 +42,9 @@ int unix_stream_listen(const char *path)
 	fd = unix_stream_socket();
 
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		close(fd);
 		unlink(path);
+		fd = unix_stream_socket();
 		if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
 			close(fd);
 			return -1;
-- 8< --

However, I don't particularly like the above solution, so I decided to take
a look at credential-cache--daemon to see why it was leaving a stale socket
in the first place. The following patches are the result:

    [PATCH 1/2] credential-cache--daemon.c: Don't leave stale socket on --exit
    [PATCH 2/2] credential-cache--daemon.c: unlink() a potentially stale unix socket

Note that, in serve_one_client(), the "--exit" action results in the server
exit(0)-ing immediately without close()-ing and unlink()-ing the socket.
So, patch #1 changes serve_one_client() to return a value to serve_cache_loop()
which indicates whether it's caller (serve_cache()) should exit from the main
server loop. This results in the socket being cleaned up correctly in the "--exit"
case.

Note that this does not eliminate all early-exit code paths (for example, we note
an die_errno() call), so it is still possible for the server to exit without
having cleaned up the socket, so patch #2 adds on unlink() call to the beginning of
serve_cache().

Note that each of these patches, separately and together, fix the test on cygwin.

Assuming that a modified http-auth-keyring series will make a return to pu
sometime, could you please squash these patches into (the patch corresponding to)
commit 2d6874d (credentials: add "cache" helper, 18-07-2011). Thanks!

Also, note that this series breaks the build on MinGW. The patch to fix the build
is rather simple, but the result doesn't work, of course, because winsock does
not know about AF_UNIX (or AF_LOCAL). I started to code an win32 emulation of unix
sockets, but stopped working on it when this branch dropped from next. If you
intend to re-submit this work, then I can pick this up again.

HTH.

ATB,
Ramsay Jones
