Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79BD139597
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844449; cv=none; b=kynjX5NeI4NHhmrWQOWQLEv9E07i7hs3juiWa/oNe4uNPDWVEoiSqe/0dYLi4iWqk9ieJHS93ZiAshskTnJCcU+bka6r2eAZ/NzwkvWIiCYaSKKsZJw4JIZXTRBeuI1k77DvSAVD8Kun4yexjgyisou86D4yJkw0zx5nqqCqqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844449; c=relaxed/simple;
	bh=f8IYap0KrgVCKrsf5miL1Ul44PFVJxyT3RGO+ZgMlrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XezmQwyR18Yo4FEJxaVF9iXP0JRIhIYgZ57gLRNDI+gRtRX7UtwN+M8GP/DtOUMWJunGhlLPkEBx83YsOU0OVZJp1WY9mBdAYQxIIjq+HDIoScdRp9wXorQTbPOiO646FNi8hfD8dCIWZupSQdL1B7SSn9jRn9WeVWrRkNPeG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=biiIupPp; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="biiIupPp"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 59E7531CBE;
	Thu,  7 Mar 2024 15:47:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f8IYap0KrgVCKrsf5miL1Ul44PFVJxyT3RGO+Z
	gMlrg=; b=biiIupPpT56fOmX01xQ8LY9ru8OgF274EgG5zvj2hI4CuyRf8tg1cu
	f+nApmTwCsXh57WrilSHMqNtTQyEWEEQQ1iuEXhJn8HHASdl7bEFuKji1hK0Ktko
	wRhPSYutbOyo/q6SBod1MXKhhtiyHVgYvafV7jWml5cEf8UZr55js=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 52C4F31CBD;
	Thu,  7 Mar 2024 15:47:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE39631CB9;
	Thu,  7 Mar 2024 15:47:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org,  Jonathan Davies <jonathan.davies@nutanix.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Denton Liu
 <liu.denton@gmail.com>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
In-Reply-To: <xmqq34t1n91w.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	07 Mar 2024 11:20:11 -0800")
References: <20240307183743.219951-1-flosch@nutanix.com>
	<xmqq34t1n91w.fsf@gitster.g>
Date: Thu, 07 Mar 2024 12:47:22 -0800
Message-ID: <xmqq7cidlqg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E684E532-DCC3-11EE-92CD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

From: Florian Schmidt <flosch@nutanix.com>
Date: Thu, 7 Mar 2024 18:37:38 +0000
Subject: [PATCH] wt-status: don't find scissors line beyond buf len

If

  (a) There is a "---" divider in a commit message,

  (b) At some point beyond that divider, there is a cut-line (that is,
      "# ------------------------ >8 ------------------------") in the
      commit message,

  (c) the user does not explicitly set the "no-divider" option,

then "git interpret-trailers" will hang indefinitively.

This is because when (a) is true, find_end_of_log_message() will invoke
ignored_log_message_bytes() with a len that is intended to make it
ignore the part of the commit message beyond the divider. However,
ignored_log_message_bytes() calls wt_status_locate_end(), and that
function ignores the length restriction when it tries to locate the cut
line. If it manages to find one, the returned cutoff value is greater
than len. At this point, ignored_log_message_bytes() goes into an
infinite loop, because it won't advance the string parsing beyond len,
but the exit condition expects to reach cutoff.

Make wt_status_locate_end() honor the length parameter passed in, to
fix this issue.

In general, if wt_status_locate_end() is given a piece of the memory
that lacks NUL at all, strstr() may continue across page boundaries
and run into an unmapped page.  For our current callers, this is not
a problem, as all of them except one uses a memory owned by a strbuf
(which guarantees an implicit NUL-termination after its payload),
and the one exeption in trailer.c:find_end_of_log_message() uses
strlen() to compute the length before calling this function.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
[jc: tweaked the commit log message and the implementation a bit]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here is the version I queued.  I have a new paragraph at the
   end of the log message to talk about use of strstr() and how it
   is OK in the current codebase.

 t/t7513-interpret-trailers.sh | 14 ++++++++++++++
 wt-status.c                   |  7 +++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f..5efe70d675 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1476,4 +1476,18 @@ test_expect_success 'suppress --- handling' '
 	test_cmp expected actual
 '
 
+test_expect_success 'handling of --- lines in conjunction with cut-lines' '
+	echo "my-trailer: here" >expected &&
+
+	git interpret-trailers --parse >actual <<-\EOF &&
+	subject
+
+	my-trailer: here
+	---
+	# ------------------------ >8 ------------------------
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 40b59be478..16c1b9b7ee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1007,8 +1007,11 @@ size_t wt_status_locate_end(const char *s, size_t len)
 	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
 	if (starts_with(s, pattern.buf + 1))
 		len = 0;
-	else if ((p = strstr(s, pattern.buf)))
-		len = p - s + 1;
+	else if ((p = strstr(s, pattern.buf))) {
+		size_t newlen = p - s + 1;
+		if (newlen < len)
+			len = newlen;
+	}
 	strbuf_release(&pattern);
 	return len;
 }
-- 
2.44.0-117-g43072b4ca1

