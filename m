Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D852BF3E2
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529931; cv=none; b=YzJjQQjAoTYGzmHKhCm5eRD9lAWp1wSbh1pbrL7XDroUtqBxs2WIZ5Rg37xZND2yliT7UgYuVPppXE3PzlvkMY5UNnQ/UmJhLAYK2rE1jMbb5Adwzx659jMnOp4a+DtBhcpoagYbkK8YK0bRA/ttfJD64ssDBY5jvL5fygmN5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529931; c=relaxed/simple;
	bh=ZASOqPwuL2duN3vAOKC81Q4T0mx4wfjktxlRnDnp7yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5gMLBsVY3e415uDy+Wj+QFRzg2Ex6cBkNQHeP1VKXMULdiAMOkVAahA1quBpkPQKJ75B/CeyyWgTE3ZRQ1hNkxmpj4Dof2DBXqr/ElF7Q4BB5u++ebHv5VHdaj4lllzCMICUIU8anGDO5RHUdLSYWI8xx2UKzBNBH0QohatvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=SEnZIKRz; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="SEnZIKRz"
DKIM-Signature: a=rsa-sha256; bh=N35YjloQoXy54miLYyiwp8ZqcfL7GYq1d6DnEWx/l0w=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751529000; v=1; x=1751961000;
 b=SEnZIKRz6Y9qNp+k/78Ct20Yl1Pb8gkZeFD9+2nbLKePO2kZyoL6QlLDmaKs6aA6s4BjZIVp
 sFj9mTd4awlp6QYTVk0sENQUMg0VKz9nW4tZxgkqbK21U8ix6AyaTXNmWBYRkLT9OhPGGRIzxC8
 7WF249BwUYuISBTRdp9jhl+J2enYZwYVYisMBudJMrzaiLhayAnRPBUbAmRSroPVsch7HTcAoL6
 bb3s6qTdvJf8DlrbOpvDxoD+4HaWAsFdTetC0RarzM4SYS9fLx+dZ68sNDdrs8YbWbvkzCCo/XW
 f9HcFMxSjWFzBJIEMI3Tzh9FRziCulohKmAIfzqYLJyuw==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id 1bd92a2b; Thu, 03 Jul 2025 07:50:00 +0000
Received: by taiga (Postfix, from userid 1000)
	id 0A66870206F2; Thu, 03 Jul 2025 09:50:00 +0200 (CEST)
From: Drew DeVault <drew@ddevault.org>
To: git@vger.kernel.org
Cc: Drew DeVault <drew@ddevault.org>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Andy Koppe <andy.koppe@gmail.com>,
	"Remo Senekowitsch" <remo@buenzli.dev>
Subject: [PATCH] pretty: add X-Change-ID to mail formats
Date: Thu,  3 Jul 2025 09:45:29 +0200
Message-ID: <20250703074952.20737-1-drew@ddevault.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the X-Change-ID header to emails prepared by git (i.e. via
format-patch, send-email). This allows tools which work with those
emails (e.g. patchwork, sourcehut) to meaningfully integrate with tools
that assign change IDs to commits.

With some follow-up work, this is also the first step towards ensuring
that those change IDs are preserved through from git-send-email to
git-am as a change moves through its review lifecycle.

Signed-off-by: Drew DeVault <drew@ddevault.org>
---
I have refrained from implementing the git-am part of this work for now,
on the basis that I'm not sure how downstream tools like Jujutsu would
feel if git wrote the change-id header to new commits. Would that
conflict with some internal deterministic process for coming up with the
change-id that could come up with a different answer, leading to
conflicts? I don't know, so I would appreciate some insights from those
who understand the implications for their downstream systems.

Adding the change ID to outgoing emails is useful on its own, however,
so I think this patch is acceptable without the git-am side being
initially present.

 pretty.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a..70fba7b023 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2045,7 +2045,7 @@ static void pp_header(struct pretty_print_context *pp,
 	int parents_shown = 0;
 
 	for (;;) {
-		const char *name, *line = *msg_p;
+		const char *name, *change_id, *line = *msg_p;
 		int linelen = get_one_line(*msg_p);
 
 		if (!linelen)
@@ -2089,6 +2089,11 @@ static void pp_header(struct pretty_print_context *pp,
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info(pp, "Commit", sb, name, encoding);
 		}
+		if (skip_prefix(line, "change-id ", &change_id) &&
+		    cmit_fmt_is_mail(pp->fmt)) {
+			strbuf_addf(sb, "X-Change-ID: %.*s\n",
+				    linelen - 11, change_id);
+		}
 	}
 }
 
-- 
2.50.0

