From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 13 Feb 2011 03:42:12 -0600
Message-ID: <20110213094212.GA25435@elie>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 10:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYTR-0001ey-1s
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 10:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab1BMJmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 04:42:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46930 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1BMJmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 04:42:21 -0500
Received: by iyj8 with SMTP id 8so3846818iyj.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 01:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gBYqgj24im6z1OXirH9BJwh4I9pQpSrO7lb2+ikP7x0=;
        b=Ga69cPa5ANkIQeSRtbz6h5D31AJEAk+0pJy8nj0sKD9GPWWa1eHJ8FSsrOx8DZE65N
         LBipRDZKKVQnX08BMYDT4dUcvUF3PV3UOqRkaUPlLh4G7+NesRS7r1VaurVZp5puzMGv
         3oM3DAxclsbj2NsZUWn7dTM8BC/cYILt/ygcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nK36z2WozmhHCirpFvZqD0vneue89Of72jiR8P1zEdtsNx29GioTF9/nMpWNEM02tc
         ePuB4Ew6TjoYwKYY/R0vfrTHAw3uh0I+uRriHiFK31F3gCugXKWzI+rwMq40rLbiF0AB
         ky+eJ3AkoET8pQlEoVy1++Op5YgIM9oHI2cIw=
Received: by 10.231.11.2 with SMTP id r2mr1897269ibr.174.1297590140861;
        Sun, 13 Feb 2011 01:42:20 -0800 (PST)
Received: from elie (adsl-69-209-71-45.dsl.chcgil.ameritech.net [69.209.71.45])
        by mx.google.com with ESMTPS id 8sm1445187iba.16.2011.02.13.01.42.17
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 01:42:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166650>

Hi Sverre et al,

Sverre Rabbelier wrote:

> Currently the only way to end an import stream is to close it, which
> is not desirable when the stream that's being used is shared.

Here's a variation on the same theme, with notes indicating
what remains to be fixed.  Maybe it can save someone some time.

-- 8< --
From: Sverre Rabbelier <srabbelier@gmail.com>
Date: Sat, 28 Aug 2010 22:45:28 -0500
Subject: fast-import: introduce 'done' command

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
---
 Documentation/git-fast-import.txt |   25 ++++++++++++++++++++++
 fast-import.c                     |   14 ++++++++++++
 t/t9300-fast-import.sh            |   42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c3a2766..d0efdf8 100644
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
@@ -329,6 +335,11 @@ and control the current import process.  More detailed discussion
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
@@ -958,6 +969,11 @@ notes::
 	Versions of fast-import not supporting notes will exit
 	with a message indicating so.
 
+done::
+	Error out if the stream ends without a 'done' command.
+	Without this feature, errors causing the frontend to end
+	abruptly at a convenient point in the stream can go
+	undetected.
 
 `option`
 ~~~~~~~~
@@ -987,6 +1003,15 @@ not be passed as option:
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
index 3886a1b..cbcf61f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -365,6 +365,7 @@ static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
+static int require_explicit_termination;
 
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
@@ -2999,6 +3000,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
 		relative_marks_paths = 0;
+	} else if (!strcmp(feature, "done")) {
+		require_explicit_termination = 1;
 	} else if (!prefixcmp(feature, "force")) {
 		force_update = 1;
 	} else if (!strcmp(feature, "notes")) {
@@ -3150,6 +3153,8 @@ int main(int argc, const char **argv)
 			parse_reset_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
+		else if (!strcmp("done", command_buf.buf))
+			break;
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
 		else if (!prefixcmp(command_buf.buf, "feature "))
@@ -3169,6 +3174,15 @@ int main(int argc, const char **argv)
 	if (!seen_data_command)
 		parse_argv();
 
+	/*
+	 * NEEDSWORK: we should report input errors before
+	 * errno has a chance to be clobbered.
+	 */
+	if (ferror(stdin))
+		die("error reading input");
+	if (require_explicit_termination && feof(stdin))
+		die("stream ends early");
+
 	end_packfile();
 
 	dump_branches();
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 52ac0e5..a366ee2 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2121,6 +2121,48 @@ test_expect_success 'R: quiet option results in no stats being output' '
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
1.7.4.1
