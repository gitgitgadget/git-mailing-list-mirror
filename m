Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13B189F47
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188157; cv=none; b=OLb/B/SRonoyhJh4Q84zl/MgtVHmnsZ+O+VGPXwr1YFJSZeJyt/o3g7Vtgl242FCQkxwnbh++2awscuPh6Z3ep4O72wS1z/aLc6RVpRJ6XzTJgnoC37n+E1uPM9dgeIqRV7tieMLEyZZDNBAZ/iGmlwCknP0AnRjd9Xz60QNN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188157; c=relaxed/simple;
	bh=j/RJJ/zyCfN4qgHtJhKx3mZxBowpWuybNFqRhEWyeUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QA0uk6wdHRVsYYDV5kbsdZwk4jDqcRnHFc5Sh+4TpRxgzynCWFTSjGop5s5b4S1l0aw0fysWChqj+Kkxgkfer0QupSOp2oKCwQ/M3RONsv7XXDYcjfvptOgwzm/fA3JWeDwuIJpq5i5h6rxUruP3SJ8x3pYm3yOX+uzTWmdFRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFY+eDFs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFY+eDFs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E79F2E783;
	Tue, 20 Aug 2024 17:09:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	/RJJ/zyCfN4qgHtJhKx3mZxBowpWuybNFqRhEWyeUc=; b=RFY+eDFsVVPwwZImf
	78EUjS+gXXBbrh/m2/b/AiZRCAWzJwFZYBPsLMwIKxqXYU0xKkgrJuhJgzBp/UoB
	k1KO4oECOLdP4JHanvJoa9UuMikD8ZUUDPYkyf6VR2YpeBxaERUXcUeT1+QCi3RK
	3cHqsdHWtFX2eNIXEctjLK/il8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65AF62E782;
	Tue, 20 Aug 2024 17:09:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA2132E781;
	Tue, 20 Aug 2024 17:09:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] mailinfo: we parse fixed headers
Date: Tue, 20 Aug 2024 14:09:12 -0700
Message-ID: <xmqq1q2i6gw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73DCE8C0-5F38-11EF-A166-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

The code was written as if we have a small room to add additional
headers to be parsed to the header[] array at runtime, but that is
not our intention at all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This will not be applied and merged down, as this will conflict
   with Patrick's leakfix part 5.  In this version, MAX_HDR_PARSED
   is still set to 1 larger than necessary, due to the use of
   strbuf_list_free(), but after the leakfix-5 topic fixes it,
   MAX_HDR_PARSED can be reduced to ARRAY_SIZE(header).

 mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git c/mailinfo.c w/mailinfo.c
index 94b9b0abf2..17d7c3b594 100644
--- c/mailinfo.c
+++ w/mailinfo.c
@@ -346,10 +346,10 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 	strbuf_trim(subject);
 }
 
-#define MAX_HDR_PARSED 10
-static const char *header[MAX_HDR_PARSED] = {
-	"From","Subject","Date",
+static const char * const header[] = {
+	"From", "Subject", "Date",
 };
+#define MAX_HDR_PARSED (ARRAY_SIZE(header) + 1)
 
 static inline int skip_header(const struct strbuf *line, const char *hdr,
 			      const char **outval)
@@ -583,7 +583,7 @@ static int check_header(struct mailinfo *mi,
 	struct strbuf sb = STRBUF_INIT;
 
 	/* search for the interesting parts */
-	for (i = 0; header[i]; i++) {
+	for (i = 0; i < ARRAY_SIZE(header); i++) {
 		if ((!hdr_data[i] || overwrite) &&
 		    parse_header(line, header[i], mi, &sb)) {
 			handle_header(&hdr_data[i], &sb);
@@ -625,7 +625,7 @@ static int is_inbody_header(const struct mailinfo *mi,
 {
 	int i;
 	const char *val;
-	for (i = 0; header[i]; i++)
+	for (i = 0; i < ARRAY_SIZE(header); i++)
 		if (!mi->s_hdr_data[i] && skip_header(line, header[i], &val))
 			return 1;
 	return 0;
@@ -772,7 +772,7 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
 		return is_format_patch_separator(line->buf + 1, line->len - 1);
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
 		int i;
-		for (i = 0; header[i]; i++)
+		for (i = 0; i < ARRAY_SIZE(header); i++)
 			if (!strcmp("Subject", header[i])) {
 				handle_header(&mi->s_hdr_data[i], line);
 				return 1;
@@ -824,7 +824,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		 * We may have already read "secondary headers"; purge
 		 * them to give ourselves a clean restart.
 		 */
-		for (i = 0; header[i]; i++) {
+		for (i = 0; i < ARRAY_SIZE(header); i++) {
 			if (mi->s_hdr_data[i])
 				strbuf_release(mi->s_hdr_data[i]);
 			FREE_AND_NULL(mi->s_hdr_data[i]);
@@ -1155,7 +1155,7 @@ static void handle_info(struct mailinfo *mi)
 	struct strbuf *hdr;
 	int i;
 
-	for (i = 0; header[i]; i++) {
+	for (i = 0; i < ARRAY_SIZE(header); i++) {
 		/* only print inbody headers if we output a patch file */
 		if (mi->patch_lines && mi->s_hdr_data[i])
 			hdr = mi->s_hdr_data[i];
