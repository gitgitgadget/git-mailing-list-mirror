Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D721C5D44
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672960; cv=none; b=OIKtHSnM5EeHN5ZO9k9QmA1M7x3x+b5ownFVZr6AjTIPYzKYSa6aKEOW0bKb6t2UlhiRj7Poxpgl3/GMLdl/5NYV+cLlIMv8gDCKfH3djl9XaOkEjTOGuS7mSmcN/k/qRERiLErsEtMkqk/VRwpHLvuGhB+/1/qPc9j7qxRvaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672960; c=relaxed/simple;
	bh=r/xx90+P7Kz7xfVMwOauBbtTBw2WER4yk3I02EX46AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3M/h3zF6Lp9VjI+Yu87hsOuluG3vKWy5TKsZJFCMkfHYMc4E4TzLwN7H+oPa5l8REtJjuhl4G5TLOLTZ/+KwpHOKZdWEEw8XNtKbOAfq04WtP3nbjCDsHGTaB1e6xnKe/bsWks+GUaW4fXZH+Lq21jcPr9SfI2vU1XPqSEgU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=rE9B7Jt8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="rE9B7Jt8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752672956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueVt6waNmleRCYe/Jun/HGLqf8cr+kuWk36Cx0aAkGY=;
	b=rE9B7Jt8F8iv595cQs9uqGymzY+HgPOf0TeNA3WfjSaCinc34NwgM+977816W95CItsx0t
	tVloDsNQJ+q1uImsaJTYr+iUegn32kk7tMpMSlbc4DtiOSMF071I4F8/2P8ghl3B5ir1g8
	iYW9YdMzo2kq4/tOWDiGKO70rdtbqBk=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/6] pretty: allow caller to disable indentation
Date: Wed, 16 Jul 2025 15:35:16 +0200
Message-ID: <20250716133518.1788126-4-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Most pretty formats indent the commit message with 4 spaces. Add field
`no_indent` to `struct pretty_print_context` to suppress this
indentation.

Signed-off-by: Toon Claes <toon@iotcl.com>

# Conflicts:
#	pretty.h

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 pretty.c | 2 +-
 pretty.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a..9b1698417e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2286,7 +2286,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 			 struct strbuf *sb)
 {
 	unsigned long beginning_of_body;
-	int indent = 4;
+	int indent = pp->no_indent ? 0 : 4;
 	const char *msg;
 	const char *reencoded;
 	const char *encoding;
diff --git a/pretty.h b/pretty.h
index df267afe4a..5d25ae2320 100644
--- a/pretty.h
+++ b/pretty.h
@@ -50,6 +50,7 @@ struct pretty_print_context {
 	struct ident_split *from_ident;
 	unsigned encode_email_headers:1;
 	struct pretty_print_describe_status *describe_status;
+	int no_indent;

 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
--
2.50.1.327.g047016eb4a
