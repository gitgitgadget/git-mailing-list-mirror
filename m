Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193157BAEC
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235065; cv=none; b=GA5zRX7xdNCwAyomq+OiGniAy0f+e60eU+mYGSiE/Yi9gmlFmZNe57Dw2b056M1QWuwV0SLTnP/bHB8FkaZvToYJZTH2xPvnhx5hbtZXQNsxNOyf3Iow+0zeM3jyfkTf4rQhpN1IgaZylXWSx2NXNBafq9QSbJSoWEYYxgAET1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235065; c=relaxed/simple;
	bh=x8G6de8A1MvFh7EaXh/f/JvvcJFzjg2wa/KZxYri87o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB09uIbYbojsigVrA/5S3HwcmWIbsmf9y5i/19AaK9p7CS+sydWolVPPxe3eCAwMuVzN6AWPSfSzykJvLb+Fimtnf/hvQOVQ6FFRt/fJRVkZj/kWmwQoORi4y0IMH+HTct1o8KmFMWE7Gvwat9vPG7OcZ7sHOIYQJlv7t0FKaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17681 invoked by uid 109); 12 Mar 2024 09:17:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28108 invoked by uid 111); 12 Mar 2024 09:17:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:48 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 13/16] sequencer: handle multi-byte comment characters
 when writing todo list
Message-ID: <20240312091742.GM95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>

We already match multi-byte comment characters in parse_insn_line(),
thanks to the previous commit, yielding a TODO_COMMENT entry. But in
todo_list_to_strbuf(), we may call command_to_char() to convert that
back into something we can output.

We can't just return comment_line_char anymore, since it may require
multiple bytes. Instead, we'll return "0" for this case, which is the
same thing we'd return for a command which does not have a single-letter
abbreviation (e.g., "revert" or "noop"). There is only a single caller
of command_to_char(), and upon seeing "0" it falls back to outputting
the full name via command_to_string(). So we can handle TODO_COMMENT
there, returning the full string.

Note that there are many other callers of command_to_string(), which
will now behave differently if they pass TODO_COMMENT. But we would not
expect that to happen; prior to this commit, the function just calls
die() in this case. And looking at those callers, that makes sense;
e.g., do_pick_commit() will only be called when servicing a pick
command, and should never be called for a comment in the first place.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index ef84832855..a8fdf00e89 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1781,14 +1781,16 @@ static const char *command_to_string(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
+	if (command == TODO_COMMENT)
+		return comment_line_str;
 	die(_("unknown command: %d"), command);
 }
 
 static char command_to_char(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].c;
-	return comment_line_char;
+	return 0;
 }
 
 static int is_noop(const enum todo_command command)
-- 
2.44.0.481.gf1a6d20963

