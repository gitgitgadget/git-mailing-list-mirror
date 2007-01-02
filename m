From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] send pack check for failure to send revisions list
Date: Tue, 2 Jan 2007 14:12:09 +0000
Message-ID: <722763b67370326ef33dabb3c8e34e7e@pinky>
References: <459A66D2.3000804@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 02 15:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ksR-0007kw-JC
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 15:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbXABOoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 09:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbXABOoW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 09:44:22 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:35336
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754851AbXABOoV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jan 2007 09:44:21 -0500
X-Greylist: delayed 1930 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 09:44:21 EST
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1H1kN7-00088o-Lz; Tue, 02 Jan 2007 14:12:09 +0000
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <459A66D2.3000804@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35788>

When passing the revisions list to pack-objects we do not check for
errors nor short writes.  Introduce a new write_in_full which will
handle short writes and report errors to the caller.  Use this to
short cut the send on failure, allowing us to wait for and report
the child in case the failure is its fault.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/send-pack.c b/send-pack.c
index eaa6efb..c195d08 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -65,12 +65,16 @@ static int pack_objects(int fd, struct ref *refs)
 			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
 			buf[0] = '^';
 			buf[41] = '\n';
-			write(pipe_fd[1], buf, 42);
+			if (!write_in_full(pipe_fd[1], buf, 42,
+						"send-pack: send refs"))
+				break;
 		}
 		if (!is_null_sha1(refs->new_sha1)) {
 			memcpy(buf, sha1_to_hex(refs->new_sha1), 40);
 			buf[40] = '\n';
-			write(pipe_fd[1], buf, 41);
+			if (!write_in_full(pipe_fd[1], buf, 41,
+						"send-pack: send refs"))
+				break;
 		}
 		refs = refs->next;
 	}
diff --git a/write_or_die.c b/write_or_die.c
index 8cf6486..6db1d31 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -59,3 +59,26 @@ int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 
 	return 1;
 }
+
+int write_in_full(int fd, const void *buf, size_t count, const char *msg)
+{
+	const char *p = buf;
+	ssize_t written;
+
+	while (count > 0) {
+		written = xwrite(fd, p, count);
+		if (written == 0) {
+			fprintf(stderr, "%s: disk full?\n", msg);
+			return 0;
+		}
+		else if (written < 0) {
+			fprintf(stderr, "%s: write error (%s)\n",
+				msg, strerror(errno));
+			return 0;
+		}
+		count -= written;
+		p += written;
+	}
+
+	return 1;
+}
