Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669F748D
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296100; cv=none; b=TA7xdJtTasjW/nFio3fALS9Q/U1Zp1kGBlGtkYg28D/mhwO3rBn54V+NoScZVwOpWZM6kQmM0jUOsDIg4Jo+4K9XEqHgZFW42M6t1Nejhk/juec2yOTH/wk78kOAUw8LqX19qZAPUSF8dU1J5E2M6XJt6MBZCGF8JdEkgSQFfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296100; c=relaxed/simple;
	bh=eZ1yqxh9Yeah8JtofZiFZP+qb4NjvQLItOpSaz+ha18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukSzOcSveGdgH0X3zcahTo4UDh/948YdYwZVxIjUxvFM3AGif26nBjo9GDNz5bitVZJJMV26fHipOUwhh0nPg8g8z07HU1zfEo+vDUM0L9ASFPz3UBJXSEPysOppYDI14zhQsz7YF9wEs3EbPgkOz5fD1XP8B9bZmb4gdlEI2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32231 invoked by uid 109); 14 Sep 2024 06:41:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Sep 2024 06:41:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11635 invoked by uid 111); 14 Sep 2024 06:41:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Sep 2024 02:41:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Sep 2024 02:41:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
Message-ID: <20240914064130.GA1284567@coredump.intra.peff.net>
References: <xmqqmskbwe1a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmskbwe1a.fsf@gitster.g>

On Fri, Sep 13, 2024 at 12:26:41PM -0700, Junio C Hamano wrote:

> The last test in t5512 we recently added seems to be flaky.
> Running
> 
>     $ make && cd t && sh ./t5512-ls-remote.sh --stress
> 
> shows that "git ls-remote foo::bar" exited with status 141, which
> means we got a SIGPIPE.  This test piece was introduced by 9e89dcb6
> (builtin/ls-remote: fall back to SHA1 outside of a repo, 2024-08-02)
> and is pretty much independent from all other tests in the script
> (it can even run standalone with everything before it removed).
> 
> The transport-helper.c:get_helper() function tries to write to the
> helper.  As we can see the helper script is very short and can exit
> even before it reads anything, when get_helper() tries to give the
> first command, "capabilities", the helper may already be gone.
> 
> A trivial fix, presented here, os to make sure that the helper reads
> the first command it is given, as what it writes later is a response
> to that command.

This analysis looks right, and I think the test change here is a good
minimal fix. It does leave "real world" cases where we'd hit SIGPIPE
vulnerable to the same problem, but I don't think that happens all that
often (any helper that doesn't speak the protocol correctly and causes
spurious pipe failures will annoy users and get fixed).

So I think we should apply it as-is. But see below for some interesting
historical context.

> I however would wonder if the interactions with the helper initiated
> by get_helper() should be done on a non-blocking I/O (we do check
> the return value from our write(2) system calls, do we?).

You still get SIGPIPE with non-blocking I/O. I assume you meant ignoring
SIGPIPE?

That's certainly an option, but unfortunately it does mean we'd ignore
SIGPIPE everywhere. We do generally check the return value of write(),
but not always for buffered I/O. So in something like:

  git ls-remote | head -1

we'd probably do a bunch of useless writes to the closed pipe. That's
not the end of the world, given that we've done most of the work before
generating the first line of output anyway, but that's the case that
SIGPIPE is really supposed to be helping with. It's much worse on
something like git-log, but if we are just talking about ignoring
SIGPIPE in users of transport-helper.c, that's much more limited (though
a confusing concept when you start thinking about libification, which
may do many things in one process).

I really wish there was a way to ignore SIGPIPE per-descriptor (or even
tell which descriptor triggered it in a signal handler), but I don't
think there is. Some environments like "go" claim to do this, but I
think it's really that they ignore SIGPIPE, and then assume all writes
are going through their wrapper, which converts EPIPE into the signal.
That's a bit harder for us to do (even if we got xwrite(), you have to
similarly wrap fprintf, and so on).

Another option is to selectively disable/re-enable SIGPIPE for
individual write() calls. That's not thread-safe, and I imagine may have
some performance penalty in practice due to the extra syscalls. But it
might make sense to do it selectively.

And now we get into the historical bits.

A long time ago, we noticed that a totally broken helper (i.e., one that
exits immediately) would cause Git to exit silently, which could be
confusing. So we added an error message when we saw an unexpected close
of the pipe. But people found that annoying, because most of the time
the helper already said something useful to stderr, and the user did not
even care that a helper was in use. So we got rid of it.

But we discussed the concept of complaining only about the initial
"capabilities" request, which would catch helpers that failed to even
start. There's some discussion in this thread:

  https://lore.kernel.org/git/20140117201325.GB775@sigill.intra.peff.net/

But the most interesting part to me is that on that same day over 10
years ago I wrote the patch below, but apparently never sent it. And
I've been rebasing it forward ever since (I have several dozen of these
"to look at and think about again" topic branches, and I guess I let
this one slide for quite a while).

Anyway, the interesting thing is that it does the exact "turn off
SIGPIPE only for this call" strategy discussed above. And so I did not
even see the race in t5512, because it was "fixed" in my fork. I use
quotation marks there, though, because the test was sometimes racily
succeeding for the wrong reason (because we got EPIPE, not because of
the forbidden capability response). So even if we took the patch below,
I think your test fix is the right thing to do.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Fri, 17 Jan 2014 15:36:21 -0500
Subject: [PATCH] print an error when remote helpers die during capabilities

The transport-helper code generally relies on the
remote-helper to provide an informative message to the user
when it encounters an error. In the rare cases where the
helper does not do so, the output can be quite confusing.
E.g.:

  $ git clone https://example.com/foo.git
  Cloning into 'foo'...
  $ echo $?
  128
  $ ls foo
  /bin/ls: cannot access foo: No such file or directory

We tried to address this with 81d340d (transport-helper:
report errors properly, 2013-04-10).

But that makes the common case much more confusing. The
remote helper protocol's method for signaling normal errors
is to simply hang up. So when the helper does encounter a
routine error and prints something to stderr, the extra
error message is redundant and misleading. So we dropped it
again in 266f1fd (transport-helper: be quiet on read errors
from helpers, 2013-06-21).

This puts the uncommon case right back where it started. We
may be able to do a little better, though. It is common for
the helper to die during a "real" command, like fetching the
list of remote refs. It is not common for it to die during
the initial "capabilities" negotiation, right after we
start. Reporting failure here is likely to catch fundamental
problems that prevent the helper from running (and reporting
errors) at all. Anything after that is the responsibility of
the helper itself to report.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5801-remote-helpers.sh | 11 +++++++++++
 transport-helper.c        | 16 +++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 20f43f7b7d..d21877150e 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -344,4 +344,15 @@ test_expect_success 'fetch tag' '
 	compare_refs local v1.0 server v1.0
 '
 
+test_expect_success 'totally broken helper reports failure message' '
+	write_script git-remote-broken <<-\EOF &&
+	read cap_cmd
+	exit 1
+	EOF
+	test_must_fail \
+		env PATH="$PWD:$PATH" \
+		git clone broken://example.com/foo.git 2>stderr &&
+	grep aborted stderr
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 09b3560ffd..98dbeb6d3d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -89,11 +89,18 @@ static int recvline(struct helper_data *helper, struct strbuf *buffer)
 	return recvline_fh(helper->out, buffer);
 }
 
-static void write_constant(int fd, const char *str)
+static int write_constant_gently(int fd, const char *str)
 {
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
 	if (write_in_full(fd, str, strlen(str)) < 0)
+		return -1;
+	return 0;
+}
+
+static void write_constant(int fd, const char *str)
+{
+	if (write_constant_gently(fd, str) < 0)
 		die_errno(_("full write to remote helper failed"));
 }
 
@@ -168,13 +175,16 @@ static struct child_process *get_helper(struct transport *transport)
 		die_errno(_("can't dup helper output fd"));
 	data->out = xfdopen(duped, "r");
 
-	write_constant(helper->in, "capabilities\n");
+	sigchain_push(SIGPIPE, SIG_IGN);
+	if (write_constant_gently(helper->in, "capabilities\n") < 0)
+		die("remote helper '%s' aborted session", data->name);
+	sigchain_pop(SIGPIPE);
 
 	while (1) {
 		const char *capname, *arg;
 		int mandatory = 0;
 		if (recvline(data, &buf))
-			exit(128);
+			die("remote helper '%s' aborted session", data->name);
 
 		if (!*buf.buf)
 			break;
-- 
2.46.0.942.g308ef7fa08

