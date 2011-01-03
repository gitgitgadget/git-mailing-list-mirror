From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] t0081 (line-buffer): add buffering tests
Date: Sun, 2 Jan 2011 19:07:16 -0600
Message-ID: <20110103010716.GE30506@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 02:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYtW-0003Jc-La
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 02:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab1ACBH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 20:07:26 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54313 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1ACBHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 20:07:25 -0500
Received: by yib18 with SMTP id 18so2933011yib.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o9ooCUpk7fZdc2yfiNdg2Rs3IK413saj3cRQZUc4O9Q=;
        b=xUDZFNZM8KIXNnOzIEebsuGu32sqScz/I5PhlIt+/muOlqvFqXCo+t0RNxBccSacz9
         XEsZQnXb60tKPFAdXdGIViR0Ofd0w8wVn1mthDJTfm/7SWGCM4l7AnGYa7172NuMhEoi
         Q0qaqNFcXZTX6f/r8lpoBLi2udfjdClZAV3KI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u54brJBQigt7A1HojDN1JwLTnjE0mOVinMTj2xAuqr9jI0QDujjIHSyK2ba8pyRn0C
         57Z36xq8377KcAbQYPuvc/soJZMTZsjqJRR2RnG8VYh87OiZTMkRskLDzaZmSMANwnFO
         OjjxVYbJ4j2Bp6vWbGaIwcQB5cOa44PnubTGM=
Received: by 10.236.102.179 with SMTP id d39mr10140906yhg.72.1294016844505;
        Sun, 02 Jan 2011 17:07:24 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id x29sm11892235yhc.46.2011.01.02.17.07.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 17:07:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103004900.GA30506@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164434>

POSIX makes the behavior of read(2) from a pipe fairly clear: a read
from an empty pipe will block until there is data available and any
other read will not block, prefering to return a partial result.
Likewise, fread(3) and fgets(3) are clearly specified to act as
though implemented by calling fgetc(3) in a simple loop.  But the
buffering behavior of fgetc is less clear.

Luckily, no sane platform is going to implement fgetc by calling the
equivalent of read(2) more than once.  fgetc has to be able to
return without filling its buffer to preserve errno when errors are
encountered anyway.  So let's assume the simpler behavior (trust) but
add some tests to catch insane platforms that violate that when they
come (verify).

First check that fread can handle a 0-length read from an empty fifo.
The writing end of the fifo is opened in advance in a subshell since
even 0-length reads are allowed to block when the writing end of a
pipe is not open.

Next try short inputs from a pipe that is not filled all the way.

Lastly (two tests) try very large inputs from a pipe that will not fit
in the relevant buffers.  The first of these tests reads a little
more than 8192 bytes, which is BUFSIZ (the size of stdio's buffers)
on this Linux machine.  The second reads a little over 64 KiB (the
pipe capacity on Linux) and is not run unless requested by setting
the GIT_REMOTE_SVN_TEST_BIG_FILES environment variable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0081-line-buffer.sh |  110 +++++++++++++++++++++++++++++++++++++++++++++++-
 test-line-buffer.c     |   22 ++++++++-
 2 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 68d6163..33a728e 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -1,10 +1,76 @@
 #!/bin/sh
 
 test_description="Test the svn importer's input handling routines.
+
+These tests exercise the line_buffer library, but their real purpose
+is to check the assumptions that library makes of the platform's input
+routines.  Processes engaged in bi-directional communication would
+hang if fread or fgets is too greedy.
+
+While at it, check that input of newlines and null bytes are handled
+correctly.
 "
 . ./test-lib.sh
 
-test_expect_success 'read greeting' '
+test -n "$GIT_REMOTE_SVN_TEST_BIG_FILES" && test_set_prereq EXPENSIVE
+
+generate_tens_of_lines () {
+	tens=$1 &&
+	line=$2 &&
+
+	i=0 &&
+	while test $i -lt "$tens"
+	do
+		for j in a b c d e f g h i j
+		do
+			echo "$line"
+		done &&
+		: $((i = $i + 1)) ||
+		return
+	done
+}
+
+long_read_test () {
+	: each line is 10 bytes, including newline &&
+	line=abcdefghi &&
+	echo "$line" >expect &&
+
+	if ! test_declared_prereq PIPE
+	then
+		echo >&4 "long_read_test: need to declare PIPE prerequisite"
+		return 127
+	fi &&
+	tens_of_lines=$(($1 / 100 + 1)) &&
+	lines=$(($tens_of_lines * 10)) &&
+	readsize=$((($lines - 1) * 10 + 3)) &&
+	copysize=7 &&
+	rm -f input &&
+	mkfifo input &&
+	{
+		{
+			generate_tens_of_lines $tens_of_lines "$line" &&
+			sleep 100
+		} >input &
+	} &&
+	test-line-buffer input <<-EOF >output &&
+	read $readsize
+	copy $copysize
+	EOF
+	kill $! &&
+	test_line_count = $lines output &&
+	tail -n 1 <output >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup: have pipes?' '
+      rm -f frob &&
+      if mkfifo frob
+      then
+		test_set_prereq PIPE
+      fi
+'
+
+test_expect_success 'hello world' '
 	echo HELLO >expect &&
 	test-line-buffer <<-\EOF >actual &&
 	read 6
@@ -13,6 +79,21 @@ test_expect_success 'read greeting' '
 	test_cmp expect actual
 '
 
+test_expect_success PIPE '0-length read, no input available' '
+	>expect &&
+	rm -f input &&
+	mkfifo input &&
+	{
+		sleep 100 >input &
+	} &&
+	test-line-buffer input <<-\EOF >actual &&
+	read 0
+	copy 0
+	EOF
+	kill $! &&
+	test_cmp expect actual
+'
+
 test_expect_success '0-length read, send along greeting' '
 	echo HELLO >expect &&
 	test-line-buffer <<-\EOF >actual &&
@@ -23,6 +104,33 @@ test_expect_success '0-length read, send along greeting' '
 	test_cmp expect actual
 '
 
+test_expect_success PIPE '1-byte read, no input available' '
+	printf "%s" ab >expect &&
+	rm -f input &&
+	mkfifo input &&
+	{
+		{
+			printf "%s" a &&
+			printf "%s" b &&
+			sleep 100
+		} >input &
+	} &&
+	test-line-buffer input <<-\EOF >actual &&
+	read 1
+	copy 1
+	EOF
+	kill $! &&
+	test_cmp expect actual
+'
+
+test_expect_success PIPE 'long read (around 8192 bytes)' '
+	long_read_test 8192
+'
+
+test_expect_success PIPE,EXPENSIVE 'longer read (around 65536 bytes)' '
+	long_read_test 65536
+'
+
 test_expect_success 'buffer_read_string copes with null byte' '
 	>expect &&
 	q_to_nul <<-\EOF | test-line-buffer >actual &&
diff --git a/test-line-buffer.c b/test-line-buffer.c
index da0bc65..ec19b13 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -49,15 +49,31 @@ static void handle_line(const char *line, struct line_buffer *stdin_buf)
 int main(int argc, char *argv[])
 {
 	struct line_buffer stdin_buf = LINE_BUFFER_INIT;
+	struct line_buffer file_buf = LINE_BUFFER_INIT;
+	struct line_buffer *input = &stdin_buf;
+	const char *filename;
 	char *s;
 
-	if (argc != 1)
-		usage("test-line-buffer < script");
+	if (argc == 1)
+		filename = NULL;
+	else if (argc == 2)
+		filename = argv[1];
+	else
+		usage("test-line-buffer [file] < script");
 
 	if (buffer_init(&stdin_buf, NULL))
 		die_errno("open error");
+	if (filename) {
+		if (buffer_init(&file_buf, filename))
+			die_errno("error opening %s", filename);
+		input = &file_buf;
+	}
+
 	while ((s = buffer_read_line(&stdin_buf)))
-		handle_line(s, &stdin_buf);
+		handle_line(s, input);
+
+	if (filename && buffer_deinit(&file_buf))
+		die("error reading from %s", filename);
 	if (buffer_deinit(&stdin_buf))
 		die("input error");
 	if (ferror(stdout))
-- 
1.7.4.rc0.580.g89dc.dirty
