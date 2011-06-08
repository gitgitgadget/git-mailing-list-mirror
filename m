From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 10/19] fast-import: introduce 'done' command
Date: Wed,  8 Jun 2011 20:48:41 +0200
Message-ID: <1307558930-16074-11-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpK-00087c-Tu
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab1FHStp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57880 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1FHStm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:42 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279692eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QPmPrbekFUKrYBiAN3v/6yQMv3AZ4rLwZknX4Gna5to=;
        b=F1vwCshSiUyYWxNmpoMoToY0IofIFDOKQxS04+mRLRGvbMA4PJUVq5SrGwWE6j6FVT
         mPd82+pN6aIh7y7JONBZv9o/x/URrByK0dR0tomSjIBK/JQgg826tDTrn5Mf+dpAigyc
         Tm3q0J059JmTSkiByTRPAZlTj/1cFuC8Lq1Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tTy09yFuzeJO2nWKM5h4u2hL+2C7c7WIw2wpSQaafa3uGaUA7uYLEBhDBKfvCb3YD+
         HK4LPSrihNNqJSRfcruU0PMc7eayj4O2Ze5d2VHWSheAjQaC8d7xQjKJjEoFw9YHCY3f
         KCfDcY96bJsEkj5wU+ydoYBQ554C/yY6YTl2Q=
Received: by 10.14.95.8 with SMTP id o8mr2913298eef.76.1307558981928;
        Wed, 08 Jun 2011 11:49:41 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175431>

Add a 'done' command that causes fast-import to stop reading from the
stream and exit.

If the new --done command line flag was passed on the command line
(or a "feature done" declaration included at the start of the stream),
make the 'done' command mandatory.  So "git fast-import --done"'s
input format will be prefix-free, making errors easier to detect when
they show up as early termination at some convenient time of the
upstream of a pipe writing to fast-import.

Another possible application of the 'done' command would to be allow a
fast-import stream that is only a small part of a larger encapsulating
stream to be easily parsed, leaving the file offset after the "done\n"
so the other application can pick up from there.  This patch does not
teach fast-import to do that --- fast-import still uses buffered input
(stdio).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This is actually Jonathan's version that makes done required if
  feature done was specified. See also:

	http://mid.gmane.org/20110213094212.GA25435@elie

 Documentation/git-fast-import.txt |   25 ++++++++++++++++++++++
 fast-import.c                     |    8 +++++++
 t/t9300-fast-import.sh            |   42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 249249a..0fc68a9 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -101,6 +101,12 @@ OPTIONS
 	when the `cat-blob` command is encountered in the stream.
 	The default behaviour is to write to `stdout`.
 
+--done::
+	Require a `done` command at the end of the stream.
+	This option might be useful for detecting errors that
+	cause the frontend to terminate before it has started to
+	write a stream.
+
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -330,6 +336,11 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`done`::
+	Marks the end of the stream. This command is optional
+	unless the `done` feature was requested using the
+	`--done` command line option or `feature done` command.
+
 `cat-blob`::
 	Causes fast-import to print a blob in 'cat-file --batch'
 	format to the file descriptor set with `--cat-blob-fd` or
@@ -1015,6 +1026,11 @@ notes::
 	Versions of fast-import not supporting notes will exit
 	with a message indicating so.
 
+done::
+	Error out if the stream ends without a 'done' command.
+	Without this feature, errors causing the frontend to end
+	abruptly at a convenient point in the stream can go
+	undetected.
 
 `option`
 ~~~~~~~~
@@ -1044,6 +1060,15 @@ not be passed as option:
 * cat-blob-fd
 * force
 
+`done`
+~~~~~~
+If the `done` feature is not in use, treated as if EOF was read.
+This can be used to tell fast-import to finish early.
+
+If the `--done` command line option or `feature done` command is
+in use, the `done` command is mandatory and marks the end of the
+stream.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index 78d9786..8a8a915 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -354,6 +354,7 @@ static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
+static int require_explicit_termination;
 
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
@@ -3139,6 +3140,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		relative_marks_paths = 1;
 	} else if (!strcmp(feature, "no-relative-marks")) {
 		relative_marks_paths = 0;
+	} else if (!strcmp(feature, "done")) {
+		require_explicit_termination = 1;
 	} else if (!strcmp(feature, "force")) {
 		force_update = 1;
 	} else if (!strcmp(feature, "notes") || !strcmp(feature, "ls")) {
@@ -3288,6 +3291,8 @@ int main(int argc, const char **argv)
 			parse_reset_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
+		else if (!strcmp("done", command_buf.buf))
+			break;
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
 		else if (!prefixcmp(command_buf.buf, "feature "))
@@ -3307,6 +3312,9 @@ int main(int argc, const char **argv)
 	if (!seen_data_command)
 		parse_argv();
 
+	if (require_explicit_termination && feof(stdin))
+		die("stream ends early");
+
 	end_packfile();
 
 	dump_branches();
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6b1ba6c..526231b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2197,6 +2197,48 @@ test_expect_success 'R: quiet option results in no stats being output' '
     test_cmp empty output
 '
 
+test_expect_success 'R: feature done means terminating "done" is mandatory' '
+	echo feature done | test_must_fail git fast-import &&
+	test_must_fail git fast-import --done </dev/null
+'
+
+test_expect_success 'R: terminating "done" with trailing gibberish is ok' '
+	git fast-import <<-\EOF &&
+	feature done
+	done
+	trailing gibberish
+	EOF
+	git fast-import <<-\EOF
+	done
+	more trailing gibberish
+	EOF
+'
+
+test_expect_success 'R: terminating "done" within commit' '
+	cat >expect <<-\EOF &&
+	OBJID
+	:000000 100644 OBJID OBJID A	hello.c
+	:000000 100644 OBJID OBJID A	hello2.c
+	EOF
+	git fast-import <<-EOF &&
+	commit refs/heads/done-ends
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<EOT
+	Commit terminated by "done" command
+	EOT
+	M 100644 inline hello.c
+	data <<EOT
+	Hello, world.
+	EOT
+	C hello.c hello2.c
+	done
+	EOF
+	git rev-list done-ends |
+	git diff-tree -r --stdin --root --always |
+	sed -e "s/$_x40/OBJID/g" >actual &&
+	test_cmp expect actual
+'
+
 cat >input <<EOF
 option git non-existing-option
 EOF
-- 
1.7.5.1.292.g728120
