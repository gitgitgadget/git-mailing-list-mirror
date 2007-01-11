From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Avoid errors and warnings when attempting to do I/O on zero bytes
Date: Thu, 11 Jan 2007 13:43:40 -0800
Message-ID: <20070111214340.GA25445@mayonaise.dyndns.org>
References: <1cb8699724ff000fbf0c14ba3e15031e@pinky> <7vvejlg1pg.fsf@assigned-by-dhcp.cox.net> <459E4270.9090307@shadowen.org> <45A2699F.5060100@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:43:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57i7-0002wd-KF
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbXAKVnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbXAKVnp
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:43:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36725 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103AbXAKVno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:43:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AB9A37DC094;
	Thu, 11 Jan 2007 13:43:40 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 11 Jan 2007 13:43:40 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <45A2699F.5060100@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36615>

Unfortunately, while {read,write}_in_full do take into account
zero-sized reads/writes; their die and whine variants do not.

I have a repository where there are zero-sized files in
the history that was triggering these things.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 sha1_file.c    |    2 ++
 write_or_die.c |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 53e25f2..18dd89b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1620,6 +1620,8 @@ static int write_buffer(int fd, const void *buf, size_t len)
 {
 	ssize_t size;
 
+	if (!len)
+		return 0;
 	size = write_in_full(fd, buf, len);
 	if (!size)
 		return error("file write: disk full");
diff --git a/write_or_die.c b/write_or_die.c
index a119e1d..700ccd1 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -26,6 +26,8 @@ void read_or_die(int fd, void *buf, size_t count)
 {
 	ssize_t loaded;
 
+	if (!count)
+		return;
 	loaded = read_in_full(fd, buf, count);
 	if (loaded == 0)
 		die("unexpected end of file");
@@ -59,6 +61,8 @@ void write_or_die(int fd, const void *buf, size_t count)
 {
 	ssize_t written;
 
+	if (!count)
+		return;
 	written = write_in_full(fd, buf, count);
 	if (written == 0)
 		die("disk full?");
@@ -73,6 +77,8 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	ssize_t written;
 
+	if (!count)
+		return 1;
 	written = write_in_full(fd, buf, count);
 	if (written == 0) {
 		fprintf(stderr, "%s: disk full?\n", msg);
@@ -93,6 +99,8 @@ int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
 	ssize_t written;
 
+	if (!count)
+		return 1;
 	written = write_in_full(fd, buf, count);
 	if (written == 0) {
 		fprintf(stderr, "%s: disk full?\n", msg);
-- 
Eric Wong
