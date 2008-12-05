From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/3] Make some of fwrite/fclose/write/close failures visible
Date: Fri, 5 Dec 2008 01:35:48 +0100
Message-ID: <20081205003546.GA7294@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 01:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Ogw-0000PZ-5U
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 01:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYLEAfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 19:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbYLEAfw
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 19:35:52 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:22536 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYLEAfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 19:35:51 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8Ak82pR9a
Received: from tigra.home (Fadd1.f.strato-dslnet.de [195.4.173.209])
	by post.strato.de (mrclete mo49) (RZmta 17.20)
	with ESMTP id Y02419kB4N4ldm ; Fri, 5 Dec 2008 01:35:48 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 41A0B277C8;
	Fri,  5 Dec 2008 01:35:48 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 206B936D27; Fri,  5 Dec 2008 01:35:48 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102381>

So that full filesystem conditions or permissions problems wont go
unnoticed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This and the follow-up patches is fallout of Windows debugging
sessions. I implemented random error handling code just to figure out
where it might be going wrong. None of that code actually helped to
fix something (and lots was just thrown away), but some, I think,
still makes sense.

This patch adds error handling only to fwrite/fputs where the return
value was ignored and writing was definitely into a file. BTW, libc
headers in Ubuntu 8.10 have warn_unused_result attribute added to many
functions (fwrite(3) and write(2) amongst them). This helps finding
the problem places.

 builtin-fsck.c  |    8 ++++++--
 builtin-merge.c |    6 ++++--
 rerere.c        |   46 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index d3f3de9..afded5e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -201,12 +201,16 @@ static void check_unreachable_object(struct object *obj)
 				char *buf = read_sha1_file(obj->sha1,
 						&type, &size);
 				if (buf) {
-					fwrite(buf, size, 1, f);
+					if (fwrite(buf, size, 1, f) != 1)
+						die("Could not write %s: %s",
+						    filename, strerror(errno));
 					free(buf);
 				}
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
-			fclose(f);
+			if (fclose(f))
+				die("Could not finish %s: %s",
+				    filename, strerror(errno));
 		}
 		return;
 	}
diff --git a/builtin-merge.c b/builtin-merge.c
index 7c2b90c..cf86975 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -293,8 +293,10 @@ static void squash_message(void)
 		pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
 			NULL, NULL, rev.date_mode, 0);
 	}
-	write(fd, out.buf, out.len);
-	close(fd);
+	if (write(fd, out.buf, out.len) < 0)
+		die("Writing SQUASH_MSG: %s", strerror(errno));
+	if (close(fd))
+		die("Finishing SQUASH_MSG: %s", strerror(errno));
 	strbuf_release(&out);
 }
 
diff --git a/rerere.c b/rerere.c
index 02931a1..718fb52 100644
--- a/rerere.c
+++ b/rerere.c
@@ -70,6 +70,19 @@ static int write_rr(struct string_list *rr, int out_fd)
 	return 0;
 }
 
+static void ferr_write(const void *p, size_t count, FILE *fp, int *err)
+{
+	if (!count || *err)
+		return;
+	if (fwrite(p, count, 1, fp) != 1)
+		*err = errno;
+}
+
+static inline void ferr_puts(const char *s, FILE *fp, int *err)
+{
+	ferr_write(s, strlen(s), fp, err);
+}
+
 static int handle_file(const char *path,
 	 unsigned char *sha1, const char *output)
 {
@@ -82,6 +95,7 @@ static int handle_file(const char *path,
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	FILE *f = fopen(path, "r");
 	FILE *out = NULL;
+	int wrerror = 0;
 
 	if (!f)
 		return error("Could not open %s", path);
@@ -118,11 +132,11 @@ static int handle_file(const char *path,
 			hunk_no++;
 			hunk = RR_CONTEXT;
 			if (out) {
-				fputs("<<<<<<<\n", out);
-				fwrite(one.buf, one.len, 1, out);
-				fputs("=======\n", out);
-				fwrite(two.buf, two.len, 1, out);
-				fputs(">>>>>>>\n", out);
+				ferr_puts("<<<<<<<\n", out, &wrerror);
+				ferr_write(one.buf, one.len, out, &wrerror);
+				ferr_puts("=======\n", out, &wrerror);
+				ferr_write(two.buf, two.len, out, &wrerror);
+				ferr_puts(">>>>>>>\n", out, &wrerror);
 			}
 			if (sha1) {
 				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
@@ -139,7 +153,7 @@ static int handle_file(const char *path,
 		else if (hunk == RR_SIDE_2)
 			strbuf_addstr(&two, buf);
 		else if (out)
-			fputs(buf, out);
+			ferr_puts(buf, out, &wrerror);
 		continue;
 	bad:
 		hunk = 99; /* force error exit */
@@ -149,8 +163,12 @@ static int handle_file(const char *path,
 	strbuf_release(&two);
 
 	fclose(f);
-	if (out)
-		fclose(out);
+	if (wrerror)
+		error("There were errors while writing %s (%s)",
+		      path, strerror(wrerror));
+	if (out && fclose(out))
+		wrerror = error("Failed to flush %s: %s",
+				path, strerror(errno));
 	if (sha1)
 		git_SHA1_Final(sha1, &ctx);
 	if (hunk != RR_CONTEXT) {
@@ -158,6 +176,8 @@ static int handle_file(const char *path,
 			unlink(output);
 		return error("Could not parse conflict hunks in %s", path);
 	}
+	if (wrerror)
+		return -1;
 	return hunk_no;
 }
 
@@ -200,9 +220,13 @@ static int merge(const char *name, const char *path)
 	if (!ret) {
 		FILE *f = fopen(path, "w");
 		if (!f)
-			return error("Could not write to %s", path);
-		fwrite(result.ptr, result.size, 1, f);
-		fclose(f);
+			return error("Could not open %s: %s", path,
+				     strerror(errno));
+		if (fwrite(result.ptr, result.size, 1, f) != 1)
+			error("Could not write %s: %s", path, strerror(errno));
+		if (fclose(f))
+			return error("Writing %s failed: %s", path,
+				     strerror(errno));
 	}
 
 	free(cur.ptr);
-- 
1.6.1.rc1.29.gb140
