From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] blame: Add --time to produce raw timestamps
Date: Tue, 13 Jun 2006 08:08:31 +0200
Message-ID: <20060613060831.GA4551@c165.ib.student.liu.se>
References: <20060612214210.22342.46844.stgit@c165> <Pine.LNX.4.63.0606130038370.25422@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 13 08:08:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq24s-00082K-DC
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 08:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWFMGIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 02:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932913AbWFMGIe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 02:08:34 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:19891 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932912AbWFMGId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 02:08:33 -0400
Received: from c165 ([213.114.27.46] [213.114.27.46])
          by mxfep02.bredband.com with ESMTP
          id <20060613060832.FMYJ18449.mxfep02.bredband.com@c165>;
          Tue, 13 Jun 2006 08:08:32 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Fq24m-00043L-00; Tue, 13 Jun 2006 08:08:32 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606130038370.25422@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21769>

On Tue, Jun 13, 2006 at 12:41:19AM +0200, Johannes Schindelin wrote:
<comments on "blame: Add --time to produce raw timestamps">

Thanks for the comments. Updated patch below.

- Fredrik

-------

blame: Add --time to produce raw timestamps

fix the usage string and clean up the docs while we are at it

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
index 88bfec2..25d3bcf 100644
--- a/blame.c
+++ b/blame.c
@@ -20,9 +20,11 @@ #include "xdiff-interface.h"
 
 #define DEBUG 0
 
-static const char blame_usage[] = "[-c] [-l] [--] file [commit]\n"
+static const char blame_usage[] = "[-c] [-l] [-t] [-S <revs-file>] [--] file [commit]\n"
 	"  -c, --compability Use the same output mode as git-annotate (Default: off)\n"
 	"  -l, --long        Show long commit SHA1 (Default: off)\n"
+	"  -t, --time        Show raw timestamp (Default: off)\n"
+	"  -S, --revs-file   Use revisions from revs-file instead of calling git-rev-list\n"
 	"  -h, --help        This message";
 
 static struct commit **blame_lines;
@@ -680,13 +682,19 @@ static void get_commit_info(struct commi
 	*tmp = 0;
 }
 
-static const char* format_time(unsigned long time, const char* tz_str)
+static const char* format_time(unsigned long time, const char* tz_str,
+			       int show_raw_time)
 {
 	static char time_buf[128];
 	time_t t = time;
 	int minutes, tz;
 	struct tm *tm;
 
+	if (show_raw_time) {
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
+	int show_raw_time = 0;
 	int options = 1;
 	struct commit* start_commit;
 
@@ -768,6 +777,10 @@ int main(int argc, const char **argv)
 				  !strcmp(argv[i], "--compability")) {
 				compability = 1;
 				continue;
+			} else if(!strcmp(argv[i], "-t") ||
+				  !strcmp(argv[i], "--time")) {
+				show_raw_time = 1;
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
+					   show_raw_time),
+			       i+1);
 		} else {
 			if (found_rename)
 				printf(" %-*.*s", longest_file, longest_file,
 				       u->pathname);
 			printf(" (%-*.*s %10s %*d) ",
 			       longest_author, longest_author, ci.author,
-			       format_time(ci.author_time, ci.author_tz),
+			       format_time(ci.author_time, ci.author_tz,
+					   show_raw_time),
 			       max_digits, i+1);
 		}
 
