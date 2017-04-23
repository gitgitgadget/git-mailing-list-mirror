Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4265207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 14:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1045672AbdDWOoL (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 10:44:11 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35398 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1045664AbdDWOoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 10:44:09 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Bqk61v0031keHif01qk7P7; Sun, 23 Apr 2017 15:44:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y8KIilWN c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=TLecUZfdgHKfcV6ZtOwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: git v2.13.0-rc0 test failures on cygwin
Message-ID: <bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com>
Date:   Sun, 23 Apr 2017 15:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Adam,

[Adam, if you are no longer the git package maintainer for cygwin, then
please ignore this email and sorry for the noise!]

On thursday evening, I ran the test-suite on the newly minted v2.13.0-rc0
release on cygwin, which unfortunately failed (the 'test-out' files are
from the most recent test runs for v2.13.0-rc0, v2.12.0-rc0, v2.12.0-rc1
and v2.12.0 - I missed the v2.12.0-rc2 release!):

$ ls -l test-out*
-rw-r--r-- 1 ramsay None 104K Apr 20 22:29 test-out
-rw-r--r-- 1 ramsay None 103K Feb  5 00:57 test-out.old1
-rw-r--r-- 1 ramsay None 103K Feb 12 00:29 test-out.old2
-rw-r--r-- 1 ramsay None 103K Feb 25 01:14 test-out.old3
$ 
$ grep FAIL test-out*
test-out:Result: FAIL
$ 
$ tail -15 test-out
[22:29:51]

Test Summary Report
-------------------
t0301-credential-cache.sh                        (Wstat: 256 Tests: 29 Failed: 6)
  Failed tests:  12, 24-28
  Non-zero exit status: 1
t8010-cat-file-filters.sh                        (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  8
  Non-zero exit status: 1
Files=780, Tests=14700, 10398 wallclock secs ( 1.27 usr  0.78 sys + 1265.08 cusr 4076.38 csys = 5343.50 CPU)
Result: FAIL
make[1]: *** [Makefile:45: prove] Error 1
make[1]: Leaving directory '/home/ramsay/git/t'
make: *** [Makefile:2313: test] Error 2
$

I was a bit surprised about the 'credential-cache' failures (I didn't think
they were being run on cygwin!), but I haven't spent any time looking at
that yet. So, looking at the t8010 test failure:

$ grep t8010 test-out*
test-out:[22:20:20] t8010-cat-file-filters.sh ..........................
test-out:t8010-cat-file-filters.sh                        (Wstat: 256 Tests: 8 Failed: 1)
test-out.old1:[00:46:05] t8010-cat-file-filters.sh .......................... ok     2169 ms ( 0.00 usr  0.00 sys +  0.21 cusr  0.54 csys =  0.75 CPU)
test-out.old2:[00:20:09] t8010-cat-file-filters.sh .......................... ok     1831 ms ( 0.00 usr  0.00 sys +  0.32 cusr  0.74 csys =  1.06 CPU)
test-out.old3:[01:05:04] t8010-cat-file-filters.sh .......................... ok     1845 ms ( 0.00 usr  0.00 sys +  0.44 cusr  0.59 csys =  1.03 CPU)
$

So, this test was passing on the three previous runs and nothing seems to
have changed in the interval. Hmm, except that the previous evening I had
updated my cygwin installation (according to my setup.log file, the cygwin
dll version went from 2.7.0-1 to 2.8.0-1). As a quick test, I rebuilt the
v2.12.0 version, which has previously worked, and ran the t8010 test
repeatedly; it failed consistently. Hmm, back to the v2.13.0-rc0 failure:

$ cd t
$ ./t8010-cat-file-filters.sh -i -v

...

ok 7 - --path=<path> complains without --textconv/--filters

expecting success:
        sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
        test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
        printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
        git cat-file --textconv --batch >actual &&
        printf "%s blob 6\nuryyb\r\n\n%s blob 6\nhello\n\n" \
                $sha1 $sha1 >expect &&
        test_cmp expect actual

--- expect      2017-04-23 12:40:07.899086200 +0000
+++ actual      2017-04-23 12:40:07.883459900 +0000
@@ -1,6 +1,3 @@
 ce013625030ba8dba906f756967f9e9ca394464a blob 6
 uryyb

-ce013625030ba8dba906f756967f9e9ca394464a blob 6
-hello
-
not ok 8 - cat-file --textconv --batch works
#
#               sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
#               test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
#               printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
#               git cat-file --textconv --batch >actual &&
#               printf "%s blob 6\nuryyb\r\n\n%s blob 6\nhello\n\n" \
#                       $sha1 $sha1 >expect &&
#               test_cmp expect actual
#
$

OK, lets go run it by hand:

$ cd trash\ directory.t8010-cat-file-filters/
$ sha1=$(git rev-parse -q --verify HEAD:world.txt)
$ printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
> git cat-file --textconv --batch
ce013625030ba8dba906f756967f9e9ca394464a blob 6
uryyb

$

Having run it in the debugger, the loop in batch_objects() (builtin/cat-file.c
lines #489-505) only reads one line from stdin, then gets EOF on the stream.

$ printf "%s hello.txt\n%s hello\n" $sha1 $sha1 | cat
ce013625030ba8dba906f756967f9e9ca394464a hello.txt
ce013625030ba8dba906f756967f9e9ca394464a hello
$

$ printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
> git cat-file --batch
ce013625030ba8dba906f756967f9e9ca394464a hello.txt missing
ce013625030ba8dba906f756967f9e9ca394464a hello missing
$

$ printf "%s hello.txt\n%s hello\n" $sha1 $sha1 >input
$ git cat-file --textconv --batch <input
ce013625030ba8dba906f756967f9e9ca394464a blob 6
uryyb

ce013625030ba8dba906f756967f9e9ca394464a blob 6
hello

$

Ah, so it looks like running the textconv filter program is somehow causing
the standard input stream of the 'git-cat-file' process to be closed (or
otherwise truncated). Hmm, somewhat odd! ;-)

Also, I have the cygwin git package installed (which was updated to a newer
version than my current ~/bin version):

$ /usr/bin/git version
git version 2.12.2
$ printf "%s hello.txt\n%s hello\n" $sha1 $sha1 | /usr/bin/git cat-file --textconv --batch
ce013625030ba8dba906f756967f9e9ca394464a blob 6
uryyb

$

... which also suffers from this problem (with the 2.8.0-1 version of the
cygwin dll, anyway).

So, I hacked up a version of 'cat-file' (diff given below), which slurped up
all of the input into an array of strbuf's, before passing each line to the
batch_one_object() function for processing (possibly by the external textconv
process). This version passes the test.

This is _not_ the solution, of course. It simply sidesteps the issue, which
seems to be caused by an update to the cygwin dll. I don't want to call this
a bug, because I have no evidence of that, rather than an unfortunate change
in behaviour. (git stresses the cygwin posix fork/exec implementation rather
a lot!).

I'm not sure how to proceed from here. (I don't know if it is even possible
to 'downgrade' my cygwin installation in order to confirm that the current
git-cat-file would work with the 2.7.0-1 version of the cygwin dll).

Hopefully, someone more clueful than me can tackle this from the cygwin api
side of things. (Also, I suppose this could possibly affect Msys2, if they
port the cygwin dll change).

ATB,
Ramsay Jones
 
-- >8 --

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a63..da5e45d75 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -426,12 +426,31 @@ static int batch_packed_object(const struct object_id *oid,
 	return 0;
 }
 
+static struct strbuf **strbuf_getlines(FILE *fp)
+{
+	struct strbuf **ret = NULL;
+	size_t nr = 0, alloc = 0;
+	struct strbuf *t, b = STRBUF_INIT;
+
+	while (strbuf_getline(&b, fp) != EOF) {
+		t = xmalloc(sizeof(struct strbuf));
+		strbuf_init(t, b.len);
+		strbuf_addbuf(t, &b);
+		ALLOC_GROW(ret, nr + 1, alloc);
+		ret[nr++] = t;
+	}
+	ALLOC_GROW(ret, nr + 1, alloc);
+	ret[nr] = NULL;
+	return ret;
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	struct strbuf **lines, **l;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -486,7 +505,13 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&buf, stdin) != EOF) {
+	strbuf_release(&buf);
+	lines = strbuf_getlines(stdin);
+
+	for (l = lines; *l; l++) {
+		strbuf_reset(&buf);
+		strbuf_addbuf(&buf, *l);
+
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -503,6 +528,7 @@ static int batch_objects(struct batch_options *opt)
 
 		batch_one_object(buf.buf, opt, &data);
 	}
+	strbuf_list_free(lines);
 
 	strbuf_release(&buf);
 	warn_on_object_refname_ambiguity = save_warning;
