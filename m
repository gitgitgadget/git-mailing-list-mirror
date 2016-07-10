Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DE11F744
	for <e@80x24.org>; Sun, 10 Jul 2016 11:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbcGJLfP (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 07:35:15 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38352 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcGJLfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 07:35:12 -0400
Received: by mail-wm0-f47.google.com with SMTP id o80so17730950wme.1
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 04:35:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=S5GzVgs5Vw9CBTpW8S8PcLlpP3C6ValyyFxmik2CiYU=;
        b=pauL46f4xK0en9h0y6F2h6GH2OK5qeM4W6GOZiNcJLgT1VX7u2uAkwr9o3hKDGcwX/
         hIVVoukUj0PyA/kG6VncfiFjhwSGZal5o7QFQ742hD1VKp0r77anLaMS6wOrI2UyjYYv
         k23rY5eyUADckpeKI+1hreMV4d7Rs98MHqmwpjyEmJOjD2KkUUDqGOMKc9EqW5McU2J0
         JaPnJFkDbJ5PePJHQ2vLmM8OK0rWSW9HgrrO0ialypzY1zPUcVOuGvBH8ioWN4qhNFcV
         vvg35/MJOcwA+B7X8KWWRv4Ma6JvFUtkgwFk31mCNVVetGuuENhNII79EIe8Hn1N9hVJ
         fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S5GzVgs5Vw9CBTpW8S8PcLlpP3C6ValyyFxmik2CiYU=;
        b=MQc9D0SLekoMnawvHorJvT5U3biU+I8RPF0eFDeHC2d8d+miku8/96mY93jftSNTKZ
         YokXmNUxF0Z4/KSb8vwE+xCad4tbmcahOjZ6lQ5KZ+KXhsQrMIqtzOLh+fFmoQG0DELO
         zTzlybSVLaDmVoUtWUvGIQKl0nQYAzH5s1ZLlsLJ1RzrFeHy/iJwinSF1yXc4d2eojP1
         nlcHEzfKRD63WuRjAu7oB11UHzzl1iA23D04ONJ02F3V3pJaka8tgH1KE6OrBrPHg0PO
         fSmPxgrjZQKoGSw7Enekf1vR8aPUEFUdPiOoSROdX0nCCxkQAvSbippwYTsCm+BF0E98
         YSzg==
X-Gm-Message-State: ALyK8tIHchIIMDgNWK5oL4yVgbzyc/rN+MKcwd7yh555RS4doGpFlDQFlfNALSypyfvrxA==
X-Received: by 10.28.127.138 with SMTP id a132mr6627602wmd.72.1468150509414;
        Sun, 10 Jul 2016 04:35:09 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAAEF.dip0.t-ipconnect.de. [80.139.170.239])
        by smtp.gmail.com with ESMTPSA id x83sm12945762wmx.9.2016.07.10.04.35.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 04:35:08 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	joeyh@joeyh.name, pclouds@gmail.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] Long running Git clean/smudge filter
Date:	Sun, 10 Jul 2016 13:35:07 +0200
Message-Id: <1468150507-40928-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git's clean/smudge mechanism invokes an external filter process for every
single file that is affected by the filter. If you have *a lot* of files to
filter then the startup time of the external filter process becomes a problem
as discussed here:
http://thread.gmane.org/gmane.comp.version-control.git/298293

This patch might be a solution to this problem and I am looking for feedback.
Please note that this is a RFC/proof-of-concept patch. If the list agrees with
this approach then I will post a proper patch series with more tests, error
handling, and documentation.


## How does it work?
Git's "convert.c" got a hashmap that maps a filter command to a process. If
we need to filter a file, then we look into the hashmap. If the filter command
is not there then we create and start a new filter process and setup in/out
pipes. If the filter command is there then we just take the existing and running
process.

In case of a clean filter we send the filename of the file to clean via pipe
to the filter process. The filter process reads the file, generates the cleaned
version and sends it back to Git via pipe.

In case of a smudge filter we send the destination filename of the file to
smudge via pipe as well as its content size and content. The filter process
reads all this info, generates the smudged version and stores the smudged
version at the location of the destination filename. Finally, the filter
process sends an "OK" to tell Git that everything worked as expected.

This patch is based on Joey Hess' great "clean-smudge-annex" topic, idea,
and implementation:
https://github.com/gitster/git/tree/jh/clean-smudge-annex

v1: http://thread.gmane.org/gmane.comp.version-control.git/297475
v4 (latest): http://thread.gmane.org/gmane.comp.version-control.git/297994

You can find a branch with with my patch on top of Joey's work here:
https://github.com/larsxschneider/git/commits/clean-smudge-file-long-running/v1


## Questions

(1) Do you see a general problem with this kind of "pipe" protocol and long
running Git filter processes? Other than the test cases I haven't implemented
a real world filter, yet (on my todo list for tomorrow).

(2) Joey's topic, which is the base for my patch, looks stalled for more than
2 weeks:
http://thread.gmane.org/gmane.comp.version-control.git/297994/focus=298006
I would be happy to address Junio's comments and post a reroll. However,
I don't want to interfere with Joey's plans. How does the list usually
address this kind of situation?

@Joey (in case you are reading this):
My patch changes your initial idea quite a bit. However, I believe it is an
improvement that could be beneficial for git-annex, too. Would you prefer to
work with me on the combination of our ideas (file clean/smudge + long running
clean/smudge processes) or would you prefer to keep your interface?

(3) Clean/smudge filter use Git's async command API to create a separate thread
and start the filter process. In my implementation I start the filter process
directly as this eases the pipe communication. I assume I am missing something
obvious here, but what is the advantage of the async command API? Git needs to
wait for the result of the filter anyways and therefore async is not really
necessary, or?

(4) I am not really experienced with process pipes. Is it OK to use the
"strbuf_read_once" function to read from a pipe? If I use "strbuf_read" then
the process waits indefinitely. Is there a way to tell Git to read X bytes from
a pipe (I just found the size "hint")?

(5) As mentioned above "convert.c" got a hashmap that maps a filter command to
a process. At the end of the Git process I would like to close the pipes and
stop the filter processes. What would be the best place in the code to do that?

Thanks,
Lars

---
 convert.c             | 143 +++++++++++++++++++++++++++++++++++++++++++-------
 t/t0021-conversion.sh |  80 +++++++++++++++++++++-------
 2 files changed, 185 insertions(+), 38 deletions(-)

diff --git a/convert.c b/convert.c
index e4db007..590b85a 100644
--- a/convert.c
+++ b/convert.c
@@ -373,9 +373,120 @@ struct filter_params {
 	int fd;
 	const char *cmd;
 	const char *path; /* Path within the git repository */
-	const char *fspath; /* Path to file on disk */
 };

+static int cmd_process_map_init = 0;
+static struct hashmap cmd_process_map;
+
+struct cmd2process {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *cmd;
+	struct child_process process;
+};
+
+static int cmd2process_cmp(const struct cmd2process *e1,
+							const struct cmd2process *e2,
+							const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+static struct cmd2process *find_entry(const char *cmd)
+{
+	struct cmd2process k;
+	hashmap_entry_init(&k, memhash(&cmd, sizeof(char *)));
+	k.cmd = cmd;
+	return hashmap_get(&cmd_process_map, &k, NULL);
+}
+
+static int apply_file_filter(const char *path, const char *src, size_t len,
+							struct strbuf *dst, const char *cmd)
+{
+	int ret = 1;
+	struct strbuf nbuf = STRBUF_INIT;
+	struct cmd2process *entry = NULL;
+	struct child_process *process = NULL;
+	const char *argv[] = { NULL, NULL };
+
+	if (!cmd || !*cmd)
+		return 0;
+
+	if (!dst)
+		return 1;
+
+	if (!cmd_process_map_init) {
+		cmd_process_map_init = 1;
+		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+	} else {
+		entry = find_entry(cmd);
+	}
+
+	if (entry) {
+		process = &entry->process;
+	} else {
+		entry = malloc(sizeof(struct cmd2process));
+		hashmap_entry_init(entry, memhash(&cmd, sizeof(char *)));
+		entry->cmd = cmd;
+		hashmap_add(&cmd_process_map, entry);
+		process = &entry->process;
+
+		child_process_init(process);
+		argv[0] = cmd;
+		process->argv = argv;
+		process->use_shell = 1;
+		process->in = -1;
+		process->out = -1;
+
+		if (start_command(process)) {
+			error("cannot fork to run external filter %s", cmd);
+			return 0;
+		}
+	}
+
+	fflush(NULL);
+
+	// TODO: Is the signchain_push OK here?
+	sigchain_push(SIGPIPE, SIG_IGN);
+	write_str_in_full(process->in, path);
+	write_str_in_full(process->in, "\n");
+	if (src && len > 0) {
+		// smudge filter processing
+		struct strbuf lenstr = STRBUF_INIT;
+		strbuf_reset(&lenstr);
+		strbuf_addf(&lenstr, "%zu", len);
+		write_str_in_full(process->in, lenstr.buf);
+		write_str_in_full(process->in, "\n");
+		write_in_full(process->in, src, len);
+		strbuf_reset(&nbuf);
+		if (strbuf_read_once(&nbuf, process->out, 2) < 0 ||
+			strcmp(nbuf.buf, "OK") != 0) {
+			error("read from external file filter %s failed", cmd);
+			ret = 0;
+		}
+	} else {
+		// clean filter processing
+		strbuf_reset(&nbuf);
+		// TODO: Should we read the expected size here first?
+		if (strbuf_read_once(&nbuf, process->out, 0) < 0) {
+			error("read from external file filter %s failed", cmd);
+			ret = 0;
+		} else {
+			strbuf_swap(dst, &nbuf);
+		}
+		// TODO: Should we ask for an OK from the filter here, too?
+	}
+	sigchain_pop(SIGPIPE);
+
+	// TODO: We probably should close the pipes and finish all processes
+	// in the hashmap. What would be a good place to do this?
+	// close(process->in)
+	// close(process->out)
+	// finish_command(process);
+
+	strbuf_release(&nbuf);
+	return ret;
+}
+
 static int filter_buffer_or_fd(int in, int out, void *data)
 {
 	/*
@@ -402,15 +513,6 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
 	strbuf_release(&path);

-	/* append fspath to the command if it's set, separated with a space */
-	if (params->fspath) {
-		struct strbuf fspath = STRBUF_INIT;
-		sq_quote_buf(&fspath, params->fspath);
-		strbuf_addstr(&cmd, " ");
-		strbuf_addbuf(&cmd, &fspath);
-		strbuf_release(&fspath);
-	}
-
 	argv[0] = cmd.buf;

 	child_process.argv = argv;
@@ -449,9 +551,8 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }

-static int apply_filter(const char *path, const char *fspath,
-			const char *src, size_t len, int fd,
-                        struct strbuf *dst, const char *cmd)
+static int apply_filter(const char *path, const char *src, size_t len,
+						int fd, struct strbuf *dst, const char *cmd)
 {
 	/*
 	 * Create a pipeline to have the command filter the buffer's
@@ -479,7 +580,6 @@ static int apply_filter(const char *path, const char *fspath,
 	params.fd = fd;
 	params.cmd = cmd;
 	params.path = path;
-	params.fspath = fspath;

 	fflush(NULL);
 	if (start_async(&async))
@@ -610,7 +710,7 @@ static int count_ident(const char *cp, unsigned long size)
 }

 static int ident_to_git(const char *path, const char *src, size_t len,
-                        struct strbuf *buf, int ident)
+						struct strbuf *buf, int ident)
 {
 	char *dst, *dollar;

@@ -860,7 +960,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;

-	return apply_filter(path, NULL, NULL, 0, -1, NULL, ca.drv->clean);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
 }

 static int can_filter_file(const char *filefilter, const char *filefiltername,
@@ -950,7 +1050,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		required = ca.drv->required;
 	}

-	ret |= apply_filter(path, NULL, src, len, -1, dst, filter);
+	ret |= apply_filter(path, src, len, -1, dst, filter);
 	if (!ret && required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

@@ -976,7 +1076,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean);

-	if (!apply_filter(path, NULL, NULL, 0, fd, dst, ca.drv->clean))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action,
@@ -995,7 +1095,7 @@ void convert_to_git_filter_from_file(const char *path, struct strbuf *dst,
 	assert(ca.drv->clean);
 	assert(ca.drv->clean_from_file);

-	if (!apply_filter(path, path, "", 0, -1, dst, ca.drv->clean_from_file))
+	if (!apply_file_filter(path, "", 0, dst, ca.drv->clean_from_file))
 		die("%s: cleanFromFile filter '%s' failed", path, ca.drv->name);

 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action,
@@ -1040,7 +1140,10 @@ static int convert_to_working_tree_internal(const char *path,
 		}
 	}

-	ret_filter = apply_filter(path, destpath, src, len, -1, dst, filter);
+	if (destpath)
+		ret_filter = apply_file_filter(destpath, src, len, dst, filter);
+	else
+		ret_filter = apply_filter(path, src, len, -1, dst, filter);
 	if (!ret_filter && required)
 		die("%s: %s filter %s failed", path, destpath ? "smudgeToFile" : "smudge", ca.drv->name);

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 2722013..1eafe67 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -14,19 +14,39 @@ chmod +x rot13.sh

 cat <<EOF >rot13-from-file.sh
 #!$SHELL_PATH
-srcfile="\$1"
-touch rot13-from-file.ran
-cat "\$srcfile" | ./rot13.sh
+while read LINE; do
+   srcfile="\$LINE"
+   echo "CLEAN \$srcfile" >> rot13-from-file.ran
+   cat "\$srcfile" | ./rot13.sh
+done
+
 EOF
 chmod +x rot13-from-file.sh

-cat <<EOF >rot13-to-file.sh
-#!$SHELL_PATH
-destfile="\$1"
-touch rot13-to-file.ran
-./rot13.sh > "\$destfile"
+# TODO: Is there a way to read X bytes from a pipe via shell?
+# I implemented the filter in Python as workaround. If Python
+# is an undesired dependency then I could reimplement it in Perl, too.
+cat <<EOF >rot13-to-file.py
+#!/usr/bin/env python
+import sys
+from subprocess import Popen, PIPE, STDOUT
+
+for data in iter(sys.stdin.readline, ''):
+	filename = data[:-1]
+	content_size = sys.stdin.readline()[:-1]
+	content = sys.stdin.read(int(content_size))
+
+	p = Popen(['./rot13.sh'], stdout=PIPE, stdin=PIPE, stderr=PIPE)
+	with open(filename, 'w') as f:
+		f.write(p.communicate(input=content)[0])
+
+	with open('rot13-to-file.ran', 'a') as f:
+		f.write('SMUDGE {} {}\n'.format(filename, content_size))
+
+	sys.stdout.write('OK')
+	sys.stdout.flush()
 EOF
-chmod +x rot13-to-file.sh
+chmod +x rot13-to-file.py

 cat <<EOF >delete-file-and-fail.sh
 #!$SHELL_PATH
@@ -293,28 +313,52 @@ test_expect_success 'disable filter with empty override' '
 '

 test_expect_success 'cleanFromFile filter is used when adding a file' '
+	{
+	    echo a
+	    echo bb
+	    echo ccc
+	} >test2 &&
+
+
 	test_config filter.rot13.cleanFromFile ./rot13-from-file.sh &&
+	test_config filter.rot13.required true &&

 	echo "*.t filter=rot13" >.gitattributes &&

 	cat test >fstest.t &&
-	git add fstest.t &&
-	test -e rot13-from-file.ran &&
+	cat test2 >fstest2.t &&
+	git add fstest.t fstest2.t &&
+
+	test_line_count = 2 rot13-from-file.ran &&
+	grep "CLEAN fstest.t" rot13-from-file.ran &&
+	grep "CLEAN fstest2.t" rot13-from-file.ran &&
 	rm -f rot13-from-file.ran &&

 	rm -f fstest.t &&
-	git checkout -- fstest.t &&
-	cmp test fstest.t
+	rm -f fstest2.t &&
+
+	git checkout . &&
+	cmp test fstest.t &&
+	cmp test2 fstest2.t
 '

 test_expect_success 'smudgeToFile filter is used when checking out a file' '
-	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.py &&
+	test_config filter.rot13.required true &&

 	rm -f fstest.t &&
-	git checkout -- fstest.t &&
+	rm -f fstest2.t &&
+	git checkout . &&
+
+	# TODO: Why is this necessary?
+	sleep 0.1 &&
+
 	cmp test fstest.t &&
+	cmp test2 fstest2.t &&

-	test -e rot13-to-file.ran &&
+	test_line_count = 2 rot13-to-file.ran &&
+	grep "SMUDGE fstest.t 57" rot13-to-file.ran &&
+	grep "SMUDGE fstest2.t 9" rot13-to-file.ran &&
 	rm -f rot13-to-file.ran
 '

@@ -335,7 +379,7 @@ test_expect_success 'recovery from failure of smudgeToFile filter that deletes t
 '

 test_expect_success 'smudgeToFile filter is used in merge' '
-	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.py &&

 	git commit -m "added fstest.t" fstest.t &&
 	git checkout -b old &&
@@ -350,7 +394,7 @@ test_expect_success 'smudgeToFile filter is used in merge' '
 '

 test_expect_success 'smudgeToFile filter is used by git am' '
-	test_config filter.rot13.smudgeToFile ./rot13-to-file.sh &&
+	test_config filter.rot13.smudgeToFile ./rot13-to-file.py &&

 	git format-patch HEAD^ --stdout > fstest.patch &&
 	git reset --hard HEAD^ &&
--
2.5.1

