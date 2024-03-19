Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906240BF2
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889014; cv=none; b=G4ea8WdNUxlXcc4ciOG2r0f2jcVR+NQindPOcdIYZborb3d3CyBf8l2s1bIPYAL9NGJS135jfhOs/Zmo3FiKSb8NoWz9f+1Ru0rMzS+b5oR4S4SFTZrtHNZ9WOo2m3LxNwOI9iG8nvW0ukr+GsaXbcf1er596c8dfICicJpM1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889014; c=relaxed/simple;
	bh=I3K+K4fElGHzZviCDsL8HQ2YKbrYlIJOrVV2pIeDlBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nnjguz74Pw1EgDhOnKs+2OxicKJUAy17WpprCPEu2TgwqsRyYkvgChJdbavw2mKQSPItU/+GVtdeunzIaCI1RUnpXc2YVp7hGu70BHVEad09ExSZAA/np73OVk5092aIuxSxuaLYQTvp5rrPo2TKhKJ5CN2C8Tu6csl/KBQmuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GenRtiVE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GenRtiVE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D73E1CECB6;
	Tue, 19 Mar 2024 18:56:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I3K+K4fElGHzZviCDsL8HQ2YKbrYlIJOrVV2pI
	eDlBI=; b=GenRtiVEWIMWNBW5czOS3srO8uFAZA0PrLPJ5+KGOq5worwZF65VAo
	NzgB21/9sAPzl7BBdKjFOriq8t0nT42nfad1I17wHd7XYy2gK+bf2MbNYiwwbPHO
	Re/eW0S8NiY1sXoIgCGlkG092BLnfXQsPcWz6wtlgk48yP8GbDi/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32DEA1CECB5;
	Tue, 19 Mar 2024 18:56:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 932321CECB4;
	Tue, 19 Mar 2024 18:56:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <xmqqttl2qml9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	19 Mar 2024 08:15:46 -0700")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g>
Date: Tue, 19 Mar 2024 15:56:44 -0700
Message-ID: <xmqqfrwlltjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5CDDB78-E643-11EE-B386-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> That is an interesting corner case.  You should make this into a set
> of new tests somewhere in t/; I suspect this only will "break" for
> creation and deletion but not modification in-place or renaming (and
> that should also be in the tests).

It turns out that this is even more unintereseting than I hoped; it
happens ONLY when there is no contents shown at all in the patch,
and the patch is about creation or deletion of a path.  Mode change
without touching any contents may also trigger the same breakage.

Here is a fix, which seems not to break any existing tests.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] apply: parse names out of "diff --git" more carefully

"git apply" uses the pathname parsed out of the "diff --git" header
to decide which path is being patched, but this is used only when
there is no other names available in the patch.  When there is any
content change (like we can see in this patch, that modifies the
contents of "apply.c") or rename (which comes with "rename from" and
"rename to" extended diff headers), the names are available without
having to parse this header.

When we do need to parse this header, a special care needs to be
taken, as the name of a directory or a file can have a SP in it so
it is not like "find a space, and take everything before the space
and that is the preimage filename, everything after the space is the
postimage filename".  We have a loop that stops at every SP on the
"diff --git a/dir/file b/dir/foo" line and see if that SP is the
right place that separates such a pair of names.

Unfortunately, this loop can terminate prematurely when a crafted
directory name ended with a SP.  The next pathname component after
that SP (i.e. the beginning of the possible postimage filename) will
be a slash, and instead of rejecting that position as the valid
separation point between pre- and post-image filenames and keep
looping, we stopped processing right there.

The fix is simple.  Instead of stopping and giving up, keep going on
when we see such a condition.

Reported-by: Han Young <hanyang.tony@bytedance.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c                |  9 ++++++++-
 t/t4126-apply-empty.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git c/apply.c w/apply.c
index 432837a674..e311013bc4 100644
--- c/apply.c
+++ w/apply.c
@@ -1292,8 +1292,15 @@ static char *git_header_name(int p_value,
 				return NULL; /* no postimage name */
 			second = skip_tree_prefix(p_value, name + len + 1,
 						  line_len - (len + 1));
+			/*
+			 * If we are at the SP at the end of a directory,
+			 * skip_tree_prefix() may return NULL as that makes
+			 * it appears as if we have an absolute path.
+			 * Keep going to find another SP.
+			 */
 			if (!second)
-				return NULL;
+				continue;
+
 			/*
 			 * Does len bytes starting at "name" and "second"
 			 * (that are separated by one HT or SP we just
diff --git c/t/t4126-apply-empty.sh w/t/t4126-apply-empty.sh
index ece9fae207..eaf0c5304a 100755
--- c/t/t4126-apply-empty.sh
+++ w/t/t4126-apply-empty.sh
@@ -66,4 +66,26 @@ test_expect_success 'apply --index create' '
 	git diff --exit-code
 '
 
+test_expect_success 'apply with no-contents and a funny pathname' '
+	mkdir "funny " &&
+	>"funny /empty" &&
+	git add "funny /empty" &&
+	git diff HEAD "funny /" >sample.patch &&
+	git diff -R HEAD "funny /" >elpmas.patch &&
+	git reset --hard &&
+	rm -fr "funny " &&
+
+	git apply --stat --check --apply sample.patch &&
+	test_must_be_empty "funny /empty" &&
+
+	git apply --stat --check --apply elpmas.patch &&
+	test_path_is_missing "funny /empty" &&
+
+	git apply -R --stat --check --apply elpmas.patch &&
+	test_must_be_empty "funny /empty" &&
+
+	git apply -R --stat --check --apply sample.patch &&
+	test_path_is_missing "funny /empty"
+'
+
 test_done
