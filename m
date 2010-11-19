From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] fast-import: Allow cat-blob requests at arbitrary points
 in stream
Date: Fri, 19 Nov 2010 03:51:13 -0600
Message-ID: <20101119095112.GE19061@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101119093530.GA19061@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	vcs-fast-import-devs@lists.launchpad.net
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 10:52:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJNdY-0006ae-Cr
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 10:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab0KSJwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 04:52:03 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53419 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0KSJwB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 04:52:01 -0500
Received: by yxf34 with SMTP id 34so2534694yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7wsYAxF5mf6QzpWHuG/bJwPAuCleyYEOEoA8s95pJhs=;
        b=Ubaqq52a7EkPb9AoFYKuZ37EYHq7xCvLooRpeYSy4HJDsUbMYbxxzWWc3r7Gvxnwa0
         5fzej8iFFQUynhYiTqDjE382u3ON73dMjVC56LLjb/7a5P7Djw0GEv1EYgXW+/bFZgKd
         6W4FRjn2ylfWLLSmlcLZAYz319UoRTvW5xhus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h6zuzXYE2m6BZrmUL/lCHd9C4RRf759JI6PsD6BMeaNm7KPnZROtLnKbWvdzZGDnR0
         79pCnrKBCPRBkb1NjhYVmLC0+qNvTqOD7GR4/FVmZoRmcPFSIcxcte2mhNY4rT/ei4bV
         cgGCxqdtn2RvUjyAOESZ8v8rrIAYUD6lOdKWI=
Received: by 10.150.196.10 with SMTP id t10mr3294120ybf.99.1290160318867;
        Fri, 19 Nov 2010 01:51:58 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id v8sm971323yba.14.2010.11.19.01.51.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 01:51:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101119093530.GA19061@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161731>

The new rule: a "cat-blob" can be inserted wherever a comment is
allowed, which means at the start of any line except in the middle of
a "data" command.

This saves frontends from having to loop over everything they want to
commit in the next commit and cat-ing the necessary objects in
advance.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

The early history is at [1] if that's your kind of thing.

[1] http://thread.gmane.org/gmane.comp.version-control.git/150005/focus=155417

 Documentation/git-fast-import.txt |    4 ++
 fast-import.c                     |   28 +++++++++-------
 t/t9300-fast-import.sh            |   66 +++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index be444da..d569564 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -905,6 +905,10 @@ output uses the same format as `git cat-file --batch`:
 	<contents> LF
 ====
 
+This command can be used anywhere in the stream that comments are
+accepted.  In particular, the `cat-blob` command can be used in the
+middle of a commit but not in the middle of a `data` command.
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
diff --git a/fast-import.c b/fast-import.c
index 88547c6..33c6981 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -55,8 +55,6 @@ Format of STDIN stream:
     ('from' sp committish lf)?
     lf?;
 
-  cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
-
   checkpoint ::= 'checkpoint' lf
     lf?;
 
@@ -134,14 +132,17 @@ Format of STDIN stream:
   ts    ::= # time since the epoch in seconds, ascii base10 notation;
   tz    ::= # GIT style timezone;
 
-     # note: comments may appear anywhere in the input, except
-     # within a data command.  Any form of the data command
-     # always escapes the related input from comment processing.
+     # note: comments and cat requests may appear anywhere
+     # in the input, except within a data command.  Any form
+     # of the data command always escapes the related input
+     # from comment processing.
      #
      # In case it is not clear, the '#' that starts the comment
      # must be the first character on that line (an lf
      # preceded it).
      #
+  cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
+
   comment ::= '#' not_lf* lf;
   not_lf  ::= # Any byte that is not ASCII newline (LF);
 */
@@ -367,6 +368,7 @@ static int seen_data_command;
 static int cat_blob_fd = STDOUT_FILENO;
 
 static void parse_argv(void);
+static void parse_cat_blob(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1791,7 +1793,6 @@ static void read_marks(void)
 	fclose(f);
 }
 
-
 static int read_next_command(void)
 {
 	static int stdin_eof = 0;
@@ -1801,7 +1802,7 @@ static int read_next_command(void)
 		return EOF;
 	}
 
-	do {
+	for (;;) {
 		if (unread_command_buf) {
 			unread_command_buf = 0;
 		} else {
@@ -1834,9 +1835,14 @@ static int read_next_command(void)
 			rc->prev->next = rc;
 			cmd_tail = rc;
 		}
-	} while (command_buf.buf[0] == '#');
-
-	return 0;
+		if (!prefixcmp(command_buf.buf, "cat-blob ")) {
+			parse_cat_blob();
+			continue;
+		}
+		if (command_buf.buf[0] == '#')
+			continue;
+		return 0;
+	}
 }
 
 static void skip_optional_lf(void)
@@ -3062,8 +3068,6 @@ int main(int argc, const char **argv)
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
 			parse_reset_branch();
-		else if (!prefixcmp(command_buf.buf, "cat-blob "))
-			parse_cat_blob();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3e2741b..2a050c7 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1692,6 +1692,72 @@ test_expect_success PIPE 'R: copy using cat-file' '
 	test_cmp big actual
 '
 
+test_expect_success PIPE 'R: print blob mid-commit' '
+	rm -f blobs &&
+	echo "A blob from _before_ the commit." >expect &&
+	mkfifo blobs &&
+	(
+		exec 3<blobs &&
+		cat <<-EOF &&
+		feature cat-blob
+		blob
+		mark :1
+		data <<BLOB
+		A blob from _before_ the commit.
+		BLOB
+		commit refs/heads/temporary
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Empty commit
+		COMMIT
+		cat-blob :1
+		EOF
+
+		read blob_id type size <&3 &&
+		dd if=/dev/stdin of=actual bs=$size count=1 <&3 &&
+		read newline <&3 &&
+
+		echo
+	) |
+	git fast-import --cat-blob-fd=3 3>blobs &&
+	test_cmp expect actual
+'
+
+test_expect_success PIPE 'R: print staged blob within commit' '
+	rm -f blobs &&
+	echo "A blob from _within_ the commit." >expect &&
+	mkfifo blobs &&
+	(
+		exec 3<blobs &&
+		cat <<-EOF &&
+		feature cat-blob
+		commit refs/heads/within
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Empty commit
+		COMMIT
+		M 644 inline within
+		data <<BLOB
+		A blob from _within_ the commit.
+		BLOB
+		EOF
+
+		to_get=$(
+			echo "A blob from _within_ the commit." |
+			git hash-object --stdin
+		) &&
+		echo "cat-blob $to_get" &&
+
+		read blob_id type size <&3 &&
+		dd if=/dev/stdin of=actual bs=$size count=1 <&3 &&
+		read newline <&3 &&
+
+		echo deleteall
+	) |
+	git fast-import --cat-blob-fd=3 3>blobs &&
+	test_cmp expect actual
+'
+
 cat >input << EOF
 option git quiet
 blob
-- 
1.7.2.3
