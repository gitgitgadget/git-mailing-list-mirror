From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git grep" parallelism question
Date: Fri, 26 Apr 2013 12:19:46 -0700
Message-ID: <7vip39w14d.fsf@alter.siamese.dyndns.org>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	<7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
	<CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoBX-0003Xv-4f
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab3DZTTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:19:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab3DZTTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:19:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5811A776;
	Fri, 26 Apr 2013 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CWOQuty48Sa6tQFCeamhc18HmVU=; b=JcRpnE
	6IoeVKnCwEh3tmSKBKjkJoNldTzaonEaBIOKifWqJjA4TBOpdNatk0L5fyhblZLp
	6K8ABh5VPOuUIe8RSzbhYBCV8MFYXOKKhSZ5aRHgBxXVNPATEGaKHJRozi1R6bbD
	amIi9xC1JbEKu6cXLFnh8TYvX/2hyi2xT4TKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b35rOwXttMrmHmYDO4neuq+vVTW9kt/V
	eoR8ZE535PROlON4pqTPlKSmCWIYx70EVYNKVfiduc8zWNMV+HAhjFS9JCDlLh9w
	F9MIpXqaqQ6B96KP1SVPIIdJvw/zwj5sg8mr+8a5Cb4HMUFiFN+wYlI6Al77b5qU
	dvIfXOQ7c+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FBE11A775;
	Fri, 26 Apr 2013 19:19:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DB041A774;
	Fri, 26 Apr 2013 19:19:47 +0000 (UTC)
In-Reply-To: <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 26 Apr 2013 11:54:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 426998BE-AEA6-11E2-8F59-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222559>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yes. Also, I'm not sure if the 15% possible improvement on my SSD case
> is even worth it for something that in the end isn't necessarily the
> common case.

Cold cache being uncommon case would be forever true but more and
more people are on SSD, and 15% is not a trivial improvement.

> Are there people out there who use "git grep" over NFS and have been
> unhappy with performance? If are willing to recompile git with a
> different THREAD value in builtin/grep.c,...

OK, you have to recompile at least once for experiment, so perhaps
building the test binary with this patch may help.

 builtin/grep.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 159e65d..f635cd5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,12 +26,14 @@ static char const * const grep_usage[] = {
 static int use_threads = 1;
 
 #ifndef NO_PTHREADS
-#define THREADS 8
-static pthread_t threads[THREADS];
+#define MAX_THREADS 100
+static int num_threads = 8;
+static pthread_t threads[MAX_THREADS];
 
-/* We use one producer thread and THREADS consumer
- * threads. The producer adds struct work_items to 'todo' and the
- * consumers pick work items from the same array.
+/*
+ * We use one producer thread and THREADS consumer threads. The
+ * producer adds struct work_items to 'todo' and the consumers pick
+ * work items from the same array.
  */
 struct work_item {
 	struct grep_source source;
@@ -205,7 +207,7 @@ static void start_threads(struct grep_opt *opt)
 		strbuf_init(&todo[i].out, 0);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+	for (i = 0; i < num_threads; i++) {
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
@@ -237,7 +239,7 @@ static int wait_all(void)
 	pthread_cond_broadcast(&cond_add);
 	grep_unlock();
 
-	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+	for (i = 0; i < num_threads; i++) {
 		void *h;
 		pthread_join(threads[i], &h);
 		hit |= (int) (intptr_t) h;
@@ -636,6 +638,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 	int dummy;
 	int use_index = 1;
+	int num_threads_explicit = -1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 
 	struct option options[] = {
@@ -743,6 +746,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    N_("allow calling of grep(1) (ignored by this build)")),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
+		OPT_INTEGER(0, "threads", &num_threads_explicit,
+			    N_("use threads when searching")),
 		OPT_END()
 	};
 
@@ -773,6 +778,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_NO_INTERNAL_HELP);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
+	if (MAX_THREADS <= num_threads_explicit) {
+		warning("limiting --threads to %d", MAX_THREADS);
+		num_threads = MAX_THREADS;
+	} else if (num_threads_explicit < 0) {
+		; /* keep num_threads to compiled-in default */
+	} else {
+		num_threads = num_threads_explicit;
+	}
+
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
@@ -834,7 +848,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1)
+	if ((list.nr || cached || online_cpus() == 1) && num_threads_explicit < 0)
 		use_threads = 0;
 #else
 	use_threads = 0;
