From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] Another squash on run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 19:17:47 -0700
Message-ID: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
References: <xmqqpp19xbpz.fsf@gitster.mtv.corp.google.com>
	<1443051711-15322-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 04:17:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zew6d-0006cL-6J
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 04:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbbIXCRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 22:17:50 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33929 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbbIXCRt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 22:17:49 -0400
Received: by padhy16 with SMTP id hy16so57659048pad.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=web7Z+9IDL9pwZ5BgWA06/UtrOaMQUJDDzu1LkTplZ8=;
        b=jbs628Sg1fGtj0a2pDFiMuGEH4iYL6flPkmNdsN1HoHpkGS8uGdA/wC2PejRvhvQOj
         akOHhP3T/mZZ68as+dOrZXOD70TxZrcbcWHS33BMu4INFtjQrPHkWa+Q5a0VCnTRh7HN
         npd5UrZ5g2xvApKS+wEUFRIJItT+Zht1FOcWNfSJlAfETy8h1N7kxJuQ7Md5rXko7/fd
         0ZJKzzUNtUaHOd5uakD7uowHQa890LOpgMwl+mSDisBmVNEaA6PlbsrSMGhCDDj5SEIq
         rPz5W+xtI9Toq5tuBpR68XBfN5+C1fA9O5TpZfRtkarGvVJw5pmfN0hAth1AhJC7teQO
         v2tw==
X-Received: by 10.66.164.132 with SMTP id yq4mr41972207pab.8.1443061068959;
        Wed, 23 Sep 2015 19:17:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id cs5sm10420178pbc.15.2015.09.23.19.17.47
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 19:17:47 -0700 (PDT)
In-Reply-To: <1443051711-15322-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 23 Sep 2015 16:41:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278528>

Stefan Beller <sbeller@google.com> writes:

> I agree the commit 7087c5f3 (SQUASH??? on top of run-command: add an
> asynchronous parallel child processor) makes sense; I arrived at the same
> patch after adding in the feedback.

I dunno.  As I said, while a small part of that commit is necessary
to be squashed into [6/14] (i.e. the "failed to start" bugfix and
redefinition of the return value of start_one()), the remainder of
the commit is primarily to illustrate possible future enhancements
that the basic structure of your code must support, so that we can
get the fundamentals right.  Each of the actual "possible future
enhancements" may or may not be a good idea and there is nothing
that back it up.  In such a vacuum, I'd prefer to leave them simple
and avoid starting performance tuning prematurely.

One thing that is sort-of backed up already by your "cap to 4"
experiment is that some sort of slow-start ramping up is far better
than letting thundering herd stampede, so I am OK if we kept that
SPAWN_CAP part of the commit.

But even then, we do not know if tying that cap to online_cpu() is a
good idea.  Neither of us have a good argument backed by data on it.

It is tempting to imagine, when you have N cores on an otherwise
idle box, the setting of SPAWN_CAP shouldn't make much difference to
how well the first child process makes its initial progress as long
as it does not exceed the number of idle cores N-1 you have at hand.

But that assumes that the task is CPU bound and you have infinite
memory bandwidth.  Once the task needs a lot of disk bandwidth to
make its initial progress, which certainly is the case for fetch,
the first child that is spawned together with (SPAWN_CAP-1) other
processes would be competing for the shared resource, and having
more online_cpus() would not help you.

If we are not doing analysis that takes into such factors (and it is
way too premature for us to be tuning), even "online_cpu() - 1" is
unnecessarily too complex than a hardcoded small number (say, "2",
or even "1").

The same thing can be said for the output_timeout selection.  "Do
not get stuck for too long until we have fully ramped up.  Do not
spin too frequently when there is no more room for a new child" was
something I came up out of thin air as an example of something we
might want to do, and I did write such a code in that commit, but
that was primarily done so that you can clearly see that a better
design would be to allow the caller, i.e. the scheduling loop,
specify output_timeout to buffer_stderr(), and to keep the latter a
"dumb" helper that can be controlled by a more smart caller (as
opposed to hiding such a logic in buffer_stderr() and have a "dumb"
driver call it).  The actual output_timeout computation logic is not
well thought out---it may even turn out to be that we are better off
if we lengthened the timeout before we have fully ramped up, to
encourage the first process to produce some output before we give
chance to other new processes to be spawned in the later round.

So for that change, while I think adding that parameter to
buffer_stderr() is something we would want to keep, I'd prefer to
keep the caller simpler by always passing a hardcoded 100 in the
initial version, before we start tuning.  And I do not think we want
to start tuning before building a solid foundation to tune.

In short, if I were amending that SQUASH??? commit, I'd probably be
making it do less, not more, than what it does, something along the
line of the attached.

 run-command.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index b6d8b39..829b6fe 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1108,20 +1108,19 @@ static void pp_collect_finished(struct parallel_processes *pp)
 }
 
 
-#define SPAWN_CAP (pp.max_processes + 1) /* spawn as many as possible */
-
 int run_processes_parallel(int n, void *data,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
 			   return_value_fn return_value)
 {
 	struct parallel_processes pp;
-	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
 
+	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
 	while (1) {
-		int no_more_task, cnt, output_timeout;
+		int no_more_task, cnt, output_timeout = 100;
+		int spawn_cap = 2;
 
-		for (cnt = SPAWN_CAP, no_more_task = 0;
+		for (cnt = spawn_cap, no_more_task = 0;
 		     cnt && pp.nr_processes < pp.max_processes;
 		     cnt--) {
 			if (!pp_start_one(&pp)) {
@@ -1132,12 +1131,6 @@ int run_processes_parallel(int n, void *data,
 
 		if (no_more_task && !pp.nr_processes)
 			break;
-		if (!cnt)
-			output_timeout = 50;
-		else if (pp.nr_processes < pp.max_processes)
-			output_timeout = 100;
-		else
-			output_timeout = 1000;
 		pp_buffer_stderr(&pp, output_timeout);
 
 		pp_output(&pp);
