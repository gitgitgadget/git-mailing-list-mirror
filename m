From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Wed, 26 Oct 2011 13:08:36 -0700
Message-ID: <7vmxcn1pob.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
 <7v39ef34in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:08:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ9mH-0002ud-15
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 22:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab1JZUIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 16:08:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab1JZUIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 16:08:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF6D96DC0;
	Wed, 26 Oct 2011 16:08:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uGpsEQMLzTSDgyDaFUdgwzSzGzg=; b=tZsqY+
	KsD6BiTvW4hdY6jdOYvHU5fsqQsQ1tTi0sIOhiJI4Ilb94SotdDIgWrOHc07yaBA
	t7sviElXgZWdBZFYkbRoWWH1Oo/Qah4Hwm3OEhVMlD1CJeQtUe32KOl+SmLmN2iA
	cxY3m4gtX27N/fzqNkzkO3+sX/+si3QV7wmCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cf231ub/AmePkvN7RbVZMJPIl4Qhyyd1
	y9juBzTPHw6xUN1RMWTKxVtYSjTltr3yrQu+y9mZilnuLk5UxvbyvzhIeXhm+nrN
	vbL5hx6z6kN5peGIFvBm5H6ou+0q7Yb1UlffonDPHdiJmL34GthyCup3Sxc7epP3
	vvb2QyJYyj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2D806DBF;
	Wed, 26 Oct 2011 16:08:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1107B6DBD; Wed, 26 Oct 2011
 16:08:37 -0400 (EDT)
In-Reply-To: <7v39ef34in.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 26 Oct 2011 13:02:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AB60540-000E-11E1-96EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184277>

Junio C Hamano <gitster@pobox.com> writes:

> The remainder of this message are hints and random thoughts on potential
> follow-up patches that may want to build on top of this patch for further
> clean-ups (not specifically meant for Dscho but for other people on both
> mailing lists).
> ...
>  - Could we lose "#ifndef NO_PTHREADS" inside grep_sha1(), grep_file(),
>    and possibly cmd_grep() functions and let the compiler optimize things
>    away under NO_PTHREADS compilation?

I suspect that the result of the conversion would look a lot cleaner if
the code is first cleaned up to move global variable like skip_first_line
and the mutexes into the grep_opt structure. Without such clean-up, I do
not think a conversion like this does not add much value.

But since I already did it,...

-- >8 --
Subject: [PATCH] builtin/grep: war on #if[n]def inside function body

Get rid of #if[n]def inside implementation of the function body
and let the compiler optimize codepaths that are protected with
"if (use_threads)" away on NO_PTHREADS builds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c |   37 +++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3d7329d..f24f3a7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,9 +24,13 @@ static char const * const grep_usage[] = {
 	NULL
 };
 
-static int use_threads = 1;
+/* Skip the leading hunk mark of the first file. */
+static int skip_first_line;
 
 #ifndef NO_PTHREADS
+static int use_threads = 1;
+#define no_threads() use_threads = 0
+
 #define THREADS 8
 static pthread_t threads[THREADS];
 
@@ -112,8 +116,6 @@ static pthread_cond_t cond_write;
 /* Signalled when we are finished with everything. */
 static pthread_cond_t cond_result;
 
-static int skip_first_line;
-
 static void add_work(enum work_type type, char *name, void *id)
 {
 	grep_lock();
@@ -181,7 +183,6 @@ static void work_done(struct work_item *w)
 			const char *p = w->out.buf;
 			size_t len = w->out.len;
 
-			/* Skip the leading hunk mark of the first file. */
 			if (skip_first_line) {
 				while (len) {
 					len--;
@@ -310,8 +311,18 @@ static int wait_all(void)
 	return hit;
 }
 #else /* !NO_PTHREADS */
+#define use_threads 0
+#define no_threads() /* noop */
+
 #define read_sha1_lock()
 #define read_sha1_unlock()
+#define grep_lock()
+#define grep_unlock()
+
+#define online_cpus() 1
+#define grep_sha1_async(opt, name, sha1)
+#define grep_file_async(opt, name, filename)
+#define start_threads(opt)
 
 static int wait_all(void)
 {
@@ -407,13 +418,10 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 
 	name = strbuf_detach(&pathbuf, NULL);
 
-#ifndef NO_PTHREADS
 	if (use_threads) {
 		grep_sha1_async(opt, name, sha1);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 		unsigned long sz;
 		void *data = load_sha1(sha1, &sz, name);
@@ -469,13 +477,10 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		strbuf_addstr(&buf, filename);
 	name = strbuf_detach(&buf, NULL);
 
-#ifndef NO_PTHREADS
 	if (use_threads) {
 		grep_file_async(opt, name, filename);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 		size_t sz;
 		void *data = load_file(filename, &sz);
@@ -992,7 +997,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.output_priv = &path_list;
 		opt.output = append_path;
 		string_list_append(&path_list, show_in_pager);
-		use_threads = 0;
+		no_threads();
 	}
 
 	if (!opt.pattern_list)
@@ -1000,9 +1005,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |= REG_ICASE;
 
-#ifndef NO_PTHREADS
 	if (online_cpus() == 1 || !grep_threads_ok(&opt))
-		use_threads = 0;
+		no_threads();
 
 	if (use_threads) {
 		if (opt.pre_context || opt.post_context || opt.file_break ||
@@ -1010,9 +1014,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
-#else
-	use_threads = 0;
-#endif
 
 	compile_grep_patterns(&opt);
 
-- 
1.7.7.1.504.gcc718
