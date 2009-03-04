From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/2] make remote hangup warnings more friendly
Date: Wed, 4 Mar 2009 03:42:45 -0500
Message-ID: <20090304084245.GB31798@coredump.intra.peff.net>
References: <20090303184106.GH14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 09:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LemiE-0003py-7d
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 09:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbZCDImx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZCDImx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 03:42:53 -0500
Received: from peff.net ([208.65.91.99]:37000 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZCDImw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 03:42:52 -0500
Received: (qmail 22792 invoked by uid 107); 4 Mar 2009 08:42:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 03:42:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 03:42:45 -0500
Content-Disposition: inline
In-Reply-To: <20090303184106.GH14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112189>

When a user asks to do a remote operation but the remote
side thinks the operation is invalid (e.g., because the user
pointed to a directory which is not actually a repository),
then we generally end up showing the user two fatal
messages: one from the remote explaining what went wrong, and
one from the local side complaining of an unexpected hangup.

For example:

  $ git push /nonexistent master
  fatal: '/nonexistent' does not appear to be a git repository
  fatal: The remote end hung up unexpectedly

In this case, the second message is useless noise, and the
user is better off seeing just the first.

This patch tries to suppress the "hung up" message when it
is redundant (but still exits with an error code, of
course).

One heuristic would be to suppress it whenever the remote
has said something on stderr. Unfortunately, in many
transports we don't actually handle stderr ourselves; it
is simply a clone of the parent program's stderr and goes
straight to the terminal.

Instead, we note that the remote end will typically perform
such an "expected" hangup at the beginning of a packet
instead of in the middle. Therefore if we are expecting a
packet and get an end-of-file from the remote, we assume
they have printed something useful and exit without further
messages. Any other short read or eof is reported as before.

Signed-off-by: Jeff King <peff@peff.net>
---
There are two possible problems with this patch:

  1. The "beginning of packet" heuristic may not be the best. I
     tried a few obvious test cases like pushing and fetching with
     invalid repos and bogus --receive-pack= settings. All of them have
     useful output from the remote. You would of course get no message
     if the remote was cut off randomly at just the right spot.

    The "remote said something on stderr" heuristic does seem better.
    But we would have to start processing stderr for local and ssh
    connections, which we don't do currently. On the other hand, that
    might be nicer in the long run, because you can mark the remote
    errors as remote, which makes it more obvious what is going on.
    E.g.,:

      $ git push host:bogus master
      remote: fatal: 'bogus' does not appear to be a git repository

  2. Even "remote said something on stderr" may not be a desirable
     heuristic. In the case of a bogus --receive-pack, you get:

       $ git push --receive-pack=bogus host:repo master
       sh: bogus: command not found

     So you are losing the part where git says "fatal: ". Maybe it
     is obvious that such an error is fatal. It is to me, but I am not
     the intended audience.

     I think this would be improved somewhat with stderr processing to:

       remote: sh: bogus: command not found

     Or you could even trigger the suppression only if stderr had a line
     matching "^fatal:".

     Or it may even be that adding "remote:" is enough to make things
     less confusing:

       remote: fatal: 'bogus' does not appear to be a git repository
       fatal: The remote end hung up unexpectedly

     I think I still favor suppression in that case, but it is at least
     more clear why there are two fatals.

So you can see, the possibilities are endless. The perfect bikeshed. ;)

 pkt-line.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index f5d0086..f2b387c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -63,13 +63,16 @@ void packet_write(int fd, const char *fmt, ...)
 	safe_write(fd, buffer, n);
 }
 
-static void safe_read(int fd, void *buffer, unsigned size)
+static void safe_read(int fd, void *buffer, unsigned size, int eof_warn)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
 	if (ret < 0)
 		die("read error (%s)", strerror(errno));
-	else if (ret < size)
+	else if (ret < size) {
+		if (ret == 0 && !eof_warn)
+			exit(128);
 		die("The remote end hung up unexpectedly");
+	}
 }
 
 int packet_read_line(int fd, char *buffer, unsigned size)
@@ -78,7 +81,7 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	unsigned len;
 	char linelen[4];
 
-	safe_read(fd, linelen, 4);
+	safe_read(fd, linelen, 4, 0);
 
 	len = 0;
 	for (n = 0; n < 4; n++) {
@@ -103,7 +106,7 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
-	safe_read(fd, buffer, len);
+	safe_read(fd, buffer, len, 1);
 	buffer[len] = 0;
 	return len;
 }
-- 
1.6.2.rc2.24.g55bc2
