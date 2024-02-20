Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042D17E1
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391387; cv=none; b=JQ6ObAwNrTEJdA+u4EsaGkBnuN4SVm8q4ni77JAx67EyQp4um73nwtr64NqxwHVHd4ceGzukKhwoc8NiI4/n05tcM8VqBforB4ZrkYKWZqlJA+No3/PoJuZ5NSRBcj59g14LBtn+SRjmlF5QIlbQN5DwxldiXGqpP61X7jA6Qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391387; c=relaxed/simple;
	bh=tRW8YKpr7do/45E6dbnCHBNjDKPsFPug3JLOhvOXZMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On2Pa9GTK64sucJyJt9gfeGJ8LzBLZHa+U7M3fH6exRHNVYUM/LPlptgr6asECMqBRmxfCLT+E3jL8QmNEpiQAZUdT01Tv+fkMlVy6490KdQLRgaz1hBmpLVnw6klJziAMi+OiyVxpwDd0hVxPNu5/+XQo1OMfTLtwnS6JgT2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22996 invoked by uid 109); 20 Feb 2024 01:09:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Feb 2024 01:09:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18125 invoked by uid 111); 20 Feb 2024 01:09:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Feb 2024 20:09:39 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Feb 2024 20:09:36 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Linus Arver <linusa@google.com>,
	Git mailing list <git@vger.kernel.org>
Subject: [PATCH] trailer: fix comment/cut-line regression with
 opts->no_divider
Message-ID: <20240220010936.GA1793660@coredump.intra.peff.net>
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
 <20240217060434.GE539459@coredump.intra.peff.net>
 <ca6a73d3-58b4-e65c-4a8f-e6ddb3e86902@gmail.com>
 <xmqqfrxo9ty2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrxo9ty2.fsf@gitster.g>

On Mon, Feb 19, 2024 at 10:42:45AM -0800, Junio C Hamano wrote:

> Thanks, both, for finding a rather unfortunate regression.  Perhaps
> it is worth delaying 2.44 final by a week or so to include a fix (or
> a revert if it comes to it).

Hmm, I had thought this was pre-2.44, but it was actually in the 2.43.x
maintenance series (so it is not a regression going from 2.43.2 to
2.44.0, but it is from 2.43.0 to 2.44.0).

Anyway, the fix is pretty simple, so I think it may be OK to apply it
for 2.44.0-rc2. Here it is (prepared on top of la/trailer-cleanups, so
it could also be merged down for a v2.43.3 if you want to).

-- >8 --
Subject: trailer: fix comment/cut-line regression with opts->no_divider

Commit 97e9d0b78a (trailer: find the end of the log message, 2023-10-20)
combined two code paths for finding the end of the log message. For the
"no_divider" case, we used to use find_trailer_end(), and that has now
been rolled into find_end_of_log_message(). But there's a regression;
that function returns early when no_divider is set, returning the whole
string.

That's not how find_trailer_end() behaved. Although it did skip the
"---" processing (which is what "no_divider" is meant to do), we should
still respect ignored_log_message_bytes(), which covers things like
comments, "commit -v" cut lines, and so on.

The bug is actually in the interpret-trailers command, but the obvious
way to experience it is by running "commit -v" with a "--trailer"
option. The new trailer will be added at the end of the verbose diff,
rather than before it (and consequently will be ignored entirely, since
everything after the diff's intro scissors line is thrown away).

I've added two tests here: one for interpret-trailers directly, which
shows the bug via the parsing routines, and one for "commit -v".

The fix itself is pretty simple: instead of returning early, no_divider
just skips the "---" handling but still calls ignored_log_message_bytes().

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Viewing the diff with "-w" makes the change a little more obvious.

 t/t7502-commit-porcelain.sh   | 18 ++++++++++++++++++
 t/t7513-interpret-trailers.sh | 19 +++++++++++++++++++
 trailer.c                     | 15 +++++++--------
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b5bf7de7cd..d8e216613f 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -485,6 +485,24 @@ test_expect_success 'commit --trailer not confused by --- separator' '
 	test_cmp expected actual
 '
 
+test_expect_success 'commit --trailer with --verbose' '
+	cat >msg <<-\EOF &&
+	subject
+
+	body
+	EOF
+	GIT_EDITOR=: git commit --edit -F msg --allow-empty \
+		--trailer="my-trailer: value" --verbose &&
+	{
+		cat msg &&
+		echo &&
+		echo "my-trailer: value"
+	} >expected &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 97f10905d2..3343ad0eb6 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1560,4 +1560,23 @@ test_expect_success 'suppress --- handling' '
 	test_cmp expected actual
 '
 
+test_expect_success 'suppressing --- does not disable cut-line handling' '
+	echo "real-trailer: before the cut" >expected &&
+
+	git interpret-trailers --parse --no-divider >actual <<-\EOF &&
+	subject
+
+	This input has a cut-line in it; we should stop parsing when we see it
+	and consider only trailers before that line.
+
+	real-trailer: before the cut
+
+	# ------------------------ >8 ------------------------
+	# Nothing below this line counts as part of the commit message.
+	not-a-trailer: too late
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index 816f8b28a9..009ee80dee 100644
--- a/trailer.c
+++ b/trailer.c
@@ -837,16 +837,15 @@ static size_t find_end_of_log_message(const char *input, int no_divider)
 	/* Assume the naive end of the input is already what we want. */
 	end = strlen(input);
 
-	if (no_divider)
-		return end;
-
 	/* Optionally skip over any patch part ("---" line and below). */
-	for (s = input; *s; s = next_line(s)) {
-		const char *v;
+	if (!no_divider) {
+		for (s = input; *s; s = next_line(s)) {
+			const char *v;
 
-		if (skip_prefix(s, "---", &v) && isspace(*v)) {
-			end = s - input;
-			break;
+			if (skip_prefix(s, "---", &v) && isspace(*v)) {
+				end = s - input;
+				break;
+			}
 		}
 	}
 
-- 
2.44.0.rc1.413.gdc9df0ba3d

