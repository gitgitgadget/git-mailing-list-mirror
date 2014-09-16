From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Tue, 16 Sep 2014 14:43:43 -0700
Message-ID: <xmqqd2av1bsg.fsf@gitster.dls.corp.google.com>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Patrick Reynolds <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU0XQ-0003xP-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 23:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbaIPVns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 17:43:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61669 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbaIPVnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 17:43:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74FF539AFE;
	Tue, 16 Sep 2014 17:43:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=u0zBT852qax2KlWI/cC7hf2vn4M=; b=Q/w4aPyiwofxrJx6gFdR
	jK0L9pFCnZgIzlUwnRAxgWKmORRxLWnohNIouIDnbeYnlDUlwlwW9VEN3nbdOFnH
	B7JafyoAgX2yQEp+c1faHxgNP9t5xcVzx3Loq6airqCk5diIjd/OLxHZaHV9igOt
	RxsFivorOclenEfg1UBNAr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=f60OHfq7VBW4pwVCFTnzb1TjLgfKrsiLxDEqJOAhRFdB2H
	TAftNzHrG+WJz0wJhoDbq51lmInhyebAby60UhHkjStaZarzC2dYB7Clt+YrWcQQ
	U2GQT28b24RBXyBnfSlrBXoT83XE+K2t4mUwO9rB4rGJUBx7/NrIqdl9/M7pI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 695F739AFD;
	Tue, 16 Sep 2014 17:43:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B777D39AFB;
	Tue, 16 Sep 2014 17:43:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88F94E30-3DEA-11E4-B5FE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257197>

Patrick Reynolds <patrick.reynolds@github.com> writes:

> Blocked and ignored signals -- but not caught signals -- are inherited
> across exec.  Some callers with sloppy signal-handling behavior can call
> git with SIGPIPE blocked or ignored, even non-deterministically.  When
> SIGPIPE is blocked or ignored, several git commands can run indefinitely,
> ignoring EPIPE returns from write() calls, even when the process that
> called them has gone away.  Our specific case involved a pipe of git
> diff-tree output to a script that reads a limited amount of diff data.
>
> In an ideal world, git would never be called with SIGPIPE blocked or
> ignored.  But in the real world, several real potential callers, including
> Perl, Apache, and Unicorn, sometimes spawn subprocesses with SIGPIPE
> ignored.  It is easier and more productive to harden git against this
> mistake than to clean it up in every potential parent process.
>
> Signed-off-by: Patrick Reynolds <patrick.reynolds@github.com>

I missed this one when it was posted.

I have a suspicion that $gmane/256544 (relevant parties Cc'ed) is
cured by this (even though the other topic came much later than this
change)?

> diff --git a/git.c b/git.c
> index 9c49519..d6b221b 100644
> --- a/git.c
> +++ b/git.c
> @@ -611,6 +611,11 @@ int main(int argc, char **av)
>  	 */
>  	sanitize_stdfds();
>  
> +	/*
> +	 * Make sure we aren't ignoring or blocking SIGPIPE.
> +	 */
> +	sanitize_signals();
> +
>  	git_setup_gettext();
>  
>  	trace_command_performance(argv);
> diff --git a/setup.c b/setup.c
> index 0a22f8b..7aa4b01 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -865,3 +865,14 @@ int daemonize(void)
>  	return 0;
>  #endif
>  }
> +
> +/* un-ignore and un-block SIGPIPE */
> +void sanitize_signals(void)
> +{
> +	sigset_t unblock;
> +
> +	sigemptyset(&unblock);
> +	sigaddset(&unblock, SIGPIPE);
> +	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
> +	signal(SIGPIPE, SIG_DFL);

With the only caller in git.c, there is not a good reason that we
would want to have this as a global in a different file (I think the
patch merely follows the pattern of sanitize-fds, but that one has
to be called from many places).

After making the function static to git.c, it would also be a good
idea to rename it to match the comment at the sole callsite,
e.g. "restore_sigpipe_to_default()" or something.  Then the comment
at the callsite can be removed.

Later somebody else may want to add other signals handled similarly
for whatever reason (I do not think of any signal or any good reason
at this moment).  But they will have to come up with much better
justification than "the function name says 'sanitize'" if we named
it to something specific to SIGPIPE.  And that good justification
will guide us what kind of signals need to be "sanitized" and find a
better verb than "sanitize", if it ever happens.

> diff --git a/t/t0012-sigpipe.sh b/t/t0012-sigpipe.sh
> new file mode 100755
> index 0000000..213cde3
> --- /dev/null
> +++ b/t/t0012-sigpipe.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh

Hmmm, do we really need to allocate a new test number just for these
two tests, instead of folding it into an existing one?

> +test_expect_success 'create blob' '
> +	test-genrandom foo 16384 >file &&
> +	git add file
> +'
> +
> +large_git () {
> +	for i in $(test_seq 1 100); do
> +		git diff --staged --binary || return $?

Write it more like this:

	for i in $(...)
        do
		git diff --cached --binary || return
	done

to (1) avoid unnecessary semicolon before "do", (2) prefer the true
option name over a synonym, and (3) omit unnecessary $? that is
given to "return".

Summing them up, something like this squashed in would give us a
good end result, perhaps?

---
 cache.h            |  1 -
 git.c              | 25 +++++++++++++++++++++----
 setup.c            | 11 -----------
 t/t0000-basic.sh   | 17 +++++++++++++++++
 t/t0012-sigpipe.sh | 27 ---------------------------
 5 files changed, 38 insertions(+), 43 deletions(-)
 delete mode 100755 t/t0012-sigpipe.sh

diff --git a/cache.h b/cache.h
index 0a89fc1..fcb511d 100644
--- a/cache.h
+++ b/cache.h
@@ -463,7 +463,6 @@ extern int set_git_dir_init(const char *git_dir, const char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
 
 extern void sanitize_stdfds(void);
-extern void sanitize_signals(void);
 extern int daemonize(void);
 
 #define alloc_nr(x) (((x)+16)*3/2)
diff --git a/git.c b/git.c
index d6b221b..c87bacd 100644
--- a/git.c
+++ b/git.c
@@ -592,6 +592,26 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
+/*
+ * Many parts of Git have subprograms communicate via pipe, expect the
+ * upstream of the pipe to die with SIGPIPE and the downstream process
+ * even knows to check and handle EPIPE correctly.  Some third-party
+ * programs that ignore or block SIGPIPE for their own reason forget
+ * to restore SIGPIPE handling to the default before spawning Git and
+ * break this carefully orchestrated machinery.
+ *
+ * Restore the way SIGPIPE is handled to default, which is what we
+ * expect.
+ */
+static void restore_sigpipe_to_default(void)
+{
+	sigset_t unblock;
+
+	sigemptyset(&unblock);
+	sigaddset(&unblock, SIGPIPE);
+	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
+	signal(SIGPIPE, SIG_DFL);
+}
 
 int main(int argc, char **av)
 {
@@ -611,10 +631,7 @@ int main(int argc, char **av)
 	 */
 	sanitize_stdfds();
 
-	/*
-	 * Make sure we aren't ignoring or blocking SIGPIPE.
-	 */
-	sanitize_signals();
+	restore_sigpipe_to_default();
 
 	git_setup_gettext();
 
diff --git a/setup.c b/setup.c
index 7aa4b01..0a22f8b 100644
--- a/setup.c
+++ b/setup.c
@@ -865,14 +865,3 @@ int daemonize(void)
 	return 0;
 #endif
 }
-
-/* un-ignore and un-block SIGPIPE */
-void sanitize_signals(void)
-{
-	sigset_t unblock;
-
-	sigemptyset(&unblock);
-	sigaddset(&unblock, SIGPIPE);
-	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
-	signal(SIGPIPE, SIG_DFL);
-}
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f10ba4a..21a0b19 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1063,4 +1063,21 @@ test_expect_success 'very long name in the index handled sanely' '
 	test $len = 4098
 '
 
+large_git () {
+	for i in $(test_seq 1 100)
+	do
+		git ls-files -s || return
+	done
+}
+
+test_expect_success 'a constipated git dies with SIGPIPE' '
+	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 )
+	test "$OUT" -eq 141
+'
+
+test_expect_success 'a constipated git dies with SIGPIPE even if parent ignores it' '
+	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 )
+	test "$OUT" -eq 141
+'
+
 test_done
diff --git a/t/t0012-sigpipe.sh b/t/t0012-sigpipe.sh
deleted file mode 100755
index 213cde3..0000000
--- a/t/t0012-sigpipe.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-
-test_description='check handling of SIGPIPE'
-. ./test-lib.sh
-
-test_expect_success 'create blob' '
-	test-genrandom foo 16384 >file &&
-	git add file
-'
-
-large_git () {
-	for i in $(test_seq 1 100); do
-		git diff --staged --binary || return $?
-	done
-}
-
-test_expect_success 'git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | true) 3>&1 )
-	test "$OUT" -eq 141
-'
-
-test_expect_success 'git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | true) 3>&1 )
-	test "$OUT" -eq 141
-'
-
-test_done
-- 
2.1.0-403-g099cf47
