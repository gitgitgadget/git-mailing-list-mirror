Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06014F10E
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044613; cv=none; b=si5uTsytXN4ePA4/XV4mIn/84+pxQoyG+wwpqyQcgrVkf9s/CiNVFleiwmXE+hcntaxeQqjRKi59Y/5grBd8IFylY946sv0VnUvH/OcToXC2qvWEKTmZP7XGiRwGtEchb5hF7fXQh/cDOAV1CeyB6QYxtwbIM3Fu6TY1lGiR1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044613; c=relaxed/simple;
	bh=/rZOhpegqM1V97v6vOvkFfKlunbCbVknaaEVOiOGZG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SCI5285SzUsgpRbG5JJlDXjRhbYG7p1cOoKLCLl2X1aZIZFT+fWWem3D343WBTFLYNRrqgLWG2rAp5+MIU54u7xOYVormE5Wc0iw2mPf0Z12lsM+0WD0qE58Iycw775irJmxb5Vz8a9Yh8wIFS50worrPajwz4RvLtznpz2uB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TNq+DNJh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TNq+DNJh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B820230187;
	Mon, 10 Jun 2024 14:36:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/rZOhpegqM1V97v6vOvkFfKlunbCbVknaaEVOi
	OGZG0=; b=TNq+DNJhPj859IjanleeTHGW5vR275CO5VNWeCmtepLO5wwbygBFzg
	M1BgrNBqksEGIWWUc1lGVU7AoPqyj/ETlY/7ljdxAtXZbUvVWiFb4KbGjQ3NSa3C
	6AP2X0gLaAR4B4O9M0O2V5LdX+CnivnoU2DnaUBmZ8REhmXPrMWBU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B205130186;
	Mon, 10 Jun 2024 14:36:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E2A830183;
	Mon, 10 Jun 2024 14:36:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: [PATCH 2/2] DONTAPPLY: -Os fallout workaround
In-Reply-To: <xmqqed946auc.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Jun 2024 09:06:51 -0700")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	<xmqqed946auc.fsf@gitster.g>
Date: Mon, 10 Jun 2024 11:36:47 -0700
Message-ID: <xmqqcyoo3ark.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65767BCE-2758-11EF-8EE7-8F8B087618E4-77302942!pb-smtp21.pobox.com

These "workarounds" are to mark variables that are used after
initialized, but some compilers with lower optimization levels
cannot see and report "used uninitialized".

This set targets "gcc-13 -Os".  For the reason why this is a wrong
thing to do for longer-term code health, see

  https://lore.kernel.org/git/xmqqed946auc.fsf@gitster.g/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fast-import.c   | 2 +-
 compat/linux/procinfo.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 6d53e42011..109b0facd5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2320,7 +2320,7 @@ static void file_change_m(const char *p, struct branch *b)
 	static struct strbuf path = STRBUF_INIT;
 	struct object_entry *oe;
 	struct object_id oid;
-	uint16_t mode, inline_data = 0;
+	uint16_t mode = mode, inline_data = 0;
 
 	p = parse_mode(p, &mode);
 	if (!p)
diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 4bb2d66227..17937906b8 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -129,7 +129,7 @@ static int stat_parent_pid(pid_t pid, struct strbuf *name, int *statppid)
 static void push_ancestry_name(struct strvec *names, pid_t pid)
 {
 	struct strbuf name = STRBUF_INIT;
-	int ppid;
+	int ppid = ppid;
 
 	if (stat_parent_pid(pid, &name, &ppid) < 0)
 		goto cleanup;
-- 
2.45.2-445-g1b76f06508

