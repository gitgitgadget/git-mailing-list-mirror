Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD790238150
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641126; cv=none; b=ot50XIVJEsKx/vRfIZEEbTKZy9LU4mXq/Xt9vryWh0/yldvUSgwZ9ZfL+8HPXNYOUqaQzG9khGVpTxzURVQ8QKc1kj/H+TSPMm0yMpnMUUbYa9MEyG1hjgTcPU0lME3IXd33DNNXFkg23nmJhkKg2tLDO2cwru/stsMstHEjcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641126; c=relaxed/simple;
	bh=TJEkvqiHlYNCbjDboiH7nFPHxmWAtC2PwRBoND8nV7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qamfsLYbiZWeu8iikrsS170EFermCYSRPdSmA5c0KfkyMqQW36AkVqEvtR+V6VvH20cq8BjV5xTF0x7OpCZa4rutSxWUIx+5+upoRarvT9Diyt75xknrIqc2OJBpsEEMEsiURCaqr/aJxSyWIipwQnh9KwhLIQIh5JD7uTNd7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OpvOM624; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OpvOM624"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1760641123;
	bh=TJEkvqiHlYNCbjDboiH7nFPHxmWAtC2PwRBoND8nV7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=OpvOM624J3EjghYxlANM1aP10R+QURX2VqBRs38BRTq1SxmmvIE4BOk7jkOtlsvgD
	 oJMwvrojQk32Ea8L6qRbrEf2j/soJyGf0XNXDa+yARz66gfN6E2ViF+BVatFfOmNng
	 8+EV4EG6O0fODbxmIn3ZWxxrggrQwqWuOC+fyQSY=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id A4D501C01EF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:58:43 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] mailinfo.c: always collect the message-id
Date: Thu, 16 Oct 2025 14:57:56 -0400
Message-ID: <20251016185758.21996-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to this mailinfo only collected the message-id if
add_messsage_id was true. Now git-am needs the message-id all the
time, hence the change, and anything checking to see if message-id
should be included in the trailer must check both any_message_id and
message_id.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 mailinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 99ac596e09..62a30e37b1 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -609,8 +609,7 @@ static int check_header(struct mailinfo *mi,
 		goto check_header_out;
 	}
 	if (parse_header(line, "Message-ID", mi, &sb)) {
-		if (mi->add_message_id)
-			mi->message_id = strbuf_detach(&sb, NULL);
+		mi->message_id = strbuf_detach(&sb, NULL);
 		ret = 1;
 		goto check_header_out;
 	}
@@ -837,7 +836,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (patchbreak(line)) {
-		if (mi->message_id)
+		if (mi->add_message_id && mi->message_id)
 			strbuf_addf(&mi->log_message,
 				    "Message-ID: %s\n", mi->message_id);
 		return 1;
-- 
2.51.0

