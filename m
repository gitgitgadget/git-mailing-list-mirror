Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA1224CE
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803671; cv=none; b=ZmpnJGbj7PcQ+wVvyCGrYpEfOOrm1La361RN35b1Gv3jK/1HwthP6qZZ3LW/V5KYqcHFuZ8kYCPYmYVs4kwCvxUgJx7Qg7IMFhdUp2oK0112OHG2NgbNJakpsyilfaoeeK0VRgORHkPLcEEfAHFO6kvktLhwM6hBg7CR2i7oPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803671; c=relaxed/simple;
	bh=QfEZIegp3HP32a7NJYKye70G8SiE56O+uklQvk79zzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrdKpJdZ5HDoDELIaczJz6X6IC1luDXoLF/F3QedQ3KN400yqjOQWkTmvgDowGJmJgqg7zwVF6DBhvr1oD4B34/GbDXoV0qJdxjevhFRgxajJeYlOG7eUT4iDL9G+PWGEcMmwounsfj2bo3R7UZYc3I5LVp/K9hD2G/hduETW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7039 invoked by uid 109); 7 Mar 2024 09:27:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:27:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12719 invoked by uid 111); 7 Mar 2024 09:27:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:27:53 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:27:47 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 12/15] sequencer: handle multi-byte comment characters when
 writing todo list
Message-ID: <20240307092747.GL2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

We already match multi-byte comment characters in parse_insn_line(),
thanks to the previous commit, yielding a TODO_COMMENT entry. But in
todo_list_to_strbuf(), we may call command_to_char() to convert that
back into something we can output.

We can't just return comment_line_char anymore, since it may require
multiple bytes. Instead, we'll return "0" for this case, which is the
same thing we'd return for a command which does not have a single-letter
abbreviation (e.g., "revert" or "noop"). In that case the caller then
falls back to outputting the full name via command_to_string(). So we
can handle TODO_COMMENT there, returning the full string.

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
index 664986e3b2..9e2851428b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1779,14 +1779,16 @@ static const char *command_to_string(const enum todo_command command)
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
2.44.0.463.g71abcb3a9f

