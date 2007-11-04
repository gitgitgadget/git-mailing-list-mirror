From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] upload-pack: Use finish_{command,async}() instead of waitpid().
Date: Sun, 4 Nov 2007 20:46:48 +0100
Message-ID: <200711042046.48257.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 20:47:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IolR5-0005Zg-12
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbXKDTqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbXKDTqw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:46:52 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:60637 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbXKDTqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:46:51 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id D514797ABD;
	Sun,  4 Nov 2007 20:46:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7BB455899F;
	Sun,  4 Nov 2007 20:46:48 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63436>

upload-pack spawns two processes, rev-list and pack-objects, and carefully
monitors their status so that it can report failure to the remote end.
This change removes the complicated procedures on the grounds of the
following observations:

- If everything is OK, rev-list closes its output pipe end, upon which
  pack-objects (which reads from the pipe) sees EOF and terminates itself,
  closing its output (and error) pipes. upload-pack reads from both until
  it sees EOF in both. It collects the exit codes of the child processes
  (which indicate success) and terminates successfully.

- If rev-list sees an error, it closes its output and terminates with
  failure. pack-objects sees EOF in its input and terminates successfully.
  Again upload-pack reads its inputs until EOF. When it now collects
  the exit codes of its child processes, it notices the failure of rev-list
  and signals failure to the remote end.

- If pack-objects sees an error, it terminates with failure. Since this
  breaks the pipe to rev-list, rev-list is killed with SIGPIPE.
  upload-pack reads its input until EOF, then collects the exit codes of
  the child processes, notices their failures, and signals failure to the
  remote end.

- If upload-pack itself dies unexpectedly, pack-objects is killed with
  SIGPIPE, and subsequently also rev-list.

The upshot of this is that precise monitoring of child processes is not
required because both terminate if either one of them dies unexpectedly.
This allows us to use finish_command() and finish_async() instead of
an explicit waitpid(2) call.

The change is smaller than it looks because most of it only reduces the
indentation of a large part of the inner loop.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	This patch allows us to reduce the differences to the
	MinGW port even further. It goes on top of js/forkexec
	(which meanwhile is in master).

	The test case checks for failures in rev-list (a missing
	object). Any hints how to trigger a failure in pack-objects
	that does not also trigger in rev-list would be welcome.

	BTW, I don't know what it means to process zombies if the
	parent does not waitpid(), but just terminates. Does this
	work as expected, ie. no zombies are left behind?

	-- Hannes

 t/t5530-upload-pack-error.sh |   49 +++++++++++
 upload-pack.c                |  192 +++++++++++++++++-------------------------
 2 files changed, 126 insertions(+), 115 deletions(-)
 create mode 100755 t/t5530-upload-pack-error.sh

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
new file mode 100755
index 0000000..9923ba0
--- /dev/null
+++ b/t/t5530-upload-pack-error.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='errors in upload-pack'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+test_expect_success 'setup and corrupt repository' '
+
+	echo file >file &&
+	git add file &&
+	git rev-parse :file &&
+	git commit -a -m original &&
+	test_tick &&
+	echo changed >file &&
+	git commit -a -m changed &&
+	rm -f .git/objects/f7/3f3093ff865c514c6c51f867e35f693487d0d3
+
+'
+
+test_expect_failure 'fsck fails' '
+
+	git fsck
+'
+
+test_expect_failure 'upload pack fails due to error in rev-list' '
+
+	echo "0032want $(git rev-parse HEAD)
+00000009done
+0000" | git-upload-pack . > /dev/null
+
+'
+
+test_expect_success 'create empty repository' '
+
+	mkdir foo &&
+	cd foo &&
+	git init
+
+'
+
+test_expect_failure 'fetch fails' '
+
+	git fetch .. master
+
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 6799468..7e04311 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -144,6 +144,7 @@ static void create_pack_file(void)
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
 	int buffered = -1;
+	ssize_t sz;
 	const char *argv[10];
 	int arg = 0;
 
@@ -168,22 +169,15 @@ static void create_pack_file(void)
 	pack_objects.git_cmd = 1;
 	pack_objects.argv = argv;
 
-	if (start_command(&pack_objects)) {
-		/* daemon sets things up to ignore TERM */
-		kill(rev_list.pid, SIGKILL);
+	if (start_command(&pack_objects))
 		die("git-upload-pack: unable to fork git-pack-objects");
-	}
 
 	/* We read from pack_objects.err to capture stderr output for
 	 * progress bar, and pack_objects.out to capture the pack data.
 	 */
 
 	while (1) {
-		const char *who;
 		struct pollfd pfd[2];
-		pid_t pid;
-		int status;
-		ssize_t sz;
 		int pe, pu, pollsize;
 
 		reset_timeout();
@@ -204,123 +198,91 @@ static void create_pack_file(void)
 			pollsize++;
 		}
 
-		if (pollsize) {
-			if (poll(pfd, pollsize, -1) < 0) {
-				if (errno != EINTR) {
-					error("poll failed, resuming: %s",
-					      strerror(errno));
-					sleep(1);
-				}
-				continue;
-			}
-			if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
-				/* Data ready; we keep the last byte
-				 * to ourselves in case we detect
-				 * broken rev-list, so that we can
-				 * leave the stream corrupted.  This
-				 * is unfortunate -- unpack-objects
-				 * would happily accept a valid pack
-				 * data with trailing garbage, so
-				 * appending garbage after we pass all
-				 * the pack data is not good enough to
-				 * signal breakage to downstream.
-				 */
-				char *cp = data;
-				ssize_t outsz = 0;
-				if (0 <= buffered) {
-					*cp++ = buffered;
-					outsz++;
-				}
-				sz = xread(pack_objects.out, cp,
-					  sizeof(data) - outsz);
-				if (0 < sz)
-						;
-				else if (sz == 0) {
-					close(pack_objects.out);
-					pack_objects.out = -1;
-				}
-				else
-					goto fail;
-				sz += outsz;
-				if (1 < sz) {
-					buffered = data[sz-1] & 0xFF;
-					sz--;
-				}
-				else
-					buffered = -1;
-				sz = send_client_data(1, data, sz);
-				if (sz < 0)
-					goto fail;
-			}
-			if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
-				/* Status ready; we ship that in the side-band
-				 * or dump to the standard error.
-				 */
-				sz = xread(pack_objects.err, progress,
-					  sizeof(progress));
-				if (0 < sz)
-					send_client_data(2, progress, sz);
-				else if (sz == 0) {
-					close(pack_objects.err);
-					pack_objects.err = -1;
-				}
-				else
-					goto fail;
+		if (!pollsize)
+			break;
+
+		if (poll(pfd, pollsize, -1) < 0) {
+			if (errno != EINTR) {
+				error("poll failed, resuming: %s",
+				      strerror(errno));
+				sleep(1);
 			}
+			continue;
 		}
-
-		/* See if the children are still there */
-		if (rev_list.pid || pack_objects.pid) {
-			pid = waitpid(-1, &status, WNOHANG);
-			if (!pid)
-				continue;
-			who = ((pid == rev_list.pid) ? "git-rev-list" :
-			       (pid == pack_objects.pid) ? "git-pack-objects" :
-			       NULL);
-			if (!who) {
-				if (pid < 0) {
-					error("git-upload-pack: %s",
-					      strerror(errno));
-					goto fail;
-				}
-				error("git-upload-pack: we weren't "
-				      "waiting for %d", pid);
-				continue;
+		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
+			/* Data ready; we keep the last byte to ourselves
+			 * in case we detect broken rev-list, so that we
+			 * can leave the stream corrupted.  This is
+			 * unfortunate -- unpack-objects would happily
+			 * accept a valid packdata with trailing garbage,
+			 * so appending garbage after we pass all the
+			 * pack data is not good enough to signal
+			 * breakage to downstream.
+			 */
+			char *cp = data;
+			ssize_t outsz = 0;
+			if (0 <= buffered) {
+				*cp++ = buffered;
+				outsz++;
+			}
+			sz = xread(pack_objects.out, cp,
+				  sizeof(data) - outsz);
+			if (0 < sz)
+					;
+			else if (sz == 0) {
+				close(pack_objects.out);
+				pack_objects.out = -1;
 			}
-			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0) {
-				error("git-upload-pack: %s died with error.",
-				      who);
+			else
 				goto fail;
+			sz += outsz;
+			if (1 < sz) {
+				buffered = data[sz-1] & 0xFF;
+				sz--;
 			}
-			if (pid == rev_list.pid)
-				rev_list.pid = 0;
-			if (pid == pack_objects.pid)
-				pack_objects.pid = 0;
-			if (rev_list.pid || pack_objects.pid)
-				continue;
-		}
-
-		/* both died happily */
-		if (pollsize)
-			continue;
-
-		/* flush the data */
-		if (0 <= buffered) {
-			data[0] = buffered;
-			sz = send_client_data(1, data, 1);
+			else
+				buffered = -1;
+			sz = send_client_data(1, data, sz);
 			if (sz < 0)
 				goto fail;
-			fprintf(stderr, "flushed.\n");
 		}
-		if (use_sideband)
-			packet_flush(1);
-		return;
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
+		}
+	}
+
+	if (finish_command(&pack_objects)) {
+		error("git-upload-pack: git-pack-objects died with error.");
+		goto fail;
+	}
+	if (finish_async(&rev_list))
+		goto fail;	/* error was already reported */
+
+	/* flush the data */
+	if (0 <= buffered) {
+		data[0] = buffered;
+		sz = send_client_data(1, data, 1);
+		if (sz < 0)
+			goto fail;
+		fprintf(stderr, "flushed.\n");
 	}
+	if (use_sideband)
+		packet_flush(1);
+	return;
+
  fail:
-	if (pack_objects.pid)
-		kill(pack_objects.pid, SIGKILL);
-	if (rev_list.pid)
-		kill(rev_list.pid, SIGKILL);
 	send_client_data(3, abort_msg, sizeof(abort_msg));
 	die("git-upload-pack: %s", abort_msg);
 }
-- 
1.5.3.4.315.g2ce38
