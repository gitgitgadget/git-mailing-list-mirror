From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] Teach fast-import to print the id of each imported
 commit
Date: Sat, 4 Sep 2010 22:29:58 -0500
Message-ID: <20100905032957.GC2344@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:32:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5xi-0004Cr-RE
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0IEDbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 23:31:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48053 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab0IEDbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 23:31:51 -0400
Received: by iwn5 with SMTP id 5so2962372iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Aq/HSe7uNYkhhPdJKtgdww9EQhe+q1UsQcctvp7XpZ4=;
        b=jrxqMs+gCgWwyajYiDgUz4Yh276gTxYha2qDmxxrl8XphfCBYArwza68GwZs3y7rbn
         77BHF6x5Mz2WwProWJSMbs/iqJ3o56zkYMufe1wnGrQI4tE/KDsFm24iOQukqGn2gKUP
         haRQTubf6h4KYKvDCIcfyzjQ7pyt+1jRTXtRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hPTHdJJZA6MwIo3k4RskJTTX64HyLWBVUQx7PPTdMUCdGoXhp5soNqdUyJuhuaYVw1
         xhiKP2EfW1AfWuDsV+56zR4hRCwboQZ44fO7hIjoPN6pAp2qSgWAj+gtpRIVIboOBXnx
         vrhLmikzbAQqd8uN2H7pgWp1wo/ig5RbasVDY=
Received: by 10.231.149.207 with SMTP id u15mr3870007ibv.13.1283657510272;
        Sat, 04 Sep 2010 20:31:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id z6sm4047748ibc.12.2010.09.04.20.31.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 20:31:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905031528.GA2344@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155419>

For the svn importer, it would be useful to build a map from
subversion revision numbers to git commits as the import takes place.
This is particularly relevant because the subversion api sometimes
represents as "copy this directory from this revision", and the
importer needs to be able to access the corresponding trees.  So
(optionally) print each commit id when the corresponding object is
written.

Unfortunately when each commit object is written, it is not yet
accessible to the caller until a checkpoint has finished.  A later
patch will teach fast-import to directly pass on the relevant data on
request, using the same channel.

Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I am not happy with the interface:

. the name --report-fd is a bit silly.  Maybe next round will
  have a better one.
. some frontends may want to use "cat" without the commit id noise
. it is easy to trigger SIGPIPE by ignoring the last couple of
  commit ids
. communication needs to be serialized.  What will happen if a commit
  gets finished while a "cat" command is being fulfilled?

 Documentation/git-fast-import.txt |   13 +++++++++++
 fast-import.c                     |   18 +++++++++++++++
 t/t9300-fast-import.sh            |   42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 966ba4f..e217635 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -92,6 +92,18 @@ OPTIONS
 	--(no-)-relative-marks= with the --(import|export)-marks=
 	options.
 
+--report-fd=<fd>::
+	Print the 40-character object name for each commit to
+	the specified file descriptor before writing it to the
+	pack.  This information may be useful if the importer
+	needs to maintain a map from revisions in the source
+	repository to commit ids in the target repository
+	during the import.
++
+The described objects are not necessarily accessible
+using standard git plumbing tools until a little while
+after the next checkpoint.
+
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -896,6 +908,7 @@ The following features are currently supported:
 * date-format
 * import-marks
 * export-marks
+* report-fd
 * relative-marks
 * no-relative-marks
 * force
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..ef0cee7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -361,6 +361,9 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+/* Where to report commits */
+static int report_fd = -1;
+
 static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
@@ -2571,6 +2574,11 @@ static void parse_new_commit(void)
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
 		b->pack_id = pack_id;
+	if (report_fd != -1) {
+		char *buf = sha1_to_hex(b->sha1);
+		buf[40] = '\n';
+		write_or_die(report_fd, buf, 41);
+	}
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
@@ -2755,6 +2763,14 @@ static void option_export_marks(const char *marks)
 	safe_create_leading_directories_const(export_marks_file);
 }
 
+static void option_report_fd(const char *fd)
+{
+	unsigned long n = strtoul(fd, NULL, 0);
+	if (n > (unsigned long) INT_MAX)
+		die("--report-fd cannot exceed %d", INT_MAX);
+	report_fd = (int) n;
+}
+
 static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
@@ -2808,6 +2824,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
+	} else if (!prefixcmp(feature, "report-fd=")) {
+		option_report_fd(feature + strlen("report-fd="));
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c274e7..610e7a5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1663,6 +1663,48 @@ test_expect_success 'R: feature no-relative-marks is honoured' '
 	test_cmp marks.out non-relative.out
 '
 
+test_expect_success 'have pipes?' '
+	test_when_finished "rm -f frob" &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
+test_expect_success PIPE 'R: feature report-fd is honoured' '
+	mkfifo commits &&
+	test_when_finished "rm -f commits" &&
+	cat >frontend <<-\FRONTEND_END &&
+		#!/bin/sh
+		cat <<EOF &&
+		feature report-fd=3
+		commit refs/heads/printed
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		to be printed
+		COMMIT
+
+		from refs/heads/master
+		D file3
+
+		EOF
+
+		read cid <&3 &&
+		echo "$cid" >received
+		EOF
+	FRONTEND_END
+	chmod +x frontend &&
+	(
+		{
+			sh frontend 3<commits ||
+			exit
+		} |
+		git fast-import 3>commits
+	) &&
+	git rev-parse --verify printed >real &&
+	test_cmp real received
+'
+
 test_expect_success 'R: quiet option results in no stats being output' '
 	>empty &&
 	cat >input <<-\EOF &&
-- 
1.7.2.3
