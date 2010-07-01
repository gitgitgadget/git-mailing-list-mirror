From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Thu, 1 Jul 2010 00:48:49 -0500
Message-ID: <20100701054849.GA14972@burratino>
References: <20100701031819.GA12524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 07:49:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUCeJ-0006vf-Ig
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 07:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0GAFtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 01:49:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56339 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0GAFtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 01:49:16 -0400
Received: by iwn7 with SMTP id 7so1677814iwn.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LmlTQx6+4QqT99YuGQU/NvjH1Mvq9btlSraAlElekgc=;
        b=F2EWoSKUpO/oigJBm35HjEAnakG2H1II+7VlrLLYoZMspX5zwJ44KpX2QKMdme3oaC
         52z+SDs4OGgn/+0JyZjSN/wqdeoIn+Two7KD7g9V/URL3rbqrMofH7+UVP2ZR6yRhlCi
         6gfkbUCRBAGmYARZBlq0UJNHapg/FOedeZ9W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TAHwbVwh9jyA4mi0IafgVh+l0HPzL7n6DF3XdouSzWpUFdAtVj8rOLrjKBeJ8JUs1U
         4+D5MkhIpl/17dcIrvq+Citbyq7L0k7r9ocYUEn6l5Yv2hnyPYUBvLn6DboUTUKP1atD
         xYn69J2+GGDKeMNhctRJudW0TH5uoCrlL11dg=
Received: by 10.231.37.7 with SMTP id v7mr4475929ibd.147.1277963355997;
        Wed, 30 Jun 2010 22:49:15 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm24823631ibk.13.2010.06.30.22.49.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 22:49:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100701031819.GA12524@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150009>

For the svn importer, it would be useful to have a map from
subversion revision numbers to git commits.  This is particularly
relevant because the subversion api sometimes represents as "copy
this directory from this revision", and the importer needs to be
able to access the corresponding trees.  So (optionally) print
each commit id when the corresponding object is written.

Unfortunately when each commit object is written, it is not yet
accessible to the caller.  The corresponding pack index
and header are not written until the next checkpoint finishes.

Should fast-import accept lines of the form

 M 100644 <commit id>:<path> <path>

and

 M 040000 <commit id>:<path> <path>

to allow the caller to use commits before they are accessible
through the git object database?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
but definitely not ready for inclusion
---
 fast-import.c          |   18 ++++++++++++++++++
 t/t9300-fast-import.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ad6843a..869da7f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -361,6 +361,9 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+/* Where to report commits */
+static int commits_fd = -1;
+
 static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
@@ -2563,6 +2566,11 @@ static void parse_new_commit(void)
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, b->sha1, next_mark))
 		b->pack_id = pack_id;
+	if (commits_fd != -1) {
+		char *buf = sha1_to_hex(b->sha1);
+		buf[40] = '\n';
+		write_or_die(commits_fd, buf, 41);
+	}
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
@@ -2747,6 +2755,14 @@ static void option_export_marks(const char *marks)
 	safe_create_leading_directories_const(export_marks_file);
 }
 
+static void option_print_commits(const char *fd)
+{
+	unsigned long n = strtoul(fd, NULL, 0);
+	if (n > (unsigned long) INT_MAX)
+		die("--print-commits cannot exceed %d", INT_MAX);
+	commits_fd = (int) n;
+}
+
 static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
@@ -2800,6 +2816,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
+	} else if (!prefixcmp(feature, "print-commits=")) {
+		option_print_commits(feature + strlen("print-commits="));
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 50d5913..5cb949f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1555,6 +1555,51 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
     test_cmp marks.new non-relative.out
 '
 
+test_expect_success 'R: print-commits magic' '
+	mkfifo commits &&
+	cat >caller <<-\CALLER_END
+		#!/bin/sh
+		cat <<EOF &&
+		feature print-commits=3
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
+		! git rev-parse $cid: >/dev/null &&
+		echo checkpoint &&
+		sleep 1 &&
+		tree=$(git rev-parse $cid:) &&
+		cat <<EOF
+		commit refs/heads/printed
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		to be printed
+		COMMIT
+
+		from refs/heads/printed^0
+		M 040000 $tree old
+
+		EOF
+		sleep 1
+	CALLER_END
+	chmod +x caller &&
+	{
+		sh caller 3<commits ||
+		echo fail
+	} |
+	git fast-import 3>commits &&
+	git rev-parse printed^ printed &&
+	git show printed:
+'
+
 cat >input << EOF
 option git quiet
 blob
-- 
1.7.1.1
