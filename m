From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] give priority to progress messages
Date: Wed, 11 Nov 2009 17:24:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911111707390.16711@xanadu.home>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <20091111184215.GG27518@vidovic>
 <alpine.LFD.2.00.0911111408380.16711@xanadu.home>
 <20091111210727.GN12890@machine.or.cz>
 <alpine.LFD.2.00.0911111617440.16711@xanadu.home>
 <20091111214216.GO12890@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8LcO-0002kf-P8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 23:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380AbZKKWYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 17:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759315AbZKKWYi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 17:24:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27288 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250AbZKKWYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 17:24:37 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSY0085AU96KZ70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Nov 2009 17:24:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091111214216.GO12890@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132715>

In theory it is possible for sideband channel #2 to be delayed if
pack data is quick to come up for sideband channel #1.  And because
data for channel #2 is read only 128 bytes at a time while pack data
is read 8192 bytes at a time, it is possible for many pack blocks to
be sent to the client before the progress message fifo is emptied,
making the situation even worse.  This would result in totally garbled
progress display on the client's console as local progress gets mixed
with partial remote progress lines.

Let's prevent such situations by giving transmission priority to 
progress messages over pack data at all times.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

On Wed, 11 Nov 2009, Petr Baudis wrote:

> On Wed, Nov 11, 2009 at 04:19:44PM -0500, Nicolas Pitre wrote:
> > On Wed, 11 Nov 2009, Petr Baudis wrote:
> > 
> > > On Wed, Nov 11, 2009 at 02:50:22PM -0500, Nicolas Pitre wrote:
> > > > According to strace, data from sideband channel #2 (prefixed with 
> > > > "remote: ") pertaining to object compression is printed way after pack 
> > > > data has already started to arrive locally.  This is really weird.
> > > > 
> > > > And this occurs only when fetching from repo.or.cz and not from 
> > > > git.kernel.org for example.  So there is something to investigate on the 
> > > > server side.  Pasky: anything you changed in your git installation 
> > > > lately?
> > > 
> > > Yes, but nothing should have changed in git-daemon, that's the only part
> > > of the infrastructure that uses system-wide git (which it perhaps
> > > shouldn't). I cannot reproduce this problem, though. I have changed
> > > git-daemon to use my local git version (about one week old master), does
> > > this still happen for you?
> > 
> > No, it doesn't happen anymore.
> > 
> > What was the git-daemon version before?
> 
> 1.5.6.5, the default version in debian lenny

I don't see why the issue couldn't happen with latest git as well.
This patch however would plug any possibilities for this to happen again 
though.

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index c4cd1e1..29446e8 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -132,7 +132,6 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 
 	while (1) {
 		struct pollfd pfd[2];
-		ssize_t processed[2] = { 0, 0 };
 		int status;
 
 		pfd[0].fd = fd1[0];
@@ -147,15 +146,14 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 			}
 			continue;
 		}
-		if (pfd[0].revents & POLLIN)
-			/* Data stream ready */
-			processed[0] = process_input(pfd[0].fd, 1);
 		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
-			processed[1] = process_input(pfd[1].fd, 2);
-		/* Always finish to read data when available */
-		if (processed[0] || processed[1])
-			continue;
+			if (process_input(pfd[1].fd, 2))
+				continue;
+		if (pfd[0].revents & POLLIN)
+			/* Data stream ready */
+			if (process_input(pfd[0].fd, 1))
+				continue;
 
 		if (waitpid(writer, &status, 0) < 0)
 			error_clnt("%s", lostchild);
diff --git a/upload-pack.c b/upload-pack.c
index 70badcf..6bfb500 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -310,6 +310,23 @@ static void create_pack_file(void)
 			}
 			continue;
 		}
+		if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
+			/* Status ready; we ship that in the side-band
+			 * or dump to the standard error.
+			 */
+			sz = xread(pack_objects.err, progress,
+				  sizeof(progress));
+			if (0 < sz)
+				send_client_data(2, progress, sz);
+			else if (sz == 0) {
+				close(pack_objects.err);
+				pack_objects.err = -1;
+			}
+			else
+				goto fail;
+			/* give priority to status messages */
+			continue;
+		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			/* Data ready; we keep the last byte to ourselves
 			 * in case we detect broken rev-list, so that we
@@ -347,21 +364,6 @@ static void create_pack_file(void)
 			if (sz < 0)
 				goto fail;
 		}
-		if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
-			/* Status ready; we ship that in the side-band
-			 * or dump to the standard error.
-			 */
-			sz = xread(pack_objects.err, progress,
-				  sizeof(progress));
-			if (0 < sz)
-				send_client_data(2, progress, sz);
-			else if (sz == 0) {
-				close(pack_objects.err);
-				pack_objects.err = -1;
-			}
-			else
-				goto fail;
-		}
 	}
 
 	if (finish_command(&pack_objects)) {
