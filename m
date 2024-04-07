Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBB812
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452027; cv=none; b=Y2Q9TXCEvaNA8h/fs9sCNjHkWMv7iBMebXRp9W4IcHH+oueaj8pelq/uQLOJhNOwoNM3/vJu2HyfvMKZYgWNw/EG+wksQFD8RJmnjWshgStMjaamEfwOC/ovp+bAEGJMYhod9RvkZiqj5OfoYPBf/flwSl1nmGDJqye1cDB+m7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452027; c=relaxed/simple;
	bh=q0ZY4CtALGR6RvelDSXhFi8Mll1I5lfDQzW7n2FuwIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYNTV6L3PrF1gqJcnqHj3+UtiO5mY7rDzW6+xRXjTpdlLEaX2c7CXkKq2pQ+jeJd/CbSg+X/rVl0I2/tzAGuGeEiG/IOvBTRfNSBVBP754e++ufSaaGNvCMWOGuT1hxKW7MQqNOzzyggVUGAbN7etCPJyE3VwnwJou58cyzdq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7459 invoked by uid 109); 7 Apr 2024 01:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:07:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11349 invoked by uid 111); 7 Apr 2024 01:07:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:07:07 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:07:04 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 11/11] blame: use "dup" string_list for ignore-revs files
Message-ID: <20240407010704.GK868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

We feed items into ignore_revs_file_list in two ways: from config and
from the command-line. Items from the command-line point to argv entries
that we don't own, but items from config are hea-allocated strings whose
ownership is handed to the string list when we insert them.

Because the string_list is declared with "NODUP", our string_list_clear()
call will not free the entries themselves. This is the right thing for
the argv entries, but means that we leak the allocated config entries.

Let's declare the string list as owning its own strings, which means
that the argv entries will be copied.

For the config entries we would ideally use string_list_append_nodup()
to just hand off ownership of our strings. But we insert them into the
sorted list with string_list_insert(), which doesn't have a nodup
variant. Since this isn't a hot path, we can accept that the path
interpolation will produce a temporary string which is then freed.

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly related to this series, but something I noticed while
converting this spot in an earlier patch. I had thought originally we
could switch to avoid the extra copy altogether:

  if (!value)
	return config_error_nonbool();
  string_list_insert(&ignore_revs_file_list, value);

but of course that is missing the call to interpolate_path().

I imagine that it could also be further refactored to append while
reading the config, and then sort after. That's more efficient overall,
and would let us use append_nodup().

 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0b07ceb110..fa7f8fce09 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -67,7 +67,7 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
-static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
+static struct string_list ignore_revs_file_list = STRING_LIST_INIT_DUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
 
@@ -725,6 +725,7 @@ static int git_blame_config(const char *var, const char *value,
 		if (ret)
 			return ret;
 		string_list_insert(&ignore_revs_file_list, str);
+		free(str);
 		return 0;
 	}
 	if (!strcmp(var, "blame.markunblamablelines")) {
-- 
2.44.0.872.g288abe5b5b
