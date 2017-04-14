Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B0520970
	for <e@80x24.org>; Fri, 14 Apr 2017 21:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbdDNVXc (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 17:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:33818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbdDNVXb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 17:23:31 -0400
Received: (qmail 10934 invoked by uid 109); 14 Apr 2017 21:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 21:23:28 +0000
Received: (qmail 5290 invoked by uid 111); 14 Apr 2017 21:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 17:23:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Apr 2017 17:23:25 -0400
Date:   Fri, 14 Apr 2017 17:23:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Rast <trast@student.ethz.ch>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 01/12] grep: add ability to disable threading with
 --threads=0 or grep.threads=0
Message-ID: <20170414212325.fefrl3qdjigwyitd@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-2-avarab@gmail.com>
 <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net>
 <CACBZZX7vEQ5jUzX3GsD6JXe50TnRUtGmSVi7zBxwOmAQGABQ4Q@mail.gmail.com>
 <20170411203434.iiupo2oovzviqju5@sigill.intra.peff.net>
 <CACBZZX7Xi2OWqHQd7jTGBEZyqcWk59oXbPJOjuYrYAFzd5huCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7Xi2OWqHQd7jTGBEZyqcWk59oXbPJOjuYrYAFzd5huCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 10:56:01PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Right, my suggestion was to teach "grep" to treat --threads=1 as "do not
> > spawn any other threads". I.e., to make it like the "0" case you were
> > proposing, and then leave "0" as "auto-detect". There would be no way to
> > spawn a _single_ thread and feed it. But why would you want to do that?
> > It's always going to be strictly worse than not threading at all.
> 
> I understand, but given the two profiles we've posted it seems clear
> that there's cases where if we did that, we'd be locking people out of
> their optimal thread configuration, which would be --thread=1 with my
> patch, but wouldn't exist with this proposed change.

Maybe I don't understand your profiles. For a single-core machine you
probably want fewer threads, right? There is no such thing as "0"
threads, as you always have the original main thread in which we would
do the work.  So the lowest you can go is "1" (it's a separate question
of what --threads=0 should "mean"; I think we should keep it as
"auto-detect" for compatibility).

We could implement the single-thread case by spawning off one worker
thread (and effectively having 2 threads, but one is just sitting in
pthread_join()). And I think that's how it's implemented now in
git-grep. But we can optimize out the creation of the second thread
entirely, and just do the work in the main thread.

That saves a little bit of thread-spawning overhead, and it also makes
debugging much more pleasant.  For --threads=2, you'd always have to
kick in the thread-spawning code, and you'd spawn two worker threads
(and the main thread just sits there).

IOW, I am just proposing something like this:

diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52f..76ce38404 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -326,7 +326,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	}
 
 #ifndef NO_PTHREADS
-	if (num_threads) {
+	if (num_threads > 1) {
 		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		return 0;
@@ -360,7 +360,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	}
 
 #ifndef NO_PTHREADS
-	if (num_threads) {
+	if (num_threads > 1) {
 		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;

where we fall back to the same code that NO_PTHREADS uses when there is
only a single thread requested.

> Anyway, I really don't care about this feature much, I just wanted a
> way to disable threading, but looking at the perf profiles I wonder if
> doing your proposed change would cause a regression in some cases
> where someone really wanted /one/ thread.

I'm not sure what would regress. Right now --threads=1 only does
work in a single worker thread. And --threads=2 does it in 2, and so on.
In all cases, the original main-thread is just farming out work and
waiting on pthread_join() (let's call that the controller thread).  So
why would you ever want the "controller plus one worker" setup? It's
strictly worse than "controller just does the work".

> But of course my patch breaks the long documented grep.threads=0 for
> "give me threads that you auto detect" to now mean "you get none".

Right, that's what I'm concerned about.

> Also doesn't --thread=1 right now mean "one thread, but two workers?".
> I haven't dug into the grep worker/thread code, but it compiles the
> the pattern twice, so isn't both the non-thread main process & the
> sole thread it spawns on --thread=1 doing work, so in some other
> universe it's synonymous with --workers=2?

I think --threads=1 right now means "one worker thread". I think the
main program calls compile_grep_patterns() to make sure they are sane,
before it even considers whether and how to thread.  And then each
worker thread duplicates them and re-compiles them itself (IIRC, this is
because the regex code may not be thread-safe).

> If so do pack-objects & index-pack also behave like that? If so this
> whole thing is very confusing for users, because some will read 1
> thread and think "one worker", whereas it really means "two workers,
> one using a thread, if you want three workers spawn two threads".

No, I think --threads is "this many workers". If you have more than one
worker, you may have an extra thread farming out work to them, but that
isn't counted (and is mostly dormant).

-Peff
