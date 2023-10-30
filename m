Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11243ECF
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qwMgFoVh"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA959B
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 21:00:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1468A1AF4A8;
	Mon, 30 Oct 2023 00:00:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i7oD8ZKlefz3aDbceFlirB8I3il/vdw2z3WjF8
	j52fc=; b=qwMgFoVhAs9jhXf/nRfkO3/OTeEfLG5MuxkTGlFlaNVyP5LS0sUQZ+
	O3pwzJIv+Y0hg0W9EPZe2Gv3u0zPq+RakjFcF69jKLmKHYi3lWdpOWqnRrYEXUui
	Nzb+BDhGS/rymj7jbuMsXvt4TfPXHnptaUeuk69zlwlL0h52lyfT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B7A11AF4A7;
	Mon, 30 Oct 2023 00:00:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B3731AF4A6;
	Mon, 30 Oct 2023 00:00:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tony Tung <tonytung@merly.org>
Subject: Re: [PATCH] sequencer: remove use of comment character
In-Reply-To: <pull.1603.git.1698635292629.gitgitgadget@gmail.com> (Tony Tung
	via GitGitGadget's message of "Mon, 30 Oct 2023 03:08:12 +0000")
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
Date: Mon, 30 Oct 2023 13:00:50 +0900
Message-ID: <xmqq7cn4g3nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA7A1938-76D8-11EE-96C3-25B3960A682E-77302942!pb-smtp2.pobox.com

"Tony Tung via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tony Tung <tonytung@merly.org>
>
> Instead of using the hardcoded `# `, use the
> user-defined comment_line_char.  Adds a test
> to prevent regressions.

Good spotting.

Two observations.

 (1) There are a few more places that need similar treatment in the
     same file; you may want to fix them all while at it.

 (2) The second argument to strbuf_commented_addf() is always the
     comment_line_char global variable, not just inside this file
     but all callers across the codebase.  We probably should drop
     it and have the strbuf_commented_addf() helper itself refer to
     the global.  That way, if we ever want to change the global
     variable reference to something else (e.g. function call), we
     only have to touch a single place.

The latter is meant as #leftoverbits and will be a lot wider
clean-up that we may want to do long after this patch hits out
codebase.  The "other places" I spotted for the former are the
following, but needs to be taken with a huge grain of salt, as it
has not even been compile tested.

Thanks.

 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git c/sequencer.c w/sequencer.c
index d584cac8ed..33208b1660 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -1893,8 +1893,8 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
 	size_t orig_msg_len;
 	int i = 1;
 
-	strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
-	strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
+	strbuf_addf(&buf1, comment_line_char, "%s\n", _(first_commit_msg_str));
+	strbuf_addf(&buf2, comment_line_char, "%s\n", _(skip_first_commit_msg_str));
 	s = start = orig_msg = strbuf_detach(msg, &orig_msg_len);
 	while (s) {
 		const char *next;
@@ -2269,8 +2269,8 @@ static int do_pick_commit(struct repository *r,
 		next = parent;
 		next_label = msg.parent_label;
 		if (opts->commit_use_reference) {
-			strbuf_addstr(&msgbuf,
-				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+			strbuf_commented_addf(&msgbuf, comment_line_char, "%s",
+				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
 		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
 			   /*
 			    * We don't touch pre-existing repeated reverts, because
