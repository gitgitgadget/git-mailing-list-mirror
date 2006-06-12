From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] blame: Add --time to produce raw timestamps
Date: Mon, 12 Jun 2006 23:42:10 +0200
Message-ID: <20060612214210.22342.46844.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jun 12 23:42:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpuAp-0004Hx-Nt
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 23:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFLVmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 17:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWFLVmM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 17:42:12 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:62434 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932177AbWFLVmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 17:42:12 -0400
Received: from c165 ([213.114.27.46] [213.114.27.46])
          by mxfep01.bredband.com with ESMTP
          id <20060612214211.DKQF9567.mxfep01.bredband.com@c165>;
          Mon, 12 Jun 2006 23:42:11 +0200
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FpuAk-0005oT-00; Mon, 12 Jun 2006 23:42:10 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21744>




Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 Documentation/git-blame.txt |    5 ++++-
 blame.c                     |   24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 0a1fa00..bfed945 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -20,7 +20,10 @@ OPTIONS
 	Use the same output mode as git-annotate (Default: off).
 
 -l, --long::
-	Show long rev (Defaults off).
+	Show long rev (Default: off).
+
+-t, --time::
+	Show raw timestamp (Default: off).
 
 -S, --rev-file <revs-file>::
 	Use revs from revs-file instead of calling git-rev-list.
diff --git a/blame.c b/blame.c
index 88bfec2..afa22b5 100644
--- a/blame.c
+++ b/blame.c
@@ -20,9 +20,11 @@ #include "xdiff-interface.h"
 
 #define DEBUG 0
 
-static const char blame_usage[] = "[-c] [-l] [--] file [commit]\n"
+static const char blame_usage[] = "[-c] [-l] [-t] [-S <revs-file>] [--] file [commit]\n"
 	"  -c, --compability Use the same output mode as git-annotate (Default: off)\n"
 	"  -l, --long        Show long commit SHA1 (Default: off)\n"
+        "  -t, --time        Show raw timestamp (Default: off)\n"
+	"  -S, --revs-file   Use revisions from revs-file instead of calling git-rev-list\n"
 	"  -h, --help        This message";
 
 static struct commit **blame_lines;
@@ -680,13 +682,19 @@ static void get_commit_info(struct commi
 	*tmp = 0;
 }
 
-static const char* format_time(unsigned long time, const char* tz_str)
+static const char* format_time(unsigned long time, const char* tz_str,
+			       int raw_time)
 {
 	static char time_buf[128];
 	time_t t = time;
 	int minutes, tz;
 	struct tm *tm;
 
+	if (raw_time) {
+		sprintf(time_buf, "%lu %s", time, tz_str);
+		return time_buf;
+	}
+
 	tz = atoi(tz_str);
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
@@ -740,6 +748,7 @@ int main(int argc, const char **argv)
 	char filename_buf[256];
 	int sha1_len = 8;
 	int compability = 0;
+	int raw_time = 0;
 	int options = 1;
 	struct commit* start_commit;
 
@@ -768,6 +777,10 @@ int main(int argc, const char **argv)
 				  !strcmp(argv[i], "--compability")) {
 				compability = 1;
 				continue;
+			} else if(!strcmp(argv[i], "-t") ||
+				  !strcmp(argv[i], "--time")) {
+				raw_time = 1;
+				continue;
 			} else if(!strcmp(argv[i], "-S")) {
 				if (i + 1 < argc &&
 				    !read_ancestry(argv[i + 1], &sha1_p)) {
@@ -873,14 +886,17 @@ int main(int argc, const char **argv)
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
 		if(compability) {
 			printf("\t(%10s\t%10s\t%d)", ci.author,
-			       format_time(ci.author_time, ci.author_tz), i+1);
+			       format_time(ci.author_time, ci.author_tz,
+					   raw_time),
+			       i+1);
 		} else {
 			if (found_rename)
 				printf(" %-*.*s", longest_file, longest_file,
 				       u->pathname);
 			printf(" (%-*.*s %10s %*d) ",
 			       longest_author, longest_author, ci.author,
-			       format_time(ci.author_time, ci.author_tz),
+			       format_time(ci.author_time, ci.author_tz,
+					   raw_time),
 			       max_digits, i+1);
 		}
 
